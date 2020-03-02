Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B1BC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A1B20836
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyTDue8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A1B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pg9-00042W-P9
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pep-0002Qf-W3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pep-00017Y-1k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8peo-00016l-Ra
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id j16so1008289wrt.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ypGQ7p6JhBF1xniDHKxYj04bd6tWT9PMX3hkKC2YjOA=;
 b=HyTDue8Fh0MTVFLh3fmkpnayOWqYSG/5iYgbPC48G1HzoVh4a73ZHCo/xFpOaIs5WM
 TaWpuFTWgY1GWJiP6HdX8igNvKdlI5198zMe4qXp8MtkYQH8fiDtcTrfP5Y6tj7B2fr9
 pCCRAlZQsSzBmPQjGwdhKVHZzZEJNnMOhPNCWiz87aMaqujbqmZdF1ekjoA6NNZwWR4G
 ZNQeJHlHyF+xt24uXMCdlHisst3ssU5kFgDLeTCDtzYDhcYbINlddmW34GiWo1SONvXx
 k8BWy8qgWaHJna6tg9ql5TKT+KhbyBiuMKEljQlCWZckVd1KTiB+7cuDSsS+PtNT+NUk
 WLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ypGQ7p6JhBF1xniDHKxYj04bd6tWT9PMX3hkKC2YjOA=;
 b=i3nDzW2MsES8njuc+8IKVG7HXKeuLSQRBs7/fZmPPywsbpVIY9iAjmVI2L2O5fNd9h
 FdAvPsGM6lc5ikwxd75uUmBVM5+ER82lDpDXHS2Eg5vvwXkvrojK6B8xXDw43sTo/lOI
 e441Ppya9DyzVoBg3vIsys0ujqEV/DJ57/t9B7SyAdpxw3VZIYlmsxwWp1oMDWfKwLDK
 g1JKgNMMsPbOGzP6gdbwlDrO4W9+eAaXQSjCSTDjbzkYWitRW2c278U94FY8UsoMs7CK
 kkLE3/aTzdoyDiPrt+AX+d8TZXgXPK0Xd53dHeuxbAP4V1+HbWKpWCSS+TVZtMQzQkFA
 +xyQ==
X-Gm-Message-State: ANhLgQ3fmHTG33uMYqH6mPWW0Gm6q5gh9Dlj+S7kR7L7AMWNhD4LciIU
 FXGcG2Dmj2v1tCM3qNnZKUL2FA==
X-Google-Smtp-Source: ADFU+vvPzl1qISXuBElhaf/Xg+P5ENgNq0dNGPoRMZe9u1rb2d+emiP6G3dKERRS6QvukbJpWWpyHw==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr798919wrw.177.1583173149793; 
 Mon, 02 Mar 2020 10:19:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f195sm314306wmf.17.2020.03.02.10.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:08 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92B7A1FF8C;
 Mon,  2 Mar 2020 18:19:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 01/10] tests/vm: use $(PYTHON) consistently
Date: Mon,  2 Mar 2020 18:18:58 +0000
Message-Id: <20200302181907.32110-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
consistent with other cases like vm-build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a4735..778e5067554 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
-- 
2.20.1


