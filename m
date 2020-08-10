Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DEBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B45E22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKgLPyTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B45E22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DpP-0001gw-Kx
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoS-0008Qn-82
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoP-0004ii-SH
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id 88so9308498wrh.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d+45d/+k1cuAYKwT/RK62hRxeNRk6rEMJI9YOmMNXaA=;
 b=vKgLPyTgwo+coOD7UC26IcVWVqNI2WgCpCI7HP+ZsgI1N4AhjmEgv7Bd/Svj6axNDZ
 G8S2brDZjgEkYAyKsdoJtQyfy7M9AYI7c/G1ZGTzF4VL+OEXjzqcMfI1l5Lqk5v7t2U7
 M7Sw0fMfmYTsm5FTeLfBR+8x8eAu0/kjitTj39V8DoVgpQH/tixSFaC/Nr1jCDnM7TAV
 kfS4O40CRptbAQEKCa1c5BSPXK9W/KVLn/Y/5omZ6RRS5EOsCm8CmpE89dgyffqfNMze
 XLUse5B6zzrKGZ7NawzCHs3CeOurSKFgF1gJBSp5wawuP93+8dM+faaUis/igSO8AlFx
 CARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d+45d/+k1cuAYKwT/RK62hRxeNRk6rEMJI9YOmMNXaA=;
 b=Lc7to5M1yTpHUzkZBWT/Q7R2lbxL9/+oXjxYMXqOdly5HvooAJfEecqO1Fxz1YyoEW
 1D+WTHgza7JduAeEUvrLBFAZ7yDvrVwVFm9hneGue/us4F9yr+h71SYhGaBHCb72g9MO
 jAQgqN9w9Tx672ZxoL/hgN7Q7JAur6mbDmfUgMcv+s6kzh+7iyadc/KPO/WVHVG7xnS2
 Ffw7dNYDdgwUkNCC95QPApeXkF4tR3oKU2hWuWJDfnH4hEQtS5ruMukln5QzkRAtuzc4
 loYRi6dq+HjNWKb5/BNuw80m80mufbb/QqELT2E6eNgR8EBVY26BOHrZR1uw54VeFRX8
 3SxA==
X-Gm-Message-State: AOAM531Vng2QmTg7R5hZq+2NCNcaDunfBbtdoWZkOuG66EJcVPltOq4X
 +04Niv1qU1YALrBPkuNstPOZf6h1a0OmaQ==
X-Google-Smtp-Source: ABdhPJzn+b4djID+Nple2PxPnX4iAtiu7fuzNidpZRPgF9Ri0+5Q6Z4UMUEV69D7kYoJYxUqpoTUrg==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr3153874wro.157.1597089023561; 
 Mon, 10 Aug 2020 12:50:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/20] qapi/migration.json: Fix indentation
Date: Mon, 10 Aug 2020 20:50:00 +0100
Message-Id: <20200810195019.25427-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commits 6a9ad1542065ca0bd54c6 and 9004db48c080632aef23 added some
new text to qapi/migration.json which doesn't fit the stricter
indentation requirements imposed by the rST documentation generator.
Reindent those lines to the new standard.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/migration.json | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index ea53b23dca9..e07c9c0f1aa 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -629,18 +629,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
@@ -769,18 +769,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
@@ -945,18 +945,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
-- 
2.20.1


