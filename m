Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA00C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7CD206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me8UnZwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7CD206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwnR-00015R-T0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLg-0004Zh-IV; Thu, 03 Sep 2020 17:00:52 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:43223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLe-0007lG-Vv; Thu, 03 Sep 2020 17:00:48 -0400
Received: by mail-oi1-x22a.google.com with SMTP id i17so4497863oig.10;
 Thu, 03 Sep 2020 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U3kLnDJsPOvbeGSaO4+ay3+JWfM5GJq3iPIdpdJdTMY=;
 b=me8UnZwyLchAouob20O7i4g3EaPf04MgoHN+HgY/AQ/xAvxYgI5bJpA1tT+BE0cnSX
 UOQTl0pUgF7V3h935m0UQ4lnPP2GrzzPE3f+3wqxlnIS7J0ASy5gerkJbaD1kIOiAz5z
 CjfkHvpEzLpEIRzKUBuFvn5QpxUdyW8f4o5geIoTkibOgRXyJ8ttM3JjMrlN/k85N7uV
 0V1VpFFVQ8YGw+1yTXV+iUxdwDR27s4s9VlKDoqNEmZmxoZCaXhoQ/Ob9xv3DPl8Bn0N
 cvQ2v+SxDAsKvSG63ACRtqKmQfVO2/cvnjQbN7mAQRtk88SGkRKP2DTTCoZDPQ9OKqHY
 2V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U3kLnDJsPOvbeGSaO4+ay3+JWfM5GJq3iPIdpdJdTMY=;
 b=mI597YaD/vKXWXRkEzGyfAtw/hDYw5BWgVJghO3j1C/dgLlrSJlbEzXQOOSyh0zuw0
 DqyGaZVoKQfVJ7QvLVHx/dyWQL9dy25VCDrMbwYmmRDUfGzNyeoJtBR48fh0KKfErcr3
 bVCpce4DLQtJGbIPj6VTl9CMp56fGAem+G409THHrFUJLhFVE3pu+AGTrTB0aQSM8IH3
 lr/z4DwU4OHKDVC9/tUYciPobn4g71YF2Toh/X5zT9jMeyzWQcRIOlJBmlZRlVRMqy8d
 74sonbA0yQeP0TR/GgThSng2kfmgz+OCGr2ZWMFvocrYjNpnpf5Spk3CQjkEyHHFqrU2
 SLbg==
X-Gm-Message-State: AOAM530HbUugU4Qgfl3d1OGJ5+XTLkzBFX8+meIiXLojEcnARl7ZylZG
 gsgS4J++PbfEAGiYfyrUZoWui2kHfCTXIg==
X-Google-Smtp-Source: ABdhPJzSxQeRHsdEaC8JNxIr0SQIlzhHbcL1pWsS0dflGGPBcU6uzAG6uvCBeCPS9A9znjhS4yZPQw==
X-Received: by 2002:a05:6808:3bb:: with SMTP id
 n27mr3256076oie.130.1599166845094; 
 Thu, 03 Sep 2020 14:00:45 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id n37sm766978ota.20.2020.09.03.14.00.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:44 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/77] tests/acceptance: refactor boot_linux to allow code
 reuse
Date: Thu,  3 Sep 2020 15:59:06 -0500
Message-Id: <20200903205935.27832-49-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch moves image downloading functions to the separate class to allow
reusing them from record/replay tests.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159073593167.20809.17582679291556188984.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(cherry picked from commit 1c80c87c8c2489e4318c93c844aa29bc1d014146)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acceptance/boot_linux.py | 49 ++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 075a386300..3aa57e88b0 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -26,22 +26,8 @@ KVM_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "KVM"
 TCG_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "TCG"
 
 
-class BootLinux(Test):
-    """
-    Boots a Linux system, checking for a successful initialization
-    """
-
-    timeout = 900
-    chksum = None
-
-    def setUp(self):
-        super(BootLinux, self).setUp()
-        self.vm.add_args('-smp', '2')
-        self.vm.add_args('-m', '1024')
-        self.prepare_boot()
-        self.prepare_cloudinit()
-
-    def prepare_boot(self):
+class BootLinuxBase(Test):
+    def download_boot(self):
         self.log.debug('Looking for and selecting a qemu-img binary to be '
                        'used to create the bootable snapshot image')
         # If qemu-img has been built, use it, otherwise the system wide one
@@ -60,17 +46,17 @@ class BootLinux(Test):
         if image_arch == 'ppc64':
             image_arch = 'ppc64le'
         try:
-            self.boot = vmimage.get(
+            boot = vmimage.get(
                 'fedora', arch=image_arch, version='31',
                 checksum=self.chksum,
                 algorithm='sha256',
                 cache_dir=self.cache_dirs[0],
                 snapshot_dir=self.workdir)
-            self.vm.add_args('-drive', 'file=%s' % self.boot.path)
         except:
             self.cancel('Failed to download/prepare boot image')
+        return boot.path
 
-    def prepare_cloudinit(self):
+    def download_cloudinit(self):
         self.log.info('Preparing cloudinit image')
         try:
             cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
@@ -81,9 +67,32 @@ class BootLinux(Test):
                           # QEMU's hard coded usermode router address
                           phone_home_host='10.0.2.2',
                           phone_home_port=self.phone_home_port)
-            self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
         except Exception:
             self.cancel('Failed to prepared cloudinit image')
+        return cloudinit_iso
+
+class BootLinux(BootLinuxBase):
+    """
+    Boots a Linux system, checking for a successful initialization
+    """
+
+    timeout = 900
+    chksum = None
+
+    def setUp(self):
+        super(BootLinux, self).setUp()
+        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-m', '1024')
+        self.prepare_boot()
+        self.prepare_cloudinit()
+
+    def prepare_boot(self):
+        path = self.download_boot()
+        self.vm.add_args('-drive', 'file=%s' % path)
+
+    def prepare_cloudinit(self):
+        cloudinit_iso = self.download_cloudinit()
+        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
 
     def launch_and_wait(self):
         self.vm.set_console()
-- 
2.17.1


