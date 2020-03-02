Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2ECC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1B82166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baZCwyYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1B82166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pgm-0005j1-BV
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfD-0002XH-Jf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfC-0001DT-72
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pfC-0001AO-0e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id x7so1033989wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=65Txf0NtQrDZ1B5f2IUJMSN/X+Wm8MrtnU1Cud0aVmk=;
 b=baZCwyYNXJIeoYtkK32eojnZSHp4XgJQOynBD3iQtaDYbCHODKRErsNnmqKvf6RhLP
 QzuLIIFVXaSyUuymiBhPY6Hot6SeS62ofHsPls+4wsKbw5KDDd1+tWCsmIZcjD9ebtRp
 9ME5k23ZGh3lIgIqxTXJGXK6BejELYz5aTNttg3Ro37JFQlXMzeZUnCJ33QjqSp0BkQV
 q+qDWLSv/ZgyVAKY4I2EOiJXzA+ZottULg21XOdN7NxVQPF52Y240ppRSnRFXeMwY4Ok
 4Ee+niwWZjMJci8mXoLF1QA7v4TIhNY5qUPxB7VE2Gcr+zqFxJ99q5MNYkS68wFcHVIP
 t6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=65Txf0NtQrDZ1B5f2IUJMSN/X+Wm8MrtnU1Cud0aVmk=;
 b=pqBFuXVJAlYk1kNK7FDCLeMf/11C4tp7xMxgYl53BbZeIkrvBsGVFiZhjGEunRc1GB
 tXPdzhwvbKIUJoVMtpfofAH46nI8Q8dSV9b5QQ42Jv9OUui5MoLhnxJDBnJ7gloCjU9+
 1Gf1aNOiwajyRJH98HMyRwoXkomVUP6H9mYFdueFMjPH5OjHeK3VaV6AD7cBxeFTcCXL
 dToq8XSqFNm4CD+W2jMckQgT5uQfGLcyep9As22lQHvuvuQ4ai3TydYGWfl2bVv6Ew7s
 Cf/Artfc/0O6Li9Yo6niibXvjBqM2tVAUjG8oARkh9+ck+BFA+ipQszQvq2hbXn+/Eyb
 m0EA==
X-Gm-Message-State: ANhLgQ0DoQonipzE3pTNx9oYHWMbuTkZ35Cc85FTjgOFgXQ8G/fJk9XN
 ZDr85bwQVCWEGJf42LZH9ZVL+w==
X-Google-Smtp-Source: ADFU+vuhoDGK1suJ6QlvTy4INR1I1A4/Wz0dc4CMncspG5pIC70ePwnJA2c3t0FR+Ji+yJ65B8zNlw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr801024wrj.196.1583173156868;
 Mon, 02 Mar 2020 10:19:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm28676472wrp.33.2020.03.02.10.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:13 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C9081FF98;
 Mon,  2 Mar 2020 18:19:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/10] configure: detect and report genisoimage
Date: Mon,  2 Mar 2020 18:19:05 +0000
Message-Id: <20200302181907.32110-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used for some of the vm-build tests so lets detect it and
behave sanely when it is not installed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                 | 13 +++++++++++++
 tests/vm/Makefile.include | 14 +++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index caa65f58831..376ccb25623 100755
--- a/configure
+++ b/configure
@@ -936,6 +936,17 @@ do
     fi
 done
 
+# Check for ancillary tools used in testing
+genisoimage=
+for binary in genisoimage
+do
+    if has $binary
+    then
+        genisoimage=$(command -v "$binary")
+        break
+    fi
+done
+
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6567,6 +6578,7 @@ echo "python            $python ($python_version)"
 if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
+echo "genisoimage       $genisoimage"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7616,6 +7628,7 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
+echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 778e5067554..1bf9693d195 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,11 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora
+IMAGES := freebsd netbsd openbsd centos fedora
+ifneq ($(GENISOIMAGE),)
+IMAGES += ubuntu.i386 centos
+endif
+
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
 IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
@@ -12,12 +16,16 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 vm-help vm-test:
 	@echo "vm-help: Test QEMU in preconfigured virtual machines"
 	@echo
-	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
-	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
+ifneq ($(GENISOIMAGE),)
+	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
+	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
+else
+	@echo "  (install genisoimage to build centos/ubuntu images)"
+endif
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
-- 
2.20.1


