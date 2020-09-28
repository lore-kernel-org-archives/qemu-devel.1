Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFDC4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478A62080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA8XH4gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478A62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwtZ-0007KB-CS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwku-0004Ek-9A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwks-0006Ni-13
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id x14so2169949wrl.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcSJN3WRYnSDrhVA+aXirUwwuRtaV2HQ16b4T6e3VA4=;
 b=VA8XH4gzcCGy6krSQUYGLnjBEIn3Nd6c2IYCbasq1dA0TYkriCBzqTkrbRFFDB5GnZ
 7kga713mDj0vCOvEyg8DdMjIul70SuAWJJa4kihJ2KN7Xm5E+uus2GXYs5N/RO7DBYkz
 l8Ne4PqKfdWp4WPkpj3xT+/dxWXHnC5oI4CwHQq0HSYZXgcFAlaVDUb0HTCyBLCE56Nc
 5fC90vopOrZRnuppZR4Rc9/upYO2eKYyzKCmB3L6uQTwoGam4QppRJ+nFR22TTqWmc63
 oKUIm90PUEJoX+aj74EIZ+7EEkMyF/uXsOzWyQg6xeIwHk0Nidz3WdV9fn+vBPeQqDI4
 93HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tcSJN3WRYnSDrhVA+aXirUwwuRtaV2HQ16b4T6e3VA4=;
 b=TemIVoEg13pYpL+6LcdQ4ytHGIOslRyEJzSzjpQkiGH0QTSFNOTy6++ydl3706ClqZ
 jPa4YQOi4Tut5atnNbPgMPJg6peQinHR1cKUwVMSbvqRNwQKW1bH6U0pwgwTyES2vBNL
 PPiMxH91SVVT0cl3j5B/jgWKSzqCltrtcZt6pESx4+bcfYOSWNPktgPqlduhGncKoiI2
 ndU9WdUML7Edfct1JNuwy1ner9cNh2q54PtQ6+cDQVeJxsnNlrrOE2aqM19hJiJADPBh
 sKKe5iDPk1P0629+2h6BSE/zm+DiLf1DaVNi2a8155H/rmL3ibYdnyWzpV3yuZaJJOuy
 QFaA==
X-Gm-Message-State: AOAM5330IlhAKrgpU59JaVplYdpfIdvyeSyETdVlQt2S/bbI9kLSqItH
 gH8oxGTNqS1FdxJoHLLh6+39sBlejq8=
X-Google-Smtp-Source: ABdhPJwsoRmxjxwiWI0SoTYa2jmSKxXTqOsJVrA+5Wjnp5Dq9a19CxjF5oAoL3CFZe70HmilKjW/qQ==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr2731852wrv.215.1601313360521; 
 Mon, 28 Sep 2020 10:16:00 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] hw/mips/cps: Expose input clock and connect it to CPU
 cores
Date: Mon, 28 Sep 2020 19:15:34 +0200
Message-Id: <20200928171539.788309-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose a qdev input clock named 'clk', and connect it to each
core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mips/cps.h | 2 ++
 hw/mips/cps.c         | 3 +++
 2 files changed, 5 insertions(+)

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
index 23c0f87e41a..c332609f7b3 100644
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
 
+    s->clock = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL);
     /*
      * Cover entire address space as there do not seem to be any
      * constraints for the base address of CPC and GIC.
@@ -80,6 +82,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        qdev_connect_clock_in(DEVICE(cpu), "clk", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
-- 
2.26.2


