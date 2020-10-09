Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ADBC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B022280
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAqArU8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B022280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvVa-0000p3-Ph
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJD-0008Qa-BK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJA-00058i-Ta
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id q5so10432711wmq.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e1qNuEpdWfGgRov+ClhnNZictf7qkkxDhIe501qEciQ=;
 b=jAqArU8BPhGKd/fcD6/Kz6Oxdt+DjomkD6vJnJWxlx1uomr0j7Zlyxa2Ko01+51pcB
 j6BPT7fWyY38ytTdaRmttbwJbuMii3vogwncneEX/SPB8byT81rLCT253KiacbhDWS5P
 ntCKeO3VmOz4vdREFzjdXmbs18xKb6ZQmZ13ml1BMf9UcZNgKjtY/FbS+U+xqZ6D2Jn/
 U1SeFkJfiTK7YqDZghxng0fKAkhw/Ymn9FAU/wjQoHGR1fKsaIf6MFgy3A49lAH9siiR
 M9r5GJpuB5fV6ZOCehSl20h+kGBdyZ4Mz003zlmLWSqPWqwPr09yFVI/5B+sKxTZSVvH
 BENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e1qNuEpdWfGgRov+ClhnNZictf7qkkxDhIe501qEciQ=;
 b=n1AEQH8ghYMLd24M+0E0dL7mkMo6KlxBjZJFjYsO6X2bGxN5QwubZyqZ1C0n2q1UJ7
 z1uLIH+1Drny9XvLjb59I3WNQgIcsVbbdCBoYy5sDS7hL++URqeg05+btNlxpIFEn1wG
 EPDdORwzbM9eiO4Z6+3ZTyNFqeuS9b777kBXtw3yf0nRDYE3zVPWA0c88pJ2nS7iuiY4
 Jaa8yD5S2ruCDh2PEYDUqWpp0gaNAUMMXLJGsZDlYor2rU/fX9IOlDDirbpVSpIXTXYE
 6MpRqDx8FCZ3u+jYz2yfj4CzF1aMbcu7TJ52Z+S3zUX2H/QIwQxUqjoV14yvcGrpe/71
 EHHQ==
X-Gm-Message-State: AOAM533/WKRGAmNwrdGEdBBYvNgQn/TE4ftQbx2A44+A2wLv3QfkHVQM
 bZUtIS0A3Nno6hwMWXZUgiQk/A==
X-Google-Smtp-Source: ABdhPJwskuQVwg3d+kDi9rgKg1d30VJ4iKmlM/Lxykpk6kTsMYrtRgHuxicewQI2Xi4yaEBmYC7A4g==
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr15305093wmm.138.1602261111638; 
 Fri, 09 Oct 2020 09:31:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f189sm12368845wmf.16.2020.10.09.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 425951FF8C;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/22] hw/misc/mips_cpc: Start vCPU when powered on
Date: Fri,  9 Oct 2020 17:31:27 +0100
Message-Id: <20201009163147.28512-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201007113942.2523866-1-f4bug@amsat.org>
Message-Id: <20201007160038.26953-3-alex.bennee@linaro.org>

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


