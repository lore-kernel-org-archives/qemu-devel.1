Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5AFC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770E12076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXdDAZXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770E12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7rN-0006fX-MD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l5-0003dS-4a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l3-00080i-So
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7l3-000808-Lp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id 65so3644739wrl.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BVjll0Btf0ZgFKbd+CxXv9O+AQAJq5w3JoNQuRDkfgk=;
 b=dXdDAZXvntr0mdoAlmfxO6t0sZemPQDj8L03pHyEeVI7Evlqe+8fhLUdwL2u3Wot5T
 HoMJ3JUAcFsgHMwKycZiuBhVUCQTt4vTBb9kdJqIKiP3+IoymMDdFIDv2rXDVN3lgNd1
 xXB90gxO3ebaLdGwQIbW2pGmjfvoxX/+fg0iO5Ce03tdRw0ER4V/wETsDff1GcVxCOAr
 wWmAPweSFQtLWsc9vNFCja9igeubXZOF0d+qaJiLnbVqkwusKZ6QN9lVQ0q4vyZfRI8e
 x2SrQdY5Apojkbe75e58j3eoc55Ybd9F70It3MQN4g+ouNwj6ex5xTrcAeHnhvvlRRpr
 7njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BVjll0Btf0ZgFKbd+CxXv9O+AQAJq5w3JoNQuRDkfgk=;
 b=M84WhnW7rIKYkfH0W3W1sfw5aKnFakUTq1l5hn84AdGfq6QfeR0/pT0zjcFusiFjhZ
 wK2UDY0IRTYlnCwTnsi0ORQoJwESx9BlfvRpIdx7Lq3w3V+/HheUrZqpjyAAzuILpOdC
 RO8PwTh0iwfmHhPqj1xugXv34K6NbKeypmhafiNmxUO6vFLvPjtanF8X9TphDIA3P5Wi
 U7UG7gIeouSwWteV186RT0zokEfUbre875vKdVI9NPLCS3zISlpRNlFuGR/yNcj1Mx19
 XPjELTJTb9dJq1DMivY6fcOQJFBTZNZESB0SeiQ2Ia7LMNbwEU1eC9xqLX4byqn/kn0C
 UYGg==
X-Gm-Message-State: ANhLgQ2YYe+9FVfncBh3vQAdxMDQHxR2UucOJseTxsNgGdYZTI52FoYF
 Fv3MNqGyGkCF5zVMEK/S5KiEHw==
X-Google-Smtp-Source: ADFU+vuUnSS48vqaQFwiD7GpsgKG5PxDTkoefXUuwDrzRxyHUwcKBjE3JCyQsuygI3Npf2l95XoYLA==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr4037020wrk.101.1585149352555; 
 Wed, 25 Mar 2020 08:15:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm36609784wro.25.2020.03.25.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 730561FF8C;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/11] tests/vm: move vga setup
Date: Wed, 25 Mar 2020 15:15:34 +0000
Message-Id: <20200325151543.32478-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Move '-device VGA' from basevm.py to the guests, so they have
the chance to opt out and run without display device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200310083218.26355-3-kraxel@redhat.com>
Message-Id: <20200323161514.23952-3-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c53fd354d95..cffe7c4600e 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -179,7 +179,6 @@ class BaseVM(object):
 
     def boot(self, img, extra_args=[]):
         args = self._args + [
-            "-device", "VGA",
             "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4843b4175e0..bd9c6cf295c 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init(300)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 86770878b67..58166766d91 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 55590f46015..f3257bc245a 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index ab6abbedab5..0b705f49452 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3266038fbde..15707753353 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = [
+            "-device", "VGA",
+            "-cdrom", self.gen_cloud_init_iso()
+        ])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
-- 
2.20.1


