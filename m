Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A20C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2819522522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmflZrYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2819522522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuh5e-0001qk-Us
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRT-00005I-FQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRS-0003Z3-5M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:47 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRR-0003Y4-Vd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:46 -0500
Received: by mail-wr1-x432.google.com with SMTP id t2so3585086wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jiFm42luXRGQ/r26a989FdFKx0ijBFZqT4Y/4nl+p6I=;
 b=jmflZrYo/7+2fkwM6KpMQ3Zmmg1u357NTHiaZleVFhk1UQ0SyfCL5rWUHSoy/MB1cb
 J8QKFS5zGhnuxaehPX2Xt9sTAuG9/ChoS7SNQvs2Y1nTIVw5NRLvQhZGXU9J1ywTkK5i
 Od3tejUo/PWbZjQ0KkOnox9ZJYtFG0fiQug+D1qpAob1/up4gg6Lm5Zmq5Cub9ssiA4/
 nZeH/f/4QVTgA9a1M5YlKjKL/H4H+rhBq9gjnwuo/PQHWbmvgbSF2iVC0hdW71B1UDLt
 jBaaY+3BMCdPH77ZT6pB5PsHU6MbCs9DpZL4JD+aZypp/54TuDWnZ7XtrOS9hRxcmPYP
 qyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jiFm42luXRGQ/r26a989FdFKx0ijBFZqT4Y/4nl+p6I=;
 b=ZXzkx2kHDzwS2EIzd7yn2PoHXsF3xmLQYPoHrBSYsboKf9+VojOo2QEuV4LGnTlc8o
 1ZWWIhJUSlfnCDLHs5Hqc0+QNt4+3pAW7s1OiyYbKu2/YWXKLFChnEy/qQlZtQUzY2of
 IWxTONDFbZeXW6/ywul6xB2TS/JWygvh5FoTKCbcoqozgBx7zDJeXgiM34AqsEN708BO
 kPgXKbEtGoEK5hj+uJBBqc8zqlkTjlUNM3U1nR7ooyvlLNFvGgqdG19RVW0ZRdc3gJw5
 Xe+Auqbm1SrxXrw3dzRmMMpbuAyhTnTzPDyDCzM2VsLuj70dSOs5iY3cIO/ZnTvH4wUR
 i9SA==
X-Gm-Message-State: APjAAAWeDvOGVM3imencmKACP2Myn/G4SaVx7qiTu2nC/UpR+YD+DTmC
 9M7P7glGkj25e05WLPHMM1wRkx5b1YwzjA==
X-Google-Smtp-Source: APXvYqwMr1zTAdm7mJG4LWx5bvG9EGpATodLmz53yTXha4NrY4vu33kH56FGHm9Q2GsK8C/7HsNbMw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr18602037wrx.288.1579793444691; 
 Thu, 23 Jan 2020 07:30:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] target/arm: add PMU feature to cortex-r5 and cortex-r5f
Date: Thu, 23 Jan 2020 15:30:22 +0000
Message-Id: <20200123153041.4248-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Clement Deschamps <clement.deschamps@greensocs.com>

The PMU is not optional on cortex-r5 and cortex-r5f (see
the "Features" chapter of the Technical Reference Manual).

Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200114105918.2366370-1-clement.deschamps@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d62fd5fdc64..64cd0a7d73c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2121,6 +2121,7 @@ static void cortex_r5_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->id_pfr0 = 0x0131;
     cpu->id_pfr1 = 0x001;
-- 
2.20.1


