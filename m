Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F8C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD9E2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQcYLE8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD9E2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXGp-0007rC-LY
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZXFv-0007MC-Fw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:40:07 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZXFt-0008A1-Ky
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:40:07 -0500
Received: by mail-wr1-x443.google.com with SMTP id n15so14012138wrq.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dtn2euk16nfI+FgmX++JltX6vI3WZdBGn0sdrp0z5x0=;
 b=fQcYLE8eCqOSTXOka2cDDDjT06IhwBtXMASBjqZWmzC/ncshtkKpjtkEsda1NrL0L7
 OZ/KwGIXoBCCdPwcWkqnrKG8sD1834KBNTDDoYIwpabrBmy75EOpsNxz7M8CvJLxvhGD
 2nbi+mGYTkwFy7tJjWTsMtFyVm08yy1sGQasVEk31b8tqhWCWNp2kMNDJTImfOTeCRle
 UKMBK0iJuRGOJih4aLTvf47tNwH5zJPlsiWgH7RY7YVMAuL5U4R8I3iYF9ukKea8AYUn
 lou5Jw5/6mkx2Isdm1CcyCzNN/VGO/MftQjRsy0nd3PrSMD0eZGu2bVBigBx/obaHEyd
 6LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Dtn2euk16nfI+FgmX++JltX6vI3WZdBGn0sdrp0z5x0=;
 b=MCaZYRyZsqSyfonYjERbdjd4vb8PVdwiE3bAO+qtP/ZTov//DG1Yyqd1L7w4EX0tJb
 KbIc9jkJFpVjX6PoMP19dcV94+ztIlSZUX+5dIaUcpvWAbVRY9X5cjaq6mWG/o9iEN5O
 8TGNczGsRsqIkzmosJfyS1Lni9BwovELSGsJ+CJXhymwoQ3By7NV3DfsrPm9EJQ+bebu
 1rF9fg86Rb0PoxUGaY+kryPKwLEVotZvWLducvbbnZuVdCtC2r1AexvG6BHepShcb/Vq
 umhq6eQPOh5B+vkCMK2nqPt/VxpaXglQJowKVFEBTUbHVafbQuvlFJYMMsQNv/skBuNH
 vaqw==
X-Gm-Message-State: AOAM531X2qZrLdfyELIi2T7u+f5nEnZsvuKltM4zsKiQaV+tCwcIKqr2
 FaegQ3FAVL7N0EYgWhb4CgL4CD9x6D8=
X-Google-Smtp-Source: ABdhPJxhK3VTq+ZXhOmIHXv4UgrVV9yBV6KMaTPpzm+bqNS488xbTvDJM6yppiTO/oIdz+mj0KrFAw==
X-Received: by 2002:adf:e889:: with SMTP id d9mr18408842wrm.134.1604313603830; 
 Mon, 02 Nov 2020 02:40:03 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t1sm20963360wrs.48.2020.11.02.02.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:40:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] MAINTAINERS: Demote Renesas target & hardware to 'Odd
 Fixes'
Date: Mon,  2 Nov 2020 11:40:01 +0100
Message-Id: <20201102104001.2062572-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
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
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c744a9bdf4..ff7c42ba451 100644
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
@@ -2075,7 +2075,7 @@ F: docs/*/*xive*
 Renesas peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
+S: Odd Fixes
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
 F: hw/timer/renesas_*.c
@@ -2086,7 +2086,7 @@ F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
-S: Maintained
+S: Odd Fixes
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: include/hw/intc/rx_icu.h
-- 
2.26.2


