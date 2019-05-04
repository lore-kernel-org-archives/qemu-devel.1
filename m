Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E207C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8088206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I65WDHgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8088206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnry-0004Vn-0X
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:09:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc4-00082p-Jl
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc3-0004Uw-Gt
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc3-0004SF-BE
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so3771142pgl.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b8jraRcPDhpc0rJ83YwCgajfHxCGUZVOCw+80nZxQJ8=;
	b=I65WDHgbd3u1xu+Z88FOArmf0ThmQui/Rk6thgIjOPz6tUQP4rcSlMrAODsPHz7KMO
	tiV14XsLHqUfBOc1KlOtUu6CNgmfoYk7x9rnhujAJPvj/yG9yNlN8EGmNgc1i/R/zGr5
	rRmh/LAN2KvCPRE/HfFXmkiuI4Lh6dy2ELOPD2a0NSqGxvOq+8tzF2Wl0QpiSw6pm0wi
	6E+bSiLPoM+YyvENSGWptMrhI0ltJ95wGpxY57r6vq8uOTSdAyXbajxysQJOsTnpYxTM
	WNOewmRWPaBvHwJgtDV6IUojCESFZErrThaoYfvzKo2lzeER6lBn2ctqbvyuGDtnhO9W
	CypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=b8jraRcPDhpc0rJ83YwCgajfHxCGUZVOCw+80nZxQJ8=;
	b=CBmHhpDQgyUsjIZGPN0H0UQP1+2csjbpWMHcb8/w8unPzw6NtkDstxVKEIIEYNN8oL
	Eq1rmXbSQFOHCVuW+G9eCbK2kTJ416g0eLlwMFoNGtK4Lvyq2mYaLuNuoCmvyOkI4vBj
	MF+7cUgH6zyy7X7gHgfCd7nBxVHBmBOvmpRTUf+7s5eHCBwlttmACyVwhXqNsGlT1qw6
	/+uFEkFq1P4wSBf5gEPP+Pmtj8hUYbCPHJGENTTu3FnFof7HcM8CvZ6fHHfKGtmgI0je
	GRPIGvJ4PRwUL7TXuyO28IT0IVzmpckYhA3FacC1TsJcOEQd4Egk3wmMQRXw5aK7tH+0
	C8XQ==
X-Gm-Message-State: APjAAAUm+rG5MvUrd1HzRh62TRaq5PdNxje5E0Nfov/sAQXpJl9dDS5u
	g/mN6kivlxrrY/OdJmrUrKqF5aftWLg=
X-Google-Smtp-Source: APXvYqzRVTSfa173J52CXvcqkoRzFfIbRBPKNegwJ52JrcqUU7N7NY8tTFc8vUGtTS7rxl0O1/vTkg==
X-Received: by 2002:a62:1ec5:: with SMTP id
	e188mr17077202pfe.242.1556949210138; 
	Fri, 03 May 2019 22:53:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:52 -0700
Message-Id: <20190504055300.18426-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 23/31] tcg/aarch64: Support vector absolute
 value
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
Message-ID: <20190504055252.L4J9a7bQxtcrV558BiRjMCfZnIAocdTaqKf2tOZgtw8@z>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 +-
 tcg/aarch64/tcg-target.inc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 21d06d928c..e43554c3c7 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -132,7 +132,7 @@ typedef enum {
 #define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 7d842cad47..5684b39e1f 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -552,6 +552,7 @@ typedef enum {
     I3617_CMGE0     = 0x2e208800,
     I3617_CMLE0     = 0x2e20a800,
     I3617_NOT       = 0x2e205800,
+    I3617_ABS       = 0x0e20b800,
     I3617_NEG       = 0x2e20b800,
 
     /* System instructions.  */
@@ -2207,6 +2208,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
         break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+        break;
     case INDEX_op_and_vec:
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
@@ -2318,6 +2322,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
@@ -2561,6 +2566,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-- 
2.17.1


