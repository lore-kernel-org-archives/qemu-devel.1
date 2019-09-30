Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF91C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA6522501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5IRgzIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA6522501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2D8-0006Y5-Hq
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Aq-0004XN-UE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ap-0005Yt-R4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Ap-0005Ya-LJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so6246138pfl.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jt4e+35BxFKMSgr66A8AIeO8Hu+tEBevMhkRfs63fGs=;
 b=V5IRgzIzQiJ+TOivhjXM/0za0vmdkwluRjlCZS+5xKof3oAfj8jxuug4ARSi7KOFFB
 m9nDrQJeceH5WRmqAbCgWzmSF5VvKpQd9m4u7/d8uRmruuNMCFlV6J/jAX6pyGyTnqPw
 aN2y5n4oHdJokCwWh4TUBMjcqChEsxTb6zoiyzhzUqFwUMVTB++/SDNlTzKYxK9Z2fAd
 38aji2WhXdoMvF5NOPH5kO0JF+KkJ4JwlgHQZgxDFsMPjn0VKq3Pxpe6rmm88InZMI7/
 hjuVOICzBrV3bH6T8WIevKSM6koKLupQ5ZWaELOduzoR2Csq0bbwaKkVxs37+/0NE5ay
 PtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jt4e+35BxFKMSgr66A8AIeO8Hu+tEBevMhkRfs63fGs=;
 b=BIeYCPVcTKPtU21VI3SEeBQDZ7kI1RIHIpTSca8In6qCdBgw9VppcIO9bRVMb2enfI
 y+7Jw6O8Z8n3TRDFGD19iQ/8FFiiVCgO+dl4kEX/CGJRmyK5bTkWRaVzI9DaDiDZww7S
 /PeANbakTwfNzd9hAUTxnwA7QqS+HsASdIwhYxca/HxgzUzjkMCUIshvg/GJiM5y5U7B
 T+oAqD305FpBJMrOqOUWVOSp/hYgXRzJl+fmVVxEuuqbBGzY9xxRgxRL+wDlAEvpu+TD
 MK8BgCkpTZDaDPCrcvn5MTsqBd1vXMlAGsM3LE2Ix0ePmBHhIiTSsFiVjHsxUwNbNTlY
 T2Uw==
X-Gm-Message-State: APjAAAU52y1hOwDuXJ1QXLjozugnJuZAnKpO196o2ZJ6mHxwp7ap4W+t
 vanlqO8yKfYaE06HfPoiGR8LIf67rYc=
X-Google-Smtp-Source: APXvYqzY6Lr0cxKejNrYddVagjQe7B3OO5veAdr/F5kCxfa59pWAJcF+iI/8QMiLVSFJMtzYmYdOgg==
X-Received: by 2002:a63:9d04:: with SMTP id i4mr13621881pgd.254.1569874894373; 
 Mon, 30 Sep 2019 13:21:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/22] tcg/ppc: Replace HAVE_ISEL macro with a variable
Date: Mon, 30 Sep 2019 13:21:09 -0700
Message-Id: <20190930202125.21064-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously we've been hard-coding knowledge that Power7 has ISEL, but
it was an optional instruction before that.  Use the AT_HWCAP2 bit,
when present, to properly determine support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7cb0002c14..db28ae7eb1 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -65,8 +65,7 @@
 static tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
-
-#define HAVE_ISEL      have_isa_2_06
+static bool have_isel;
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG 30
@@ -1100,7 +1099,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     /* If we have ISEL, we can implement everything with 3 or 4 insns.
        All other cases below are also at least 3 insns, so speed up the
        code generator by not considering them and always using ISEL.  */
-    if (HAVE_ISEL) {
+    if (have_isel) {
         int isel, tab;
 
         tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
@@ -1203,7 +1202,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
 
     tcg_out_cmp(s, cond, c1, c2, const_c2, 7, type);
 
-    if (HAVE_ISEL) {
+    if (have_isel) {
         int isel = tcg_to_isel[cond];
 
         /* Swap the V operands if the operation indicates inversion.  */
@@ -1247,7 +1246,7 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     } else {
         tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
         /* Note that the only other valid constant for a2 is 0.  */
-        if (HAVE_ISEL) {
+        if (have_isel) {
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
             tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
         } else if (!const_a2 && a0 == a2) {
@@ -2795,6 +2794,14 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif
 
+#ifdef PPC_FEATURE2_HAS_ISEL
+    /* Prefer explicit instruction from the kernel. */
+    have_isel = (hwcap2 & PPC_FEATURE2_HAS_ISEL) != 0;
+#else
+    /* Fall back to knowing Power7 (2.06) has ISEL. */
+    have_isel = have_isa_2_06;
+#endif
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
-- 
2.17.1


