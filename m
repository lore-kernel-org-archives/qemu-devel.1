Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A9C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5516E25741
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdP14LNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516E25741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIKI-0005Wz-GS
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:30:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6e-0002gc-0B
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6d-0006bi-4V
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6c-0006b5-SU
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so3829115wrv.2
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DzRVR0ExhRGQxByUv2nr/r2y2wqFk/czcVmFguGzwdY=;
	b=RdP14LNOerzbqEp1tTroRRiVS7bA7UBC9UFnl1qdwxUFoUTbHJiokmedvonwoFAK9h
	svvAk61R/y5JcfxyI9ZyDTK/MRqY24Sqgu0JXNeJ0OxcU5DSl/KNWQZ0e6ds3xMNt4u+
	RHk2qlNNmDCURKd8lpOeqrtex3kemf54jHZpw6c/Iol5wzzDaj6BT4Iv6ZuwSqL1A1/Z
	ct4r6deydGD0uezL2mgsr8wD2Uoi9Ez03bU+3kHy52G3uT/uEUYoc3WLlb7Z9ROdhLRb
	k4q1XFF1wdIXd3szo7nAfz6YVJX+8fwgd0nXDTdOPCL1KEkKzkejhzx7Zz0tT7rq5M8m
	9reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DzRVR0ExhRGQxByUv2nr/r2y2wqFk/czcVmFguGzwdY=;
	b=agjecLv99QkjPUzYchKT4Tk5k0s8YQ2vqa7sambCtZTLNyjOD/AHvjlscL02r5Zjku
	LFehZc/Y4vhFFHf/6bEMZeTvp16+tDbOWoNVwSgAt55FuSWOx2DXsWlZSI304ZEISqY1
	6WWlzv4droPKhjNE91rePDN5aPVazPQ/L0tUg3SQDJ863bxnTs956J3cflASUA3wKgoX
	ZqfXpQqyWTACAb8LlZ4mx/JN68vesmiFk2S8DUQWDZNwuF/hKZlNRJw4VTI0sXVkp+dE
	ZBVsiWB/ug4+xsba7E+Sxnd85PM3tv3vKjix8j1p8wCPYq5tLAOwk6hhPGrOPLJlg7XJ
	CfBQ==
X-Gm-Message-State: APjAAAVbgfViFIVAJFmXQk3W0NbWP/qaojUP7ngrNyyOe+TpqJcpchuO
	uoMp/MTGb8YZ62CmikDwUpuDBQ==
X-Google-Smtp-Source: APXvYqxiVDZNyIeMpJQHDPyfutDG8NqOHk19OMPgk26WtEZBtYdEGT6YG1wFsuPIoeKU0C70u0LpFA==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr2152352wrw.214.1559211377929; 
	Thu, 30 May 2019 03:16:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f2sm2888915wme.12.2019.05.30.03.16.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:10 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E9E961FF9B;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:48 +0100
Message-Id: <20190530101603.22254-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 11/26] tests/vm: Fix build-centos
 docker-based tests run
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

`make vm-build-centos` run docker-based tests on CentOS. The
created containers should have network otherwise some tests
fail. Also fixed the BUILD_SCRIPT template to correctly
evaluate "V=1" for verbose output.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190329210804.22121-5-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/centos | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index ba133ea429a..7417b50af4a 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -26,9 +26,9 @@ class CentosVM(basevm.BaseVM):
         export SRC_ARCHIVE=/dev/vdb;
         sudo chmod a+r $SRC_ARCHIVE;
         tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos7 V={verbose} J={jobs};
-        make docker-test-quick@centos7 V={verbose} J={jobs};
-        make docker-test-mingw@fedora V={verbose} J={jobs};
+        make docker-test-block@centos7 {verbose} J={jobs} NETWORK=1;
+        make docker-test-quick@centos7 {verbose} J={jobs} NETWORK=1;
+        make docker-test-mingw@fedora  {verbose} J={jobs} NETWORK=1;
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.20.1


