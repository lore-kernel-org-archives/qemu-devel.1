Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98FC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEDF24692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTfqtBf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEDF24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HrQ-0001ib-4V
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7Hkx-0008MH-Dy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7Hkw-0001qX-5Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7Hkw-0001p8-0E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582804505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNDoCxti1ZKjwsCGkBle4NieXpATQtFMULFFc50WaEM=;
 b=KTfqtBf6fkGmhMZmz+dj7iPzhdhrHytYG+GRtYd2NiIyCsKf14N7Il3h/ptou1F456WzwV
 BqKEsyOqyrj5qrPUxztsA9K2GvbzDiqnf1qHKBaKID4BWIqttCqDo8ZLuoYc1GSkBns0M6
 t7q9w/j6LX4FWnNyR32oeBZXYMbsbBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-aoBpAtqgO2-vJfOOZxAPbg-1; Thu, 27 Feb 2020 06:55:03 -0500
X-MC-Unique: aoBpAtqgO2-vJfOOZxAPbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100B31937FC2;
 Thu, 27 Feb 2020 11:55:02 +0000 (UTC)
Received: from localhost (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8D919C58;
 Thu, 27 Feb 2020 11:54:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/7] s390x: Rename and use constants for short PSW address and
 mask
Date: Thu, 27 Feb 2020 12:54:31 +0100
Message-Id: <20200227115431.32364-8-cohuck@redhat.com>
In-Reply-To: <20200227115431.32364-1-cohuck@redhat.com>
References: <20200227115431.32364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's rename PSW_MASK_ESA_ADDR to PSW_MASK_SHORT_ADDR because we're
not working with a ESA PSW which would not support the extended
addressing bit. Also let's actually use it.

Additionally we introduce PSW_MASK_SHORT_CTRL and use it throughout
the codebase.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200227092341.38558-1-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c     | 2 +-
 target/s390x/cpu.c | 4 ++--
 target/s390x/cpu.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0817874b4874..9c1ecd423c23 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **=
errp)
                 /* if not Linux load the address of the (short) IPL PSW */
                 ipl_psw =3D rom_ptr(4, 4);
                 if (ipl_psw) {
-                    pentry =3D be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
+                    pentry =3D be32_to_cpu(*ipl_psw) & PSW_MASK_SHORT_ADDR=
;
                 } else {
                     error_setg(&err, "Could not get IPL PSW");
                     goto error;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8da1905485f9..3dd396e87035 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
     S390CPU *cpu =3D S390_CPU(s);
     uint64_t spsw =3D ldq_phys(s->as, 0);
=20
-    cpu->env.psw.mask =3D spsw & 0xffffffff80000000ULL;
+    cpu->env.psw.mask =3D spsw & PSW_MASK_SHORT_CTRL;
     /*
      * Invert short psw indication, so SIE will report a specification
      * exception if it was not set.
      */
     cpu->env.psw.mask ^=3D PSW_MASK_SHORTPSW;
-    cpu->env.psw.addr =3D spsw & 0x7fffffffULL;
+    cpu->env.psw.addr =3D spsw & PSW_MASK_SHORT_ADDR;
=20
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8a557fd8d176..1d17709d6e10 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -276,7 +276,8 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_RI             0x0000008000000000ULL
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
-#define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
+#define PSW_MASK_SHORT_ADDR     0x000000007fffffffULL
+#define PSW_MASK_SHORT_CTRL     0xffffffff80000000ULL
=20
 #undef PSW_ASC_PRIMARY
 #undef PSW_ASC_ACCREG
--=20
2.21.1


