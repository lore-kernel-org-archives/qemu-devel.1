Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD568C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8694D217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhWsf6ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8694D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33vj-0002Vk-7m
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GS-0003lM-OV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GO-0000MV-Fq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GK-0000Il-Ky
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id h3so393428pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l58FUNN+MerXiKJ010yMrqx8XR2Kx9uSnwDhJ/Yfh7g=;
 b=vhWsf6ZYPt12s0Om+XQwtwmO5xZsu0M6Fj/Sa2yvivWAemIFS5lEwrNu7jA6HMvDf5
 DDm08yS76M24Y83HXBJw0lBC5MJJBGssLgoP/DWXfofzVyiij7eg4rWBX4gU6q3FxXKG
 OkMV6phlUKBKkF93N2gp9sxVWleHT/SAyLGlr/tzd/+B/8/nlsQ9hdH9CSQ7QFzLnYsT
 s5TH/cefXfq/tS9zo9CDM1KViHjvbxWvMuCj2F+rXlEfpJI8Pr4w9gwEIdif30k908at
 P5XZSpfCExWcGxGvzlpiW/fqUrBx1irPosC6i/UpYD2uJu9p5zojNP0iYsNxgSQVW930
 U3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l58FUNN+MerXiKJ010yMrqx8XR2Kx9uSnwDhJ/Yfh7g=;
 b=apdbfo8oGYl65exLrxsMR7eVNIR4SIOL5vKAX46/mFjayvMjS6DhtF+nuOJogH7QNK
 4oYvZZjibrY91SGExNIif93H1n3Ye0tuqY0b4dJFdwu2AQ2fRSjK15IWUJo92j8pLMyJ
 xZL257cwhYQvYmPmUo/h/D92GzUdcR6Z0KXvzxPWQXHoae4LXukz/6+eWgx3d/iNlaPY
 uGMvyT2nmjVL337QbDnM+Bkghn8sdhII22CXPP70AXb/B3yTPKj1cnvM5BUfhHAPpt+e
 uiWBtNX7USlsdP0ClxleHsOSkL4cKrVwdWJIfyzVrtuWEuw4BXsgmAx2PY0R0G0woriu
 cBUg==
X-Gm-Message-State: APjAAAUhUl6xQBuWHbnucTVCPQPxHQiIrZBdijY+J95JCh6jqiUNDWY+
 d6Qn0pCp0zLrJmvcybVeS9XeIDHyVu8=
X-Google-Smtp-Source: APXvYqwlf6jZPzhX2iYzWBfauxNiXvBBk0+/Lsb4Akp7sldomGJVT0yCamTCt1Ge3x1zKsMLbkrX4A==
X-Received: by 2002:a17:902:b704:: with SMTP id
 d4mr6022572pls.261.1567019142379; 
 Wed, 28 Aug 2019 12:05:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:20 -0700
Message-Id: <20190828190456.30315-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 33/69] target/arm: Convert SVC
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 19 +++++++++++++------
 target/arm/a32.decode  |  4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fb0e875917..eb4384618c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10048,6 +10048,18 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+/*
+ * Supervisor call
+ */
+
+static bool trans_SVC(DisasContext *s, arg_SVC *a)
+{
+    gen_set_pc_im(s, s->base.pc_next);
+    s->svc_imm = a->imm;
+    s->base.is_jmp = DISAS_SWI;
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10315,6 +10327,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x09:
         case 0xa:
         case 0xb:
+        case 0xf:
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
         case 0xc:
@@ -10330,12 +10343,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             break;
-        case 0xf:
-            /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
-            break;
         default:
         illegal_op:
             unallocated_encoding(s);
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 62c6f8562e..0bd952c069 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -528,3 +528,7 @@ LDM_a32          ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
 
 B                .... 1010 ........................           @branch
 BL               .... 1011 ........................           @branch
+
+# Supervisor call
+
+SVC              ---- 1111 imm:24                             &i
-- 
2.17.1


