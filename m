Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC4C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2808A20644
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMn9KZ/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2808A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTuhT-0003wm-DW
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:52:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZz-0006CL-4A
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZw-0003Ho-1c
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:45 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:42636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZv-0003Ff-SO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:43 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id a21so2782555ybg.9
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=06P+BrsS8Wgfkpmivdl7rtQvDnn06OvuBRIH+NIQTdk=;
	b=iMn9KZ/dPRhsy0owQd++Y+KxKPwSakEro6GIGJ83BUKA+WiPhty6qjoA0qE29TsK3a
	dSetkpaw6o1evI4SA1IEFIdjSGCJj4Xbdv6Q1yQTRGAjSL++RLWj/7YlQa1ERjJ1GYXW
	2A6zMR5rwO07Xuxqt9QvhsbjKXl6zwjfoZHh0hJmOUMc2WlRqlhwRNuGAukyKMt4kXTp
	IxV5eo+Uz91SmuDldM7IViYnjZ+H5q98ZnwCTMnBoKEsHF1KfaDKc6Sp2/OeHz88MxRo
	gNASwAYoTg8pCPPBCKC1eyZq2zmc4MJROdKfpQeY/OSuEuwMdLLEgr4N4f1x8WQIcGzt
	54fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=06P+BrsS8Wgfkpmivdl7rtQvDnn06OvuBRIH+NIQTdk=;
	b=ds3QKt4e5Ho9jchN5YNy+2dPIQcB7T+X/SY+vT2SL0vll36kMN8ELvuQ21MQ8km55e
	/15l/NLEVcCEZtb8UZIDYTR+Q4kENGdXKilu/OkC/4FXsm7DaV96PQKpTzjYePutJyP9
	ah7lDJiQjIMoP0/gIsWd2aAUdqR6As28GVvUc7EHdK7TEiL6MDkJ8lPUv15CcNKnntBJ
	jXz3txtJZmGin02FdAqXcA/qmjfuB4ChfbeoGLcqikEk++vBIFdAcuomKcB0oZWYnLpX
	to7mcsTri37HwNJiz8ZP2Odb50S303jXsMRD4D2lUWTOZpCjjk+655adtfxeXzYdrdMY
	+wQA==
X-Gm-Message-State: APjAAAUTOhaf1qjC4h4oMtTfE9fU39crX3rFLZPYIk8CdUKsJL5XitWK
	1XTWWpulYv5R6l5/lrVu/slOXCF3
X-Google-Smtp-Source: APXvYqz1C2Id0Koqf+UbbDJjqnM3Pc0qym0TMk258BksGxRjlnNW80bBTo6VFuTTeDl1BR+KnMU8UA==
X-Received: by 2002:a25:138a:: with SMTP id 132mr45212293ybt.127.1558644282987;
	Thu, 23 May 2019 13:44:42 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:42 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:08 -0400
Message-Id: <20190523204409.21068-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2b
Subject: [Qemu-devel] [RISU v3 10/11] risu_reginfo_i386: replace xfeature
 constants with symbolic names
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The original code used "magic numbers", which made it unclear in
some places. Include a reference to the Intel manual where the
constants' meaning is discussed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 83f9541..01ea179 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -22,7 +22,25 @@
 
 #include <asm/sigcontext.h>
 
-static uint64_t xfeatures = 3;  /* SSE */
+/*
+ * Refer to "Intel(R) 64 and IA-32 Architectures Software Developer's
+ * Manual", Volume 1, Section 13.1 "XSAVE-Supported Features and
+ * State-Component Bitmaps" for detailed discussion of these constants
+ * and their meaning.
+ */
+enum {
+    XFEAT_X87              = 1 << 0,
+    XFEAT_SSE              = 1 << 1,
+    XFEAT_AVX              = 1 << 2,
+    XFEAT_AVX512_OPMASK    = 1 << 5,
+    XFEAT_AVX512_ZMM_HI256 = 1 << 6,
+    XFEAT_AVX512_HI16_ZMM  = 1 << 7,
+    XFEAT_AVX512           = XFEAT_AVX512_OPMASK
+                           | XFEAT_AVX512_ZMM_HI256
+                           | XFEAT_AVX512_HI16_ZMM
+};
+
+static uint64_t xfeatures = XFEAT_X87 | XFEAT_SSE;
 
 static const struct option extra_ops[] = {
     {"xfeatures", required_argument, NULL, FIRST_ARCH_OPT },
@@ -160,34 +178,34 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
      * Now we know that _fpstate contains XSAVE data.
      */
 
-    if (features & (1 << 2)) {
+    if (features & XFEAT_AVX) {
         /* YMM_Hi128 state */
-        void *buf = xsave_feature_buf(xs, 2);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX);
         for (i = 0; i < nvecregs; ++i) {
             memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
         }
     }
 
-    if (features & (1 << 5)) {
+    if (features & XFEAT_AVX512_OPMASK) {
         /* Opmask state */
-        uint64_t *buf = xsave_feature_buf(xs, 5);
+        uint64_t *buf = xsave_feature_buf(xs, XFEAT_AVX512_OPMASK);
         for (i = 0; i < 8; ++i) {
             ri->kregs[i] = buf[i];
         }
     }
 
-    if (features & (1 << 6)) {
+    if (features & XFEAT_AVX512_ZMM_HI256) {
         /* ZMM_Hi256 state */
-        void *buf = xsave_feature_buf(xs, 6);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX512_ZMM_HI256);
         for (i = 0; i < nvecregs; ++i) {
             memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
         }
     }
 
 #ifdef __x86_64__
-    if (features & (1 << 7)) {
+    if (features & XFEAT_AVX512_HI16_ZMM) {
         /* Hi16_ZMM state */
-        void *buf = xsave_feature_buf(xs, 7);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX512_HI16_ZMM);
         for (i = 0; i < 16; ++i) {
             memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
         }
@@ -243,7 +261,7 @@ static const char *const regname[NGREG] = {
 static int get_nvecregs(uint64_t features)
 {
 #ifdef __x86_64__
-    return features & (1 << 7) ? 32 : 16;
+    return features & XFEAT_AVX512_HI16_ZMM ? 32 : 16;
 #else
     return 8;
 #endif
@@ -251,9 +269,9 @@ static int get_nvecregs(uint64_t features)
 
 static int get_nvecquads(uint64_t features)
 {
-    if (features & (1 << 6)) {
+    if (features & XFEAT_AVX512_ZMM_HI256) {
         return 8;
-    } else if (features & (1 << 2)) {
+    } else if (features & XFEAT_AVX) {
         return 4;
     } else {
         return 2;
@@ -262,9 +280,9 @@ static int get_nvecquads(uint64_t features)
 
 static char get_vecletter(uint64_t features)
 {
-    if (features & (1 << 6 | 1 << 7)) {
+    if (features & (XFEAT_AVX512_ZMM_HI256 | XFEAT_AVX512_HI16_ZMM)) {
         return 'z';
-    } else if (features & (1 << 2)) {
+    } else if (features & XFEAT_AVX) {
         return 'y';
     } else {
         return 'x';
@@ -301,7 +319,7 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
         }
     }
 
-    if (features & (1 << 5)) {
+    if (features & XFEAT_AVX512_OPMASK) {
         for (i = 0; i < 8; i++) {
             fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
         }
-- 
2.20.1


