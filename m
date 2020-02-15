Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C96C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2422F2084E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9HuCdzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2422F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j30B0-0007fF-AY
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30AE-0006ns-2f
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30AC-0000C6-1d
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:19:29 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30AB-0000B3-SF; Sat, 15 Feb 2020 11:19:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so13098689wmi.1;
 Sat, 15 Feb 2020 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eTn2oK2dQxQzFgBTTAIiys0g5gffJIiQC/GfhEVlsF4=;
 b=H9HuCdzNLNf5wF5E9yZCwWovzZFqAKQ08jQSCepYUtrA+g5tne/7ID+2V6XXf3oDpI
 DtjRFNn3c+BLKf/ssniyT13Z8WBTrv5ze6E1AkSzHD3MIVqu9tvgkUC7DUaG5y4oC0EG
 GjBnjd+/QtzwEvJpBRX1qOSv/P3W1HMGfMDF+4SrTWR07vO1RQbHXl1ufUNpMQ3+6QxV
 9i1+5QAvmsVsMaduNB8HMwuoj2ddXPA2UeZ0jjIxkJdlqRpJDZMN1SYPDmN2xL9g+9h+
 LBNyrJaPZy4zjB1ko8GAnpkfsYkNzOgys/d9FE8zGOaY9gmTUGxzLMQy4M0JEA+Uq2QQ
 HW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=eTn2oK2dQxQzFgBTTAIiys0g5gffJIiQC/GfhEVlsF4=;
 b=VznbnAy+ysgifIkEdkh6oRNzu6+Ezp2jKDvESuUFKsm/cIeJf1VR7JKfu8dNzFK/I7
 Q8lZKrkA2ndSxAz/PpmrUlh4PxEqBYVrL2JPHlQk+rZAYYx20rwlev09ekdNNjX3xTo+
 KQ7mz+C/NIcePRcj4sROdLUcv1p+7genVwwTw3RWyT2obprpJItDPt5l1DqfXyDASTuG
 0YdFwzQ2ccGDun6EgW22W5BfL9nEKoYQWdDKLh+BW7A7XRvWpOl+/p6B0EmnZNOUyDRC
 09o9lCV8gHj8+f2Mn8jS3sgrmAEJfb9GK/+cjZqsDE2oqHE6XCHCxV5tu1G2E7prpJ5t
 GKhA==
X-Gm-Message-State: APjAAAXoUumVMD7IlXEgZH2zEBaRt9sXn7fTHrGwfALGThuj7jYXnVLS
 mgAotUUKBoeoIfuM7BztSrwUsP4/O1M=
X-Google-Smtp-Source: APXvYqwDeqCcaHBmMOZ7xTwSxEXmBVriU1c/6subQ0Wwg+sgp86ZRj9hZTq7zZa+rIaRuzWBCYFfZQ==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr11205173wmb.38.1581783565941; 
 Sat, 15 Feb 2020 08:19:25 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c13sm11899255wrn.46.2020.02.15.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:19:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt Clear'
 register
Date: Sat, 15 Feb 2020 17:19:23 +0100
Message-Id: <20200215161923.4741-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/misc/iotkit-secctl.o
  hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is never read
          value &= 0x00f000f3;
          ^        ~~~~~~~~~~

Fixes: b3717c23e1c
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 609869821a..0d5556dd17 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
         break;
     case A_SECPPCINTCLR:
-        value &= 0x00f000f3;
+        s->secppcintstat = ~value & 0x00f000f3;
         foreach_ppc(s, iotkit_secctl_ppc_update_irq_clear);
         break;
     case A_SECPPCINTEN:
-- 
2.21.1


