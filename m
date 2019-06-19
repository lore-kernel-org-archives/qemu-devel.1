Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F89C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37342214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMVuiKku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37342214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgZW-0003Xo-OH
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRW-00061J-AW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRV-0008SI-2p
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRU-0008Rk-So
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so669846wme.4
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOjApRFyonn/7Cn6p2ojwBNi3DBnLp0ky5fDJ7UyreM=;
 b=CMVuiKkugnseipDzZesGcJkDxkHE4uiVbnBppHdgkmQB7s1Tsyy2+ABEjUjJc6tr4S
 ZY8TRLzR9QEvYIXXaWswWNzu2ldQzKDEIPuCKRA9argsWyHKwqSfw5tnhmc+JLihcZix
 zqZyW6VnxB1TTZKinUzaJ2RCp/mCFXdaY6kWweoUbXxSGesAhGFrBuV41tuRYTNhMGK0
 xOFMvyIIsW9xXIQAXL7NBF16eTFKy38q2qHrAl3MIf1z3x+ERM7WQ82OjJjGspdS53Ac
 iLOuaiqMa9LOGK6EFcyB52UgifTlUmBUjAh5Qzwr3drjw6cLlcWmXPoqvt0+qZ9G8aQv
 ekQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QOjApRFyonn/7Cn6p2ojwBNi3DBnLp0ky5fDJ7UyreM=;
 b=leTR3v5Y3bSkApGiO4Cq+NJwnDvB7a8NHWTMeEhc2LgCN9CnOmZkXnUnnXN0d8k8E6
 Ij9j4JSCVx6FUY/qFondhr+rkL2YQOVFb2yOazWKyUQm3z0+cSSsM123g7uIPW6+TImX
 y94YqoyFe6arI86exIqQINjlubZmIycrzCM2KpLOfXtpE8p4SYCgXfL5Aeb32k/vqZic
 lJsx4n8zz3YfigyvN/U8ZNnLkXTgnmiretllLv85X29iziDEaLyTqsgV9BtFMa1rEFk/
 uZOBBJkISSItS6it1AKteaxdEe9aDXKmZn7/Rmanezf995I5z4YHEUg146zAB33LZT9K
 5gbA==
X-Gm-Message-State: APjAAAUdVeC21q/KqtmJpA7/8bjAT4cAWNDmEGHdAhyPxwUGLwd4LH1h
 oYKxVvyM9rC9DBnNqu3vxdVQiA==
X-Google-Smtp-Source: APXvYqzK5vhglbYC5MmULok/KEnE0eaUAO1Dl9JLrQ9pYfYPz9kcBdF2MAEQcpYaHdnLZxNdqF/bwg==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr9493478wmc.159.1560973223794; 
 Wed, 19 Jun 2019 12:40:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c65sm1375701wma.44.2019.06.19.12.40.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A53231FF8F;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:06 +0100
Message-Id: <20190619194021.8240-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 02/17] tests/vm: avoid image presence check
 and removal
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

Python's os.rename() will silently replace an existing file,
so there's no need for the extra check and removal.

Reference: https://docs.python.org/3/library/os.html#os.rename
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190613130718.3763-3-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/centos      | 2 --
 tests/vm/freebsd     | 2 --
 tests/vm/netbsd      | 2 --
 tests/vm/openbsd     | 2 --
 tests/vm/ubuntu.i386 | 2 --
 5 files changed, 10 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index b00b46a8dc..53976f1c4c 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -77,8 +77,6 @@ class CentosVM(basevm.BaseVM):
         self.ssh_root_check("systemctl enable docker")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
 
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 5575c23a6f..091be1a065 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -36,8 +36,6 @@ class FreeBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index d0508f4465..ee9eaeab50 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -36,8 +36,6 @@ class NetBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 87ec982489..28c7d25e29 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -38,8 +38,6 @@ class OpenBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
 
 if __name__ == "__main__":
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index a22d137e76..12867b193f 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -80,8 +80,6 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
 
-- 
2.20.1


