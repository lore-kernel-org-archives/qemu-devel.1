Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C1121556
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpLINvgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcGB-00059I-St
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcFb-0004bt-8X
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:53:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcFZ-0000L5-34
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592416404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9uliBsP0an46gPx+oD2wPLvOfI9JPxFlPTJ+G83rjdw=;
 b=DpLINvgT5zHumSDMC6AWxDJDIBzlW5zX8E+wK33zpgOLfJTvIyB8MzUVg7NCZpbvkCV8Gs
 ixODI8VxHVjwKpeHq6K1dPqnpEb9QEOQp+SLWsUUnq3QXyd8J89gph0woAYZPcbKc8iRJO
 /WGA/ShVL47GORxhBlngYD7BramNP4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-MVvxKsLKM2GGAUSbxMZzxQ-1; Wed, 17 Jun 2020 13:53:20 -0400
X-MC-Unique: MVvxKsLKM2GGAUSbxMZzxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC01D100CCCE;
 Wed, 17 Jun 2020 17:53:19 +0000 (UTC)
Received: from work-vm (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7C2F19931;
 Wed, 17 Jun 2020 17:53:11 +0000 (UTC)
Date: Wed, 17 Jun 2020 18:53:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 13/21] hmp: Handle virtio-mem when printing memory
 device info
Message-ID: <20200617175309.GJ2776@work-vm>
References: <20200610115419.51688-1-david@redhat.com>
 <20200610115419.51688-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610115419.51688-14-david@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Print the memory device info just like for other memory devices.
> 
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor/hmp-cmds.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9c61e769ca..afc9a28069 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1818,6 +1818,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>      MemoryDeviceInfoList *info;
>      VirtioPMEMDeviceInfo *vpi;
> +    VirtioMEMDeviceInfo *vmi;
>      MemoryDeviceInfo *value;
>      PCDIMMDeviceInfo *di;
>  
> @@ -1852,6 +1853,21 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                  monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
>                  monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
> +                vmi = value->u.virtio_mem.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               vmi->id ? vmi->id : "");
> +                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vmi->memaddr);
> +                monitor_printf(mon, "  node: %" PRId64 "\n", vmi->node);
> +                monitor_printf(mon, "  requested-size: %" PRIu64 "\n",
> +                               vmi->requested_size);
> +                monitor_printf(mon, "  size: %" PRIu64 "\n", vmi->size);
> +                monitor_printf(mon, "  max-size: %" PRIu64 "\n", vmi->max_size);
> +                monitor_printf(mon, "  block-size: %" PRIu64 "\n",
> +                               vmi->block_size);
> +                monitor_printf(mon, "  memdev: %s\n", vmi->memdev);
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


