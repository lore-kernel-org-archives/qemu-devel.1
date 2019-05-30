Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A244FC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEB525741
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tL38zyF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEB525741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIK1-0005IE-Kl
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:30:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFG-0001Ej-AL
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFD-0000Iz-Tj
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFD-0000BY-Dj
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id u78so3603731wmu.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=f1LzSCynUI6fUnn106lFa25PqYUY/YDKYZafY8tD3Yg=;
	b=tL38zyF0BhsVozr95jh31CUABlgftio1pK336oAi9rr4l0aYWXBMCRVE71Me+u9AFH
	P9e9Vp4KmdyIwYL8cCKyOAcI/hAaWOYrVGuobcQTne+YKUrgZcWW5Y3P06h5ac3Yi+en
	4oqpF7I3hqnebO5BEB/ZYox1iTnwUottJWXpzo2frLimSFkxRnZO61mdCk2Bd1aB11Ja
	s7/yzCHbglYed+bUTxnOG5fwIMXdKJqL6+8jbcm4BoPT6vW16dHfPPB8oDstVtq6iHH+
	MmYzwlsf7zU4Cur692GcnUitumsTfCfeyhjKRGm6HI62SewUdMaZ7DM2Hrx7/iJUqydU
	N9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=f1LzSCynUI6fUnn106lFa25PqYUY/YDKYZafY8tD3Yg=;
	b=Z6jUofCJHWm6ljlyCLi08DlyftFQ6l1r/9pwHIFL1xnWnI5Acdqjz55+dHIFODVrgV
	jU9Q1DCitapF2ceUR3l+UqSbRyIpxim4YCJfCWQxdGmD981tLzth/OcanBsKiOhkWcBh
	cm9+oSIjLmN72ywurU7c9T2ElXSJj9amNFqw5ZdINhuHPfDGY9o9gWSnD9JOP2kgIUkq
	nBENMsi3U9m739mtPEWPQBH09jDqCips/krjiR1/BqYXrpFGpt9ckkEU1Sfr3oxqwnMQ
	EqXXh4NIjurdqCYKjsnH2N3Zc0rCwaGmbJ/9deDWb/JJbVourWpTwaIEljxeSP3C6+sc
	35yA==
X-Gm-Message-State: APjAAAUuA8eK6BiVbVilCCNA1HSBxPLKjhTCEXpWvbgTF58jpvkvYMBv
	io1GF+Nii+SCTRNQiXhzUDXh3w==
X-Google-Smtp-Source: APXvYqzyZLa5HM3V3vBkGjUkCfCmt/DZglm6u6rTjZMbugLlBdvsqGk2ozyKeZb2hAHwmPCUWn/k9w==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr1893664wmc.154.1559211908713; 
	Thu, 30 May 2019 03:25:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y132sm3811044wmd.35.2019.05.30.03.25.03
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:07 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7428F1FFA5;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:54 +0100
Message-Id: <20190530101603.22254-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH v1 17/26] tests/vm: run test builds on snapshot
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
	Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The build script doesn't shutdown the guest VMs properly,
which results in filesystem corruption and guest boot
failures sooner or later.

Use the --snapshot to run builds on a snapshot,
That way killing the VM doesn't corrupt the base image.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>
Message-Id: <20190520124716.30472-6-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c59411bee01..276b870216c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -57,6 +57,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(V),--verbose) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
+		--snapshot \
 		--build-qemu $(SRC_PATH) -- \
 		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
-- 
2.20.1


