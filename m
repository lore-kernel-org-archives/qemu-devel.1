Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA928C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E777206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5ZrTSIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E777206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDFc-0003Qt-Nk
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jcDEv-0002ro-1b
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:21:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jcDEt-0007IM-Hl
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590175309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RufgAS4IBh0kLNoRk3mNIq3bV+0ETlkKGv6QKHXr2A=;
 b=R5ZrTSIMdyzPzZog3fpM0EmcdNZyfNgtNumY2E/pHCfeJ5OPwGLE3ZVqKtOUvLNodR3mf2
 uFu21SlpPl9RZBtfiXc1fqQKGNYLPUMkb4psYdjN3RMi+QnH+yEQFiQ2SCKcHzvA1bKXXI
 dcR3Gy/Ha4SHc4nUPbwEfdfUEEsV3vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-RuqRYAT5PVm0bUfyPxRvug-1; Fri, 22 May 2020 15:21:47 -0400
X-MC-Unique: RuqRYAT5PVm0bUfyPxRvug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52719102CC2E;
 Fri, 22 May 2020 19:21:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43E3A6EA3C;
 Fri, 22 May 2020 19:21:46 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2BB5B1809542;
 Fri, 22 May 2020 19:21:46 +0000 (UTC)
Date: Fri, 22 May 2020 15:21:45 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <141172567.27998044.1590175305826.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200522171726.648279-2-stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-2-stefanha@redhat.com>
Subject: Re: [PATCH 1/5] tests/libqos: mask out VIRTIO_F_RING_PACKED for now
MIME-Version: 1.0
X-Originating-IP: [217.92.231.145, 10.4.196.27, 10.5.101.130, 10.4.195.18]
Thread-Topic: tests/libqos: mask out VIRTIO_F_RING_PACKED for now
Thread-Index: krMnpo2erdhVwqWc4eNm6VOk3Tl+9w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Friday, May 22, 2020 7:17:22 PM
> 
> The libqos VIRTIO code does not implement the packed virtqueue layout
> yet. Mask out the feature bit for now because tests have a habit of
> enabling all device feature

Sounds like we should rather fix these tests in the long run - they
should really only enable the bits that they support...

> bits and we don't want packed virtqueues to
> be enabled.
> 
> Later patches will enable VIRTIO_F_RING_PACKED so prepare libqos now.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qtest/libqos/virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 9aa360620c..1c3f4a0c8b 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -96,7 +96,8 @@ uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t
> addr)
>  
>  uint64_t qvirtio_get_features(QVirtioDevice *d)
>  {
> -    return d->bus->get_features(d);
> +    /* qvirtio does not support packed virtqueues yet */
> +    return d->bus->get_features(d) & ~(1ull << VIRTIO_F_RING_PACKED);
>  }

... but as a temporary work-around, that should be fine, too.
(in case you respin, maybe add a TODO comment here, too, to remind us to fix
the tests later).

Acked-by: Thomas Huth <thuth@redhat.com>


