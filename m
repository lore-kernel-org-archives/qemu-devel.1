Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99244CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A44205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVkBbmp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A44205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNh1O-0001JQ-FO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNghV-0002cd-O8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNghU-00023Y-OM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNghU-00023O-LQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHi/ZcZkuogsRdwJr7LU741XrjKiy2gJElKC2Qe6S0E=;
 b=OVkBbmp9bdPHTi8VUfOHOGnKYXT928/IptIFmlUqyVKFP9qQbqFUDRLXrKK0N4tsC4OvmB
 ItTYU5qXIUthAwXJG3Sn8L+j/7fJvQ2UVwq16sKcUAI8n0h46441doXWeTYxf8CRiQ2q2n
 GG08GP3vLQFSZntGCR7xAcLwrCpNTFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-YEA7LjBPM6G2_I9af-Bt7A-1; Thu, 24 Oct 2019 13:15:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B54107AD31;
 Thu, 24 Oct 2019 17:14:59 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB9E61F21;
 Thu, 24 Oct 2019 17:14:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 8/9] virtio: add some rcu comments
Date: Thu, 24 Oct 2019 19:14:05 +0200
Message-Id: <20191024171406.12504-9-eperezma@redhat.com>
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
References: <20191024171406.12504-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YEA7LjBPM6G2_I9af-Bt7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 hw/virtio/virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3cf12a62c0..9195b08da8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -278,6 +278,7 @@ static void vring_packed_flags_write(VirtIODevice *vdev=
,
     address_space_cache_invalidate(cache, off, sizeof(flags));
 }
=20
+/* Called within rcu_read_lock().  */
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *=
vq)
 {
     VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.caches)=
;
@@ -721,7 +722,6 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
     return true;
 }
=20
-/* Called within rcu_read_lock().  */
 static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement *el=
em,
                     unsigned int len, unsigned int idx)
 {
@@ -780,6 +780,7 @@ static void virtqueue_packed_fill_desc(VirtQueue *vq,
     vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head, strict_o=
rder);
 }
=20
+/* Called within rcu_read_lock().  */
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
--=20
2.16.5


