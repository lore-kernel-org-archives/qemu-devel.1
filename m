Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF1DC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AC820675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz3g8Bl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AC820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnm9-0007Yu-0U
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:03:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbq-0007mR-6D
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbp-0004Et-3q
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbo-0004EX-UD
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id n8so3723863plp.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=yjaWcvw9UbJX/NgPrNoAKyN+ZZwbI4Jl9YPntsAKSX4=;
	b=Pz3g8Bl5GlOK0uwydAsWCYeYWC4KXpsFIrBDgck9hqexVJzxjQdxiZRIg9AeofZhlI
	wTq5sXhsVEeuU4S2iMaUOPFu/BGBRHqtVexRT5jGr4W4sxf8SXS/ie6CvDQK6vgf+iXI
	/yQYbDzorhvKB9919zp2x4XQ+FVBaESiK8iPqtLHLY2nqTCbHCiYpKRfwKcYTJIYrcVJ
	ZgFKqSFXtraEDq7o67zyuyAfWUgKTU+nSq/BYKm6XhvimIoJxJVEfYBo+iH53lwRaB8J
	Aq2FXASGaBP+jfT9QFxObwIjUKnEQkpTEygDLutgd62x7T7NeVcI1tTaR0zjB1WARknB
	P9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=yjaWcvw9UbJX/NgPrNoAKyN+ZZwbI4Jl9YPntsAKSX4=;
	b=Gg1ZyNQ4+tkECQJ8kAHkbdlGhbJqIaCrssY16XXVKCU7UejgZVAwmGlYJ+6hUSIyrS
	vNlGUdwMkxVaWafhw9QbU/vKUDk8RtpPRx5lp+m7qq+wHd/z91llV5wdpkxTyoy8bbhE
	Ldw6zj8cpXKCUbME6PvNSls9W8bWm4OzlipZSMsv+s1RzIAVgF/fSyjTUkMZdbopDSLh
	NfQ4pbURO7+7ub70pIqdNBlz0NNxPdX6u0l3edEHIOvWcLzMcC1Zzd2ndFXYPBuQ92xq
	Zg22WFXChLkDdzsDnFDgRwfuVpdZVhVToO+lwxqpVErjWkAWU2E2LDPwn72NY4PoZLSD
	fb2g==
X-Gm-Message-State: APjAAAXX4hDx7xu/4JOtg8efVx0dSZE3BAG0RmnzrjnRw2uZeY06fhz9
	0p4R2+ECjQjfnGhV2ElEKty0Khefn1s=
X-Google-Smtp-Source: APXvYqxFU7KvjqpPEOXfiIgIk86AhJpKIaCSJKUi6JuVk/u9s4rSwiC3v1b8epbZOlcNgEJf8BhS2A==
X-Received: by 2002:a17:902:521:: with SMTP id
	30mr15799157plf.248.1556949195769; 
	Fri, 03 May 2019 22:53:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:40 -0700
Message-Id: <20190504055300.18426-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 11/31] tcg: Add tcg_out_dupm_vec to the
 backend interface
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055240.qvvC9wlzNPgGytBEMb9nPIzg0uzIkR6nZLUuQO7FWPA@z>

Currently stubbed out in all backends that support vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  6 ++++++
 tcg/i386/tcg-target.inc.c    |  7 +++++++
 tcg/tcg.c                    | 19 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3cefdd1e43..4a3cfa778a 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -822,6 +822,12 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3c8229d413..f04933bc19 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -891,6 +891,13 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
+
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg ret, tcg_target_long arg)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2b715bf099..b9945794c4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -111,6 +111,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg dst, TCGReg base, intptr_t offset);
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg dst, tcg_target_long arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
@@ -122,6 +124,11 @@ static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 {
     g_assert_not_reached();
 }
+static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, TCGReg base, intptr_t offset)
+{
+    g_assert_not_reached();
+}
 static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                                     TCGReg dst, tcg_target_long arg)
 {
@@ -3422,6 +3429,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     TCGRegSet dup_out_regs, dup_in_regs;
     TCGTemp *its, *ots;
     TCGType itype, vtype;
+    intptr_t endian_fixup;
     unsigned vece;
     bool ok;
 
@@ -3491,7 +3499,16 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         /* fall through */
 
     case TEMP_VAL_MEM:
-        /* TODO: dup from memory */
+#ifdef HOST_WORDS_BIGENDIAN
+        endian_fixup = itype == TCG_TYPE_I32 ? 4 : 8;
+        endian_fixup -= 1 << vece;
+#else
+        endian_fixup = 0;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, vece, ots->reg, its->mem_base->reg,
+                             its->mem_offset + endian_fixup)) {
+            goto done;
+        }
         tcg_out_ld(s, itype, ots->reg, its->mem_base->reg, its->mem_offset);
         break;
 
-- 
2.17.1


