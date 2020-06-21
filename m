Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFABC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C923E248E7
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZB0py3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C923E248E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzT6-0004BI-2T
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOS-000530-09
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOQ-0002ov-03
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id l17so12463786wmj.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pnYwqyRw7PrUBqK6RMzPW7ocbdUWT8/A3afeCH6DRm0=;
 b=SZB0py3/NsMkhmmaQcks++xtuTP0epgST/ofB1+Rp2r5Q+J4kzfLXZr8/GvW3X9JMK
 mnzyD7pFf/myceJECBg7oG2XRi5w9CAn4Fx3RewBrrf54Zba0xSWvmTYILxAMKY+qQQ4
 oZ4ZBhS2yn8EOsefJIOZcLBL1hJuFB8uPptTFOY6/VC9y0rQbjl2twZ45Kt3SccligqB
 jwL2o7g1bfh39+yRKvU6Z/nc4ZJWoTRJ+CFThF5BOfNVgQHUXIKAdEIpem83t+LfMKtp
 MjnQP4To8Q2P5ZdEtXoe0cB9UknAIYs+RRd1rK4Cb+Hs9rFhl6hlZEpQYVJ513qKe8NA
 GQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pnYwqyRw7PrUBqK6RMzPW7ocbdUWT8/A3afeCH6DRm0=;
 b=GRKMa1KrXqbms7Eu6SOvma2nISedD/FzyvyymH6Th9j6tlrg7Zj5Z8dUjdODvwZ8Kj
 Xk4nTA1phuVwIL+8RLf4TqgEgH9IGs1ZJ6oFKVNL/7r9TjNTUoH6FApET4oURPdci3P7
 ZgcJ4K20rqtwjJoQjZ6xKkU64jAhFZ64FrTWIj2+RSz06tMg+rQb0qc9ZYzsM9A40rMp
 k+0/mQ2u4geMFlMR9Vtta3NVHmxfKkmrg9GSpupKXrq9rKmjXP5Nmkh768Wu2LfjVFpp
 MnRtU9daoVU2Lbke7SBX8tyRmi15X/Npkgz5mxPWTJdz9xDIYLvCFPRYUPu1+eeo/xLu
 QmdQ==
X-Gm-Message-State: AOAM533qfBPQCS9iZRcXX+gci5/vCYoIOWaubW7QO08JdTpE3FnYDEJM
 qNvUzkZ8QxVkqKGEPATr8N3CmJiL
X-Google-Smtp-Source: ABdhPJx8ohIxa0APdMMlMc7rZiBX+zEzRFJb7VSgxJz3Ko4N0aBVi7+QpFH9TDeZESyfX4Si5E3pHQ==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr12981900wma.168.1592743692445; 
 Sun, 21 Jun 2020 05:48:12 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] MAINTAINERS: Add an entry for common Renesas peripherals
Date: Sun, 21 Jun 2020 14:47:54 +0200
Message-Id: <20200621124807.17226-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


