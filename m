Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DBC54E8A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBB1208CA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msAsWSOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBB1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXntw-0007Zy-Us
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsl-00068X-UW
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsl-0000yV-5J
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id y16so552166wrs.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FTIVyDAEBMzFrxhPmJ8SqTBQ9LJJn+QNrQQoHkrH+DU=;
 b=msAsWSOdS3qpXwtqo0IYXM3g7YUfgKFsiIUQKUYL2NWy5aA3/NQSuBnOTcAlH9p33a
 UZSmuWWJerlcAIEcnDQW45V46Noe3XfBbpJwG0gYSVPsWP3gjGLX/zAsKrwNPf6s5OUC
 miLsWb9nqjX/ASTB6O2MtORqm907xacoV9LCVTAdB9ZLYfLpg4rKNRCFTJ9aDFuop0rx
 h//PB7STDUUx1KUbmi0eciZr9DcDQcMlKCOT+6wcFA4cFs4jH43n6qA8JlkbhJreiExo
 Nv/Il7+jf+f3AvzW48OyVzNmnK7JeUP3987SNoYatKR4H/iyrhOiZCIAywuYTfSuHp7s
 Q3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FTIVyDAEBMzFrxhPmJ8SqTBQ9LJJn+QNrQQoHkrH+DU=;
 b=L3HDSX2f3OTIj2XMsYSNAki37WBZTUxcKqP5CImApX0KQ9O3iBy5oEWU1NlAMsqM4u
 aQeTO3IUWj3G0CKv+vw1KFChGmQ24GchT4irF3FAQ0mimfvvYb4Dp64XDhyVft5xJg1C
 JwVojK+7mFIFStWo3QTMnGjYeYoM1a7W3kXzRzvZejBNCDlbC7UFUPRf3+f79LWtV/oF
 NX5culJA0/2oVQeP2gBCU0BAmFdwNi89x+MvutSQz7vS17giThG+4U0vnXyUa2eur3OS
 yB/ipIJ5NNJf+LJfyjYtoQPT0Ok3ZH78F2BKi7rFu/3L7xCD70J+INhMx5ZjcU8ZSu+v
 1t7g==
X-Gm-Message-State: AGi0PubAhcQmEWEKchdKDkoGjUHjE5yu04+2uSPTCOeKPd7+l2SHo8YQ
 h23iFeiO+nsYL7tWleSPOkwWCQgxc4c=
X-Google-Smtp-Source: APiQypI678r+4XFWrK/Ku+Vu7xlEl2s034DWyKkhgo6vH7aCtp/LpNJiDsZREj0SgAkWekN2tsbkrg==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr13755787wrv.3.1589124525626;
 Sun, 10 May 2020 08:28:45 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
Date: Sun, 10 May 2020 17:28:34 +0200
Message-Id: <20200510152840.13558-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices are not slots on a bus, but real I/O devices
that we do not implement. As the ISDN ROM would be a ROMD
device, also model it as UnimplementedDevice.

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/sun4m.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 9838c5a183..f1494907b0 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -47,6 +47,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
 #include "hw/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
@@ -920,7 +921,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     }
 
     if (hwdef->sx_base) {
-        empty_slot_init(hwdef->sx_base, 0x2000);
+        create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
     }
 
     nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
@@ -983,14 +984,16 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     if (hwdef->dbri_base) {
         /* ISDN chip with attached CS4215 audio codec */
         /* prom space */
-        empty_slot_init(hwdef->dbri_base+0x1000, 0x30);
+        create_unimplemented_device("SUNW,DBRI.prom",
+                                    hwdef->dbri_base + 0x1000, 0x30);
         /* reg space */
-        empty_slot_init(hwdef->dbri_base+0x10000, 0x100);
+        create_unimplemented_device("SUNW,DBRI",
+                                    hwdef->dbri_base + 0x10000, 0x100);
     }
 
     if (hwdef->bpp_base) {
         /* parallel port */
-        empty_slot_init(hwdef->bpp_base, 0x20);
+        create_unimplemented_device("SUNW,bpp", hwdef->bpp_base, 0x20);
     }
 
     initrd_size = 0;
-- 
2.21.3


