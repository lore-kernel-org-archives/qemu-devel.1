Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC089C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CBA208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHz+mKQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CBA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERdi-0000I5-Hu
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcL-0006qL-8d; Sat, 05 Sep 2020 02:24:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcJ-0003Wi-BB; Sat, 05 Sep 2020 02:24:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id c196so300398pfc.0;
 Fri, 04 Sep 2020 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K1kiquLcp3jZlvGJbkVDS6+TjJzTJus3sZYsM0LRxls=;
 b=nHz+mKQSoBUCF2snijWK9lMursS8pXhE/2n3ov3+R0cjVE+StoxLM2+8LGU22JK3J9
 fyAujJ43eTE6+0iPoX2Ew24EC6nIvXoJKk5a/++zooK/F0s/wNPWf1Nz/jc22tR+IbmA
 hfQDIhL7ASz+xbEvdQNo9rFMXhUpxCOkZNa3aAm3/yvzBhC/JnjMUuXkpgZarCaYYJpq
 fl2k4XFISupUTWy0y7fUsuxFZEsqAKW3hzxatxHKRiJyZ/AvzCOLYkPYBg5SFiPaO8bg
 i9s3q45O7kMCL7T9FuHv8oBE5HX5uYJJBEWIzC/CE0dzYL4OyE004G45sWvxRDn2LIBh
 EBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K1kiquLcp3jZlvGJbkVDS6+TjJzTJus3sZYsM0LRxls=;
 b=trnbJfgtgA5ThLJUZDC9d1btGhH+qzywhCj1PmHoW/toPWkvfcMZpkEHVkwWdN6TcE
 oZp4Y3QdBtKKsOGf6gS+CZ9wpxtPWfsB448p2eu0HpMuUsEr3lYiU2zWIzjkZGHuQZHj
 oIhOEOb4L6QV3+wtKpJFjShQEZY6vIWK2gluXPE8nosNKjxbwGHl5w1zbo59aPAIYKck
 nsPkfzrkxVnWY3leyt4fAy3MCG4N8sOnYITdPFEHcCvZJwPQjqIpw/3Iw/CfnrxKuqqH
 bPleEKDNGChavh7sZM1BDOBJ1me4JHjDACz783uLujWXKtRlEyjH+77U1SBY0dc3Nxxt
 dVHg==
X-Gm-Message-State: AOAM531fokdxkQaaKZNKJOqtKP7SZIV5NjW7c1ngbPRDZ0RRZILQ6J9S
 IiiLp9KXHoyn9la5XN1iSjE2StvHqhDs/CNT
X-Google-Smtp-Source: ABdhPJzxOLcuOJx5Q1Vh+bFJSRvcJWt/t8RmONjvdtVHj6sJIGQiBUC2AeME32K8irdwozEBE1HoEQ==
X-Received: by 2002:a62:1989:0:b029:138:932a:8869 with SMTP id
 131-20020a6219890000b0290138932a8869mr10429771pfz.1.1599287041280; 
 Fri, 04 Sep 2020 23:24:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/11] meson: upgrade meson for execute custom ninjatool
 under msys2 properly
Date: Sat,  5 Sep 2020 14:23:26 +0800
Message-Id: <20200905062333.1087-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ninja options now have no need anymore.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson b/meson
index 68ed748f84..492afe50a4 160000
--- a/meson
+++ b/meson
@@ -1 +1 @@
-Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c
+Subproject commit 492afe50a439d70df99d6e3e59572aff55e14c6b
-- 
2.28.0.windows.1


