Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBCC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEF620578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCkN7ke8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEF620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SWn-0004tz-93
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOD-0002xK-Kw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOB-00081R-W6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:57 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:43959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOB-00080y-OC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:55 -0500
Received: by mail-pf1-x431.google.com with SMTP id s1so313524pfh.10
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebGq32l0nFHilBZHXJSmVFGGc6KeoYEINrsNMAqI2qk=;
 b=gCkN7ke8S9LuLDuubL2fV4vxQC2ve0J+uVGkTjMCy2x45hMnq2zNxVPNsR9Er8t2OE
 e7RrpNdKEUSLvF6g2uGFC97KeMNKQAt5G/Sc0k/0tvu5SqvMdhlEA34quhpqD+1sl0PN
 AJ1gTzcZ2QEsn+VtfJwtKMN+ovcwqcHzsKOrTuZIPgkpR6ezAcSFJ11HP6kCuzc6kt6f
 ZuS92caSN/JNchV0vhhWMi4rtOCeiDIuCaAdJV9BgxcjOAMeU9BjL9cflZPAVpHzY3u0
 KC7PN3YpJAY8VbxDNoyiW2eo0ni3/e2+7jfkmMIPdwHgqRRq4iwBNSBmRm56nHMvQY9D
 RqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebGq32l0nFHilBZHXJSmVFGGc6KeoYEINrsNMAqI2qk=;
 b=gYp+F5ywygxzdQNFuDFPsSEPEShq8BOs8t4Lx3Ca7tHm4A07mPY1xPxnRPI0WT2YOQ
 LLSQSy2hKagLW2fwZd6HYa+WRzaA4TWe4dSipW0DTR8uTdhCDEo7niwdIltNxBAkWuJ1
 bRvuJvGG+HopKdaTlES/mSYW/xCxr62DsNHCOzPgMZoxi/mbps6vB0jiQKXi9GQpRfts
 dLIdDKtnYb/4EQdbx2tWym/RRxMYkL0sbqFZe1tlLb6ngoJ+RDZm7gbtZ4Okcc6Q+y5c
 Lzmdbxl07PCQLePtMuk0A9evGi6MGP+HChIWagH0b/L+ph3LMJ8nG+gwIXQ6kE2Rc1Yj
 5uJQ==
X-Gm-Message-State: APjAAAX05x7X0zZT7MtEij9OL+U9j7N6cg4mL1yQmlpxP21oue63IT1y
 El5fwgqZfXj9tpFIsANTRdBBi5EUyNE=
X-Google-Smtp-Source: APXvYqz1M2QtFpW+KYR68gLmFhTl5o1yKAtGdzXMM7ImKgTmZKBgbG06+a+wWLpm40126SvUxCbb4A==
X-Received: by 2002:a65:4d0d:: with SMTP id i13mr28300362pgt.346.1582130394277; 
 Wed, 19 Feb 2020 08:39:54 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:53 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/14] tests/vm: Added gen_cloud_init_iso() to basevm.py
Date: Wed, 19 Feb 2020 11:35:28 -0500
Message-Id: <20200219163537.22098-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This method was located in both centos and ubuntu.i386.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py   | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/vm/centos      | 33 +--------------------------------
 tests/vm/ubuntu.i386 | 37 +------------------------------------
 3 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7f26892268..8400b0e07f 100644
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
index a41ff109eb..0ad4ecf419 100755
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
index 48e9cb1ad3..3266038fbd 100755
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
2.17.1


