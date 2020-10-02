Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77183C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A70206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXA1enb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A70206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJWJ-0007Rn-Op
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNH-0006v8-Sp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007dF-AN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id k10so1443421wru.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yf34W0UG9bSoWU3PdrQbo/iXmFEGMdKNNVCv6EMFOfE=;
 b=rXA1enb3RAAk6f3vNqwiAxtT0KL4mvAmMuiXh4fFGMRUA2P/X6fYXsZg9jo8XSyMPi
 xNJE8pff60wzFkCVLLOoMxOaDmNEPFKnAzZKUaRP9dsOLYqr+T3DkITBEJ5V5aOs/3H0
 Z6Kp/jwfun3sEYQ9iCo+TZRFAfTVI/wP8M/t+iJWVuSTFm1lHUotfq2o04aA9fQY8pcq
 nBQET+zXcfHOxC87gWYDn1+mgyM/vZLjv6K2s8kFihro1Eghi/FNArmR314k+G6HiH1F
 b9JAxO3SK5nrS5i1j/t4LrOe6pUnvAuVB/0mBddUE1Pjxs1WdGhoKPLkskc7HxA/n8DD
 9qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yf34W0UG9bSoWU3PdrQbo/iXmFEGMdKNNVCv6EMFOfE=;
 b=c8t9jiPXD/kV/QJKsHRnOjElsTZTkZg5/iHPx9norVfVcipTDWnRD9um2tCs29fjNj
 ZKobovy6WfQFjkbSGbD5KRQQSKqdjEYzzclaXqZY4ZEFmdZ/Iz+lVjcOkbQxxIIxPCVw
 TXkBe5EwgeTtEYLHsT+mooUyy9j4cHI0qs3r9yz0CYMCKS9SFHgvsDTHwUIpp4Zztcct
 tMay+Vh+8qDpUW4wjsafBWhgNarzy2/zyO2A65MHG0/o9yeOHLVjpsSj2ozMblBEPBmt
 ybxIBqNdd7TZxDmku29BErPpMcox2M0yx0G54IfTAlNwI5gaLJfabZqMWLnl7ZU0Omt/
 AtXQ==
X-Gm-Message-State: AOAM5315/PzDWKWGVLJZS4kRdxaX+Y12RKFg6lZk/FQXcAE0/O6kQigC
 PeHXax/FH6apZDUTbSDIz4iv0EmfgEN+8w==
X-Google-Smtp-Source: ABdhPJyp4DW+YproEUVgcFyiI35IFSvE1zfVoZbZEsUAKAez2q1U83ZzEfa4PWZCf3TSeVGTe+aq9w==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr2713687wrm.371.1601638625708; 
 Fri, 02 Oct 2020 04:37:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d19sm1560755wmd.0.2020.10.02.04.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C333C1FF98;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/14] shippable.yml: Remove the Debian9-based MinGW
 cross-compiler tests
Date: Fri,  2 Oct 2020 12:36:40 +0100
Message-Id: <20201002113645.17693-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We're not supporting Debian 9 anymore, and we are now testing
MinGW cross-compiler builds in the gitlab-CI, too, so we do not
really need these jobs in the shippable.yml anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200921174320.46062-5-thuth@redhat.com>
Message-Id: <20200925154027.12672-13-alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 0b4fd6df1d..14350e6de8 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,10 +7,6 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    - IMAGE=debian-win32-cross
-      TARGET_LIST=arm-softmmu,i386-softmmu
-    - IMAGE=debian-win64-cross
-      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.20.1


