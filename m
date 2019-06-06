Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD8C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA9720868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuzlN0rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA9720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYweZ-0005mE-4i
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:58:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTz-0004Ko-N6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTx-0003sd-1D
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTt-00037t-6N
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so795745wmj.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7cJ3cFmAyElsbk0Hu0rymmkEdd46OTUs5chKPb+2SUk=;
	b=PuzlN0rOoe+tct2TDQT9IC5tcPr1vkND3v3RXksDDziqk71KN+I8TM4mGsw6gjSsOC
	zc0I5GCHYLuY2iIPqWRRmNzYATGQXE4iQUwk8bvjPykHMgepqJdVu9xi8QUiNW2/7k3m
	zdeTw5IQndN3DmT48esq9QVncIiIWXyX9UimzoVeGedZqdGybV4c2S0aBCYtTVQto4i1
	Yk3ODpGi6XUxjgJ+d6+PKN8aD/61vnjxXGNZqTclD+1rNlJrfMyvgIShncRbNdGEN3W0
	HqprcflwaiJiFUN4o8D7doQYbrlWUsXsdrhaI7e8HK6eQCfAtLrvI3nsCCuqWewHazXQ
	+Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7cJ3cFmAyElsbk0Hu0rymmkEdd46OTUs5chKPb+2SUk=;
	b=NOqLO0zDqtXnIbWxIk1tdOksbXPEL4fWWqqMqaiz/8zbYKsUPdoeNKWx5hTYJm/5Zq
	7/IsKJeu4iUOSA8cO2RUyno8LomqW5UmU0iZCL5Km4JFz9ONpuQ//8moJ5cqVYgFbHjI
	nNSk98+HYtu4d1TAzsblEEehRqEGgAzgn/bGBflnJ+Awp+RxD7xVtMz0yjXAhOau8q5s
	MVNpXvnLG/z/6UIn1u91NjaYvtRiwB30hFgqLw/QfIBmrnB/aG97//5gNt/iPylpJPQq
	8trVDMjj49O4+fB3OpAA3Vo542hqhi52aFPUuOVz1C3QWXlK4kX+/cPD0IZ1xwJiX99E
	BtVA==
X-Gm-Message-State: APjAAAXw8eYOXwrq1mmwpHaptm23zXkEPe4/658qWY5jGYlxbAAGRthS
	1EEkhkXHVEeIVSDNAgcVj99MrA==
X-Google-Smtp-Source: APXvYqwNOjLbparFDztc5upKC6q8OlaD59H1/fy/WMloMbPoIaAitzEnTw3k6NME/WFfkBCcIjq7TA==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr753998wmh.148.1559843197969;
	Thu, 06 Jun 2019 10:46:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:51 +0100
Message-Id: <20190606174609.20487-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 24/42] target/arm: Convert VADD to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VADD instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 4c684f033b6..14aeb25f597 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1451,3 +1451,13 @@ static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 23addcf53d6..7fa255f6598 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1386,7 +1386,6 @@ static inline void gen_vfp_##name(int dp)                             \
     tcg_temp_free_ptr(fpst);                                          \
 }
 
-VFP_OP2(add)
 VFP_OP2(sub)
 VFP_OP2(div)
 
@@ -3111,7 +3110,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 5:
+            case 0 ... 6:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3297,9 +3296,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 6: /* add: fn + fm */
-                    gen_vfp_add(dp);
-                    break;
                 case 7: /* sub: fn - fm */
                     gen_vfp_sub(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 3063fcac23f..d911f12dfd0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -127,3 +127,8 @@ VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


