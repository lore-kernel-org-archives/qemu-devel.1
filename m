Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F15BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384732072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPsG4J+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384732072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8yh-0004J6-F5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uL-0005fJ-V9; Wed, 10 Jun 2020 18:09:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34837)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uL-0008HW-89; Wed, 10 Jun 2020 18:09:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so4061681wrp.2;
 Wed, 10 Jun 2020 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qDvs5twxCaHhByb22PxsXzcbfQt1bFI28WI/GqaJpt4=;
 b=CPsG4J+0l7Rlh/clPZVcgu1mqeQxvUeC5TgPAepASxzvbmqFfEtjprE++idGbvGh1I
 fe2yWoXUt4+GAslSi6KAM201OWv4Xky+Bm3FzFsuyUiaK/rtACuMqjiOmVRz+HXTWtFa
 Q4W4DvM4oJYlHpZZl0JCSZfV9KkWcym9RZqLbWX/lTc/RNwJM/FtAK0ekFDCxV4TVaG1
 PTrhtP3iphG9n3mSWuV7F2eDHLXcFweEdVE3/Z+MzYiFQ1y8LPhwkA4nOuXcRuMpou/W
 iIW8D5Sg4WXWEkXOZ4GQssHdBxfJSbLAciZz/8HwWxWknU0gulW2h6+BzF2v4dGO7cBi
 9rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qDvs5twxCaHhByb22PxsXzcbfQt1bFI28WI/GqaJpt4=;
 b=l/BcBqdbEANs1f1Byu5tam1NgVeU9yzmyL0NLykzFFCra5aWXzCPb264hnKE6Cq/om
 9UXgY22sWO9pXylC71QbjHU0U01ZKcGeCt0UB+uOWrLIxP81NjAPTmbaMrqH7PhBHYx4
 S/exMqGgceSE/ntIv9Q9FPPGqMEkkXD7M641upD0SPn8BHECWqe2VwWPhkij6bH0mjN4
 qYf8HhKbypqwVWY8WWG5SvBoZIiRpAIe9+2tPKKK9LxiJOZd6VrYvHIfd4d5CZzRs1xI
 trabwK5Bw/0IInLJsTzvWkZi5S07HSDA5ClGmYcmIecbjnyb+2m/qEmWyxj6Qq3VMzVG
 cJFw==
X-Gm-Message-State: AOAM531YfjCNl0yx5hlpk875dc0pttnhkZuUZta3AzBlU2+t0cREWLR7
 XQUU+8qHNowMP/76qQRKXQReoodf
X-Google-Smtp-Source: ABdhPJzKP/qugzS8Fpg6hnOsSv145n6T2qz0rMA9INiS0U1FlDxI++pQ797LByAi6rEv9+OPVEaR1A==
X-Received: by 2002:a5d:4b85:: with SMTP id b5mr2223076wrt.8.1591826943324;
 Wed, 10 Jun 2020 15:09:03 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:09:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/11] MAINTAINERS: Add an entry for common Renesas
 peripherals
Date: Thu, 11 Jun 2020 00:08:47 +0200
Message-Id: <20200610220853.8558-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Renesas peripherals are common to SH4/RX based MCUs. Their
datasheets share common sections. It makes sense to maintain
them altogether. The current names are misleading (see the
'sh' prefix). This will be fixed later when RX peripherals
will be added.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 653fca1da8..0398634179 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1254,8 +1254,6 @@ M: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
-F: hw/timer/sh_timer.c
-F: include/hw/sh4/sh_intc.h
 
 Shix
 S: Orphan
@@ -1954,6 +1952,13 @@ F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*
 
+Renesas peripherals
+M: Magnus Damm <magnus.damm@gmail.com>
+S: Odd Fixes
+F: hw/char/sh_serial.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh.h
+
 Subsystems
 ----------
 Audio
-- 
2.21.3


