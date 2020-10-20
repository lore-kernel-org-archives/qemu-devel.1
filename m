Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130F52098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n24E9+xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130F52098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwGz-0002u6-Rl
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFC-0001Dm-9d
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwF7-00070D-57
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id x7so3364508wrl.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6rbwkEpyi/KBr1JflrTSauoQCOoSH88ZHs4jFJdadLY=;
 b=n24E9+xhkh9MrByR5MozzwrcTs0OvFhmmKqxdRGH9X2ffwdz+R9EfGxGSYqXiyU7jn
 vxbMoEJLQHBatb6jS5goc3XWgDibMd5rdlb/vUZuxKcNutZtdn1if9Y3P0HUYK4DsQTs
 15MHj3PHlwaP2ZaduFeJIBeam3iXd5mw4ai5oXzs2wjQP4Q4SZovzWVs8fRFEtKomp7P
 fXq48Z4SRGW5SnUBVKaduriygCItDskxD9xHW6qNmcAxXw8FJ32eFbOYRHZ7lOF48xCn
 ZBiy3YwINRrPx3nWTDuMAqmkcT2ydCAt+WRPQ3YHGM9grb1e8rqFiMVGXfcf6il16Cw9
 dY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6rbwkEpyi/KBr1JflrTSauoQCOoSH88ZHs4jFJdadLY=;
 b=Mi5un/cY91ZyVcT+zmgZKsLq1EZQ3tfyK5sMwBfdaoQcyOPiD45Df+lSMDfcyVBJCn
 Qc32RWMvE8wPx/CN76CiBKcGuz3k3ApFa/O01p0rE9cL9TMHsrEmXovIVsRC2KjcDlKU
 HgvoBh0l2Y+WMuR9xMmWdtRhxnPfVF2XkyCc7UfaQSbzpMriRE41IRs6Cjjqpnkc7xvK
 NVJJbKsMAgEXm/W/ksEFvFCXBvnE+z4WRcFaqYqZgeTTpb4kl6GLeCoJoCckxYNPMsuK
 453PtAky3xRGZVljFD7pleCtlplW1u3t3IXk5KhgE0L0i4iHFXW++/p9hLTIwKcl0CSl
 e8QA==
X-Gm-Message-State: AOAM530nuWNikxxSXXYGQqjyIMFvrd457fo5pogXHH2tV9jHrLW66vtI
 Lp5ZLh2XUznm5vK+g/qGg9KWEvKZQLs=
X-Google-Smtp-Source: ABdhPJzvwZsia23Py+FB4CSB7KBEzY4PeneAkRECN47o3hJO+3qvV26MpElNdqBbCuWPZ0QFPnWi9g==
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr5407603wrn.204.1603218015232; 
 Tue, 20 Oct 2020 11:20:15 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f14sm4254328wrr.80.2020.10.20.11.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:20:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qdev-monitor: Display frequencies scaled to SI unit
Date: Tue, 20 Oct 2020 20:20:05 +0200
Message-Id: <20201020182008.2240590-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020182008.2240590-1-f4bug@amsat.org>
References: <20201020182008.2240590-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
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
 softmmu/qdev-monitor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index bcfb90a08f3..1c5b509aea2 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
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


