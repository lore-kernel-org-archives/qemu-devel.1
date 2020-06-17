Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABACC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494D020739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWtKhx2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494D020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldY7-00063E-Cg
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWx-00048s-2x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:27 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWv-0006T1-GB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:26 -0400
Received: by mail-ej1-x643.google.com with SMTP id l27so3763005ejc.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jCwEKiqElBxLQXAlfyFiEH72FywgqlOn8GvwvgG5WDA=;
 b=DWtKhx2HBiuaD0E+KFDtjKxwlSlUV3XNJ3sJaRbU+XpL6x6Hzi8pILG46vRE2hLQbJ
 PZ1Am5xhId/FuN+evkg/F5hjsuRLkCn6b1kxY6DUnSMgFp2M2lBdPlO5psIojiwqYQpE
 Sn1bf4iOkvCAB/AWabktrrP8ESzPifQkDy7ndmdpB4zWAPfDFeRTQMuHN5jAZqKAluGb
 K8ZOHYKsKWz0wGJv1quB6PE7mgBY/Z4q2Q8tFPPcGchDissmlODfKsFI8rHSm+zuk5Qt
 vcSayD0L8We4mM5QE6NHQzBSZVYcesKPFPwZA1WnuLE/5/ZEabIizwe+ktcElIa3qsSl
 7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jCwEKiqElBxLQXAlfyFiEH72FywgqlOn8GvwvgG5WDA=;
 b=EgVsKkFbBSEByR2fLfm9XzEvSL5nC7rRc1fF9DfiKtVNrn/ET/h8BAy1LDDvkzgq74
 SpUkhmShco6Z5tsyNX4uS8uA18V1eHdeQQYCf7BVX7f4iwIar1eyAJ29p0ftkP/awypI
 0Pg9FDlspKnwcl3Of3kmS6ZwMtVBmnzgV6qGTU7fhXcsHNjeXCGuuUpkIgybeBU3U0AM
 Wcd9PF5hjw73KpPzZ7pT+/+JYeYejoczm9tphv9HjVv71MiiH50biaZ/WJ7yTSzmnS1x
 iG+xe0W+eAG05HJrDleT+HktZOh23/r8WRRCvwddMC/EMhFI4ZjTJ51jbapQgH3/MTqs
 SKYQ==
X-Gm-Message-State: AOAM533ee34VzsEarJHBE6vxCUoE/VFTq3IWOBJnT+hH3gg2Hw6VSRW3
 HPzwVAzoBom0Eea0ntwnY6c=
X-Google-Smtp-Source: ABdhPJwmSViyWc4PEI2J1xlwe/+F9OPm7nlrxG63Wml9LANQ5y7M8FU+MNspVtnCUQL8ufU5v+bDMQ==
X-Received: by 2002:a17:907:217a:: with SMTP id
 rl26mr587191ejb.209.1592421324035; 
 Wed, 17 Jun 2020 12:15:24 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 02/15] MAINTAINERS: Add an entry for common Renesas
 peripherals
Date: Wed, 17 Jun 2020 21:15:06 +0200
Message-Id: <20200617191519.14842-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Renesas peripherals are common to SH4/RX based MCUs. Their
datasheets share common sections. It makes sense to maintain
them altogether.
Add the uncovered UART SCI peripheral.
The current names are misleading (see the 'sh_' prefix).
In another series we will remove these peripherals with
the 'renesas_' prefix. Out of the scope of this change in
MAINTAINERS.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67c495e841..f1ae0775f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,7 +1260,6 @@ R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
-F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 
 Shix
@@ -1964,6 +1963,14 @@ F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*
 
+Renesas peripherals
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Magnus Damm <magnus.damm@gmail.com>
+S: Maintained
+F: hw/char/sh_serial.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh.h
+
 Subsystems
 ----------
 Audio
-- 
2.21.3


