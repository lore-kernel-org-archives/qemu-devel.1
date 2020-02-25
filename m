Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035DAC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E8F21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfU8ao//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E8F21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a4W-0002cS-VO
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcY-0005cE-Lf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcX-0007Hd-Lh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:30 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcW-0007Gp-I5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so14595329wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=na92kVuJJsjY30jm/AoUIfDqEYfGMWmCBB2a9Ak5rMc=;
 b=kfU8ao//sTxn2+jp/mewHRgcmNuhH0miGGE44IjK0/bzxtBF/uz3kNp8SEKkizaBWw
 zzijHh6nyX7B8Dsv8/fo4fWeKJupsAdc05OMp7dFCij0LXmbyFDTtxzuOvalkcgC4pmG
 xwH42zZmEf+kfeRzsCHOj0dqgnOCvEFOGvui3wjGwZ8Hi9wisoLNmMaXox88U/rV4hCR
 OnTz6HlRCZ8dDwkiSwFlWgTTS1wJZuQVicrEYNxNcs5itOIPVz/lYYN6s0KRg9Hpo+VW
 5wyBQoy0c2upE4pQBS+sz2Tna33pxSKcGPWAlTQ4aY8TfCqVa1fLx79MGbLaC+Gqeg3M
 G7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=na92kVuJJsjY30jm/AoUIfDqEYfGMWmCBB2a9Ak5rMc=;
 b=CLW2oXGGVbH3aYtFONHD9irMXVDqSbtKhJV9uLApUbyrBSmPmUtGK2BEN7c/kcE3Hg
 OwdoIHZ/nkfsDvtxLx+WLAr7Ta5yc/1FJkNUZUlDKH5vPNNFHkLRxQOhD/EQxWGoP9Lk
 u+n7WOxfryppL5htVFb0PKZTD++7Jha83/P9H/K9Aunm8nL44JUlMfjOx6WroEygyYcV
 iQdP6yt4dhK19Y4c+l86Dn76QuERM5DPuliXIbboSdWB+YJZPmDoNhjcCVzRiV4hygXf
 JWwwDEsI59D0H8Q2Pk8rqmLytwCwRXLecD2E93WtjeP/hjEjaUxNcTy+J5uD+UjlRKWD
 pX2A==
X-Gm-Message-State: APjAAAWA32DlslTxNnXemYHh7HQrT35rv5h/C9AK1MmWt+Y5NnE5YkK+
 79PisJ/6A0Kf2XFP0/BQkO761Q==
X-Google-Smtp-Source: APXvYqzantn4UyHjGDRJMwcfpHqNT+AyG386KerVbvcQeeBptcKWGVcVU1Z++1zQ5GJRz4b5UDq1OA==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr7063342wrq.250.1582634847306; 
 Tue, 25 Feb 2020 04:47:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f8sm22586384wru.12.2020.02.25.04.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:22 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 426A41FF9B;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 11/19] plugins/core: add missing break in cb_to_tcg_flags
Date: Tue, 25 Feb 2020 12:47:02 +0000
Message-Id: <20200225124710.14152-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 qemu-stable@nongnu.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Fixes: 54cb65d8588
Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200105072940.32204-1-cota@braap.org>
Cc: qemu-stable@nongnu.org
---
 plugins/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a915..ed863011baf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
     switch (flags) {
     case QEMU_PLUGIN_CB_RW_REGS:
         ret = 0;
+        break;
     case QEMU_PLUGIN_CB_R_REGS:
         ret = TCG_CALL_NO_WG;
         break;
-- 
2.20.1


