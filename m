Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF0A2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE56C8E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHcm-0005G5-H2
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZM-00018o-8p
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZL-0003cG-4j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZK-0003bH-Ue; Tue, 17 Dec 2019 13:27:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id j42so8205346wrj.12;
 Tue, 17 Dec 2019 10:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X3aoTKFOEPvDjRCIHjLD6crQEVS/A3CYuC7Vv8K4W3k=;
 b=kE56C8E/NbtpZjNbq9bhK3mGzU1Wq7Vkr0T1aZ+irlcv+JVhVJbQZeK/GkmmUjPju+
 aqeuC+SDPJKdaM+MVDpdUwsHj5QPE19K9fwW1kU5InIhrclIsNU4mF3KU3ioxA6ouA1E
 0dY8N5rj+87UJFNwwkWUE0Qg+mTHTXZvuy93OtV5p6rwvzx/laizm27jZeyRudxywUl1
 qi741fKh57GmrzMODQpVA5ShhHLJL8qEzdwti49fvJ8613lTkLpyPUX+hPtUKzyBpTTE
 S9JjiwbHQuRlj6cHSU9Cj7hZZVWdKq27eIFyfyoqwF2WNaA3W1Fh295WFpBbmjmIMIve
 X0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X3aoTKFOEPvDjRCIHjLD6crQEVS/A3CYuC7Vv8K4W3k=;
 b=tQQOhSmi4/yAByk00U67litF7PxyBrQYvBQE4WtPM4eGEe6kV7G/GylkV0CYfjZ5w6
 REpaloGwcq4kGBcO474Iz9ewNiGaQU/eHidCYVXYIgq+Ugvxktz0NBnwLblGKzs1gsg5
 eQ+um/76t0jT07dXYXjTx/Ffm/2pYCx3VK1dxfx6WIBYCkG4fBa2uDk+0FndJGPYEecf
 hPZP7Y4bYTvr2xnpzRLkj2QMa5WzBrzIvCVCVggrK2Cep8gd4McALrTIYiqwM9uGdSTk
 d/kti2NOirNTAo1hyX8RobomIfzHmSqqmvu+ozhLVB78NU/RGUFp4buyYAVWgcMRzENA
 pGiw==
X-Gm-Message-State: APjAAAWGXGD3HXQjiX5+RZLO/jLevr0OamvSotEvwafQnrrCHmmmqrLd
 wnnahsWKFMLTAb/uff8okIC1UruD
X-Google-Smtp-Source: APXvYqyZ5JCy9eLjrKZCQjIZvdUJdMtMSyEFMXoHKNU/gOHTb+kA2mYIpF43cVJO7t+vk/W1a6WFkA==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr38472286wrt.15.1576607257776; 
 Tue, 17 Dec 2019 10:27:37 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u18sm26006975wrt.26.2019.12.17.10.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 10:27:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/5] !fixup "hw: arm: add Xunlong Orange Pi PC machine"
Date: Tue, 17 Dec 2019 19:27:29 +0100
Message-Id: <20191217182730.943-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217182730.943-1-f4bug@amsat.org>
References: <20191217182730.943-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this, the machine starts with default 128MB, and Ubuntu Bionic
fails:

[ ***  ] (2 of 4) A start job is running for…Persistent Storage (37s / 2min 1s)
[  *** ] (2 of 4) A start job is running for…Persistent Storage (38s / 2min 1s)
[  OK  ] Started Flush Journal to Persistent Storage.
Starting Create Volatile Files and Directories...
Starting Armbian ZRAM config...
[    **] (3 of 6) A start job is running for…s and Directories (55s / no limit)
[     *] (3 of 6) A start job is running for…s and Directories (55s / no limit)
[    **] (3 of 6) A start job is running for…s and Directories (56s / no limit)
[  OK  ] Started Create Volatile Files and Directories.
[***   ] (5 of 6) A start job is running for… ZRAM config (1min 10s / 1min 19s)
[**    ] (5 of 6) A start job is running for… ZRAM config (1min 12s / 1min 19s)
[*     ] (5 of 6) A start job is running for… ZRAM config (1min 13s / 1min 19s)
[FAILED] Failed to start Armbian ZRAM config.
See 'systemctl status armbian-zram-config.service' for details.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/orangepi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 119f370924..da758d7eba 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -122,6 +122,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->max_cpus = AW_H3_NUM_CPUS;
     mc->default_cpus = AW_H3_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->default_ram_size = 1 * GiB;
 }
 
 DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
-- 
2.21.0


