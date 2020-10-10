Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08897C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BCA22461
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OspX0yPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BCA22461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIqP-0007fg-Ms
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIe1-0000lP-B3
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdz-0003st-Dl
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id f21so12874559wml.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AzmFEGnohCvn1W440dVAMj47SxdqWOdTt0i8s2oVyM8=;
 b=OspX0yPr7Xj5RvIU/nGUysSoWyPtK1GUzJz4KC82XCDc2iJD5UIUk1FPJBAb5Rv8sT
 LI0kbu1/foPAmnlp+yb0Kn+ifFzoMdX5h/pVB7eIr/E64AsVSo578Yc6RT1fAkkvk1BU
 2uPKRmP8mxtjMiWuCWlDc8gpkfWuuSjHWhIs24scFJsDPMN851j5wC+ji6HPvuM7KxNA
 dDCpRA+JFk4UQdJe5MSbanfQ7VyDhGNxT+KTaWcu5Jo33k9+CwLkKW8UYM/ha2EDSZGz
 GJaHJlYgbpWuSmLeV8FCZMQW7/p3rT+o1y2ntxqq9cgIr+Kk0FZ1ze/3YeE4QNRIErHQ
 SoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AzmFEGnohCvn1W440dVAMj47SxdqWOdTt0i8s2oVyM8=;
 b=XsXqkfAC9yOzl5ZGs/aKVh0tcS3ikuSqNDLfTbC8g/oFRjR98M/c/S5IFk+UzkIrdf
 a44GLPvfr5nXsVbV27FYI+CltU7nUZ+JaLZwlip0LInWgTCTmLSpajxzv5TXMt9xPrS7
 Pp10PBFtOxguhnC3SStMz48nRZE8yucrnRXmKD/GKhGVfiUnJJjlalHHZdedNb76PPAW
 CwjGgYb6TDW4OenF0ZwkXw1tPVosLqwWgF86A0QpRZUC2UrhqcOysjnDXEP4TiLN3UnX
 sEiiHzKr9wlvQ1felrBXMNf10L+XBgQGY8r2jyFUH0/IXWi+cOlCjkGkcN+c9h9PyQth
 8nBA==
X-Gm-Message-State: AOAM533buEfcfaoDs7cllKSt7FHKnxBvPBgIZg9/0xG/JNGAPHO37cuZ
 Su3cT0A2Nq2fFzi7U7W60lDWHB056TU=
X-Google-Smtp-Source: ABdhPJyXHdUBLGljPFHqIC/kRszrJeCdF+H9u3tgZs/XSnnZUlLzDSuDyB5WB1l/Q+h/lnyDuNVONA==
X-Received: by 2002:a1c:63c3:: with SMTP id x186mr3652008wmb.66.1602350806437; 
 Sat, 10 Oct 2020 10:26:46 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/20] target/mips/cpu: Display warning when CPU is used
 without input clock
Date: Sat, 10 Oct 2020 19:26:17 +0200
Message-Id: <20201010172617.3079633-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
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
 target/mips/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 3deb0245e7c..0c801a3a075 100644
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
@@ -157,6 +159,12 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+        warn_report("CPU input clock is not connected to any output clock, "
+                    "using default frequency of %s.", cpu_freq_str);
+#endif
         /* Initialize the frequency in case the clock remains unconnected. */
         clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
     }
-- 
2.26.2


