Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B63C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8054C20725
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBlpFANJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8054C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51049 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoFS-0006sL-B4
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDz-00059x-SM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDy-0003Up-Er
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoDy-0003TR-88
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q9so6240828wmj.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sh1cPn4xkreFT2HSorYq3mSvdDWkFJfIxqbhkUlZld8=;
 b=MBlpFANJnzpO0DNFXHMp2JXr14YM8aQ3FBhP3LNS0Rq4/LLiR2xHn29hGtyxjifL25
 N7hdz4+8xx9Q/xFv4mmEXCtCcsPpXS16ajW5Yzd+W6TmtX97JHkGFUmjuZcHJHHQrw99
 fXne8bdQPkjOyvGrsQnMbXHSBSI2Up+Zr4HdVwKHS+wJx6z6zMTUh6uOF151wnQ6pcr9
 b33QL34YN+yWRH+LcHx9OxMGwZXJnPkqN3PLHBgabFyfLVIdLfboy3Y84K+YGE6zg07/
 Ert1Oy3EsZ8qTXR0wXb9GLwxKZqR83QxNdFWcYkfnh4M8jwVmfKkBnjWuZLJRjlfQG9b
 kaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sh1cPn4xkreFT2HSorYq3mSvdDWkFJfIxqbhkUlZld8=;
 b=d64zgo2JPU9TUbrYkpMOh1byCf19xdFIAU8tuWY/SeyEcotbteBHtL87G0r1zia0tb
 Eb9IgCzJwAXfjz+vCABtwh/jpRO37Z8ORKVN9OwSStW8MtNI8bv8GFrjDc1Srg169p4p
 mszgio6b3S63djJUGsRVgH3eoPRo5kwO3bYTCOay6zpetzPSYuuT3Wg1tMG5QnjfOCUK
 qOz62BfY8MwQx6WUodN7hENKDOcItqGTczVfuWTk3KAvSffB8AX1L4Ib+FbP3U/8YZpB
 QBujYfNAN2Xc1EZKGR0xPL4j34thXwQGWjHpbtbQC8Ca+Vz5de2+XxFZk76eIBHOUudG
 ibqA==
X-Gm-Message-State: APjAAAUMKF1rvARDLA5zYz7rBLaAu2LT14VmPLTWxRild0R2y3lOsifw
 DSxtyfies8RS4xK7nSKF1emYSw==
X-Google-Smtp-Source: APXvYqyq2ZqOa1RXzyjESLlusxsCEa0ybZm008+RStAMaUnBr68SmyJY5Z4Dw1fUB6miv8BrR3Lc6A==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr1983444wmg.110.1576494457070; 
 Mon, 16 Dec 2019 03:07:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o1sm21709919wrn.84.2019.12.16.03.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 52A2E1FF8F;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/16] tests/vm: Allow to set qemu-img path
Date: Mon, 16 Dec 2019 11:07:18 +0000
Message-Id: <20191216110732.24027-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

By default VM build test use qemu-img from system's PATH to
create the image disk. Due the lack of qemu-img on the system
or the desire to simply use a version built with QEMU, it would
be nice to allow one to set its path. So this patch makes that
possible by reading the path to qemu-img from QEMU_IMG if set,
otherwise it fallback to default behavior.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20191114134246.12073-2-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/devel/testing.rst    | 6 ++++--
 tests/vm/Makefile.include | 1 +
 tests/vm/basevm.py        | 5 +++++
 tests/vm/centos           | 2 +-
 tests/vm/fedora           | 4 +---
 tests/vm/freebsd          | 3 +--
 tests/vm/netbsd           | 3 +--
 tests/vm/openbsd          | 3 +--
 tests/vm/ubuntu.i386      | 2 +-
 9 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8e981e062d5..9be6cd44109 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -418,13 +418,15 @@ access, so they SHOULD NOT be exposed to external interfaces if you are
 concerned about attackers taking control of the guest and potentially
 exploiting a QEMU security bug to compromise the host.
 
-QEMU binary
------------
+QEMU binaries
+-------------
 
 By default, qemu-system-x86_64 is searched in $PATH to run the guest. If there
 isn't one, or if it is older than 2.10, the test won't work. In this case,
 provide the QEMU binary in env var: ``QEMU=/path/to/qemu-2.10+``.
 
+Likewise the path to qemu-img can be set in QEMU_IMG environment variable.
+
 Make jobs
 ---------
 
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index fea348e845c..9e7c46a4735 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -34,6 +34,7 @@ vm-help vm-test:
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
+	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0b8c1b26576..930ad821eed 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -152,6 +152,11 @@ class BaseVM(object):
     def build_image(self, img):
         raise NotImplementedError
 
+    def exec_qemu_img(self, *args):
+        cmd = [os.environ.get("QEMU_IMG", "qemu-img")]
+        cmd.extend(list(args))
+        subprocess.check_call(cmd)
+
     def add_source_dir(self, src_dir):
         name = "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdigest()[:5]
         tarfile = os.path.join(self._tmpdir, name + ".tar")
diff --git a/tests/vm/centos b/tests/vm/centos
index b9e851f2d33..f2f0befd845 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -68,7 +68,7 @@ class CentosVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
-        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.exec_qemu_img("resize", img_tmp, "50G")
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 7fec1479fb7..8e270fc0f03 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -74,9 +74,7 @@ class FedoraVM(basevm.BaseVM):
 
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
-
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 2a19461a909..1825cc58218 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -82,8 +82,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso_xz])
         subprocess.check_call(["xz", "-dvf", iso_xz])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
 
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args = [
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 611e6cc5b5c..ec6f3563b25 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -77,8 +77,7 @@ class NetBSDVM(basevm.BaseVM):
 
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["ln", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
 
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args = [
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index b92c39f89a6..6df5162dbf4 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -73,8 +73,7 @@ class OpenBSDVM(basevm.BaseVM):
 
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
 
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args = [
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index f611bebdc9d..3834cd7a8df 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -70,7 +70,7 @@ class UbuntuX86VM(basevm.BaseVM):
             sha256sum="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef")
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
-        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.exec_qemu_img("resize", img_tmp, "50G")
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
-- 
2.20.1


