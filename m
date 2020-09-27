Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED3C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABCD2389F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdPBjNfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABCD2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSgO-0006C1-Oz
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfU-0004YQ-EJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfS-00029k-P8
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id k10so5270722wru.6
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g/6nKkvgWnq0c/AG8DfCxF9NNLJNAWyxVfnfIeVT6t8=;
 b=mdPBjNfcPkLfBgSUQeZDh+mxzVmtg/H2GK1HTBzqmcprES/nCEsPACKP5l4ISdbrH5
 mdJK4dtnR8oPAl3om5xjhlnGb+44+fppxFf23MQuZarjg1blWGecIZOwlXxqeXnU02rs
 zvOMlCgQsuM2EbGH5GwqmjLTwrGWczShSFvVleovAQsHo5aHLhEx8qbla3uexYANv316
 3nRlSfdvCoVgYInxlbt8ufDfCG/mUmZZOl9pmKhOGvcXYTRKso1L3wnDMEa79m7Wvlxi
 J94k1DA9MXHMEpZ5PebOaooBdQV9xMnHctXe+mgCRKBmpVGoY5/s4D3dF+7smpJFX0XR
 Hh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g/6nKkvgWnq0c/AG8DfCxF9NNLJNAWyxVfnfIeVT6t8=;
 b=B4eDdB2Sd/iwJzvrpmqFsoo91n1pjGQOqZBEL9oIw4GN3eat4+j+t4qwYUwyu27OvJ
 8m1Koc9pKsM61zyhZ8eNdSa7v9WzUvay6oZuHzp1BBUtd590q134T4sToKc6BLkcYg3Q
 /LEviVxGgQl7Et1Vc0TdbOJMFCHu5cMGB1TrCMusM+QYjgIo8NPn+mrh2St5yVlklbPq
 Q4QAZh2psugoxpAXivBOMIinjlNnbkSszwSVgjj3HiyFO1cCxs6PHbYI46t3QYwZnzqn
 kz5YwwqkX//zBOAY2KLx4fvamivJcaFh1f2S4I6isNqMnC0sQOj9yuCy2aFAKvGFVMFW
 s7Sw==
X-Gm-Message-State: AOAM530JYfdm2gKVsOPZZ+aAY5WllsX/8nCymmFanfFCM0W06idrxXkv
 noywLtF8D/VFA9rALn75NxrUvAKoOi4=
X-Google-Smtp-Source: ABdhPJzKaiDMaImaZToR7YXr9MEBSOLaHTuNCojcQODEJemcetZXMiWfa4KQ0h8DDEwJihbqbSoUjw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr13010243wrt.366.1601197705256; 
 Sun, 27 Sep 2020 02:08:25 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y6sm9007187wrn.41.2020.09.27.02.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 02:08:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qdev-monitor: Display frequencies scaled to SI unit
Date: Sun, 27 Sep 2020 11:08:19 +0200
Message-Id: <20200927090820.61859-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927090820.61859-1-f4bug@amsat.org>
References: <20200927090820.61859-1-f4bug@amsat.org>
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
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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


