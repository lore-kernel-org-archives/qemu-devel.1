Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB3C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0022184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ecgs47tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0022184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVh0-0002Tp-77
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVU5-0003us-V1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:28 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34]:42606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVU3-000205-Qk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:25 -0400
Received: by mail-oo1-xc34.google.com with SMTP id l18so1432728ooa.9
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UI+D9Y2q+l7wpNPIYlQftKzl9o1sUbD+xWKlt5UhcEY=;
 b=Ecgs47trmO9AC1abcvx4fDdhcGgeygFWEBSLEaSla4Z7IW37M7Md5KhHY4n8Ggppj1
 quHIOftV5QRvg0/OulAWrg/Ioxm/9obYD8lnszj/3xknzLX4b7rVmUy6D88WdFem8RsO
 91PNkyUU0wokFr2J3spBhLkVgyEJAzhQYODDj9jwL6zDxbQfax63JBu8cMGbIUK8PhT1
 61QAAKeaom7FXRSq6qMASTkP4BSGSgzecqVMhJgNY/FCIdsqd+tvkpbHF6uUjgh5xMgH
 jWNlfKg6T2H1zhMRjRAI9vaQcSkCDO6KLLgo8LymvHqk7J8NSfPNwUBRntVRS+Z6TQ02
 aJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UI+D9Y2q+l7wpNPIYlQftKzl9o1sUbD+xWKlt5UhcEY=;
 b=WHcy2RpQiQ7PM0xbB6DZSJPb2NAKUVQUz+Mqf7MhoB/rRJtVmqPzl/NJB3mecz3e7b
 s7dKwHhNJ6qFcrYY32FsVvH3VMNNgtY3m3GmnrhoftkA0QKqLdyoESjwIj6a5znmBnyz
 5gbp8p5+RoujsuFDCWlZ6IvryASY1WNo3GryWagPRf9EA6E9JGb8BFTyoSOixO4sDSWf
 Y1rgL6gACAoVNikZ5b6PH4wLwFB4sdU/hMbn/7tam0LvPpwOBZKi7Fb6rU5oFB2kS0vm
 RincUh5HCwyTI5FAEqcxVI/nGZfRZPQW6073HMPSTiUQPz551NSNgnfWhVl8Y1EV2jBE
 KfkQ==
X-Gm-Message-State: AOAM530vvg+LxEAVEf6BVPzLq3FHKDEAIIZ3nYVFbUymQF5c8vEurIBf
 dthpnQLH4Pyrc3ChX8MvL65mSgJyLLvgNX6+
X-Google-Smtp-Source: ABdhPJxDEnX+dgbgcizZshxT//Q4LdBPvXD1pdqjbma1+jIZrPuvXVsDRv/4qrkhS93x4QkntwDc1A==
X-Received: by 2002:a4a:e1bc:: with SMTP id 28mr277379ooy.53.1602161841204;
 Thu, 08 Oct 2020 05:57:21 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] accel/tcg: Fix computing of is_write for MIPS
Date: Thu,  8 Oct 2020 07:56:59 -0500
Message-Id: <20201008125659.49857-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Xu Zou <iwatchnima@gmail.com>,
 Kele Huang <kele.hwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kele Huang <kele.hwang@gmail.com>

Detect all MIPS store instructions in cpu_signal_handler for all available
MIPS versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modified code for MIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
Message-Id: <20201002081420.10814-1-kele.hwang@gmail.com>
[rth: Use uintptr_t for pc to fix n32 build error.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5c96819ded..4ebe25461a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -702,16 +702,51 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #elif defined(__mips__)
 
+#if defined(__misp16) || defined(__mips_micromips)
+#error "Unsupported encoding"
+#endif
+
 int cpu_signal_handler(int host_signum, void *pinfo,
                        void *puc)
 {
     siginfo_t *info = pinfo;
     ucontext_t *uc = puc;
-    greg_t pc = uc->uc_mcontext.pc;
-    int is_write;
+    uintptr_t pc = uc->uc_mcontext.pc;
+    uint32_t insn = *(uint32_t *)pc;
+    int is_write = 0;
+
+    /* Detect all store instructions at program counter. */
+    switch((insn >> 26) & 077) {
+    case 050: /* SB */
+    case 051: /* SH */
+    case 052: /* SWL */
+    case 053: /* SW */
+    case 054: /* SDL */
+    case 055: /* SDR */
+    case 056: /* SWR */
+    case 070: /* SC */
+    case 071: /* SWC1 */
+    case 074: /* SCD */
+    case 075: /* SDC1 */
+    case 077: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+    case 072: /* SWC2 */
+    case 076: /* SDC2 */
+#endif
+        is_write = 1;
+        break;
+    case 023: /* COP1X */
+        /* Required in all versions of MIPS64 since
+           MIPS64r1 and subsequent versions of MIPS32r2. */
+        switch (insn & 077) {
+        case 010: /* SWXC1 */
+        case 011: /* SDXC1 */
+        case 015: /* SUXC1 */
+            is_write = 1;
+        }
+        break;
+    }
 
-    /* XXX: compute is_write */
-    is_write = 0;
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.25.1


