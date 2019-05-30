Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87429C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52ED025715
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCUSwaMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ED025715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIBn-0006Gg-EK
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:21:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6d-0002ff-3j
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6c-0006ao-2t
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6b-0006aH-Se
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id z23so3459874wma.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zHc+QewZiPLzAKrh7Ap5biSxTst0S3+b8dtoVpxzoyo=;
	b=aCUSwaMJHXE+rRG3Ku2QceQq/98HeRQvRONO/R1BIQnVG1jeFIsenqNU2jnpL0T2ZR
	dJgxHo72vXx71eNWJL6906Jhbtz7kCkBlK5hAr/8OGWlMA8fNT70v3V5LBMjUujpICOt
	J4Slyk4z+Nss4WmEAqhnOs2e/vGKirgumAUVWCi0rcjG9UUrzD3AKZtGFm3b6qExo9eD
	T+qWDkaR+ygFV7IjU0Dm0cF0gNRFkPlAXIg43+UfGpGFp5yFBlDf0xtfXKEW+1O8z043
	YT06593rCtvOeKfwp9wS1LfhB1wA0oX6wlct4ZPcIN+0uHll2F8LpG+bnbkRmaBtnAZ8
	flTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zHc+QewZiPLzAKrh7Ap5biSxTst0S3+b8dtoVpxzoyo=;
	b=iU+wpEwofmiGF6KZMcju4eTgyhrPnL1OKKSVkH7lMUrtm20yWE0JWgWTfj75hopztT
	KCLE1h3eVaacUbl2rXyJjreaiZZnsfnySJ/9ORnDQv2XISWvQXRvURVrcZr+tWIfMGm8
	ubjG9RmET8uA+xri7rqgRKgheyGItKPQbj+xyWRQkP44D+43ShH5+9bO/fR/IEo83hFN
	nlnSsCyWsYxiNRh1+caGKnlf0LfoSCUU9QRtDzGimhs0ADf6xC0Pn6DITctUPAhoD9Sz
	d0WMMp0kaqxbC48+7SwPtbASHsv3bQgG+Rv4gU2ZTY/zqzeZDTNxO4BEYEBjhICv4cqL
	YM9Q==
X-Gm-Message-State: APjAAAWfI49mGGixaRG7Ut7PSC9TVE/Uaa3ZJdspkH/tzZZMFoHKzkVL
	CgopxEt8QyffvzgJxE0qH1J98Q==
X-Google-Smtp-Source: APXvYqxXVomBiQw3TuXtOTLMLtFFcwzUhA1wgp8lcEVVqIUI4bAYpGBzQjTgJ6/fW0Hb8TOLmkSO/g==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr1689806wmg.35.1559211376798;
	Thu, 30 May 2019 03:16:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id h8sm5024657wmf.5.2019.05.30.03.16.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:10 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0B85E1FF9C;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:49 +0100
Message-Id: <20190530101603.22254-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v1 12/26] tests/vm: Add missing variables on
 help
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

Added description of variables missing on vm-test help.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190329210804.22121-6-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 6f82676306d..c59411bee01 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -21,9 +21,13 @@ vm-test:
 	@echo "  vm-clean-all                    - Clean up VM images"
 	@echo
 	@echo "Special variables:"
-	@echo "    BUILD_TARGET=foo		 - override the build target"
-	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
+	@echo "    BUILD_TARGET=foo		 - Override the build target"
+	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
+	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
+	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
-- 
2.20.1


