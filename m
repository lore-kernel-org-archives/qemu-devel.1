Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84A62072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDHu0uX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84A62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj94I-0002Do-RU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj92t-0000t2-Ey
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:18:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36332)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj92s-0001H3-IW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:18:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so3264504wmc.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bYpaUY1vbLoeLHxXLu/f8gtn6M7opx+zgkgvogrZHT4=;
 b=GDHu0uX5anN4VubVYuthexkYOW1aoi2Lyr3jA+xYwVUos4zDYOZ8yxvkSuJTqFLKl8
 /NAuLNdVJqxX/n+NP4DJ571DYw5UXPnodz80qW1OyPYOV1LNja8JaR0E9UBthKrqguh8
 xXJBjShTHyfIzzjz/+EH8/Wa1XnbzNHxO4YE+zi3UWQfGS/9QW6v3fczYtdaSe9pnuGw
 w1bUewu4d6yNQ4Bv5d4KR+Z9kW3uc48Vy/gA+X9CJ922jd2cQW6BrXIzGBWuznkh7DIt
 fBzRCoe8fi9GEUN6pOU3Jfh2BK6UxuEQkfDo28QMwEilxN2nt1EmL6nfuGK95/7RKKG6
 7gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bYpaUY1vbLoeLHxXLu/f8gtn6M7opx+zgkgvogrZHT4=;
 b=dMSD5ny27oNhEmD+gsqnmk4m8JveSHCJ+jqEx9S6cItay5+Jm9W1i/Fl6YgtPYu4cl
 UYjKcSqtthuFQXWAhdxr0kWnmu2Sizh2ouxrNnpuW8Fd0HdNkvJyMPMKSr3KR0Ug1rAg
 UprW2qx6HCJyexkq1lkhoJ456ld4gmUvb6Jfh/v9uNQX2vDNhYdVX7zi0J4sTszDRWkm
 ts7jhBwA8pc6EL/dElvZCqScldmM8mtIY/xtUpv/cUH4fo6vM2+0ImTPzL9QcSWhOrNS
 hWPHDN6nqwRTcO5+Z/PtXBOeMpKJHIZzQo51POWPXSJL+yzBLY7iSZugyshS8URRo/aB
 4eFA==
X-Gm-Message-State: AOAM533NA6tROsBmrnTeGtpHyEyeuypEeDi/7czi59F19B8EupOpgIlH
 25evC0+r2vvGFqbkVF47Dye3H2jlHU8=
X-Google-Smtp-Source: ABdhPJzziTdXQkPUFTFApcL8zZf1r3Dj8NmvnyiE5xODIdDnMupNiSFy186i1QXdl//j5oPDBaDfqQ==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr5053074wmu.123.1591827479206; 
 Wed, 10 Jun 2020 15:17:59 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id a124sm1374589wmh.4.2020.06.10.15.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:17:58 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] MAINTAINERS: Adjust sh4 maintainership
Date: Thu, 11 Jun 2020 00:17:43 +0200
Message-Id: <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
References: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch transfers sh4 sections to Yoshinori Sato, who is best
positioned in the community to assume their maintainership. He is
the maintainer of the related target rx.

Further adjustments, reorganizations, and improvements of sh4
sections are left to the future maintainer to be devised and
executed, as he deems suitable.

Aurealien and Magnus are deleted from some sections from the
MAINTAINERS file with this patch. However, they will not be
deleted from QEMU Hall of Fame, where their names will always
be carved in stone as QEMU pioneers and granddadies.

Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..7ddb6db38c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,7 +296,7 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-M: Aurelien Jarno <aurelien@aurel32.net>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Odd Fixes
 F: target/sh4/
 F: hw/sh4/
@@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
 SH4 Machines
 ------------
 R2D
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
 
 Shix
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Odd Fixes
 F: hw/sh4/shix.c
 
-- 
2.20.1


