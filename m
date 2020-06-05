Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E88D207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mfm1DtyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E88D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFdP-00051z-Dy
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY2-0001ar-V2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:56203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY0-0001fq-Eh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id c71so9036371wmd.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2yUBQIbu54pdqWo2t660udQ3QOPVJ1+0t/Js/DFf5WY=;
 b=Mfm1DtyJP9bL42gpn1BC/vmnFWfQMarR1tubE2Af3D/iDs9IdgFPifOyn2lvNaOYGZ
 6sTmRVram6tEc4Zrf5HXDYQmo0TRMIZF8LIgxWYX3aNTFAdDcgDE4p0Lo4BvDC5q5tYT
 9QmpFh6bNBkHaY+4wc+lP60QSaeB13UVEjnkVzchj1Yg3WgZyRsOSDfrbnyD1/rfzAe1
 bmC4uMOIhCQcNcU8c6GINNPDYKwKQKv3PmrEtxKrjrZeQwMR8E1Shj41bJY9Gnmi5RNg
 5oic9wR53pc7nWY9FauAbiRgs1vNiKuSD718RxY1AMA8RgyPhndhN067RpJCSOAs6knP
 lbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2yUBQIbu54pdqWo2t660udQ3QOPVJ1+0t/Js/DFf5WY=;
 b=Fpzksox3RxH6lbB3rYwAzWWNH/F4aeHC/BwhgpVfRBDXPYmyJPzfOqpthotyXAhwh4
 Kpv0xs7/291DQLq/RTZzyuciF3pQ1088ED6kYMkVZU1e5gpjFAMZAOikbiSzNSaRPNqP
 80BHYYZbIWlbyDSZTpCgiGwQdzM6s5PGLRZBgqk3tOl1iL1Z46Zrjm0xU7BO/9YcaTkJ
 1l+Tk1w2PxAWLoDjzoAn9biJuwd6nW2iLawyxJ9sMhCcSVu4wgouFduu3tJKB5s3uL0l
 M75ll5bB9NGJJOazlk78RVRcZ53Wa/T0LKbIw+nHM3cOHHf/BNWEZgVaxHQo2ZV+ecdv
 wLog==
X-Gm-Message-State: AOAM533IQl7IWOmZckI/KbjwFaCEUg4g0NuA3rQmnMS4apc0eZsQ8D6N
 16Qpjk8Qwm3y6259d+g/tyc7Ryoqz7kXAQ==
X-Google-Smtp-Source: ABdhPJynlFiHTl4y8f4T3SRN1BMp6l5TAQRUGwwwmdV6ShPXkSWs1dbLooKJCigfcDoDJ9CaVlPFRQ==
X-Received: by 2002:a05:600c:1146:: with SMTP id
 z6mr3531259wmz.179.1591375822819; 
 Fri, 05 Jun 2020 09:50:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] tests/acceptance: Add a boot test for the
 xlnx-versal-virt machine
Date: Fri,  5 Jun 2020 17:49:50 +0100
Message-Id: <20200605165007.12095-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

As described by Edgar here:

 https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html

we can use the Ubuntu kernel for testing the xlnx-versal-virt machine.
So let's add a boot test for this now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200525141237.15243-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 12725d45290..bbbbd30e48d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -308,6 +308,32 @@ class BootLinuxConsole(LinuxKernelTest):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_aarch64_xlnx_versal_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:xlnx-versal-virt
+        :avocado: tags=device:pl011
+        :avocado: tags=device:arm_gicv3
+        """
+        kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
+                      'bionic-updates/main/installer-arm64/current/images/'
+                      'netboot/ubuntu-installer/arm64/linux')
+        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
+                      'bionic-updates/main/installer-arm64/current/images/'
+                      'netboot/ubuntu-installer/arm64/initrd.gz')
+        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-m', '2G',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path)
+        self.vm.launch()
+        self.wait_for_console_pattern('Checked W+X mappings: passed')
+
     def test_arm_virt(self):
         """
         :avocado: tags=arch:arm
-- 
2.20.1


