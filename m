Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9BA2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwFJOTBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9BA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFfH-000146-RZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYA-0001tU-Q9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY9-0001hR-M8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id r15so9761934wmh.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eUHKjZjRDD1Oi9j8r38x7T3t+alWeJOdSbyNmuX60Ac=;
 b=MwFJOTBX7MeZ5NpXQXh34LW7zuspo3PI4WvC+LtSaohTS9ZGxYjJ1ZkTYBPjT7JWyX
 EkHANZc09cYX5j0j3wvMLgQHmeeyHHl5cMCWT4dk1iIgoCsCwfx9KR81n3cAnmoTkzee
 qfYxrAecZiZGZn2y4ksvsXlQS1x30QTytEnVu6YGkydcDSq57kFvOe4Ruzyyh/yM47+z
 5skP4KCpIN9KwxBYdUFVlBY2t7poHZgzn7b86smWkSnUO2+qUzHK0WvbsAfl7JRkWX6W
 AuyHXyuRdAFQdLtlEF1sLFHSavAT0Sos5ClkmLBLIdAQrU2VCLJjTIJH8RWhM42tMR42
 cxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUHKjZjRDD1Oi9j8r38x7T3t+alWeJOdSbyNmuX60Ac=;
 b=jEctPY29qPNvClW/4MIRJZbicBUjKenf1TXaXqgjfhjCB9jiwnY3Kv8f/JGqKQJ+Gt
 pL0AhRckWF16wnn1P9pfp94BpVmo1lFyxw1tOs/ZLui3ZwIagbRPy9MYJAfJXnigKrKB
 9DgtiEkHNoFLqYpSWzjeYQb+R63qA3KXe1qXDZJcs9iiLnvU6G0wvI0wlc+EYVIWMbcE
 BFedf/L8Z99PFMzGtyIBwr3qisExVBhj7PRo3Hqdq+5LbJtHMqI4YJqsEDTXlv5KrNls
 VEQVpjcPZIGqa+Wv5rsVXaFONG7QyKOhrznPFcUwiNeZR3NnuHVhqQf7D7Qyrvf5d34s
 31Pw==
X-Gm-Message-State: AOAM533EWJq75i6kKHipUJ6X7Mad+xcCZaXisrf8PouPZHQMfBSy5qV9
 LqohVO4e+IrulYOQ0v2dH5ViSzpJv8/2RA==
X-Google-Smtp-Source: ABdhPJwgNAcwcCVswoVQ/T7vH/73of1Rwmp38vj/o2pLgEtYhw8Z1bO8WD91StLwW43RQCTl2Qqk3A==
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr3895807wmg.68.1591375831970; 
 Fri, 05 Jun 2020 09:50:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] raspi2 acceptance test: add test for dwc-hsotg (dwc2)
 USB host
Date: Fri,  5 Jun 2020 17:49:58 +0100
Message-Id: <20200605165007.12095-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Paul Zimmerman <pauldzim@gmail.com>

Add a check for functional dwc-hsotg (dwc2) USB host emulation to
the Raspi 2 acceptance test

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Reviewed-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Message-id: 20200520235349.21215-8-pauldzim@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index bbbbd30e48d..3f3aa0c8540 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -405,13 +405,18 @@ class BootLinuxConsole(LinuxKernelTest):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id])
+                               serial_kernel_cmdline[uart_id] +
+                               ' root=/dev/mmcblk0p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
-                         '-append', kernel_command_line)
+                         '-append', kernel_command_line,
+                         '-device', 'usb-kbd')
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Product: QEMU USB Keyboard'
+        self.wait_for_console_pattern(console_pattern)
 
     def test_arm_raspi2_uart0(self):
         """
-- 
2.20.1


