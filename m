Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC5AC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75056207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjL/Lq+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75056207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVx1G-0003bt-DW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxh-0007th-Mt; Fri, 23 Oct 2020 09:18:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxg-0000d6-4T; Fri, 23 Oct 2020 09:18:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id y12so1793510wrp.6;
 Fri, 23 Oct 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5pHoldkIUZ8/kD1SNq5odZMH1XKMIeTmSn/5M9yZycY=;
 b=KjL/Lq+JyrkRxn8SLyd/KYUNuDVy6ZqgOYORNhPuu7NTw4hIkI3sv6h8DtcyHv+gq1
 lUZLaMN0yr8hythLpB0lsQaCRJLTXjuiiSZmebCC+5ZmWaHO4Wzc4CTUPYzrwZFSWxHK
 XvqQt92SRKBFdTqzcJsiEzMrW+sEaHWRxZI3EcY4dJ4C0M0RZAL1b3UB0J3DinqfFDTI
 VtdM4gP73Lsyb9xo/KiJuW8aHEY/KhATzyxqVy/cPe4/8he1XDKV+0Eopiunqiy2qe1v
 MtQ18DH9UjdRB1LzJmfseRfbGGKv5oIN3EZGJ9zhcroUzJVUaluvB3oYf9zf2A7OfFpM
 m94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5pHoldkIUZ8/kD1SNq5odZMH1XKMIeTmSn/5M9yZycY=;
 b=NrlIUbMCHoDIUpDfYihHVhmca39no4s7b8bUZ9jwOsZyPEYvKaSa/fGv8oZ2AJn0HQ
 GkOlD7+Im0XnFvAGZZW89SpNeQLz0dE40v/apRzEc4nFkth4uSvfjObeF9+YC275h3a4
 re/+lNk9vBSR/kcwWJJokct6wZCoCYbyK/JF5xredXcairElHppKy0488fA8jTeFmLvn
 YtNu/vs72cAzG/4LdM3kKn2wZOKgopcv/amcnuXx1MZmL+Pgb8pyLosLfVuT0yDpBM8B
 URAk3e5cx3W9PxPvw2xxJSO0S2uahfkczNcHTShMpIGnUlVaaky5sz0r2O/1PnPyX1jp
 SXUg==
X-Gm-Message-State: AOAM531IgxN3nNW8MH7VB91wjuk62AQMfTdD6/eRpcWXBQWJE3kLCNSD
 ukYTZJ0zSnF+t56f3CQL7GPhDiTMckg=
X-Google-Smtp-Source: ABdhPJy6K78D42cyoc386bS+yF/g88RmQ7gXxUlI1YhUBcjof4RS4bGl2hZS78ODJ05PpY3pnnWuTw==
X-Received: by 2002:adf:f903:: with SMTP id b3mr2661348wrr.142.1603459105999; 
 Fri, 23 Oct 2020 06:18:25 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s19sm3568367wmc.0.2020.10.23.06.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:18:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/4] tests/acceptance: Extract
 do_test_arm_orangepi_armbian_uboot() method
Date: Fri, 23 Oct 2020 15:18:07 +0200
Message-Id: <20201023131808.3198005-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
References: <20201023131808.3198005-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to reuse the same U-Boot test for multiple
Armbian releases, extract the common part as
do_test_arm_orangepi_armbian_uboot().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 45 ++++++++++++++------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 032ac85978c..803b4512a26 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -780,27 +780,7 @@ def test_arm_orangepi_sd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
-                'Test artifacts fetched from unreliable dl.armbian.com')
-    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
-    def test_arm_orangepi_bionic(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
-
-        # This test download a 196MB compressed image and expand it to 1GB
-        image_url = ('https://dl.armbian.com/orangepipc/archive/'
-                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
-        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
-        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
-        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
-        image_path = os.path.join(self.workdir, image_name)
-        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
-        image_pow2ceil_expand(image_path)
-
+    def do_test_arm_orangepi_uboot_armbian(self, image_path):
         self.vm.set_console()
         self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
                          '-nic', 'user',
@@ -826,6 +806,29 @@ def test_arm_orangepi_bionic(self):
                                       'to <orangepipc>')
         self.wait_for_console_pattern('Starting Load Kernel Modules...')
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
+    def test_arm_orangepi_bionic_19_11(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
+        """
+
+        # This test download a 196MB compressed image and expand it to 1GB
+        image_url = ('https://dl.armbian.com/orangepipc/archive/'
+                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
+        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
+        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
+        image_path = os.path.join(self.workdir, image_name)
+        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+        image_pow2ceil_expand(image_path)
+
+        self.do_test_arm_orangepi_uboot_armbian(image_path)
+
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_uboot_netbsd9(self):
         """
-- 
2.26.2


