Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BAC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02933206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiOP8Pvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02933206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYr9-00085G-78
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL8-0007wj-T3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL7-00025U-T6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:54 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL7-00025L-Ou
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:53 -0400
Received: by mail-qk1-x743.google.com with SMTP id k13so8208656qki.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=oiOP8Pvs0iAUi0RJ/krm78vg3eL01ZQqQpHl1zVxM/WWr+GURS0LHBv0ClGOlMUZZQ
 ccl7gaxvD35z8nXnYvevs5ke5j6YloiiWmCl03ffAf6bUAYicK5Rz0fnJiGlM2maJFaX
 y8eyu2vODfDlS79Cy6hAdTrR1GkOCtQxpetIPADKCnaMEc16+EnNs5TL7gZ5qaMiRCCQ
 qU1f5/NSx8fmZ7qGhB0PBzZPdoX8mYu/zS+ZPjmdTB8ZN8THWN36C1TR61yN+fcKX7t5
 Aptf8pr/IPNfjBaqVvApGGPHluhTw9Kcl1sAuXrajdgditABLNoM1eVbRYwi58zVnuTL
 01Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=tyRju9OOUkC5Vc2CFN+zXvAMGYygZvTawRZlQ+YwwdRwld8zFXIRp2IdZYSzY7Yl06
 tDxQwKPhCGwKNs4LL1ySVH2BKb6j+nyDUKBorNpRDi5KrUXXxopi42DwM9M+g0vxWCF9
 gRSYcUUsmwcP2r5eS1tNSDz7oUMUEHfJ3ObrTznoApU2CXov4W72XC3YJt7OPy1wGUVN
 cI1V7TFIXDdIQhKK2Zvn1LPc1LemX0onM7XIjLU/ConFjnP2qNDPp3peobpB3RBq8Xie
 Pv/abvZJ/5gA4Lg01IK7WClR7TqjiNHmV2Nlqkj1DvbOz+OE8HeCf3RU1ewQQfKla3bx
 MXhQ==
X-Gm-Message-State: ANhLgQ397V9NOiywQ41dKfyn3ro0vY0lPkB4qwc2O5SMS8YHbxP5KZOq
 2q3e3/ILFVLpYsQNOsbqINKidgCOAS6+Xg==
X-Google-Smtp-Source: ADFU+vt9CPpLbEJ55sNcnzQUKP7ktmDteHUwQMUiOQexvQIuAULTZDXpTGLG2tAtEWPaQV30j55owg==
X-Received: by 2002:a37:b002:: with SMTP id z2mr9884193qke.289.1585251533055; 
 Thu, 26 Mar 2020 12:38:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:52 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 57/74] openrisc: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:39 -0400
Message-Id: <20200326193156.4322-58-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 target/openrisc/cpu.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 93268815d8..9475b77d0a 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -102,7 +102,7 @@ static void openrisc_timer_cb(void *opaque)
         CPUState *cs = CPU(cpu);
 
         cpu->env.ttmr |= TTMR_IP;
-        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_TIMER);
     }
 
     switch (cpu->env.ttmr & TTMR_M) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 5528c0918f..fd2da39124 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -32,8 +32,8 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD |
+                                        CPU_INTERRUPT_TIMER);
 }
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1


