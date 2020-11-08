Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F00C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACF0206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQicPfxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF0206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbucD-0003Es-5Q
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 19:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuaj-0002M7-9N
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:25 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuah-0003kH-Kf
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id d142so6442895wmd.4
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fbb2L6ljoaLuj4iaRLcKsD/qG9dEoDgoSld5R0Iivi0=;
 b=GQicPfxYMo0A6CNOwywoBMz+pLvQpb5bpiAkc0n991C27IwXHVG/W0+rMHEqclT6Bl
 0yq+BdPHU08W1BtKcE3pzaH4y7oq4Qvx5dQAkYq54zTVy3q2ugzX68acYI9zzPDqh/oK
 ONibC2BZ0CtQw1qGNWR/DUVdMZNwdOZiB6GkaiamCLsUDu6+nhwmonZlsoWmKANvm35k
 v7KlB2utg4JNqnnOo4rCJqzCYrfGoaeU3RnRYlMeYvLknx2iWZ70qF6Jzgc+EbrhEeYt
 8ZEA0wb+n+uRfMQsybsV9TjyCd3Kci/Rl41AGBDjTwhSKpBxeWWfy2XzvntAkGM0VNke
 ItMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Fbb2L6ljoaLuj4iaRLcKsD/qG9dEoDgoSld5R0Iivi0=;
 b=X7sq0ObdLGPLr1m+nmxVpcpEk9OxdVvp54iF1jGIqBRCmtR3ccOr77WlTNsqareCEA
 7nSTMLggoGzwkbIRdxkC55nr9wXsAfJt8Sj42XR76Y99wo0cikbrpqtPmMhCpYsBxmUF
 jatXQ+fvgVedIGBTbNXJNOdJCowto+rMaBGxeqVF4lBRei5CUh3v5RueDnodS45I+am7
 UkOO8UsLhj5XxFxRqLWIDjfHZcsDgBM7nsS4UIUYmsMIsLrlxhLZc8o+MinQqIpXaE9b
 Xu5As/88PBs7l8VgozFEuCfT6lYHK3Cjj1AOLm6+KUvZaotCqrZ8xERThrg2j2emJhpz
 WhgA==
X-Gm-Message-State: AOAM531zQlusqFAXTmmYQCTusxEd4X6F7/kup0EKqtyw8Pj9dUak5n5S
 y0wr7rVy6ApeBzEwT8KIngwpeO7Co3Q=
X-Google-Smtp-Source: ABdhPJy1WbkqedQJ8mTpgoZVdWWpzrTkIBvWyGbeifSHM7Q11Veo1R09ik6767b98paAZ1rSIgfnGg==
X-Received: by 2002:a1c:6484:: with SMTP id
 y126mr11012475wmb.141.1604879962012; 
 Sun, 08 Nov 2020 15:59:22 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l3sm12643124wmg.32.2020.11.08.15.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:59:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] MAINTAINERS: Demote Renesas target & hardware to 'Odd
 Fixes'
Date: Mon,  9 Nov 2020 00:59:14 +0100
Message-Id: <20201108235915.2396150-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108235915.2396150-1-f4bug@amsat.org>
References: <20201108235915.2396150-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be fair with other subsystems listed as 'Odd Fixes' but having
maintainers more present, demote the Renesas sections from being
'Maintained' to 'Odd Fixes' (has a maintainer but they don't have
time to do much other than throw the odd patch in.)

This matches Magnus's possibilities so far:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg710319.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201102104001.2062572-1-f4bug@amsat.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63223e1183d..f6da5990aa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -289,7 +289,7 @@ F: linux-user/host/riscv64/
 
 RENESAS RX CPUs
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
-S: Maintained
+S: Odd Fixes
 F: target/rx/
 
 S390 TCG CPUs
@@ -1334,7 +1334,7 @@ RX Machines
 -----------
 rx-gdbsim
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
-S: Maintained
+S: Odd Fixes
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
 F: tests/acceptance/machine_rx_gdbsim.py
@@ -1344,7 +1344,7 @@ SH4 Machines
 R2D
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
+S: Odd Fixes
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: include/hw/sh4/sh_intc.h
@@ -2077,7 +2077,7 @@ F: docs/*/*xive*
 Renesas peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
+S: Odd Fixes
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
 F: hw/timer/renesas_*.c
@@ -2088,7 +2088,7 @@ F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
-S: Maintained
+S: Odd Fixes
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: include/hw/intc/rx_icu.h
-- 
2.26.2


