Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2AFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CFF20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPKBkcN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CFF20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCRH-0004D1-Ci
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPE-00016p-5N; Tue, 16 Jun 2020 10:17:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPC-0006XE-4E; Tue, 16 Jun 2020 10:17:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id 25so19331761oiy.13;
 Tue, 16 Jun 2020 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Oa9V802o+PKNgGwDm+Qufd06GDhvGLD8PaFrQvvJnXo=;
 b=pPKBkcN9VXNTxdWjT62sbbWXk3bR/ijQ7bpqv36i5g+tQaT3dF6iysnzpw3h3tTAGc
 WerjyMVdKhjB1ILkOo/RR8Zuq4OPdu+fPjYflJMnJCcs+nv9sTeSi8UBtOYHayV6menC
 ZQ/Ma1ipzKeAkiVZmHbYZII+8SR6ZN8NRUQ70H0xzQ5lmXUy+i6KqdNiVOj40ed0AtfM
 DPUj+5uTHympnhH5cPr/+NdNw4Pq5v3PmEBeGu/O3vhgC6Q2HXPpCWdo7SyErxh6kk9N
 HkbpLySXH15EWrbOpceFRCBAb81vx4ZtRzUvtWKUlSxmtQ4DPm9yN1MsHA7JbU5TNhbO
 GRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Oa9V802o+PKNgGwDm+Qufd06GDhvGLD8PaFrQvvJnXo=;
 b=ehfl2s14+WNxaUOHAdz2o0xOgHeTzjsQCHqojCT/1Hf84u9a3B88pOZiW7rAirUrP7
 bhW6lVWHr9QYk/Ip2nEanXfKkcEG7pCEktUPDTx+qbLDby83zAQZlRm8r/fWkaFO08S9
 CFdszIHhSoMVs7uX9O0ZxFuKHtcqAnaslyku2kkE5OgI3TCRamSn7g63XGTnwEIHlJAi
 HGr3mzE0WrUtDjlxvUMrMPoke/cBn4UhkmtUImhxE4BOmxLzhGMlEJE2RY+CJ8nOzWN/
 71Ub2qzNsZMXqxFqZnAm1kwDKVm7Qz2ftLTIE2UiHlVoR/BBJI/xl3kOYKSEwIyAiOXA
 p4+w==
X-Gm-Message-State: AOAM532IQuWOFDZnsXZPnwzd/wA4QRe2CexnpFZve/j23g9ghA7nWCI2
 8H/Grig70zwQRdGeh3AStIeCIyj4
X-Google-Smtp-Source: ABdhPJx0bxk2406g7lFlhHW5g5/MKrysHiVPGT7MC6cu+nFQv3oCGGBGtcmwqBr81Qm8k6ahKblNEQ==
X-Received: by 2002:aca:f0d:: with SMTP id 13mr3343149oip.90.1592317056370;
 Tue, 16 Jun 2020 07:17:36 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w10sm4086944otp.44.2020.06.16.07.17.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:35 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/78] arm/arm-powerctl: set NSACR.{CP11,
 CP10} bits in arm_set_cpu_on()
Date: Tue, 16 Jun 2020 09:14:40 -0500
Message-Id: <20200616141547.24664-12-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

This change ensures that the FPU can be accessed in Non-Secure mode
when the CPU core is reset using the arm_set_cpu_on() function call.
The NSACR.{CP11,CP10} bits define the exception level required to
access the FPU in Non-Secure mode. Without these bits set, the CPU
will give an undefined exception trap on the first FPU access for the
secondary cores under Linux.

This is necessary because in this power-control codepath QEMU
is effectively emulating a bit of EL3 firmware, and has to set
the CPU up as the EL3 firmware would.

Fixes: fc1120a7f5
Cc: qemu-stable@nongnu.org
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
[PMM: added clarifying para to commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 0c7f8c43daf6556078e51de98aa13f069e505985)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db6..b064513d44 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -104,6 +104,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
         /* Processor is not in secure mode */
         target_cpu->env.cp15.scr_el3 |= SCR_NS;
 
+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        target_cpu->env.cp15.nsacr |= 3 << 10;
+
         /*
          * If QEMU is providing the equivalent of EL3 firmware, then we need
          * to make sure a CPU targeting EL2 comes out of reset with a
-- 
2.17.1


