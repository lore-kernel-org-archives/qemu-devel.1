Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D3E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHhabzs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D3E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRupP-0001Sc-PW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucW-0002QU-Aj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucU-0002w6-UF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so18438238wrq.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cW/gfj34pmesiBnES6l2ixnKu1WwVqBwo9OSQ9eCA9g=;
 b=SHhabzs3z9clXgqH70u2QvqTe3YqImGe3v/XAx7mS9Psb0LZV06AxubP9l4xl+SpLM
 XJ/rHsDPkb0lzk15Y8sN0vtVBuJpcX5WtIVmoUnv7xjb28zxaMUQjaaJ1LbQFYrJZMws
 gCaf5KywD1XWaLj/FPhG5jPkYF3ZsUs3bRq5gFezN/Z+RaOVURROZrdnILpCewoyDkpX
 /rznTZ6PbQxlxsZIQilKZJuux/n+oXJsl1NEHEWEGHaFVQrXlIGQiG5ACy7A3zgUlwkE
 Bsu5H+PcxIzVkx9x7B94cw+5b9h6oDfrMsuyfDtmWSXIiBq90E/g1dsP1vMVUxHf3ocb
 Cn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cW/gfj34pmesiBnES6l2ixnKu1WwVqBwo9OSQ9eCA9g=;
 b=OLVOOudST/Moe52OUpKjWeO4wBQJlZuAQ2uJt7ZjHZf2JL0Zxbg4GKtsPXBy9YVkY9
 /qZGh8cmGjzrUT0BLVL6oKWHFfHDiphpCwETGbjZw5Y96p6LECbBrqdVe/NB8c1iQVJX
 UIF+msJ8rByX4I0LQrHkBpKCq51OCj7W94AISbKC/kshs7TOdlxNcJqmJaI2byzyejB3
 vSMVuHohk9XZP1fb5CNnFVGyDFFCNO3fIueN/EX74nheSi1UCc+H1bdMWZE8qtBQhGBS
 00ckIUDBydNIT40v/Hf8PJcoOHbP08yn5qN+92waAnA8cQMcVN3GCKk0OcIwW6mcoj8M
 TqZQ==
X-Gm-Message-State: AOAM532mJA3blY52bA0R3ntDv9+W+wzm9guhsx8B9mWHdEh71eB371js
 5BixFWsHyZzgjZd9bBTRGi/Mw241IZ8=
X-Google-Smtp-Source: ABdhPJzfTBpmqmq3JBZjngs0H2XF8XmirkPAKJsDKGcQxwRG+5K3evn/EssB+wFoAdJ6YoxAxxks8Q==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr20009304wrn.91.1602496793428; 
 Mon, 12 Oct 2020 02:59:53 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t13sm22300006wmj.15.2020.10.12.02.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/21] target/mips/cpu: Display warning when CPU is used
 without input clock
Date: Mon, 12 Oct 2020 11:58:04 +0200
Message-Id: <20201012095804.3335117-22-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

All our QOM users provides an input clock. In order to avoid
avoid future machines added without clock, display a warning.

User-mode emulation use the CP0 timer with the RDHWR instruction
(see commit cdfcad788394) so keep using the fixed 200 MHz clock
without diplaying any warning. Only display it in system-mode
emulation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 23f7b4508a4..8daa5878ba1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -19,12 +19,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "sysemu/qtest.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
@@ -157,6 +159,14 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        if (!qtest_enabled()) {
+            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+            warn_report("CPU input clock is not connected to any output clock, "
+                        "using default frequency of %s.", cpu_freq_str);
+        }
+#endif
         /* Initialize the frequency in case the clock remains unconnected. */
         clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
     }
-- 
2.26.2


