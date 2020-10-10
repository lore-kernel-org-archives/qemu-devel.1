Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2E52227E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxY18DeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2E52227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIjS-0005TR-Og
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdW-0000L3-OS
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdV-0003qD-3e
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id e23so5862594wme.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PwcUcNfmDXAXz3ZdCfHv1ZWyP4lS5DeJuKN8TDRFEM0=;
 b=YxY18DeNnYphjJN08LdP4vD11Hqv0wBT99crsSbj7pox1gHolSw5StCK+5um6v72fM
 0o5JFxmSlxOGMXTbHgi3bFOhF/K6tmoqlVGU94/hYuKlin+kE4as/7PIRoyyH5YvpDCA
 tq76hBnpyRUfTbtcY3j16zrMRB/W34zrD29mrR6mKvaqaDQDWJ1BDwBNMlvh043fLPA2
 Q+6oc8k8HuFi5JwJEc8av9clvKJv/6o+wgjqFWdrNxghP5qH0eK/EIIohwzplfBHHuDq
 8GyZbdMK5r5Ry3bSEkT7jjPSs1Rr5Zt7E6v+1mOMIh9sXfrysuokVPrPfiieVLuvw1aj
 KfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PwcUcNfmDXAXz3ZdCfHv1ZWyP4lS5DeJuKN8TDRFEM0=;
 b=CilSFx1+oaQPaierZzwK/pQlEmiz1ZKIMFpD2+1/BYMi8nLyr8fJ6N3dccVkD5uD3W
 /fvyTgHe7pb5bHe9lBeN50rfeSiW0cBzVaCPVUyi7vC1HerwRfN410DyOjPqgnO+cv6+
 NS+x0S3jd9bcTEwRCfsSGKIiQ/1YCpBHhyn1hPS8kvwYqSO87WfweOiwN7jyWSm8g5Y3
 skv44kfgiV+H/FPkDSBmlPMAlpdm02/U0ijVhlmsIh6UOs7MiPZ8+S8pk8zGfpQjWvo/
 nTfXr/zrFb0SNyxyhubjPWbIPO1iLHgDGtjoDFiDuE8LVmlNgCEgIVANRWZiDfXlwFiM
 qlMA==
X-Gm-Message-State: AOAM533Bp1RDExu3SUCku37oxJIRCK7oVZtnNjKMld+xZPvjH6bPfcO0
 lN84VfCI61ZeEBT0tiDr0m9OtaMkR7M=
X-Google-Smtp-Source: ABdhPJyGcuOeHJiyPmmICuteYtWQrWGzYsWTWQ36xcxa0ucu+AQnw2sm+dRw0AjQv5MhLsOe2CqS6g==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr3435280wmf.67.1602350783424; 
 Sat, 10 Oct 2020 10:26:23 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/20] qdev-monitor: Display frequencies scaled to SI unit
Date: Sat, 10 Oct 2020 19:25:59 +0200
Message-Id: <20201010172617.3079633-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
with info qtree") we can display the clock frequencies in the
monitor. Use the recently introduced freq_to_str() to display
the frequencies using the closest SI unit (human friendlier).

Before:

  (qemu) info qtree
  [...]
  dev: xilinx,zynq_slcr, id ""
    clock-in "ps_clk" freq_hz=3.333333e+07
    mmio 00000000f8000000/0000000000001000

After:

  dev: xilinx,zynq_slcr, id ""
    clock-in "ps_clk" freq_hz=33.3 MHz
    mmio 00000000f8000000/0000000000001000

Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qdev-monitor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228480d..a0301cfca81 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
         }
     }
     QLIST_FOREACH(ncl, &dev->clocks, node) {
-        qdev_printf("clock-%s%s \"%s\" freq_hz=%e\n",
+        g_autofree char *freq = NULL;
+
+        freq = freq_to_str(clock_get_hz(ncl->clock));
+        qdev_printf("clock-%s%s \"%s\" freq_hz=%s\n",
                     ncl->output ? "out" : "in",
                     ncl->alias ? " (alias)" : "",
-                    ncl->name,
-                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
+                    ncl->name, freq);
     }
     class = object_get_class(OBJECT(dev));
     do {
-- 
2.26.2


