Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12897C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D315620758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6cqfybQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcXo-0002jD-1u
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZcWl-00021k-GX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:45:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZcWk-0003Bc-B2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589557532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJRYEOxfhnIv6V55aS4jIHgdK9dsxo5uezteg/4zrTE=;
 b=L6cqfybQv1b7c0i7g7EmZIMn1OUn6PcpIGz2qLA3SUbfhlZZJTuomdlJiSj6s8i84cFXA2
 EfSxaoAYNKNpZ8DOnGrEH6i5G/tL/H91cb7IX/GWDK27q8GzhTSxDXsk8ocSojLox+q+aw
 w9vwfEhmKXorU0MlKZHHcN5/LWDDKkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-leUvtcylM9Wo2MwcchP2dA-1; Fri, 15 May 2020 11:45:29 -0400
X-MC-Unique: leUvtcylM9Wo2MwcchP2dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FF51100CC88;
 Fri, 15 May 2020 15:45:28 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A03D1C8;
 Fri, 15 May 2020 15:45:09 +0000 (UTC)
Date: Fri, 15 May 2020 16:45:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC v4 6/6] hmp: add x-debug-virtio commands
Message-ID: <20200515154506.GC2955@work-vm>
References: <20200507134800.10837-1-lvivier@redhat.com>
 <20200507134800.10837-7-lvivier@redhat.com>
 <20200513105105.GE3225@work-vm>
 <edc743ad-7e5d-ffc9-c0d0-676e4216386e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <edc743ad-7e5d-ffc9-c0d0-676e4216386e@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 13/05/2020 12:51, Dr. David Alan Gilbert wrote:
> > * Laurent Vivier (lvivier@redhat.com) wrote:
> >> This patch implements HMP version of the virtio QMP commands
> >>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > With a thought below....
> > 
> >> ---
> >>  Makefile                |   2 +-
> >>  Makefile.target         |   7 +-
> >>  docs/system/monitor.rst |   2 +
> >>  hmp-commands-virtio.hx  | 160 +++++++++++++++++++++++++++++++++
> >>  hmp-commands.hx         |  10 +++
> >>  hw/virtio/virtio.c      | 193 +++++++++++++++++++++++++++++++++++++++-
> >>  include/monitor/hmp.h   |   4 +
> >>  monitor/misc.c          |  17 ++++
> >>  8 files changed, 391 insertions(+), 4 deletions(-)
> >>  create mode 100644 hmp-commands-virtio.hx
> >>
> ...
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 66dc2cef1b39..c3d6b783417e 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> ...
> >> @@ -4033,6 +4092,92 @@ VirtioStatus *qmp_x_debug_virtio_status(const char* path, Error **errp)
> >>      return status;
> >>  }
> >>  
> >> +#define DUMP_FEATURES(type, field)                                         \
> >> +    do {                                                                   \
> >> +        type##FeatureList *list = features->device->u.field.data;          \
> >> +        if (list) {                                                        \
> >> +            monitor_printf(mon, "                    ");                   \
> >> +            while (list) {                                                 \
> >> +                monitor_printf(mon, "%s", type##Feature_str(list->value)); \
> >> +                list = list->next;                                         \
> >> +                if (list != NULL) {                                        \
> >> +                    monitor_printf(mon, ", ");                             \
> >> +                }                                                          \
> >> +            }                                                              \
> >> +            monitor_printf(mon, "\n");                                     \
> >> +        }                                                                  \
> >> +    } while (0)
> > 
> > It feels like you should be able to have an array of Feature_str's
> > indexed by VIRTIO_DEVICE_FEATURE_KIND_ enum, so that when a new
> > VIRTIO_DEVICE_FEATURE_KIND is added you don't need to fix this up.
> 
> I don't understand what you mean here.

Instead of the switch below, I'm thinking you could have something like:

    if (features->device->type < something_MAX) {
        features_str = anarray[features->device->type];

        ....
        monitor_printf(mon, "%s", features_str(list->value));
        ....
    }

with 'anarray' somewhere more central, so we don't have to keep
these switch structures and macros spread around.

Dave

> >> +
> >> +static void hmp_virtio_dump_features(Monitor *mon,
> >> +                                     VirtioStatusFeatures *features)
> >> +{
> >> +    VirtioTransportFeatureList *transport_list = features->transport;
> >> +    while (transport_list) {
> >> +        monitor_printf(mon, "%s",
> >> +                       VirtioTransportFeature_str(transport_list->value));
> >> +        transport_list = transport_list->next;
> >> +        if (transport_list != NULL) {
> >> +            monitor_printf(mon, ", ");
> >> +        }
> >> +    }
> >> +    monitor_printf(mon, "\n");
> >> +    switch (features->device->type) {
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_SERIAL:
> >> +        DUMP_FEATURES(VirtioSerial, virtio_serial);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_BLK:
> >> +        DUMP_FEATURES(VirtioBlk, virtio_blk);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_GPU:
> >> +        DUMP_FEATURES(VirtioGpu, virtio_gpu);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_NET:
> >> +        DUMP_FEATURES(VirtioNet, virtio_net);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_SCSI:
> >> +        DUMP_FEATURES(VirtioScsi, virtio_scsi);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_BALLOON:
> >> +        DUMP_FEATURES(VirtioBalloon, virtio_balloon);
> >> +        break;
> >> +    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_IOMMU:
> >> +        DUMP_FEATURES(VirtioIommu, virtio_iommu);
> >> +        break;
> >> +    default:
> >> +        g_assert_not_reached();
> >> +    }
> >> +    if (features->unknown) {
> >> +        monitor_printf(mon, "                    unknown(0x%016"PRIx64")\n", \
> >> +                       features->unknown);
> >> +    }
> >> +}
> ...
> 
> Thanks,
> Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


