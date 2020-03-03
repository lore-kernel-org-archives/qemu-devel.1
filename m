Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51AC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFD72073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj+3xr+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFD72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99Ah-0000Oq-Lc
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9981-0003CD-4T
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997z-0001lS-GL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:37 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997z-0001l8-9L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:35 -0500
Received: by mail-wr1-x432.google.com with SMTP id r17so4770281wrj.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ijdyySbr5Pr5tu/6iL3NJ3hKubBXGURsFPuH6qfE7XM=;
 b=qj+3xr+fsB+VVYDJp7yguPBDXZ2CPns1k4bvMqkNBRasJKC7XtLejnvjCZ6L5yADVe
 ARsEp53j51XANsj49YT80pXLpfOb7EpARfV7Te+CjElR1DHdmj9+guuMksifTgAeD6Rm
 EZEWmyCjDekMkWz4dzWy9BoRwSqp9cZVaJQu+0ylx3z2RA8q3cqQEkKJYo/nAUUS7UTG
 wPkp2SNqlQuy/Vlb39BkiTpLyAOyjFNRCqF+GJFy1PcENSzKCnOCt6UA0dApn67IBwds
 rla3smyMlF3K7FewUGOqcLC+Pc+DR+6qbvvhzRz5uoes3mwWF+5hjb6MWKU2bjUxzSw3
 R3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ijdyySbr5Pr5tu/6iL3NJ3hKubBXGURsFPuH6qfE7XM=;
 b=UDnMaG4J5CZhL6Xwij73UYZCWXQZqcJc/eEGyDkREzljU8N/u9sJlATKJt67eFC35d
 9+DHtZWHqqxarndJUG3dy1wn4LAPlMgLk3pjkKIfRdOhzH1l7sX8HUzHeyNrJGQsJX68
 L4Eu+GYGHhbUQvC/WL9/Wn7+jyZ/H+ukrWcUv5wxy5ad4Q0bRnp0//kWFbYRtYQQ2i0W
 Z1Tix2zCTq/+71qTlR5Mi8WJVzPr9945K4YQm9ZLJPP5BaDKWvSDI/+N/K06W3z8j5k+
 bbcwi5zo2GnRfmGBMNfkmtJIJeW6DDqBiKtsv/XP6k5pmsDo7pH9vPwscAj6MSQrCBhn
 hnfQ==
X-Gm-Message-State: ANhLgQ3LjiYNnzZcsNgE1xfwX2Z8hPPFReNHj9N9UTMYhd2Bqvubm0FJ
 y6cWjG9nccEjAXZwKiY/zMGIwg==
X-Google-Smtp-Source: ADFU+vsKSDK8ONYTDJmdardp5wKG26yZvWUsrKY8G2xq9SW5agFZ3ygryZ3xd4JDpmtj7hU4+Dd4PA==
X-Received: by 2002:adf:a114:: with SMTP id o20mr5834864wro.7.1583247994125;
 Tue, 03 Mar 2020 07:06:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm35544399wrw.20.2020.03.03.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:29 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B66A1FF92;
 Tue,  3 Mar 2020 15:06:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 5/9] tests/vm: Added gen_cloud_init_iso() to basevm.py
Date: Tue,  3 Mar 2020 15:06:18 +0000
Message-Id: <20200303150622.20133-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This method was located in both centos and ubuntu.i386.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219163537.22098-6-robert.foley@linaro.org>
---
 tests/vm/basevm.py   | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/vm/centos      | 33 +--------------------------------
 tests/vm/ubuntu.i386 | 37 +------------------------------------
 3 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7f268922685..8400b0e07f6 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -345,6 +345,46 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
+    def gen_cloud_init_iso(self):
+        cidir = self._tmpdir
+        mdata = open(os.path.join(cidir, "meta-data"), "w")
+        name = self.name.replace(".","-")
+        mdata.writelines(["instance-id: {}-vm-0\n".format(name),
+                          "local-hostname: {}-guest\n".format(name)])
+        mdata.close()
+        udata = open(os.path.join(cidir, "user-data"), "w")
+        print("guest user:pw {}:{}".format(self._config['guest_user'],
+                                           self._config['guest_pass']))
+        udata.writelines(["#cloud-config\n",
+                          "chpasswd:\n",
+                          "  list: |\n",
+                          "    root:%s\n" % self._config['root_pass'],
+                          "    %s:%s\n" % (self._config['guest_user'],
+                                           self._config['guest_pass']),
+                          "  expire: False\n",
+                          "users:\n",
+                          "  - name: %s\n" % self._config['guest_user'],
+                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "  - name: root\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
+        udata.close()
+        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
+                               "-volid", "cidata", "-joliet", "-rock",
+                               "user-data", "meta-data"],
+                               cwd=cidir,
+                               stdin=self._devnull, stdout=self._stdout,
+                               stderr=self._stdout)
+
+        return os.path.join(cidir, "cloud-init.iso")
+
 def parse_args(vmcls):
 
     def get_default_jobs():
diff --git a/tests/vm/centos b/tests/vm/centos
index a41ff109eb5..0ad4ecf4190 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -31,37 +31,6 @@ class CentosVM(basevm.BaseVM):
         make docker-test-mingw@fedora  {verbose} J={jobs} NETWORK=1;
     """
 
-    def _gen_cloud_init_iso(self):
-        cidir = self._tmpdir
-        mdata = open(os.path.join(cidir, "meta-data"), "w")
-        mdata.writelines(["instance-id: centos-vm-0\n",
-                          "local-hostname: centos-guest\n"])
-        mdata.close()
-        udata = open(os.path.join(cidir, "user-data"), "w")
-        udata.writelines(["#cloud-config\n",
-                          "chpasswd:\n",
-                          "  list: |\n",
-                          "    root:%s\n" % self.ROOT_PASS,
-                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
-                          "  expire: False\n",
-                          "users:\n",
-                          "  - name: %s\n" % self.GUEST_USER,
-                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "  - name: root\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "locale: en_US.UTF-8\n"])
-        udata.close()
-        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
-                               "-volid", "cidata", "-joliet", "-rock",
-                               "user-data", "meta-data"],
-                               cwd=cidir,
-                               stdin=self._devnull, stdout=self._stdout,
-                               stderr=self._stdout)
-        return os.path.join(cidir, "cloud-init.iso")
-
     def build_image(self, img):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp = img + ".tmp"
@@ -69,7 +38,7 @@ class CentosVM(basevm.BaseVM):
         subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("yum update -y")
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 48e9cb1ad3d..3266038fbde 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -29,41 +29,6 @@ class UbuntuX86VM(basevm.BaseVM):
         make --output-sync {target} -j{jobs} {verbose};
     """
 
-    def _gen_cloud_init_iso(self):
-        cidir = self._tmpdir
-        mdata = open(os.path.join(cidir, "meta-data"), "w")
-        mdata.writelines(["instance-id: ubuntu-vm-0\n",
-                          "local-hostname: ubuntu-guest\n"])
-        mdata.close()
-        udata = open(os.path.join(cidir, "user-data"), "w")
-        udata.writelines(["#cloud-config\n",
-                          "chpasswd:\n",
-                          "  list: |\n",
-                          "    root:%s\n" % self.ROOT_PASS,
-                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
-                          "  expire: False\n",
-                          "users:\n",
-                          "  - name: %s\n" % self.GUEST_USER,
-                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "  - name: root\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "locale: en_US.UTF-8\n"])
-        proxy = os.environ.get("http_proxy")
-        if not proxy is None:
-            udata.writelines(["apt:\n",
-                              "  proxy: %s" % proxy])
-        udata.close()
-        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
-                               "-volid", "cidata", "-joliet", "-rock",
-                               "user-data", "meta-data"],
-                               cwd=cidir,
-                               stdin=self._devnull, stdout=self._stdout,
-                               stderr=self._stdout)
-        return os.path.join(cidir, "cloud-init.iso")
-
     def build_image(self, img):
         cimg = self._download_with_cache(
             "https://cloud-images.ubuntu.com/releases/bionic/release-20191114/ubuntu-18.04-server-cloudimg-i386.img",
@@ -71,7 +36,7 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
-- 
2.20.1


