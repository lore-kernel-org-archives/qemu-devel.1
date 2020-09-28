Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECFB2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxJ9Nl4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECFB2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwwp-00023h-C5
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwl0-0004V0-Tk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkz-0006OP-6m
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id v12so1932587wmh.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/nKnDzshEoTJREnnsRFqyXOBxcp33CXKr1VQJgDssSY=;
 b=FxJ9Nl4mxaFBxr0+oqnbxDPacEqCgSZ5GqRLsDZB8kT0MNzsBE3ZEKCbNzqW/tw0Yl
 7rSwZdUuo3EkY/t4ZsEoJ+OteWp5Adwi8r2cOxewM1alTDWH3NlB0KZX69vwbAbJsDhR
 qMTrojojLr/qD3Hz1PupHByLtXnuSeoPXbcafTEMUh8Sqto0CFvgiyZ+t9lnKpy8b0xz
 /vCf5Jb+dfGM4w9VF8AxBpGbszZGio0CQG/4gVtHnaDFkdcDvZ1eNRJY0F2Sm4RhYovv
 I08kM2dXti2142L00vRWmirjZuodMQZg8WC0bQ4mvGat1c524RM3B5dFQDanNa0rpqaF
 OAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/nKnDzshEoTJREnnsRFqyXOBxcp33CXKr1VQJgDssSY=;
 b=P8QRIzTpNz2TzRlDedYP4Bjlf2oPxeMFYyJb2qv9shP27WVVwaJ1RP91MbbC2Ndp+7
 HX7/9Tr7FQ0idIWYNkZORMhhzudALYtoppK3NiQ3w1VsmUPVEw+zhexa/7IiLXmfmp9F
 Gy/HIpQwPOaYOVNbwq3r4lv0/gFc/zfHmSaW5tjdAsplb4q9r0Dez8RLtYA6ZX31h67/
 Ux0v0CnOhH6GOd15nS8cVBGeyCVUY2DeaUg8w0pLaskEOUP005DvkSs18VBCG4YCJV49
 Y22s3x6ZcxMhbqHBE4pP1qFYv7D2ERIv9Z9q4YX14Q+2XG5fH8OhRnZykdMBH8XA9ExG
 C6ug==
X-Gm-Message-State: AOAM5311eZRWRRmZ1t+uKdiVKDsYgX7BvqYVa2XsOMnO2DpKVQqCls3i
 wRtQVcJCqq8QuFMUCZOaxSCPLGyQyEM=
X-Google-Smtp-Source: ABdhPJyYd+aGPilDzcC5zOrQVGFI3sz96+KPN7kO/qIGtX7lyPzOe2M+sNdmoqsHDt4x952YSR8vvw==
X-Received: by 2002:a1c:ba84:: with SMTP id k126mr226266wmf.126.1601313367450; 
 Mon, 28 Sep 2020 10:16:07 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:16:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] target/mips/cpu: Do not allow system-mode use without
 input clock
Date: Mon, 28 Sep 2020 19:15:38 +0200
Message-Id: <20200928171539.788309-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Igor Mammedov <imammedo@redhat.com>,
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

Now than all QOM users provides the input clock, do not allow
using a CPU core without its input clock connected on system-mode
emulation. For user-mode, keep providing a fixed 200 MHz clock,
as it used by the RDHWR instruction (see commit cdfcad788394).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Igor Mammedov <imammedo@redhat.com>

We need the qtest check for tests/qtest/machine-none-test.c
which instanciate a CPU with the none machine. Igor, is it
better to remove the MIPS targets from the test cpus_map[]?
---
 target/mips/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 2f75216c324..cc4ee75af30 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -25,6 +25,7 @@
 #include "kvm_mips.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "sysemu/qtest.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
@@ -159,11 +160,18 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cs->clock)) {
+#ifdef CONFIG_USER_ONLY
         /*
          * Initialize the frequency to 200MHz in case
          * the clock remains unconnected.
          */
         clock_set_hz(cs->clock, 200000000);
+#else
+        if (!qtest_enabled()) {
+            error_setg(errp, "CPU clock must be connected to a clock source");
+            return;
+        }
+#endif
     }
     mips_cpu_clk_update(cs);
 
-- 
2.26.2


