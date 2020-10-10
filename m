Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E674207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkYTz2ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E674207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLqp-0001Zy-7h
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiB-0000Q3-OS
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiA-0007RT-2e
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id b8so948152wrn.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PwcUcNfmDXAXz3ZdCfHv1ZWyP4lS5DeJuKN8TDRFEM0=;
 b=pkYTz2evODSTCIVzNSYqNs/Wu3LRBzHO564YrznUuNnUViWUOgDW9/UTfksKF1Ro6d
 QGLDUmSxIgT0+1F3FnSV7kbMysQ797Yx0fCwKRwIFCDO6/OKXTS5CY6YPnOUAiZeQjy0
 stZvtnoBUqgkBvcbCQHvdNMPu6+avkYfIiN1fO0pNrcEYt2FUxn4FHxqHjbeqtxm9575
 ond3xSW1yt0pWiDofywzP71AUR57LPHRdbN7ue19nWqvuSejI6dWZn+a+IdDWYSwJ1Dn
 gVTJEODm1506TOq0O+gnxg9g6FCgogT05HM47/CSfRMrkX1FGOuhv+/iK3A9K4Mr1OCl
 HJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PwcUcNfmDXAXz3ZdCfHv1ZWyP4lS5DeJuKN8TDRFEM0=;
 b=cXuaalxRsCl/VaXMikZhqsVFyU+XJinoVy17tbDxvhroJZkIa9YyY3ej9O9nYorBIt
 3jmGA4i0pRXgPP/4aanTZ7jINxCnxaIoaLHYRr33OzJuj68PBJNl44PAIgN6tUche00C
 GgedEtqFNelOjxi9epLYOUa08MnTb2C+F8YFKi7XVZIGHUXOq105sWBZLdFxqRPePrV6
 GajBcuU29ezdm1El1dhkP56vYVvITbEGgMG5BUa5mJOEDkujcZfsRVpQDX0abRrmaleu
 o6pMC6a/4CT1hnpjf3pvk1vPJQ1CSm14KTQpQQYNGZDdcYdPpT0o1BA9Z5pm47qknAUO
 4gWg==
X-Gm-Message-State: AOAM530uy3aRpeYWJ8gXPKdqSJG8dtZiDEdTJUefvnGBJrowcTLNgmqk
 WR5eXoBoi2vqV+WUltn6BvcxiFHAIEQ=
X-Google-Smtp-Source: ABdhPJyKG18SUJWicNOEnW25JkO1pg40q1XYZSxXkR6vQR9z0ERwE9NcxMfyoKWY5wfiPjaa3w9lWw==
X-Received: by 2002:adf:e289:: with SMTP id v9mr21472977wri.14.1602362604458; 
 Sat, 10 Oct 2020 13:43:24 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/20] qdev-monitor: Display frequencies scaled to SI unit
Date: Sat, 10 Oct 2020 22:43:01 +0200
Message-Id: <20201010204319.3119239-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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


