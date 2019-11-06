Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22837C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD722077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qU0On76W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD722077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJdZ-00017B-HQ
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZC-0003mP-5E
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZA-0007H0-4u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZ9-0007F9-Vn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:36 -0500
Received: by mail-wr1-x42e.google.com with SMTP id f2so16415741wrs.11
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/0sggaw1v8ZuIdMOPOdNQg2kpFmBqjitREJdcWvNbpc=;
 b=qU0On76WqJf4dxsXSFTpvmiacgEnXGgWszbuqTr5AucrI/LhAv+aUt5rH5cd+yQhPD
 LSLYfxnpSIFvS4axbpepqe27inlzdm73fop24eDnlYKjP+nkpaKkpnl5G5ilhtGzee0e
 Xtdnf3oTtKuyAtbPUM4EsBceaWyCmEtbKipKL5BA/bkzcpaqHpbxdquhYJSjoQa04SrW
 AqeN39KLXxs9fthIcWNXzORt9R6RlQnp6Kq4CXyhymdHE6fTMSw0GhkS/L1rVsizChuF
 tB0/kZTIZcypiGKeJXVVt02Fp6rL9JEVBHlC+K94GZDWytusK7M6PveTv9hUDHLb7inV
 jG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/0sggaw1v8ZuIdMOPOdNQg2kpFmBqjitREJdcWvNbpc=;
 b=sid/GP6gMh0wrCumO94PMhGr8+YjHS6EsDacSHOIpdhamdfj/HdYIeoWx5BG3hWSQ+
 xrbIQvk+dUOGyp4ENvWCYAmETE/Bco7zbBRNfj04DJVfWD0htIhaIjxh28q/C7vL8jJm
 M7Z4JYliqsKmXqaSdZyTjnVeiW90JFNaS3Dm3y9mpBCGs6SILABauAOxW0ABnsinfY/0
 RjWe9uBH2ke216UhNAUrszxFOlP07GGZDylOYXnNVOqUMQ8y0MCQfLxIYnHOxKRbARTp
 IzswP1POeOC6TOobkF99iPsYK3I1yx31th2TOvs+oluV7syDT85hnb9IarqggxxdNQoe
 WVdw==
X-Gm-Message-State: APjAAAUM3Ax6r/6euLmBHySIflS+ZdJhonr1MhZhPccAWrtlWvmXauyy
 IVqfer4/KEwdI66V2VI3PgFsLxY+TZbGjg==
X-Google-Smtp-Source: APXvYqz0AhkSWQjfclLXjhy3Sngz9oj4tX39iSgdVd374fH9dLv/Mljrv2NHj5IxX0lcu25I3aKE4Q==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr2286784wrw.170.1573040014245; 
 Wed, 06 Nov 2019 03:33:34 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] target/sparc: Define an enumeration for accessing
 env->regwptr
Date: Wed,  6 Nov 2019 12:33:09 +0100
Message-Id: <20191106113318.10226-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-4-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 778aa8e073..ae97c7d9f7 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -13,6 +13,39 @@
 
 /*#define EXCP_INTERRUPT 0x100*/
 
+/* Windowed register indexes.  */
+enum {
+    WREG_O0,
+    WREG_O1,
+    WREG_O2,
+    WREG_O3,
+    WREG_O4,
+    WREG_O5,
+    WREG_O6,
+    WREG_O7,
+
+    WREG_L0,
+    WREG_L1,
+    WREG_L2,
+    WREG_L3,
+    WREG_L4,
+    WREG_L5,
+    WREG_L6,
+    WREG_L7,
+
+    WREG_I0,
+    WREG_I1,
+    WREG_I2,
+    WREG_I3,
+    WREG_I4,
+    WREG_I5,
+    WREG_I6,
+    WREG_I7,
+
+    WREG_SP = WREG_O6,
+    WREG_FP = WREG_I6,
+};
+
 /* trap definitions */
 #ifndef TARGET_SPARC64
 #define TT_TFAULT   0x01
-- 
2.17.1


