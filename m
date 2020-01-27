Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CCAC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FAE2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0OYtCKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FAE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Ox-0001Ms-5I
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3NY-00086c-I9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3NX-0006VO-Dl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3NX-0006VC-AK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKsAHQQ7z+2VhSIav2j26ciHYIwhGE8V/yMvzmm1J/0=;
 b=S0OYtCKeQ6PdWnJ0NogyTYzu3KufNbvOIe7CDJWH2D9eYjjLgTeERqjW+jf/xDhbfx0Ig4
 mReoZZIbpYcjhOngUOTxlG3Y1UCpcmVl6leF8Fh52Tiq0l/7Oo+vocAKyVgiod/WmqmyjE
 b+DjfKBtash05zp3GqHIgLXyGn44mEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-mEvPC_4IPq6ELqEaOZnq-g-1; Mon, 27 Jan 2020 07:20:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 518AC1800D41;
 Mon, 27 Jan 2020 12:20:25 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E61CE5C1D6;
 Mon, 27 Jan 2020 12:20:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/15] s390x/sclp.c: remove unneeded label in
 sclp_service_call()
Date: Mon, 27 Jan 2020 13:20:02 +0100
Message-Id: <20200127122016.18752-2-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mEvPC_4IPq6ELqEaOZnq-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

'out' label can be replaced by 'return' with the appropriate
value. The 'r' integer, which is used solely to set the
return value for this label, can also be removed.

CC: Cornelia Huck <cohuck@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200106182425.20312-39-danielhb413@gmail.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f57ce7b73943..af0bfbc2eca7 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -197,24 +197,20 @@ int sclp_service_call(CPUS390XState *env, uint64_t sc=
cb, uint32_t code)
 {
     SCLPDevice *sclp =3D get_sclp_device();
     SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
-    int r =3D 0;
     SCCB work_sccb;
=20
     hwaddr sccb_len =3D sizeof(SCCB);
=20
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        r =3D -PGM_PRIVILEGED;
-        goto out;
+        return -PGM_PRIVILEGED;
     }
     if (cpu_physical_memory_is_io(sccb)) {
-        r =3D -PGM_ADDRESSING;
-        goto out;
+        return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) =3D=3D 0 || (sccb & ~0x1fffUL) =3D=3D env->psa
         || (sccb & ~0x7ffffff8UL) !=3D 0) {
-        r =3D -PGM_SPECIFICATION;
-        goto out;
+        return -PGM_SPECIFICATION;
     }
=20
     /*
@@ -226,8 +222,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb=
, uint32_t code)
=20
     /* Valid sccb sizes */
     if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
-        r =3D -PGM_SPECIFICATION;
-        goto out;
+        return -PGM_SPECIFICATION;
     }
=20
     switch (code & SCLP_CMD_CODE_MASK) {
@@ -257,8 +252,7 @@ out_write:
=20
     sclp_c->service_interrupt(sclp, sccb);
=20
-out:
-    return r;
+    return 0;
 }
=20
 static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
--=20
2.21.1


