Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F938C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DCB206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFhOGUfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DCB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOXJ-0004gt-F9
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOPc-0007ql-3T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOPa-0007hC-Kn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:27:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOMcQ-0008Qd-TP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586874774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usud7HQtWcVJijpTkz2PO4OweNTy74ApJTA60pfgfLM=;
 b=DFhOGUfOTTJP6d9KA3XWjHzbqZGTM6T3mf9pEpeSwxA6BkKO3zIBPrkDTmzG/OOuJ8mxlw
 atbj152AKAA3NuAPZSo7Hk9SuHaKL7Ql1ALE3Kax+c0PQfbkWiLmPtBqe7auQjYFH6kSJf
 ALlckXLfw6h5bOYnNNgw4G4/YywzRH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-3QdrhU5nOTm36XNY5UTgbw-1; Tue, 14 Apr 2020 10:32:53 -0400
X-MC-Unique: 3QdrhU5nOTm36XNY5UTgbw-1
Received: by mail-wr1-f72.google.com with SMTP id s11so3916729wru.6
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DlcgVz7EPaAP2AnC9Mg/H61s7VGki7VELu66pHcsX8M=;
 b=p2z3cX35rOiHhWn/AdfJEuzQj7F7OZ09QP3Q1Vcrg2QkYykhsSSyYpaDxwGzIRf5kb
 ALdePEFWg8rHTmV6sgNirTlv4iSgU7cwn2asJsKF6P4abnS0EN+UpRjouVaDhyye9KzM
 G8PnNMwIPYewLKu/6jBytBKDSg05x/82+73syCN/N3096zeIJrBYhEJqOX8VLRdQayBD
 NAe/6Tzs9ZkUdtgnlOG/MuUU7/kSfYuAsWyLKQ+J5UYRjlGS11ZkMKW3SasQ4FvqKos3
 1N0saI4sa6+TOVifuYTDqUr5W4NOZT647/lzEsqkowrge/RfkdciXy3HyES4YoWhlYvJ
 wLiw==
X-Gm-Message-State: AGi0PubUS1a8NTtCckdNrv61lcSJzSV0z2QgofCT8Rc6C5KgYMig3H/J
 FmFcwjMlay9GKz7LJu7FJm3QZocQDaZSD7pQW0iE1M7fhtuQnzXqj8yc3+/vDrRinLa0fXq31WK
 GGTawKYrR15NkVE8=
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr23395490wrm.161.1586874771788; 
 Tue, 14 Apr 2020 07:32:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLziDO4Yb83DWlpveulj3lVb9bkkfCKws6I53ZNVAwfcHGSn8jSeivxZ0iY1ozoLCkfoEg+Gw==
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr23395478wrm.161.1586874771613; 
 Tue, 14 Apr 2020 07:32:51 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q187sm19020295wma.41.2020.04.14.07.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 07:32:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 2/2] gdbstub: Introduce gdb_get_float64() to get
 64-bit float registers
Date: Tue, 14 Apr 2020 16:32:40 +0200
Message-Id: <20200414143240.21764-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414143240.21764-1-philmd@redhat.com>
References: <20200414143240.21764-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When converted to use GByteArray in commits 462474d760c and
a010bdbe719, the call to stfq_p() was removed. This call
serialize a float.
Since we now use a GByteArray, we can not use stfq_p() directly.
Introduce the gdb_get_float64() helper to load a float64 register.

Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/gdbstub.h          | 12 ++++++++++++
 target/m68k/helper.c            |  3 ++-
 target/ppc/gdbstub.c            |  4 ++--
 target/ppc/translate_init.inc.c |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 3caca99416..ef88cefbf6 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -137,6 +137,18 @@ static inline int gdb_get_float32(GByteArray *array, f=
loat32 val)
     return sizeof(buf);
 }
=20
+static inline int gdb_get_float64(GByteArray *array, float64 val)
+{
+    uint8_t buf[8];
+
+    QEMU_BUILD_BUG_ON(sizeof(CPU_DoubleU) !=3D sizeof(buf));
+
+    stfq_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     for (size_t i =3D 0; i < len; i++) {
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c637..cc80b48dda 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,7 +72,8 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArr=
ay *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d,=
 &s));
+        return gdb_get_float64(mem_buf,
+                               floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index eb362dd9ae..5c11c88b2a 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -130,7 +130,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray =
*buf, int n)
         gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -184,7 +184,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByte=
Array *buf, int n)
         gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
         gdb_get_reg64(buf, n - 64);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c
index e853164a86..d825cb5975 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9881,7 +9881,7 @@ static int gdb_get_float_reg(CPUPPCState *env, GByteA=
rray *buf, int n)
 {
     uint8_t *mem_buf;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n));
         mem_buf =3D gdb_get_reg_ptr(buf, 8);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
--=20
2.21.1


