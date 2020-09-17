Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52113C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F531206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpXCeEpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F531206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwyU-0001vK-Jo
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwx7-0000wn-67
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwx0-0002IR-H7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pxU8SWd6ZAx+w8Jr7lSfeojx4hS7gfX9o5nGi6b4XaI=;
 b=SpXCeEpi5xp9hv2GjILtdTqNXJ1YS4WUTAgASOIbejIIavtZFslbsV6qbNagGDQuhnDAc7
 MjZsM9j+wb8MaAjPBgkRQpOYcb8Mn+CVd11NGWmyAax6L3hOKUu8O0VIBfzyLg69secSj2
 zCrYd43Q+B7PSBOq05kXs6b3CVYLmNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-wpte92BFODCvkf4wGEQ1QQ-1; Thu, 17 Sep 2020 12:39:58 -0400
X-MC-Unique: wpte92BFODCvkf4wGEQ1QQ-1
Received: by mail-wr1-f69.google.com with SMTP id w7so1109632wrp.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pxU8SWd6ZAx+w8Jr7lSfeojx4hS7gfX9o5nGi6b4XaI=;
 b=jG7wcB6jfftiSuB8GrTgh8vcvkMM43d6CdbCfR0ogJaQUaFOIunYxslIuxwUZmYse1
 xXD8h0Tr6qfgM2SstvgexbMZXEp0KRv5nBknjO4pjZ6H/5k/tntwMLuvOmcJLzo2SYRq
 u++4ZYPQRi3UwIQmvhLSglESVYAn1oO7GUB0BRWOPSbsVNMVcCLGxplYHHN7/DzixS5s
 RUOLU4uxF2nG0SfSescoXCOtItMrYsjst3oe3DY2MCvgRaFarZ/dkDqmcrQOF9m1LnMj
 1o5VxzrQaHaxF8FUtqhOWRVAWjd868P11imXZe0qePEixMz+998wqwCTai32JYr1sqBH
 W2Eg==
X-Gm-Message-State: AOAM533yTtQarsoJb53BgVn2TOtxcIiil+CfKilB6eC/nOR4gvzeP0YS
 knA1pt7VG9RRsdQqglMIe19XZ3jckhSJ7DBTz3iY0UBGM9yAUPmCS0sgT9oi/NwwpuK5+c2sXjc
 Ecd1tpwtr3Bd5l0I=
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr31989865wrh.192.1600360796625; 
 Thu, 17 Sep 2020 09:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMF4S5Uw64O2snYIZEoMj4zTAnccDCayPRXthf8jV3o48AYWYXgd8tzikWKtquhL7QigCntQ==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr31989842wrh.192.1600360796425; 
 Thu, 17 Sep 2020 09:39:56 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i26sm100598wmb.17.2020.09.17.09.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:39:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
Date: Thu, 17 Sep 2020 18:39:54 +0200
Message-Id: <20200917163954.50514-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Armbian servers are not very reliable and confused the GitLab CI
users a few times this month (path updated, archives moved, and
now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
error). Time to disable these tests.
Users can still use the artifacts from the cache (or manually add
them to the cache).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 10 ++++++++++
 tests/acceptance/replay_kernel.py      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4a366ce93e4..68534693109 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -485,6 +485,8 @@ def test_arm_exynos4210_initrd(self):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
@@ -525,6 +527,8 @@ def test_arm_cubieboard_initrd(self):
                                                 'system-control@1c00000')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_sata(self):
         """
         :avocado: tags=arch:arm
@@ -651,6 +655,8 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
@@ -676,6 +682,8 @@ def test_arm_orangepi(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi_initrd(self):
         """
         :avocado: tags=arch:arm
@@ -718,6 +726,8 @@ def test_arm_orangepi_initrd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi_sd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index b79fc8daf8e..7b4310fccf3 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -127,6 +127,8 @@ def test_arm_virt(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.26.2


