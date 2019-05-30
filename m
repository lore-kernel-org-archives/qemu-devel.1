Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F7C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E45125725
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISqxTQ+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E45125725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIEd-0000K9-Lh
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:24:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6Z-0002dD-Pc
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6Y-0006Xu-In
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6Y-0006XB-Ca
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so765077wrs.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=aEPT2KH0ylKDQMa3RRq5y0ml/pOWW4HSQXWafsxR9f0=;
	b=ISqxTQ+sW2feLTqo940rJnIFrMshLMilzv1nngoXgcL3rLG8EW93HVKRxBcSWtlRC0
	cWV/WrfvsX6KIv3AeD8hV9u1bFw0cCmQA+mdT3JjsFx7JL/IrLaaQItB/rMPa9Q2NVjJ
	kQErzSH5GDGoiDCLGF2Y1xQ99JsQJnd5XmOWnHLlD+eQlfLFCl7ah8eR7H+9Fam28ZBP
	ShEKJpOvtuifJ48E4c5NxYjL+iAnS3C9ffRGnzpPEfWsfQVoyUbeilMZZPra/xNqC2oA
	GC9JiqeEkR4fWqDwpUvBprx6oLFmHM5t4oWeqQg8bKvn1iCMd2PTouJUmzMN07X7uL0Q
	2wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aEPT2KH0ylKDQMa3RRq5y0ml/pOWW4HSQXWafsxR9f0=;
	b=Fq/0F4frv2NJFWHb5+4gGMD4TVu9l/ZJtxASQJGntnqUO5mKR6DNATUWW1+JSpT0yp
	cCDPz64M16WNxl0qBNTLpEngEKvhJfplJeXejB0ySaMWHjgGD3Zw8T+9TU996aoIMR2M
	sFuzVbCClLZNGXlu2S8L2HUWtlV1B3TyqcJknP267hyW1QoHMG4gW8MR6ADjTr1C6U2h
	Gz6tbvyxPD7jpQkrGTfjc6JNvDNVvHabcyi53ssI9hpGTA+NDRM7U/0krjquo6JM4xOX
	uJwX7Q2W7Eq4U+9rqFtHN9n3oamPkaEJgu6+VBgBL04kgeibWf6KIkTQ2MHPJJTFDf06
	05Pg==
X-Gm-Message-State: APjAAAVAD9f863l3rfs+sCW6C2Xx6BbjmtPlm9VNE0hUYCZ30U0bzMgv
	ydT42HhE1uiT9NQPgVOwL5upSQ==
X-Google-Smtp-Source: APXvYqytXWu9kdd/CUBR4p0OTJno6iz9UKk6jl3wSSjP0H4u0r/9I7c5M0YodQuav55WYFkpmZZJWw==
X-Received: by 2002:a05:6000:148:: with SMTP id
	r8mr2070870wrx.210.1559211373322; 
	Thu, 30 May 2019 03:16:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f3sm1906097wre.93.2019.05.30.03.16.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:09 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AF4561FF98;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:45 +0100
Message-Id: <20190530101603.22254-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v1 08/26] .travis.yml: add clang ubsan job
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document this on our wiki and we might as well catch it in our CI
rather than waiting for it to be picked up on merge:

  https://wiki.qemu.org/Testing#clang_UBSan

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index f0aa37f2d12..2f1658602ed 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -152,6 +152,13 @@ matrix:
       compiler: clang
 
 
+    - env:
+        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+      compiler: clang
+      before_script:
+        - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+
+
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
       compiler: clang
-- 
2.20.1


