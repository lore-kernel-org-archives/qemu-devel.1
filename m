Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78BA207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E05BfWmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78BA207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibfc-0001Ba-0L
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeK-0007uz-Hl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeJ-0004QF-CS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id g10so2315606wmh.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iLEYO586LN3lan1c/6dZyP5NhR1wfNmqNW/hILo90zI=;
 b=E05BfWmoqCNO58L5BPz1PwjV0obDMFC9J2pqtfcRk2LqJE/LjYYnC6qCd0WFy7CYT0
 WCLeBIJnJjFFoHbGKdWOO9jJXM14QCk1StPW9IHIvyZcZMqHgkqUBlslDfkU+vfwcTSM
 7eN+4OnTEv3DCqCTvJn3a63j+HbVAGN+lPfL/OB0SZEO5LlQgERRiMW3+SDlCx15C4Is
 hCXLtoNOUl03J6dB0Nmohr3HH3cvtOvQrBP1x/yhh3BtWIFSyg25NLAKMEgUuLNjx6xF
 DSTU4DsaYQhAadvupRG1wCnQOJIN5d/7s3sz/7oN5Jz57Aiu58/P5bBll3IdHFLrRqSl
 oz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iLEYO586LN3lan1c/6dZyP5NhR1wfNmqNW/hILo90zI=;
 b=dWbqqr+8p9tqleppXK/w0cMf5qW6tehe1BstYFcgoX9nuMc0I2SxChXkXOJvVxIMbJ
 Gb5Ov24N12jM38ZRSAN3th/TGyBmNc9M1/V12sKraPDVHcQEPSLjacxTWmcn6Qo15AEF
 AYGnK891crJVqN4WUFduWKrT90YWdAAZ8tj6/0XMA+e9TKRKkeaAtKFsr2+b4lM+Frq4
 84w4emgCRx0RMh2pQUerWOK8lDgAp3HK3+cobXSZ3/tPNxY5/kRaF3/tZdf9eVqW1Th5
 4TKNfgbhWSXBBjx5SZ42rWDwUdrg1vKLmEYNxjkhmN5CGhqlS+tllaME/grIM/57vP89
 TbNQ==
X-Gm-Message-State: AOAM533tv/PtAxZVTkUy0AbJUPt1V99UkME6OzmutVy6xfWvlyj5mXkJ
 B/SKamXB74mRpOG8I6lVyza3QA==
X-Google-Smtp-Source: ABdhPJx0Z7av3V2Qfb54yGI/xT5s8ORYmzKs035nNVg6GKKk1uKCHAJ4mTlTOLs7iuSQBTBzvYQZJQ==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr3216584wml.108.1591699110009; 
 Tue, 09 Jun 2020 03:38:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm2795837wrx.44.2020.06.09.03.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9ACC51FF9D;
 Tue,  9 Jun 2020 11:38:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/17] tests/vm: Remove flex/bison packages
Date: Tue,  9 Jun 2020 11:38:07 +0100
Message-Id: <20200609103809.23443-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200515163029.12917-3-philmd@redhat.com>

diff --git a/tests/vm/fedora b/tests/vm/fedora
index bd9c6cf295c..a9195670f4b 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
     pkgs = [
         # tools
         'git-core',
-        'flex', 'bison',
         'gcc', 'binutils', 'make',
 
         # perl
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 298967fe9cf..f87db2b126e 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "flex", "bison",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index b10c9d429de..cdac502dad8 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "flex", "bison",
 
         # libs: crypto
         "gnutls",
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 0b705f49452..13e7f9a6d56 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -35,7 +35,6 @@ class OpenBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "bison",
 
         # libs: usb
         "libusb1",
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 15707753353..24527cc78c7 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
+        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
         self.ssh_root("poweroff")
         self.wait()
         os.rename(img_tmp, img)
-- 
2.20.1


