Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58635C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D104B21D43
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCHDYoqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D104B21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBJ3-0005y2-JS
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF3-0000jc-HD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF1-00049W-U1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so3358457wrm.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1w2U7KaJCafVLgHn4TQ85aM2P9TmM9vieHJlmx2rStk=;
 b=uCHDYoqcv9VDEyUxtKAUsDENvkZ56wtz/sqML043IXgoQ/uSfZfErKoBZ/NaQW1t61
 h3Gf7AVB5yEqLfwEbWhtqn6+Q1DslCgThuDriHhJs1CbzlC+uBRaS8e/kMtvRujbp021
 p96bFajHMA88jj0sMoufsgT9Os5SyrXkc0NPPRAoWC6swNDbDnnzdRO1ze3aDdYLbp+c
 qglzZKdDV7ysjnG1PsQucTmgZe888Vu3MAJa8r7+BW4lH+jR1C3FgEmeR3BFOG5QVc0h
 x7QuFUC3fGWVUKAwmt37cdIRcqYOHUh99bUGMi/nKSKb6UmOtj0S5cBuAtq41q4CGqPR
 QRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1w2U7KaJCafVLgHn4TQ85aM2P9TmM9vieHJlmx2rStk=;
 b=B2TNXPB5Yqqq2gGVgT6X8QQGAcLaKJu4S+KQeIHgz/TaTL7UZpX+vn6Hg16oe4D2UB
 VkyT/RNZ6LFsJzXsFdc8bOUPgVPX04FDLXTFBwa+xJFRmOTUPHuVYZrUb2ges9X1XPqD
 ZVfunB+541VVHSoUr5SMgJLbFPkIox9fwHoBphtDYmqBHKjOBODBrgcNInjn4Ar7kCCh
 FcsfWbotGQ69pMD0DBOud5hlZbpIBjAkCGP5f72M9mSsLKkatbXuRnW0m1Yfa/A/mLdr
 6KJ1oyCunAopZ1iTYVejKIObrWog0WrjfkZqeUlXgWsGJhPLHN+zk0u0Xg3NiG0XDYFB
 B9Bg==
X-Gm-Message-State: AOAM5330fMG4FKwNDrn+BgpgK9v9iZjsagd4a/p5DCKTT3HbLwAwFQ+I
 0xS+2gTVVSqBMnSRSOiD2HyXMg==
X-Google-Smtp-Source: ABdhPJzaNob2zXJnnOoIfTY/o/NwQ6vijnk9HCq0eNPJU2Xurcq4EiOKba+xiF07icLfwmADLDnc9A==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr21133735wro.242.1600177406597; 
 Tue, 15 Sep 2020 06:43:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d13sm26596319wrp.44.2020.09.15.06.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA0CC1FF92;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] configure: include tilegx-linux-user in the
 deprecation logic
Date: Tue, 15 Sep 2020 14:43:15 +0100
Message-Id: <20200915134317.11110-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The target is already marked as deprecated in the documentation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 58be974065c8..dfd7f18dcb24 100755
--- a/configure
+++ b/configure
@@ -280,7 +280,7 @@ supported_whpx_target() {
     return 1
 }
 
-deprecated_targets_list=ppc64abi32-linux-user
+deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
 deprecated_features=""
 
 supported_target() {
-- 
2.20.1


