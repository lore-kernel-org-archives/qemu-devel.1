Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F61C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B0E20656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxL2umYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B0E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJvD-0003a8-Oi
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJuJ-0002kH-76
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:53:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54495)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJuI-0002N1-DB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:53:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so4379178wmh.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QGmeKoMjUx2P3GmL7M76rOcN1cHpZ8t5GZzb0yL6t/w=;
 b=VxL2umYlDS+6Dp56jQn9CIBYAH3ScLEeqdxvH8Cr0c45v373g5rJjXmfT7+qVhKH0o
 1yreLxcTBr/SuhLKJSiTKpRE5HOBkMqxazw3j0HT71/M22lyoGVww5vTx9V2WP/9mzUW
 93nr995bk/RnMhMfpvFzR4AfjS4BdnHKJ+wrjMIJ2judzXLT0XJ42KmaHoMhl08i74Qn
 sWYt1hY+e6bjXcJpfAwtk/e1MamdTulNr1fTxe8RXH4+mbusm6ZdSaLipASB3xvZt7+A
 YLufiq9G4xle6sH+GwhYmeaRIEsrNjQWexQhqqkWwiwp+ywyZgW7uzCA7Xeh9Zj4ay62
 2y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QGmeKoMjUx2P3GmL7M76rOcN1cHpZ8t5GZzb0yL6t/w=;
 b=RIXPyXPJLugdTsGHfAXQ+82fz9ZOCmanVCpIY4j8qMAe3m5vvRqi2GQSLnUX4Sjq50
 5CKEPcNA9g7EjposXeBq/1J0yyXRPoWKB29Nv3u3KvrRp491PolR88M0Wxvfaq76NnvH
 7IcSxOMk7b/kEfGDKVhgOEb0QhjoayS99ude5d5Yu7mzUJKrWSW2GMnvZTy8/YKWEIUa
 QcRysBc9YBgcjo9YosRPUtEorvmb5BfSdeBpawbfktb9wY+evciZF5jZWLGimMbwEHWL
 HMhhswCAXyF78xG9a3KPYHK60u+JnkAjdk0Movib18C3RmnnnazufzIdPP6eQwve6QmZ
 H6tQ==
X-Gm-Message-State: AOAM5300skdlvYDjFj9f56HCMZRKtbh76yhl4TwyiAMPp5XQLR4ZEmEK
 LO0wIEO7uaiVNi2GJrw0xrwJwuiB0x0=
X-Google-Smtp-Source: ABdhPJydcGYHR9GrFmSYYfzKnxvtit0Vg0BzNZgptgCMzXZEx3s0bs7N9NXxqQffYrnBEZTSU6/WNw==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr7114231wmh.38.1591869231640; 
 Thu, 11 Jun 2020 02:53:51 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id i10sm4060257wrw.51.2020.06.11.02.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:53:51 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] MAINTAINERS: Adjust sh4 maintainership
Date: Thu, 11 Jun 2020 11:53:16 +0200
Message-Id: <20200611095316.10133-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611095316.10133-1-aleksandar.qemu.devel@gmail.com>
References: <20200611095316.10133-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
---
 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..5c78ff5672 100644
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
@@ -1251,14 +1251,16 @@ F: include/hw/riscv/opentitan.h
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
2.20.1


