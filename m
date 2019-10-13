Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B3CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2B2206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vD5gI1Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2B2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmVD-0003eZ-2B
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJa-000748-O3
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJZ-000139-Au
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJX-00012G-ES
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:13 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so9277711pfl.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=po6eZ+VU9o59N8b7iUQ3oHFe6Xwg+QTX5CS1/tMvGQs=;
 b=vD5gI1FmGd3z48X8mSvtFpCIdCVc+rb95WdSbbNw18IxiyK6/w//UpruEpQld/ugq2
 z/Dbd1QA+hXm8nCb4w2jHmMxCLkQxZ9+syUgQQ7J4QJPgNQldmZ0R2/rhY4hg0Ansu/8
 ZuzDRcQ0qrUGM24m5a9rC1XW1eVpWYnvXs2Xyb9rBY1iASoZMg2v+AOzJH8R90O582n5
 SocJEBy3bOBrt/cy5Upk8TzfR5vRvHUCm7gCfrlmsgOtiLnL02qF1duLxDl8l4nFQN3U
 nniwxUJfDyyUumj+JnCE8KTlE0VTcWi69u3kz/zknm7m93rocQGSBrQ2h/gnhcNAlfrO
 5MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=po6eZ+VU9o59N8b7iUQ3oHFe6Xwg+QTX5CS1/tMvGQs=;
 b=H9MFpATsAKn9fUgauJ00fhVUyD5uLduPGmOLUNCbVxKHT851+Ki40yWr5YtCk8KfBQ
 YBcFnMTQyhmKypaK8U7FI4nUMAGLLNCJlyu1mgjZ3w1GCZNIuhmU49O14VoLoxsb9gS/
 irStEdtwwFPyMXb7tAwINUGbDdZxg+AL7/a/gGPUlYinB6qL/Vc22HcQwn10vPAvzREV
 coOD6Z7dRlCxOq+Dceh3nj6pLO4sjCT0THIXfByBVjcHKHDUmRL/xSRGt5TzT8eu+9ZP
 jti+ZLqi6CoDp/pNAZ212V0LLr363PrDDwSl2J1/F6y7nqXHeWrJZseikAJGMXN1KaJl
 yC8Q==
X-Gm-Message-State: APjAAAXpglSM5sh9EY6b650gQqcP8NiRsK2mztEVQr6TDPzKIH2k8sKC
 yEqNaIsZbkwe3WLYU2DBqrl7YMSHcEI=
X-Google-Smtp-Source: APXvYqzdcxcGjjOI6/gPoUuKa65pIQIi7pt6q2n0mnAvv3M4rxZKcjsBkgynszPAr/MB+AIniduypw==
X-Received: by 2002:a63:ad0d:: with SMTP id g13mr1880886pgf.407.1571005570036; 
 Sun, 13 Oct 2019 15:26:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] tcg/ppc: Update vector support for v2.07 VSX
Date: Sun, 13 Oct 2019 15:25:39 -0700
Message-Id: <20191013222544.3679-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional only on MSR.VSX and
are thus part of the VSX instruction set, and not Altivec.
This includes double-word loads and stores.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bc3a669cb4..6321e0767f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -470,10 +470,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEWX      XO31(71)
 #define LXSDX      (XO31(588) | 1)  /* v2.06, force tx=1 */
 #define LXVDSX     (XO31(332) | 1)  /* v2.06, force tx=1 */
+#define LXSIWZX    (XO31(12) | 1)   /* v2.07, force tx=1 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 #define STXSDX     (XO31(716) | 1)  /* v2.06, force sx=1 */
+#define STXSIWX    (XO31(140) | 1)  /* v2.07, force sx=1 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -1156,6 +1158,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
             tcg_out_mem_long(s, LWZ, LWZX, ret, base, offset);
             break;
         }
+        if (have_isa_2_07 && have_vsx) {
+            tcg_out_mem_long(s, 0, LXSIWZX, ret, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 3) == 0);
         tcg_out_mem_long(s, 0, LVEWX, ret, base, offset);
         shift = (offset - 4) & 0xc;
@@ -1203,6 +1209,11 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
             tcg_out_mem_long(s, STW, STWX, arg, base, offset);
             break;
         }
+        if (have_isa_2_07 && have_vsx) {
+            tcg_out_mem_long(s, 0, STXSIWX, arg, base, offset);
+            break;
+        }
+        assert((offset & 3) == 0);
         tcg_debug_assert((offset & 3) == 0);
         shift = (offset - 4) & 0xc;
         if (shift) {
-- 
2.17.1


