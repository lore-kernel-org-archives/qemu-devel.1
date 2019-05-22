Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2AC072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89B821773
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU4ebq/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89B821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEnT-000616-TS
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:07:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hTEmF-0005QB-2J
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hTEmD-0002xu-0A
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:06:38 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hTEmC-0002wa-5d; Tue, 21 May 2019 20:06:36 -0400
Received: by mail-io1-xd42.google.com with SMTP id b3so377166iob.12;
	Tue, 21 May 2019 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=GELshUJMcfsyuLTBAGnahSvgqmRmNRDjtImZZ+mDnUw=;
	b=sU4ebq/FVDvF9K9dMNZQInCIthxFZ5ycUbWoW3B0o3Nko73jFVLUJIXSUGlKB8pOKm
	kaJqGjRS8EuZ9n69GEfproAX1DRD4miCRBk0XQ2SSku6/GCcoXZ/JZORxqIw75+7VQ06
	jFHqzyRda0f0oGYvvukBeafzMnu9Tz2CMN6rzh0+mjtpZQCcAIZnMG5ihc1SfdIYYTzB
	FD00Aj6Q8h24Pxucbj8hb/80A7SZw4xzdzZLqtH4DyOw6xlFEkt5QG0jkbOAjI9h3rlu
	Ksl3QAvIMKBJVBKX/sXrPgUw3v2N6djWTlfZECerGGGKB+zIedWMJHAL+BNoomCBXrC+
	k8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GELshUJMcfsyuLTBAGnahSvgqmRmNRDjtImZZ+mDnUw=;
	b=VeHv5d9VShQW9fZ6LGt+aSUV1dwuP+n1SlxO5dM7Z/EtDD8PQ7PDO3a2MOZxYgbd7J
	YSfZrcpv5TJPHvIaZ1g0pNUW7b53GuHBlXuickvZRzGCOetByarW53s0iEwIBkBT+Pff
	hGKZnKG7+Vl3MoZcrjnZaocn6qCOFbq+dleP8zNkOa/PJGXDZx2g6VoCxMd1tFENv1l3
	v0K/ilix+kDBFVkJlungiDYHN6o0tZ55EiXYM6kAwgAH0IbCsgwsCmoMFYCRnqBnFYG6
	Wt/icLGS6CmsMXsHfR9xgv8xDxu7l+uY0C13u5k/jxOCNvsOxyX38sIs8FPPFovlYlPu
	1Zaw==
X-Gm-Message-State: APjAAAVrQG36Mu/5a4JjXuug1d+ffp2k/YmPzUVmyh1WEnujSdFq2YVP
	fYgD/PP9IldnOY0m7SPFy/ZATRjm
X-Google-Smtp-Source: APXvYqxY79XdmtytV1QNNeYZZGHL9+8bGbpdvEl9EJ3GGqXZwXlmZTBfW5xTIFz8dArDHDdVguD+Lw==
X-Received: by 2002:a5d:8589:: with SMTP id f9mr7990317ioj.274.1558483593719; 
	Tue, 21 May 2019 17:06:33 -0700 (PDT)
Received: from localhost.localdomain (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id k1sm6897920ioc.71.2019.05.21.17.06.32
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Tue, 21 May 2019 17:06:32 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rth@twiddle.net,
	david@gibson.dropbear.id.au
Date: Tue, 21 May 2019 20:06:17 -0400
Message-Id: <20190522000617.21945-1-programmingkidx@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: [Qemu-devel] [PATCH] Implement Fraction Rounded bit in FPSCR for
 PowerPC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the PowerPC floating point status and control register flag Fraction Rounded.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 fpu/softfloat.c               | 15 ++++++++++++---
 include/fpu/softfloat-types.h |  1 +
 target/ppc/fpu_helper.c       |  4 ++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec370..ac34f6a2de 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -702,7 +702,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     const uint64_t roundeven_mask = parm->roundeven_mask;
     const int exp_max = parm->exp_max;
     const int frac_shift = parm->frac_shift;
-    uint64_t frac, inc;
+    uint64_t frac, inc, rounded;
     int exp, flags = 0;
     bool overflow_norm;
 
@@ -744,7 +744,12 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
         if (likely(exp > 0)) {
             if (frac & round_mask) {
                 flags |= float_flag_inexact;
-                frac += inc;
+                rounded = frac + inc;
+                if ((rounded ^ frac) & frac_lsb) {
+                    flags |= float_flag_rounded;
+                }
+                frac = rounded;
+
                 if (frac & DECOMPOSED_OVERFLOW_BIT) {
                     frac >>= 1;
                     exp++;
@@ -793,7 +798,11 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
                     break;
                 }
                 flags |= float_flag_inexact;
-                frac += inc;
+                rounded = frac + inc;
+                if ((rounded ^ frac) & frac_lsb) {
+                    flags |= float_flag_rounded;
+                }
+                frac = rounded;
             }
 
             exp = (frac & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b1..bee576e0fd 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -147,6 +147,7 @@ enum {
 
 enum {
     float_flag_invalid   =  1,
+    float_flag_rounded   =  2,
     float_flag_divbyzero =  4,
     float_flag_overflow  =  8,
     float_flag_underflow = 16,
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0b7308f539..0baf1ce8e4 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -630,6 +630,10 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
         env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
     }
 
+    /* Set or clear the Fraction Rounded bit */
+    env->fpscr = deposit32(env->fpscr, FPSCR_FR, 1,
+                           (status & float_flag_rounded) != 0);
+
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
         (env->error_code & POWERPC_EXCP_FP)) {
         /* Differred floating-point exception after target FPR update */
-- 
2.14.3 (Apple Git-98)


