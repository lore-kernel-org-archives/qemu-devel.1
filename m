Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61625C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8FD206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMypnSNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8FD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDjy-0002yH-8P
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfL-000509-KP; Mon, 08 Jun 2020 05:01:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfK-0004JU-RM; Mon, 08 Jun 2020 05:01:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id x13so16504434wrv.4;
 Mon, 08 Jun 2020 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qKEUX8J9UiexOSRaGrgM4+4clMJ9RxUveCPFaOqjRAw=;
 b=LMypnSNiRGMcd1bw9a5ZzTbtpoTyhv+1WQgai5C4Pn+sb444HpB1KEQUHg7+KN7ndv
 igDJ+2gFJ9eBZdIXNxnfOO7RBFcGBX82QbjKCF22yWG5QE8WNuUNrmRhpdn9fdcx+Pw1
 uHG23ItlfqtVEa1TnsvlySPOYhmoRd5LEKXEL09lnegPitMmFbsOpw/TxFDjL057EY/G
 Dsm7dCPccdF+osxrJ4/59gMBV3mTlxc1Om4uWZqPCCp0a5EAaqitD8qZPImmWQ2qVeY8
 Or0bz2+0gQhXuHLEpruMx/IJpwgk3zELryPxjbPI0VpYwswMj+hlBzUiZSzzgMaw3qgl
 QSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qKEUX8J9UiexOSRaGrgM4+4clMJ9RxUveCPFaOqjRAw=;
 b=sVEAb+Ps8hBrMWFl4fNAuHIqL1BW27dDJrmIUf3V5XI005n/7Z56NpS7NQmKDsNkAo
 bCHlRkbnNIc+qyKFJJvDQC/0JRXK0MEq8i5eJ/D3qWSN25PacfBMOHaDOHoN/jR/7kFc
 zFXuYOaLUX2Fs99U3jL2a0c5A4bXi6chSZN6tEhsC0+AEj2htmLeob03vuhnrJ3vQ4qh
 cj6qqR3icjOxd3y9egbka6PYL7Zi8Ac/FTXNZLSUm8eFJOEj1jJhzf9mfHq+hgIzZZ/5
 3pH9DcD0s9/Pr4MbOn8yyjJeErmkw9/DCVv+Cy8StJPs1KholVRoyqseOdeNdLGoBkvo
 W+jw==
X-Gm-Message-State: AOAM532xE/s0vGRQ+HUBxrCBvBszqwfRVkCc477lyh8F7h9Z31LF6Nhq
 NRDE11nnWNiyK1f/cSC43oQSeP8e
X-Google-Smtp-Source: ABdhPJzsaYG/EcdmjVSDN14ud1kdq+OhujedXbe6h0OQDBOdD8KCYjYmJw5Sxb8NeI1av3R9UB/NFg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr24601253wrd.157.1591606916906; 
 Mon, 08 Jun 2020 02:01:56 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
Date: Mon,  8 Jun 2020 11:01:40 +0200
Message-Id: <20200608090142.6793-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "qemu/timer.h" include.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200504081653.14841-4-f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index b9cbacf5d0..bb0e1c8ee5 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
-#include "qemu/timer.h"
 #include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
 
-- 
2.21.3


