Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02037C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF1B21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pudx98c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF1B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgTc-0007sD-1i
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRV-0005zF-MO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRU-0008Rs-Ec
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRU-0008R3-7R
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so676346wmj.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ahgJcoAG7RlG7q4icivLXPe7IKp6EgtWsDrDvy33nsw=;
 b=pudx98c+j8ZzDliq4YExa9ZVynTLKf/yqrj/3IvRabsx6+gwOY4wcobzJ2LOPOPOhz
 NWD6QguqQ9xKrYKgIqt7nwc02Qpot4/Plj+gmJHdgpaLAnReM2T2UVL/kh3AU0T3jWtu
 AugUyumRiBAA7JQ9IKaqBvC6AbN1N2LYIpOqCRpjZs7quG7fNaB9ZT76jgNCDt/ZH00i
 nn//+5Q5hKlZfU/XfWf6p4pN95BXuXQ73z8DBZF9op20avcfZxGJIFcbgur0GudZkdJe
 j0B1EJlbB0VN8aRzW+qe2W1IB6AORRKgO+s75e7hKbXxykAkijOLKMhLC4FDpJSsxZ1b
 WQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ahgJcoAG7RlG7q4icivLXPe7IKp6EgtWsDrDvy33nsw=;
 b=OFsbvChHIMD5eusd0t+ZO9TUi62Oy2y+NDD4FCTwNsCPUVWcfTf4o0Wtdiwfr5/Z1n
 P1P+C6KgEHRMkfNfM9qDPIBD+hMRnmw0U6mEd8b30US4AgQJuY4/DWc20KXuLbmWR/Af
 1KIM2drf7t3WF9+XS+Frs7uaKhfAzL+NEG3aNqSAEBnZ+3woExEcwcFagqTsjKqDeBCd
 lgJJRAdXpuUBRVb/2EpUpdzP+iyIi8LojLeEc/vPC+xcLCceRM4+T4soB1cpyDbvjuuc
 30ui1CDSnRKPqr241nLFH1PVL06av4tg4Owesl7C2pP8haVQXVLguGqHY+lMmjPuM1Bg
 ZoIA==
X-Gm-Message-State: APjAAAUxVczliCu5wqiCGMMuSmBZL1QMoSnPKRnF38aFlbP9MtS2MizA
 PDuZ5UCBwaGrkPn5xrmTMu02gA==
X-Google-Smtp-Source: APXvYqxQaUiq4e94q+Fv5OwfONe1WJ1/kiMUH7Qh6O/tzqP8tltbhSk6AF1tnYp0dlie3o8zkOlI6A==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr9641760wmc.53.1560973222964; 
 Wed, 19 Jun 2019 12:40:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f12sm27114958wrg.5.2019.06.19.12.40.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BB3E1FF8C;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:05 +0100
Message-Id: <20190619194021.8240-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 01/17] tests/vm: avoid extra compressed
 image copy
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

The image copy is only really needed because xz doesn't know to
properly decompress a file not named properly.  Instead of
decompressing to stdout, and having to rely on a shell, let's just
create a link instead of copying the file.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190613130718.3763-2-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/centos  | 4 ++--
 tests/vm/freebsd | 4 ++--
 tests/vm/netbsd  | 4 ++--
 tests/vm/openbsd | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index 7417b50af4..b00b46a8dc 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -66,8 +66,8 @@ class CentosVM(basevm.BaseVM):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
-        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b0066017a6..5575c23a6f 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -34,8 +34,8 @@ class FreeBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 4c6624ea5e..d0508f4465 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -34,8 +34,8 @@ class NetBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a26..87ec982489 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -36,8 +36,8 @@ class OpenBSDVM(basevm.BaseVM):
         img_tmp_xz = img + ".tmp.xz"
         img_tmp = img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
-- 
2.20.1


