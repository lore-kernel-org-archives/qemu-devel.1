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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0DB208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQYU85b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0DB208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERdc-0008V5-6o
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcI-0006ib-6A; Sat, 05 Sep 2020 02:24:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcG-0003W4-HO; Sat, 05 Sep 2020 02:24:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id y6so2113390plk.10;
 Fri, 04 Sep 2020 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=++1aA2Xl9ysD8wDWmIeGZJ6wyUNL9z15K1e2nNVJtLE=;
 b=ZQYU85b0F+JvYt5zVicobgeS9DA14vfNMjkdPD/J3pGVLfg8qO17N+50PEyYrXGP4Q
 40QEQyvO9JHvjSXsPMoG90PVMkOSqphpJt1nu5RmpZGn9hegijfmT8diwoViwc1+B9G/
 1jMtyA8Jzqpu3msY+rYF7IuKIhL4URISx4dbJ7b9GnS/9X5nxCh7mSPTlYqTZaivCZrV
 EQHRsM4UOGGxPWqWDBQoWTginH3C9pVHHJIR09XdmbULFRMI7Fgb4V8GaiWW5fyiFEL+
 PBx5HsZD2pqMj1jJIFk5dS4Tq7UV45Akq0BHAoapKPEqiFgU8yIKd4vndLzUKJIrhtdq
 6NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=++1aA2Xl9ysD8wDWmIeGZJ6wyUNL9z15K1e2nNVJtLE=;
 b=N6zYi49EYz+uOwyyJMDA2Xd9+r2M1zPbE4KS9U0baYRunWQLj8kle5+h/tSN9M1eBE
 F1+KEYgzx85iSGmd8qZpDl18DGYJf9OVEbqwkJRtOFp0CnZmDUiR0BLRU0IedRxdwh5G
 wwdMdDSVDK5dl0p0ROHAkMjFRgbY2m+/LI9s3oc5WWAU9uYiGn1tjCly0kL5iI8XPWjt
 97UjjnFJKzPQqpFNF+ZzFD+I1dkehJgax3QmwbqIoshI1C9y+rZZ9YgAblSN31jRoa8K
 U6DzqZV8pfvJCk/wtQsI5V4ocYeIzSXQR5moczW/GEV2k8cftk16eMd8T4gT0jnt23qh
 ksCg==
X-Gm-Message-State: AOAM530xEum+OoeAzjTU55eM3QhmBVnSGmnT12jUUAzF2FlHPaXjf4SA
 qQCN3kJOzvfj9M8/2/shmf4noTguayeY6D+v
X-Google-Smtp-Source: ABdhPJx4yAXVmMPCeKS94k6r+BdnG4Ny1bMvzSZ3TrPcMCNZPAenCcdkfFF8nsCga2Pk+wlq8C+m8w==
X-Received: by 2002:a17:90a:e207:: with SMTP id
 a7mr3923491pjz.117.1599287038443; 
 Fri, 04 Sep 2020 23:23:58 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:23:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/11] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Sat,  5 Sep 2020 14:23:25 +0800
Message-Id: <20200905062333.1087-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x631.google.com
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 capstone  | 2 +-
 configure | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..1d23053284 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
diff --git a/configure b/configure
index 5d8bf4d8bb..f8cbd2898c 100755
--- a/configure
+++ b/configure
@@ -5117,7 +5117,7 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     capstone_libs="-Lcapstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
+    capstone_cflags="-I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     ;;
 
   system)
-- 
2.28.0.windows.1


