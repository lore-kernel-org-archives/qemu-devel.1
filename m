Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2959C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B663207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mau7wHTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B663207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqln-0005hx-Ew
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg5-0002AO-EQ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg4-0000Pf-DU
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id h4so6505528wmb.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+UWd65MNaXy/OQDuLVzrQNt/oF82AvY7dMV37Xy5Rco=;
 b=mau7wHTlx20GUrMORsDr55dfX3PsdozLoDNwGmuKSpIVgMI6rSKWujLHj8V4If3/pr
 IXuvCDcShhjCQyTqTLaXr6uU324nwO/Sq+0z2jyop821BRi7Lf1tVYvvRzvStpagy7/T
 1a8Vbxa9awEAHDHOEhiEDBcWAEHx3wmC8O24DycyTgBOzygMHhrDZubAiW+GGM0F8rJX
 oVlAe2vziAftYz0NeFkw5bL3yFxKuW8UHoLuRaCSzQH+ZTxTeep/s9Tv2U0kceg758Mn
 72TO9kr1EaLrH4//uHE/v9TObtQBvn+onQWTU5/2sK4ubLIDwcHWy5yA1tf51cgs53TV
 tISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+UWd65MNaXy/OQDuLVzrQNt/oF82AvY7dMV37Xy5Rco=;
 b=TwVeLWOHblrnm+o4fMrNHjzKzY3TQTvgWus+wWkhxl/AwoR9l3CuOOQigK+dA4IQCV
 fOspE/W/nAxk1+GFoajLxcbN12YG7zRKSDT67sip/3Dr14cpSb4WEk1JDBly0f9Z8c0g
 GFrWJqIYgaeDl3Pq/Ws6Gj6yRLJFprEwHTEAKbh8yhEmdBZF8CBBH1DORBle9mE2FBst
 sf/5V2ciBhbrejQ+bMwOE+DBWIzvIC+D+WcWy8Wr9JKgNSQKOpwIaRXY8gOVIlP05yHM
 aTatGlOg2dkAxfbb7Mmddz6CKPckopJYcXh9VRAe2EaXB/+JjsnXgdnXPJVNw5OznlQh
 ATbA==
X-Gm-Message-State: AOAM531vw/1N8oZnRrwNsTMdGnzAOgxY1pgDtgJmkiOhaIANfqWMzh5P
 okaCXhKQbgX+V9/4N6EeX8gpdqVZGiTkmg==
X-Google-Smtp-Source: ABdhPJwBZMV1vohQrSX/qYNWj/lzb5dEOuB2gpZqhnYLi8rJzpomY3lXfpgQxXrGN7MSyzgUHzfROA==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr9543395wmt.129.1590088582641; 
 Thu, 21 May 2020 12:16:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] linux-user/arm: Remove bogus SVC 0xf0002 handling
Date: Thu, 21 May 2020 20:15:49 +0100
Message-Id: <20200521191610.10941-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We incorrectly treat SVC 0xf0002 as a cacheflush request (which is a
NOP for QEMU).  This is the wrong syscall number, because in the
svc-immediate OABI syscall numbers are all offset by the
ARM_SYSCALL_BASE value and so the correct insn is SVC 0x9f0002.
(This is handled further down in the code with the other Arm-specific
syscalls like NR_breakpoint.)

When this code was initially added in commit 6f1f31c069b20611 in
2004, ARM_NR_cacheflush was defined as (ARM_SYSCALL_BASE + 0xf0000 + 2)
so the value in the comparison took account of the extra 0x900000
offset. In commit fbb4a2e371f2fa7 in 2008, the ARM_SYSCALL_BASE
was removed from the definition of ARM_NR_cacheflush and handling
for this group of syscalls was added below the point where we subtract
ARM_SYSCALL_BASE from the SVC immediate value. However that commit
forgot to remove the now-obsolete earlier handling code.

Remove the spurious ARM_NR_cacheflush condition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200420212206.12776-3-peter.maydell@linaro.org
---
 linux-user/arm/cpu_loop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 82d0dd3c312..025887d6b86 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -308,9 +308,7 @@ void cpu_loop(CPUARMState *env)
                     n = insn & 0xffffff;
                 }
 
-                if (n == ARM_NR_cacheflush) {
-                    /* nop */
-                } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
+                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
                     /* linux syscall */
                     if (env->thumb || n == 0) {
                         n = env->regs[7];
-- 
2.20.1


