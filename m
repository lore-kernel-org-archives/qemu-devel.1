Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E46C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D599206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0XYsaK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D599206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtSD-000787-JJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxl-0002no-KU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxk-0000pM-3V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxj-0000ZG-Q2; Mon, 02 Dec 2019 16:10:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so1084653wmi.5;
 Mon, 02 Dec 2019 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5I8SpK7yJTqrWa069AbQjRTm8TolcAxVRIFgMoj+ZJ0=;
 b=K0XYsaK6kM2j1a5/AYPnE5yHEwoqv/Uqc8s/bf10ipYar6WTmTvvcvC8M2Zr/bg+Xl
 nQzyrOCMe+rp5l8+Hd2DmSKibGI+CSE6Hph3S5EyqWAxZrLoASNMUBqUzTQqJsEBLS+W
 y1nDPNUWVg3SP7kbcXwRGL5Q6Bmoo8hu9deClMmJkCfkPcC8KOBKExSKrEHP/M3kECPO
 ipvadTlq1NRkHE0KDi41l52u0Sercdor5/cpPNomr+s0U27A7tDJBIJTApOZPtgyj7Zb
 QMZf0qFL6ajbi3u/erz0D6LpRPogDEmxILs8wIi3vAJvDTPbcV5F9B3a8qC9+rb/SZQ9
 efsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5I8SpK7yJTqrWa069AbQjRTm8TolcAxVRIFgMoj+ZJ0=;
 b=fkhTKobMoTjcEMNwiRL7PdlDaARLhhuDbm9dzIqR5oxfZ/pas6T95I4+PXZqx4DsM9
 VfGps5+HW+SlVSzXyzt9dDWjTQ2UUtvDdacuCZ9SZDBnIeWkeUqTneujWiBnT901CsvS
 wNNj/o48l8u+YFMOv1rW8icEJFMbnF+DIuScCmX1I+nCNNzelJbVtB3nGPRY6STjUuUd
 F0S/z2Nh8XKxX7imPX1HKRhZZwBr7VxNa75QaEHfaYGzmesJtdmoccLFrgAS0EQQGqw9
 /z5NdQXRKooXSMHc5ARmL8hVDM+uxcyjpaVgAmp7fvOiOitYyQxEKabY/qZr34XL0Vp/
 WnFg==
X-Gm-Message-State: APjAAAUL6xafI/gv0i1ibQUtQMkrhhyw4hosfWVWplsZFxcGdYslGYs3
 9ofhCkYAB3+rvgqci97iZEjUk1hu
X-Google-Smtp-Source: APXvYqxc/726bx2suYPTiEg7ZbvZg+Xg+KlXFhLvvvLRKLoIKgOwhfzvjoI775km1xi0oLit71DQOQ==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr30178448wmj.11.1575321001972; 
 Mon, 02 Dec 2019 13:10:01 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:10:01 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] arm/arm-powerctl: set NSACR.{CP11,
 CP10} bits in arm_set_cpu_on()
Date: Mon,  2 Dec 2019 22:09:43 +0100
Message-Id: <20191202210947.3603-7-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:23 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change ensures that the FPU can be accessed in Non-Secure mode
when the CPU core is reset using the arm_set_cpu_on() function call.
The NSACR.{CP11,CP10} bits define the exception level required to
access the FPU in Non-Secure mode. Without these bits set, the CPU
will give an undefined exception trap on the first FPU access for the
secondary cores under Linux.

Fixes: fc1120a7f5
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db6..b064513d44 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -104,6 +104,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
         /* Processor is not in secure mode */
         target_cpu->env.cp15.scr_el3 |= SCR_NS;
 
+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        target_cpu->env.cp15.nsacr |= 3 << 10;
+
         /*
          * If QEMU is providing the equivalent of EL3 firmware, then we need
          * to make sure a CPU targeting EL2 comes out of reset with a
-- 
2.17.1


