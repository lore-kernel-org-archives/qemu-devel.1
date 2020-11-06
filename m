Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E504D20735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaFmAEZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasfG-0001BL-UB
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRy-0005TT-70
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:07 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRt-00075U-5q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:05 -0500
Received: by mail-pg1-x544.google.com with SMTP id e21so2865993pgr.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lR9ILVXMVkME60wGI8pWnBaKO2y1Li21DXN5Z4ukxX8=;
 b=jaFmAEZd3q6hKFAfLjDCKTZf6mgsn+43MkS0j0Q7ND9xFtCm5dbS2sdJC6U+cTOMqt
 157uPA80qIDqR93Dxt0TLjyhYF7wZx/48TvK8InU0wHgWVbJKn2bQ5dJhIDoxCg1MvZF
 ra17Gict90s/pk0wogAP3RQh67dnjHj7suqaveMqhUQRDsCPtUT0LgrM8S2chPcJiEVn
 mtI7cnG2HbsgFH/rX6LIqdf6ryLJK+Dg3zTl8BZg4S2FNuZ5LrZ4NLqhFuFFNk5cwftu
 J4wy0RSL+rUI96V41uQGRpSFDpZfHiQeF1+axbk71ScCvxxsab/9tQavgLBHUQDqaMlb
 F+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lR9ILVXMVkME60wGI8pWnBaKO2y1Li21DXN5Z4ukxX8=;
 b=p5XKrT3wI7wo13X5mDi3u/uIT9tXgkb/W+j3sXKlz9gzsWprwasx1i41ISDEIQVca4
 bfFpUs+TU9sQ2cDa+zbwD5E6EOJjVkVICG6gwRU7QIkx9XeemTIGgWN6AnOu+r+lUVYA
 DmmJ6TZ1eELC9xMeZYn0Gw3jUofpe3una7LO2qM27TYwBL2Iz/Rtlq4AxKat9z74xGTb
 7Ct1UqBgCbCOA5H7g+Ow5se2NfJwxrlYLcBG81tgsfyMyLbccUYA2Xx5RoCsjO4RmdQg
 cqr4X33acjeRQqHs6fbZIVdZbYRcjOv8KtHartYB779FCEAmOP1kuO/bGYWJq1hqBNmH
 pmpw==
X-Gm-Message-State: AOAM533Bn4KpEG4pRoohiC+nZfhnqiSApPq+ksIsYn8USlZLp5BuVr37
 GsD84Ux+nLAC5dpw7mM+SFea3qxDLh+GYw==
X-Google-Smtp-Source: ABdhPJxg5NT13ldS9qh1aZC2A4bTg0Xv/FPkpeMM6jGAXP0pq8UdY48Ms6ZwWrdkakB+ltJ8RV2jUQ==
X-Received: by 2002:a17:90a:eb12:: with SMTP id
 j18mr150225pjz.15.1604633399544; 
 Thu, 05 Nov 2020 19:29:59 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/41] tcg/ppc: Use tcg_out_mem_long to reset TCG_REG_TB
Date: Thu,  5 Nov 2020 19:29:06 -0800
Message-Id: <20201106032921.600200-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The maximum TB code gen size is UINT16_MAX, which the current
code does not support.  Use our utility function to optimally
add an arbitrary constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index dc90705d02..91d5d95ddf 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2392,9 +2392,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         set_jmp_reset_offset(s, args[0]);
         if (USE_REG_TB) {
             /* For the unlinked case, need to reset TCG_REG_TB.  */
-            c = -tcg_current_code_size(s);
-            assert(c == (int16_t)c);
-            tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, c));
+            tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
+                             -tcg_current_code_size(s));
         }
         break;
     case INDEX_op_goto_ptr:
-- 
2.25.1


