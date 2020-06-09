Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3450B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNlkJVAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3450B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYmN-0007fL-Cg
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkA-00044d-Nz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYk9-0007W4-92
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id j198so1627405wmj.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JxuhWv9nXttnrpgLvIV7ogduNdbBfeeeDDN47mb5Gl0=;
 b=BNlkJVAcy9QDjcpfKBwuM5HDZ1wqLj/PU5aemqJpOIA0MAi1G8peFA7U8ETWQLGJEF
 gRw740JrKo/862lSfvGPxsBDREaFU1dN2E0bK6JNLIKaiLR9cJFO/UcyrKAWBNaL8Xcc
 K6S+Wvhif9HW65++3qafkzAoH63pTNTjB4/d5c8BDDdan2A8DBp6ROeyuFxdZMtr0Yqp
 sLr0/tnTvMiNqiPDY0ZKZHtQ2kp8oMrUmEms9OGO58M+nd2iLGxcWFzqDhCgB8CiKuyJ
 9c6k27+cmf90qszXHsvC+OmWW74TvFFOq94QGWdn5RK2edAf384Cbi03ddV+xBusJ/4s
 oJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JxuhWv9nXttnrpgLvIV7ogduNdbBfeeeDDN47mb5Gl0=;
 b=edlI9XYWXvhKt/m2Xq0T875/jW/4FQBg32ONQGgQYFaBMDoq1iBmuxdr/g3XZhsagw
 INz8fmb9FfoYSlv7AnovPIqMoLn2QNGQiLyUjDxI4kxWCq9rJujWUKjDboYqkCrIJVQF
 4CfgibAMZjgPa7P335CjX2p0Nr05HCe3DWASIHR/qwcfdZrKZu6C+2hH9mEwqh/8ZZvV
 YYDs0AwnDEfC3A9X99spHkLmDs5IPx2REVtbEjnHwm86zz9jsUYlPC/wxlXtBTN+PeJY
 xGdiUjSO4BTJ4yD6myKKs4T5M0b5sePUPhGaNtr3VkVqNqiLcG4N2aaoeud+iljexmbl
 Tmsg==
X-Gm-Message-State: AOAM530k4RUihNGX82VuGvDjZyTH4F9gMS5Nxg2mh5ZHmLPSlf1hwXP4
 lGdTeZSjS1fyANx7KJHqyzmo8021
X-Google-Smtp-Source: ABdhPJxVxBgChIBeV/o3pwdMWP2OoADwKmrY5OHvranrqwlsdxgcy6Mv9+W6ex7JRNSSlwLfPSOFUA==
X-Received: by 2002:a1c:38c2:: with SMTP id f185mr2701861wma.79.1591687937323; 
 Tue, 09 Jun 2020 00:32:17 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
Date: Tue,  9 Jun 2020 09:31:59 +0200
Message-Id: <20200609073214.14079-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices are not slots on a bus, but real I/O devices
that we do not implement. As the ISDN ROM would be a ROMD
device, also model it as UnimplementedDevice.

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-2-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/sun4m.c | 11 +++++++----
 hw/sparc/Kconfig |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 8dda3f7292..fa3dd7775f 100644
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
@@ -968,7 +969,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     }
 
     if (hwdef->sx_base) {
-        empty_slot_init(hwdef->sx_base, 0x2000);
+        create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
     }
 
     nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
@@ -1031,14 +1032,16 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
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
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index 22aff2f5b7..91805afab6 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -5,6 +5,7 @@ config SUN4M
     select CS4231
     select ECCMEMCTL
     select EMPTY_SLOT
+    select UNIMP
     select ESCC
     select ESP
     select FDC
-- 
2.21.3


