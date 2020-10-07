Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675AFC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0408820789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SASI/WUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0408820789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQC4p-0007gF-P1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs2-0005DZ-Bx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBrw-0000sw-VA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id k10so2816318wru.6
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dNHnnNf2fBdlVjmyimawuNWkUDFu8uys3FqvGBSdx28=;
 b=SASI/WURW4KwhFAVV5FUgG2sI/u7IoD5wkTSCJ+DSVuEk3jZJp+KICs3iu6oFBvHTT
 m1WPxdWYY7BcxnyCgTqEQcJZW+sJSAtU3JxPWinDs4pkSqQ6AhoUFGdhUNpmkT7RwZk+
 Uwxklvg+JwEfWG/wI6vd0zZm2lqTzwq5oCFR1F/Mec2ofcS39fzEixKxbXrXMOxaLqXT
 32xUNz8llskdkWl8uMjM81G2kUt7W8vY9NWcVjnOSJ71M3sbeTRP3oMSunNceQBawsfO
 8TPuYLnehHasHImipBshZLvHEC/Q6qeA+gTPpa3T5uiRX2O2HGVr/iAuG3rgvXFvAsrs
 SExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dNHnnNf2fBdlVjmyimawuNWkUDFu8uys3FqvGBSdx28=;
 b=P2KRF3ifWoYxqX8SJLnKE0X/2Zqn435U856vPw0cKhF93yKlOUs58HiEieqYaFTYHr
 GBEoZhqryzq2KmiZxlq/PhAhH/DG3QnvxFmwxPSl8wH0r0nOhAXZBSOl4aGP1ebKasVs
 rekQg+EZKxhOhHR268vTUsXW8wMKomquog65pdKkRHzwlah0WEAwJji0V58G1ZfWyo3f
 +4N+5FWOhqt0LapVQBhavJRJnduQGMbiHTE9yEDlCgFH2FwJ/auYURGlKVcVcTiFruB5
 b2SeJ1Px3y9eZYngvaVhdzDxBn1OBaHPFvGm3Av5d5xcUCmPy0170okPVZGS3w8A9pxr
 o7eQ==
X-Gm-Message-State: AOAM531ys1lPmK4u/K69550nYBbM2xw0nWqhDfPWPE5Hi809ebqg+gaZ
 2O1pAcUiAXvCXeSwwt+a2v38Gw==
X-Google-Smtp-Source: ABdhPJyrOQwtRBzUFxyZ39Rc4MDM4q+aHhiQAYVc1zpuaA2Do53f5S5HZ9XJH9E6vpogEpotqM/Rew==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr4168973wrn.45.1602086442525; 
 Wed, 07 Oct 2020 09:00:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 10sm3158084wmn.9.2020.10.07.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D8061FF8C;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/22] hw/misc/mips_cpc: Start vCPU when powered on
Date: Wed,  7 Oct 2020 17:00:18 +0100
Message-Id: <20201007160038.26953-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

In commit 102ca9667d we set "start-powered-off" on all vCPUs
included in the CPS (Coherent Processing System) but forgot to
start the vCPUS on when they are powered on in the CPC (Cluster
Power Controller).

This fixes the following tests:

  $ avocado run tests/acceptance/machine_mips_malta.py
   (1/3) test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.67 s)
   (2/3) test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupted by SIGTERM (30.22 s)
   (3/3) test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupted by SIGTERM (30.25 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | CANCEL 0

Fixes: 102ca9667d ("mips/cps: Use start-powered-off CPUState property")
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201007113942.2523866-1-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/misc/mips_cpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9592..7c11fb3d44 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -38,6 +38,7 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
     MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;
 
     cpu_reset(cs);
+    cs->halted = 0;
     cpc->vp_running |= 1ULL << cs->cpu_index;
 }
 
-- 
2.20.1


