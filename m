Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D4C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EBC217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSQluwCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EBC217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmdz-0004P9-EI
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:15:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU5-0003n8-2H
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008Aq-0I
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU3-00087X-P4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so4034283wra.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Llj5a15rxb/inXIkUK7P8QxmrenFf2cH6bC9uvAV0fk=;
	b=nSQluwCYcvQEr/MQNBK0KuM817Rs8FOFo5o/savJuTjGaWC4Y1N25A2k1zMnr4lYVx
	Pgj2t6jArIOARMOui8ADODwchbh7Jvz9KhK9bs8vbe4JihOPr/xkhEBmSRafIpWBC+3R
	hTykfpNFj+WTh5gsuBKEXHq37gYSzLkXntfC4AaaznEux7rBFml3qQDaeZrgIQFVXP1L
	qlAKbA74a4JxGMaQq6nw3EsUor0cvVOIoBjvtPfDwrt0cTx73Zpec7kdPZSsI8OdE4O6
	QUBID2lgCsIZ20gqzxwKThMJXUFPfLZmdl/td4Fu+W3F3YQkBBiCAgxunRj/Ij5GfVGc
	DMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Llj5a15rxb/inXIkUK7P8QxmrenFf2cH6bC9uvAV0fk=;
	b=HIKc+WMMuVyLrXA/SxEKR/yLL7EzstbE0Upx6AvDKjos1XeJEOp1YC20GP3no2xXzV
	wBBTAmR3+48GPpkyn6dKDGXY/PH1QOtHFAl4ZjQ4oB+9Mqx1ZsH57yX+e+EX8xMenSSE
	pvn/tg7L3AimjYttk1AfuaXZV3MoMNggrEX554Y1Ie7F2rTZS53L74B82aEPCj412uOL
	nXyqBmL5zh1xjbOHqn17rlkvPZ+7Xt+ClA6wo2QwQXGdpE2XY1mowwaVlsp+AxMK61RT
	d1ivP7IfZFR/iABSml6LvxlsFX1s83db0qx/O9uaTMnOSNeZwd7gnfStb3hKdVwNcwfl
	Hcmw==
X-Gm-Message-State: APjAAAWm8At9oVi/21FDGNYkzQVCJa1rynyUnoJFOZQEM4X9VrzfRbja
	NOV/IpcTWFXULiHyt2mc4nekGQ==
X-Google-Smtp-Source: APXvYqzb8vyfOuNoDcSNchV/giQaWe+/xyLprQq6dwD23MR1yyGijNHvmaXBFZcxFEhKoCn9pfhZQg==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr125004wrv.264.1557421522978; 
	Thu, 09 May 2019 10:05:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o8sm5064911wra.4.2019.05.09.10.05.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 146611FF9C;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:00 +0100
Message-Id: <20190509165912.10512-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 12/23] .travis.yml: enable aarch64-softmmu
 and alpha-softmmu tcg tests
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
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 66448d99d64..8ba571b88a8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -283,5 +283,5 @@ matrix:
 
     # Run check-tcg against softmmu targets
     - env:
-        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu"
+        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
-- 
2.20.1


