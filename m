Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FDC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC220679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDtx6M+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRus8-0005Bd-Gd
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucC-0001kg-Af
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucA-0002uX-OI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id p15so16630146wmi.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aGuMhEybmPvVnTdSYOtH7MX85+5QscNdHJrgVgiAwF4=;
 b=rDtx6M+NBWpWawh/Tru88CRfgfT9rdLKSyT+mr6cioarHtaZwcLGY3pvl1lF219/2d
 AvksOE5LOOVifLfHiO5blAIYwvIFS3tTh8DLfBXHmLxTNc5ZuGSVruLdVjypdjDWqSWT
 MdDJsQCeEGqcPhTw6SMoSfKG0R7FTYhjlkd+nFlp9u6XCRi7hpZFzRtYlhU2RuIzhwLp
 e+vABOu0SQonzlitjVzLxSZw7RajB9BgNZKm92QDwJojLSE41jup1pAaZhD8A/puXWch
 9bd1OIY6t0+jgB4UCbL/DLNt6SAJ34enc3x3xcLCX6CVGGG2mEFPnezDKdHCzc0fC8rX
 2BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aGuMhEybmPvVnTdSYOtH7MX85+5QscNdHJrgVgiAwF4=;
 b=g5NHxA4Lk1w8ot0ZXlJSdPBuEOkTTYOLkrMdklLmLJdoiKvBRkY3fvb6rMDEtEyzzJ
 F2JkpS6BgrMh3xs0p26hgCGBWMiG21ILFV6a+L/tKZ5r+l/LDXhXRCuSrQN7Dm1S/7d1
 gGk9kuz2OJw5NsJNNfIvSfGU6P/ur3LDjvdTF1Iq0mtQKEdJAWjZOGaKzBLFEAdpgv3x
 ZOECXS/Du6DRBNOlugd8CeoogOtyLm5EF3i5JT0Vwj8WyxDDQ9TwBAdn/bbYC9YudgVg
 L/7LRaVipQBe+eDetHEkzyuMXa3zaHqrXlF5yI+dLSF/RgXMIwa6HuCao4vi4Wibnk1l
 bKHg==
X-Gm-Message-State: AOAM531ngRlHxVPlKIH851EgOcsjIcnM0qYNzgrd6SrAnQgPVx8cXCze
 l+0POvSyHnDzdxSiDtZSxBhrddSqXXU=
X-Google-Smtp-Source: ABdhPJw6Wjlk+bACzI5Qve0koO9tViV/K80SgFNZXBfrlQlDLUFB3KNzbwjfMKn8ftIipajKJ+UJow==
X-Received: by 2002:a1c:2108:: with SMTP id h8mr10048664wmh.63.1602496773274; 
 Mon, 12 Oct 2020 02:59:33 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y14sm21695105wma.48.2020.10.12.02.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/21] hw/mips/cps: Expose input clock and connect it to
 CPU cores
Date: Mon, 12 Oct 2020 11:58:00 +0200
Message-Id: <20201012095804.3335117-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose a qdev input clock named 'clk-in', and connect it to each
core to forward-propagate the clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mips/cps.h | 2 ++
 hw/mips/cps.c         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a881366..859a8d4a674 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -21,6 +21,7 @@
 #define MIPS_CPS_H
 
 #include "hw/sysbus.h"
+#include "hw/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
@@ -43,6 +44,7 @@ struct MIPSCPSState {
     MIPSGICState gic;
     MIPSCPCState cpc;
     MIPSITUState itu;
+    Clock *clock;
 };
 
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87e41a..af7b58c4bdd 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
@@ -38,6 +39,7 @@ static void mips_cps_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSCPSState *s = MIPS_CPS(obj);
 
+    s->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, NULL);
     /*
      * Cover entire address space as there do not seem to be any
      * constraints for the base address of CPC and GIC.
@@ -80,6 +82,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        /* All cores use the same clock tree */
+        qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
-- 
2.26.2


