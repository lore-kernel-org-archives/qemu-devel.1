Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28504C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6CD2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8zLcOP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6CD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hvC-0003DH-79
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqs-0002BI-AM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqo-00053z-RF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so14379679wmi.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QI5AKzPXefPD6C1P2HIGbpvr66qRwSQ3EEuHj7Lej/I=;
 b=D8zLcOP8SgEDDsfeLWeOgI0+kBHIkY0pD/vY8p1onfYQBK/ecqKCIDdsDE7uYEoe/h
 NkuFtR6KirTap4cebT00wPZqu6YphiuxouMRxrx08lAree28CzlWqBlidQN/CqZrHV4q
 f9mqDZqi0xNjKaKTuiBHxwLTQyi0a0UhevXhLPuR1VnjnEyVdoz/DzNN0W1GnlY9zf/v
 ot90y6AYIK4R3pmx7tKJbPd27D0E1v9N3XUILbuKbhkTkOVY/NpfkZUp86xcoIJ/OsvX
 OhCsdNsTY7KXs8+d77B7/hKOOAiEgPlx/OFS0FYuDulrhH5mbXLhBo9LSWyZLsiwQIDq
 zysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QI5AKzPXefPD6C1P2HIGbpvr66qRwSQ3EEuHj7Lej/I=;
 b=AF18qFbNdb6mnP9jc+uDlZDr5Gdpht/IawxMxssu+/jtE+AsaYH/IlImY3XZ/iRNc9
 YeCk2jVFQZZfoS3nhwEaA54YyGil0i3SRwhjCM5+qba30XYCHla5AFoey8HWyUZrPwCK
 EeHbR10//dqkqQ8zE0gfeHydgjMLn4+NrmVUznICKisnZwNYyihGMs4w0QQy4HehvWlw
 GNa7GB/6fuLnTEvQCXP54kUDLJu6SR4znAC4QOJLd0mE5nXn6HzLPYGGtE+69rbko+up
 HsRPn8o8j6jKYQuyruanxjQca+2HBHGofulZXvuG8DKuyEoilTKDROxdQMI+EyeGMqcJ
 VkWA==
X-Gm-Message-State: AOAM532hyjxafQkiV2ybpq48nOJNTP9ckvrj7z0KblmTGDNm9R6i4/+x
 ze4x5o+HsFS/WhD0z3sm5eCYR+R/7/w=
X-Google-Smtp-Source: ABdhPJyznKOlxofdVg2m2sx9zQ/89hMh6/9LHRoTQzrE/frRBIItaLGD4zoMegJhes1fXUKYmc43gw==
X-Received: by 2002:a1c:4d16:: with SMTP id o22mr263754wmh.131.1597681145612; 
 Mon, 17 Aug 2020 09:19:05 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 6/9] hw/core/null-machine: Allow to use the MMIO 'test'
 device
Date: Mon, 17 Aug 2020 18:18:50 +0200
Message-Id: <20200817161853.593247-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MMIO 'test' device (TYPE_MMIO_TESTDEV) can be mapped almost
anywhere on the sysbus memory. Allow the 'none' machine to
instantiate it from the command line, such:

  $ qemu-system-sh4 -M none -monitor stdio \
    -device mmio-testdev,address=0x00000000 -monitor stdio
  (qemu) info mtree
  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000001fffffff (prio 0, i/o): testdev
        0000000000000000-00000000000007ff (prio 0, ram): testdev-sram
        0000000010000000-0000000017ffffff (prio 0, i/o): interleaver-container
          0000000011608000-00000000116081ff (prio 0, i/o): interleaver-16x8
          0000000013208000-00000000132083ff (prio 0, i/o): interleaver-32x8
          0000000013216000-00000000132161ff (prio 0, i/o): interleaver-32x16
          0000000016408000-00000000164087ff (prio 0, i/o): interleaver-64x8
          0000000016416000-00000000164163ff (prio 0, i/o): interleaver-64x16
          0000000016432000-00000000164321ff (prio 0, i/o): interleaver-64x32

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/null-machine.c | 2 ++
 hw/misc/mmio-testdev.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 7e693523d7..d8be17092f 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/misc/testdev.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -55,6 +56,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_sdcard = 1;
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_MMIO_TESTDEV);
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/misc/mmio-testdev.c b/hw/misc/mmio-testdev.c
index 3b7a8057b2..42eed16f2d 100644
--- a/hw/misc/mmio-testdev.c
+++ b/hw/misc/mmio-testdev.c
@@ -9,6 +9,10 @@
 /*
  * This device is mostly used to test QEMU internal MMIO devices.
  * Accesses using CPU core are not allowed.
+ *
+ * This device is meant to be used for testing, like:
+ *
+ *   qemu-system-sh4 -M none -device mmio-testdev,address=0x10000000
  */
 
 #include "qemu/osdep.h"
-- 
2.26.2


