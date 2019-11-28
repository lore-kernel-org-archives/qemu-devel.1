Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23F3215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmJ5sNJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23F3215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44669 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia90w-00021e-O2
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x4-0005zn-PI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x3-00049h-Sv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x3-00047N-Ko
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so29058042wrr.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GKaacMsIgIZwUgHU10AvimUPTS2QfclWgoTlYWP2G6A=;
 b=hmJ5sNJuZPNrr8BRnDEOaZrwmMkmZQtFROSchLJ+7IIuIXJUvJ166jrxR3TBAFzSv7
 sJw2Djfqhtma/noBB8ztMgKTWyKBcUsDF3qmbtmKQ/X7nZAvPyWDrUHYYCxhbtKlk4tu
 cy8BrA8Iaf8qSo0VjNNPkZcqNyejVnvlyQZVj9PUjOgQvtKTLOPgGsS0519m43PW3bUG
 L+Bg3TUDH0RUUpWnNOTWN10RRkm3cOcvYRMoc11bFJcCnyZ+J2H0IWE3P3mRVVGRQQMa
 uc9BQSIcXks2gGpyuuJALvhyN9s9JO8vOV1tEONJ0oTJkDFKb8It6ypVTPfeS7E2NnG0
 5rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GKaacMsIgIZwUgHU10AvimUPTS2QfclWgoTlYWP2G6A=;
 b=Z4uZGcBG7Xvkfa1/trBV9EROlwJWGQ+vsJhZs9caae44XTqw2feSB7vy6w39RnE/KA
 +bUKOGvxdkWNRHukwcpyxqOwyjVXbR161KYFFDPRbfcpkPpQzQQshbc8EMDhh/Prku9U
 I84j4OwDAPgc2VM5tw8IrImEHn9K8U7pPjGNL8Y2wFZ39W71tYkuQJE+HGGL7pu3gIL2
 JTcXAUPBCvxMueI4VGChjdaL3q3l75KTTpGzAihHKPRIyUSFGw1XOyn1QtTM0ylS48ds
 MX3wsYKksgDiOI6O23HbLK93Wi1OXcapBHkzbN0WmpDMavsZXn3H20qNyRcNVHIaOIjS
 H4eg==
X-Gm-Message-State: APjAAAXSnPPeiUt11O/DTxBLVMBD43GqCRLkg6ymBlV76aKUv4ZJ2gKw
 fzgcDZJZvI8mzDAuvjrzA+7KMQ1c
X-Google-Smtp-Source: APXvYqz6ZivBr/uTRyWnd7xmmQlMRJIov0mOQWhuUMvxZFOAUqb2rBwAMW/JNpGtRhXB0bPvAJEKBA==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr47770804wrt.189.1574905836296; 
 Wed, 27 Nov 2019 17:50:36 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 02/10] target/avr: Remove unused include
Date: Thu, 28 Nov 2019 02:50:22 +0100
Message-Id: <20191128015030.27543-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index f1939bd5a7..75946209b8 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "exec/exec-all.h"
-- 
2.21.0


