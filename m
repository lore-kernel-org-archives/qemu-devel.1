Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E62C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CE42073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yh2az2SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CE42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99AY-0008Sp-Pk
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9982-0003DL-5h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9981-0001lv-16
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:38 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9980-0001lb-Qn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so4773934wrn.6
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kM9hBY7eIh07kImPzKsu/Kar9U4il+ooFKtjpsl4u+s=;
 b=Yh2az2SRjAwIjznOGOkJ7HqYNYLNUQ7AN5n0D7Rom4RyvmFESwLb47sfJI5Z8Tg2Iw
 4Srouw4aCB/SFr7XvP8taU8xydvUgB4/UqtUcgPG/mqll0LV1qVSy31l2vM5OZvxiOiR
 rV/CH0T6VfSd6LcK8G2gKdzxs5mmGxyDYAZWE+g9JJ5A7q5kaoeti0CNW710/RsvTq3s
 l5rmwTZJnyAjU239f4aR2b8W+1GTx2YSSb9m+U2CRwtNSNoDNaePpUpe1KXrerBru+vB
 a6OejfTGywCbA0C0mQeHv/dANFQqTr3Iw454oIuL36b0FiNDa0kG6kwrDg7HI0O+8+4c
 Dkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kM9hBY7eIh07kImPzKsu/Kar9U4il+ooFKtjpsl4u+s=;
 b=RCCkY7/IMArZ1JPCX4VkCJkxJiRNvJA+x3p3O8t5OWrT9ymeD52UAtzZbUN53rfM6B
 nZQYLnNzcavt7dkxA5xLd8JsX/yfnb41M+iNX2R6ICiznUzlcWQ/YyCJ6KSLLwHLV5GL
 DCGq/qOk8tQan33XSHxq3joIW4YjzHQdZG0+JVz/Jd7V6bhlUfS1hscx0bt1rWI6yNG8
 1MuW+tBMdq0p37Aw/Cfv8wo7/9eUlaFjbeXf1vcUetVSrvj08P9ehhnCztJeaBoDKM34
 pIlP6WzSVI0TB4sII+dHIeaYBM1GLwOfQBJKgYwkEB/BnldDUknGs02IPwp2CMIW6xry
 MRnQ==
X-Gm-Message-State: ANhLgQ0N0dP5Q16mRTU/juDKm7+Xqd3gQq3KkimluR7HC+mqOS4kNduk
 hN0PM9ekXSPSzhZ99H4NgyDKCQ==
X-Google-Smtp-Source: ADFU+vuLNYXJgtowbWSrlTl3RsijOgzoAWpCkR9E3ib71ZjNpIZH7D4mpa3IbpAh0VZN+IHM+kMOtw==
X-Received: by 2002:a5d:608b:: with SMTP id w11mr5377328wrt.366.1583247995826; 
 Tue, 03 Mar 2020 07:06:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm16265232wrp.84.2020.03.03.07.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:29 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EE4A1FF99;
 Tue,  3 Mar 2020 15:06:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] travis.yml: install python3 numpy and opencv libraries
Date: Tue,  3 Mar 2020 15:06:22 +0000
Message-Id: <20200303150622.20133-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

These are used for the acceptance framebuffer tests to count Tux. As
we need slightly newer python3 for opencv we bump up to bionic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - bump to bionic
---
 .travis.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 70a24bf2fc8..b92798ac3b9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -313,6 +313,7 @@ jobs:
 
     # Acceptance (Functional) tests
     - name: "GCC check-acceptance"
+      dist: bionic
       env:
         - CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD="make check-acceptance"
@@ -323,7 +324,9 @@ jobs:
           packages:
             - python3-pil
             - python3-pip
-            - python3.5-venv
+            - python3-numpy
+            - python3-opencv
+            - python3-venv
             - rpm2cpio
             - tesseract-ocr
             - tesseract-ocr-eng
-- 
2.20.1


