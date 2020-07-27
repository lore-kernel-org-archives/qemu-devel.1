Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504EFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FE020663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqQHbu9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FE020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Kr-0004Jm-EH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02B4-0007UW-Ey
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02B2-0006SQ-SU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id z18so11111917wrm.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rLNmNXPwsek6Q6dP3H8DkSo9b+2a+VCiz0OAeSbTq64=;
 b=gqQHbu9CU8GC8dEucl7MtjH6MmL/xPXpYh3QqF71Q8SpSL5VcHnlbey+Qob+y6rJvE
 n8eWPy4Dz7SAlLCmAukC/6H8kYH8HjVegw/Z/Z4djMZaS3aQMC8V48UNQ75yJFzkmpbv
 1GWvbMPY73S5ql1IH1Gay641Nu0EIgzH93oEjhA7J1JBxg6wxTCptMffzbOlryUoMBPu
 0P9xOToM8h/gEyl/NnGiM0rRdoGFDTqxyURJSS0BM6/+AGwTA1J0tzZ2bNSV3vgQJj9M
 qPyGdAtd7cnwySlRhoOgatvI0syCbM05qnZzntHI9sk0NctA/yk8TeQJVlqhpPp9y41+
 9riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rLNmNXPwsek6Q6dP3H8DkSo9b+2a+VCiz0OAeSbTq64=;
 b=MU+iAM9flakoicIykhiJ9+w6yAaNaGGzgCdqLOeh9S9h1KUaCe3SDTRMefyAOldOlG
 2ET6jOqzyYiydKtCmokwv3Wti3WJ+1YN3LR5EtLIgpp/gsNuUF0lNUc3IzLBiSYptbAW
 RbmDm6JQrlL4fKl2USI5AIk7mTYcSuHqmVMCehjV1zlhK591Y/iwifFN0dibSHon5elQ
 76UoRIpSIJN24RAtaG1VND27fh7dqPqFoUyoLLb362nnLjQd2xNq5aDkDI5N6RVoaM9U
 lLpi4R9BcXakRkDLpcQZ0m/kW6HUOEjl7lSLkvCXCQUXvgZuEyvdVcFkOUH1rkKY2rS3
 tOeg==
X-Gm-Message-State: AOAM530gD5+iA942cNxc7UepuZE/OPmRLlYuLCzANgsY1Z223Ybg3crk
 9ouOuzw70+AvHZWREdNZuWTbfA==
X-Google-Smtp-Source: ABdhPJxaHn1H3+Vs7Ff+dbLfdUpNbBTJoyExT75f4g2wo6XK7aox0o6p7DBbNAnTcTtDOUQb7hY7ow==
X-Received: by 2002:adf:b352:: with SMTP id k18mr21051035wrd.386.1595852659480; 
 Mon, 27 Jul 2020 05:24:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm18759864wme.1.2020.07.27.05.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91EE91FF9C;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/16] linux-user, ppc: fix clock_nanosleep() for linux-user-ppc
Date: Mon, 27 Jul 2020 13:23:54 +0100
Message-Id: <20200727122357.31263-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

Our safe_clock_nanosleep() returns -1 and updates errno.

We don't need to update the CRF bit in syscall.c because it will
be updated in ppc/cpu_loop.c as the return value is negative.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200722174612.2917566-3-laurent@vivier.eu>
Message-Id: <20200724064509.331-14-alex.bennee@linaro.org>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 43a6e283961..f5c4f6b95db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11840,13 +11840,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             host_to_target_timespec(arg4, &ts);
         }
 
-#if defined(TARGET_PPC)
-        /* clock_nanosleep is odd in that it returns positive errno values.
-         * On PPC, CR0 bit 3 should be set in such a situation. */
-        if (ret && ret != -TARGET_ERESTARTSYS) {
-            ((CPUPPCState *)cpu_env)->crf[0] |= 1;
-        }
-#endif
         return ret;
     }
 #endif
-- 
2.20.1


