Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB242067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb+xxs+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB242067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3P1-0001ZF-5m
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nc-0008AD-12
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3NZ-0006Xv-Tw
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3NZ-0006Vw-QM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1dKsuUbWfD5OIwrrNq1iWHaDUOTD0Yfi+NwoQ/d9JQ=;
 b=Gb+xxs+OEqH+FeSiX7jmseD1FiwZ8wTRo+7fZNNCSxfKgJb9jYz6vhMx0FGc7ari++3sjq
 0URJcOpjii/WoUhB/igmbdQzTBXrV6KpiZjtvHSQBj8HV5QYmB1eWa3fWlhrv/ph3Punbe
 hGyYAd/mvPegaAbRf92nBKYx7EWg3rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-wnmTBV8jNFKgNMcENNalTw-1; Mon, 27 Jan 2020 07:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CBC71005510;
 Mon, 27 Jan 2020 12:20:27 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A4A41001B08;
 Mon, 27 Jan 2020 12:20:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/15] intc/s390_flic_kvm.c: remove unneeded label in
 kvm_flic_load()
Date: Mon, 27 Jan 2020 13:20:03 +0100
Message-Id: <20200127122016.18752-3-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wnmTBV8jNFKgNMcENNalTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

'out' label can be replaced by 'return' with the appropriate
value that is set by 'r' right before the jump.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200106182425.20312-42-danielhb413@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index dddd33ea61c8..2e1e70c61d5b 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -439,17 +439,14 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, s=
ize_t size,
     count =3D qemu_get_be64(f);
     len =3D count * sizeof(struct kvm_s390_irq);
     if (count =3D=3D FLIC_FAILED) {
-        r =3D -EINVAL;
-        goto out;
+        return -EINVAL;
     }
     if (count =3D=3D 0) {
-        r =3D 0;
-        goto out;
+        return 0;
     }
     buf =3D g_try_malloc0(len);
     if (!buf) {
-        r =3D -ENOMEM;
-        goto out;
+        return -ENOMEM;
     }
=20
     if (qemu_get_buffer(f, (uint8_t *) buf, len) !=3D len) {
@@ -460,7 +457,6 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, siz=
e_t size,
=20
 out_free:
     g_free(buf);
-out:
     return r;
 }
=20
--=20
2.21.1


