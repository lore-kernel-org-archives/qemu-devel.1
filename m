Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7DF20756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk+leVYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7DF20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkups-0007k7-Pu
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkuh6-0006gE-EY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkuh4-0003ql-L3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id r15so714380wmh.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLLt/ZA/CTjspHHz2mdlknpJpMmJgI69nogAOwAORyI=;
 b=uk+leVYgZL0liYCpOEUE4xYW6UkzTxdSxJWRQOqzdKV6MZtq/VgK4a+6FRdTffRlSu
 nw/aBSILV20C5YxHY6J0eTZl36CqASDlX51xferSoYJiZqou8memn88VIaubjRuvAzsU
 l+b/aG0v/NF8G9HBuet0reBRAI/gG2VdWhDspKl37Epy6afcNDBANTB9NH2aR4lb6tmd
 waq4m9fy6WipWDeaflXK6ujPunK1h4FuvkNp1K3AYHbC32baW2FdmTMsiy0sCqQU+oij
 rKnD9Hhqb6xnSttb2NjkNtOeu8hwCCbhd7/x4kb04HUbXaxPwAGxivi1xN0PVcc0vjlJ
 UlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLLt/ZA/CTjspHHz2mdlknpJpMmJgI69nogAOwAORyI=;
 b=E+OGs0q7iUgZ9fZ0HCp3L2i36kDdISThxHMA3WSsF2CekefXKpwny93ZPoHgqAdoee
 MGudaX2mJmA72Fs/yv+PlhNftq2tBoidwoTDuhcH7b59jTDOfV8AxluwWEupNZWz+Oi7
 rV1oEHb/MwbLbWLxP2lMsK6SA1zbElDU3fu2mYosgkFkRHXtF7Th0fkyUO5MbUfY0Jdp
 YMweOBUfv8dw+QsSm+aRcu/B2ukeEXMUOlnmuzw/zJ05jNt76c4Ld2MV2k6FjEYrSwv3
 7SL1SkFBPtGzGtEH/VGgCGh1bob5rp6dPRHR9FM4/Mr6Q/gPhey8WWcFcy4ACJVu6sp/
 6uKQ==
X-Gm-Message-State: AOAM533Iemo8NpPt3sALyum48pCRal7fEfdY2PySFR4E752rleu0oFZv
 6nVtpQp9+w9LbmpmDDxCPxUf5IkX
X-Google-Smtp-Source: ABdhPJx013tKEPzyyEYX1KCw9FCp2uJvf6PX/QOIjRfRZSz/S/SmW5am7g0g204W/KLqzgDO8M8KTA==
X-Received: by 2002:a1c:6509:: with SMTP id z9mr895970wmb.144.1592248973088;
 Mon, 15 Jun 2020 12:22:53 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:52 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 17/18] MAINTAINERS: Adjust sh4 maintainership
Date: Mon, 15 Jun 2020 21:22:32 +0200
Message-Id: <1592248953-8162-18-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch transfers sh4 sections to Yoshinori Sato, who is
best positioned in the community to assume sh4 maintainership.
He is the maintainer of the related target rx as well, which
means that some synergy between the two targets can be expected
in future.

Further adjustments, reorganizations, and improvements of sh4
sections are left to the future maintainer to be devised and
executed, as he deems suitable.

Aurelien and Magnus are deleted as maintainers in some sections
of the MAINTAINERS file with this patch. However, they will not
be deleted from QEMU Hall of Fame, where their names will always
remained carved in stone as QEMU pioneers and granddaddies.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200611095316.10133-2-aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a922775..d59b605 100644
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
@@ -1253,14 +1253,16 @@ F: include/hw/riscv/opentitan.h
 SH4 Machines
 ------------
 R2D
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
 
 Shix
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/sh4/shix.c
 
-- 
2.7.4


