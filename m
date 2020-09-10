Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDFFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6303021D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugdsSy2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6303021D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMtm-0006yl-GU
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kGHG3-0004Ly-Q5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:44:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:47065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kGHG0-00070I-F8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:44:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id b124so4116911pfg.13
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j05rnkItkh3LOypPRmy7aeVBelO22zvkXc9fsKS4afE=;
 b=ugdsSy2jYGkiuvSEbSIifSm8BhKhBYgXSKvXiCg2ZIWKGpzjuDC8/xh45J7yDNFw35
 Skxk+HJZPRbbMHXJ5sZplWTkYqfk8oUyXkF7f2neEeQXADvn0RFhrSPo+w2vpSga+iPM
 t/x4V4DgIOfBoj0RasQDzxeXgnTLzJgt2TLnQi1tz/Y+FVwWV9BxtXjchODQUpBCf5Oa
 48H/AcebEjdxjjxwcHZz0w8DC5BPwfYmlO2CNV2028ukA2ICT9GAP7VNLuSd/MebUXMb
 BojSYD7tskilTbfkQrX57Pn++3Kv/RS4Yd7n8KEeV6jxsf25HOMack1YcmBHRwmjDwwD
 tzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j05rnkItkh3LOypPRmy7aeVBelO22zvkXc9fsKS4afE=;
 b=TgX+EMBdCbMv5POb4ye7SwO3eghBUI5ov3zsDjb3/FR+hFxc9aWdJxX7F3/Pj9z/56
 JvKSruMXKwcQf89NrUKj70Gdvv4ZQ2ctR36MdLN5Xq741ALiepAjrqDK5enG1a22XZwJ
 zij6PrwYv58mBrNckMFtkO+fSJmV2gxo/i1h9Dbv3BlJUx7GRyBSo7NdixVuJsG+lQIi
 vl2q9JSoPBSbTGtFXSIE2JmMy5OUKnngSIJrko/aBV97Th32pURmqvlHg8UHH0i+wE4g
 Q0ooKY5pmsO9zw1YOurV6Shf9riAAeuvKj/EdSlvepXylzK7Z9tUsWFqG69ZwgolNHvY
 C+xQ==
X-Gm-Message-State: AOAM530HilP2GepVFmioBnDy2l5Gzze/a+LpN9CTAINiroetBP0M2fJ6
 Y9mW05PGY+hDwY+06AKCH6s/QWzCcZ2gPBAud40jyQ==
X-Google-Smtp-Source: ABdhPJz7Bv/G6LeQrsPfKkmNUXK/3hTfPe3ONlpyW0C1jGyOv5o/pooVjlO6mAxXlAvIY76q7bcAdA==
X-Received: by 2002:a63:4923:: with SMTP id w35mr3421322pga.368.1599723874714; 
 Thu, 10 Sep 2020 00:44:34 -0700 (PDT)
Received: from carbon.loongson.cn ([52.229.162.29])
 by smtp.gmail.com with ESMTPSA id n67sm3995337pgn.14.2020.09.10.00.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:44:34 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] accel/tcg: Fix computing is_write for mips
Date: Thu, 10 Sep 2020 15:43:42 +0800
Message-Id: <20200910074342.20421-2-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910074342.20421-1-kele.hwang@gmail.com>
References: <503406>
 <20200910074342.20421-1-kele.hwang@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=kele.hwang@gmail.com; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Sep 2020 09:42:38 -0400
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
Cc: Kele Huang <kele.hwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect mips store instructions SWXC1 and SDXC1 for MIPS64 since
MIPS64r1, and MIPS32 since MIPS32r2.

Signed-off-by: Kele Huang <kele.hwang@gmail.com>
---
 accel/tcg/user-exec.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..e69b4d8780 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -712,6 +712,27 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
     /* XXX: compute is_write */
     is_write = 0;
+
+    /*
+     * Detect store instructions. Required in all versions of MIPS64
+     * since MIPS64r1. Not available in MIPS32r1. Required by MIPS32r2
+     * and subsequent versions of MIPS32.
+     */
+    switch ((insn >> 3) & 0x7) {
+        case 0x1:
+            switch (insn & 0x7) {
+            case 0x0: /* SWXC1 */
+            case 0x1: /* SDXC1 */
+                is_write = 1;
+                break;
+            default:
+                break;
+            }
+            break;
+        default:
+            break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.17.1


