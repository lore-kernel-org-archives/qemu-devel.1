Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD42C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C510207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="uZ5z9XVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C510207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafRZ-0001Gy-6o
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jafQK-0000Mp-JJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:03:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jafQJ-0001Iz-NB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:03:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id f134so9228550wmf.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=ErLDMWgn2v75cbd0bor+6ik+a8MBeggWbn1mFO0I2v0=;
 b=uZ5z9XVaYkmV6/dPgZlQxy/2jfYjZLOq3PktEKWsOuMaxTtCQW17PdIpnJG5rxugRu
 +7GVi6eUiWIOjyeEyi+7bxeDrJRyL14FW02mttyjFIapE0WYh776729G55CCmrX2mUei
 ePBV3SOAKSFq2JZwN/douwTgN4Nsqsg1LqaUIxZYQ8WHOiKED6MPaKEdY8Ozwvui9xOS
 +ripTCBGPnD+bKaYdbly/npBqDt4RO32eJ1KcwBYJYYBf3rm2k8yP04y8aSR0whxt0DC
 +HSMRKzc5BrDJQXIPe643ZlHH7sm/QAC2ccsZ98YfvvLMKUwrFeCxir9f/un5dhWsfSl
 MlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ErLDMWgn2v75cbd0bor+6ik+a8MBeggWbn1mFO0I2v0=;
 b=f9VAZe3B1C1CFxTQ6hoeF2sPMJYwxzetkWGhzfTsjge7NKpH+nfw1gWAuhrwwS1XpT
 J7GVz0h0D0KFH5vniwIH+O0POHcybypibCLEAMUF/8Uu+JDHnAxCS57Ze3WWlTcwrV/I
 QfarSsO4rfj0yQVYH9wq1Zr4PA48eoay/CnUmNiw7DRC1IK0Y9h8D2ElDRq7D32GRWQF
 Ix+cux362V6PovK+5ZCBrI+5FQ96Kyx1ZHUYfsiReFyHUvUFRsDlEqpqrRbYGKU92rQW
 XqTochD/1i0rvUdsOQVBPCZtIVtDHocYTR6RjMt4wsrVj2iGYoW30j8aHrx2nNyvapZe
 YQOg==
X-Gm-Message-State: AOAM530qR7oiasHgzNfDe3+20cYygYRdxp9tjEJK2nuj+dhOVS29gdK1
 ng5kkhKmi8UdZC0rNhaUDqjO/w==
X-Google-Smtp-Source: ABdhPJwUp+bAsIfyXcuGnwVsvJQoaFbi83XD2cKnxl6pa3a0YMh1WhE/7eqhTeIqWWUhxpFxXmAuUQ==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr20041016wmm.67.1589806993901; 
 Mon, 18 May 2020 06:03:13 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id 128sm17249197wme.39.2020.05.18.06.03.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 06:03:13 -0700 (PDT)
From: konrad@adacore.com
X-Google-Original-From: frederic.konrad@adacore.com
To: alex.bennee@linaro.org
Subject: [PATCH] semihosting: remove the pthread include which seems unused
Date: Mon, 18 May 2020 15:02:38 +0200
Message-Id: <1589806958-23511-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: frederic.konrad@adacore.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This have been introduced by:
  8de702cb677c8381fb702cae252d6b69aa4c653b

It doesn't seem to be used so remove it.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/semihosting/console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 6346bd7..22e7827 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
-#include <pthread.h>
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
-- 
1.8.3.1


