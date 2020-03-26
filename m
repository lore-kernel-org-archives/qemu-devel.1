Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CD42074D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1Fmcxu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CD42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYtr-00042y-Db
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLA-00082B-IH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL9-00026I-C8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:56 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:35406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL9-000262-7t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:55 -0400
Received: by mail-qv1-xf43.google.com with SMTP id q73so3706624qvq.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g5Ui26IYflB7RMxLLOQyjjArRpQxbNqKCvou8uKMYcU=;
 b=q1Fmcxu053j1KdEh9oYBpX00DIb1chbO7U3ErqqW7nwGZ2E8Cbxo3dTtFeeDuzVSpy
 u0xspx2JKKfJnM6IRUgCm7vl327Zf3jbm5pjyeP+5pZy+HzEwFZ5b5QZVqAvgLhmf4rz
 dS56Wiyzq16RUPXdRFx4CeSGjsbuvWpIrizyhgxAOnIHd454+WkT6FkylCSqEjAxKsbB
 1U6v7fYgOo95FtPL4gJ58PnpFMFAQaD/QFjS3NBjzSy1UACSs7F9d0LwlBAMS6Y9ptTi
 7HjzBuOBbh0EBuqjp8gs7MwwFyjTlSt463PpzUEtWPMNy0Mmb6BHVJ0202JuVJYXYbs3
 TdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g5Ui26IYflB7RMxLLOQyjjArRpQxbNqKCvou8uKMYcU=;
 b=XwydXkgueHJHrHlZgV71AeWXQZEg6ZxvUUT1ZgaylywrN43NbfzLt7t4sqg6jEetc0
 BB/kgJ3Pg8HRBLNDHFPNZI/ORkZ3yIqxUOiXdf8GzcMERaJJXXWB/z/GdPJI556xscLZ
 5hGADCC2ktGukslM4mxeuhMvKX5gSomF6DCulTHr3ahsDstxTqQ2BO5MqAaVjwzRiF1N
 +eyOs7fAzB7Kcfz9I32CcVGjViQ4Z1j+fwEpJYgWNpPwOxVCrAz9klfVSx/K8Cn+h1y3
 uws6xvfSxmViuPW/iRolyqarXHJ+BEaoMgyYN+gIylpkfIHW9vUYtRy+OFbKCG7gn3cJ
 eMRQ==
X-Gm-Message-State: ANhLgQ3/XbEdK39uROtumCBvW0svE9QKApm/v8qxjd/Y5Myt0HwJMoTj
 l9bNGgT7XVFyYo5mBRp/DWbrovle1m4pug==
X-Google-Smtp-Source: ADFU+vvZ3V2ISvPPvcqqWL0MEa5ftj8yFnGYAorwVv35HMNyz9uu44/iqJ2sDVdbC7BekFxY+LKL7Q==
X-Received: by 2002:ad4:4ba7:: with SMTP id i7mr9833152qvw.39.1585251531366;
 Thu, 26 Mar 2020 12:38:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 56/74] sparc: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:38 -0400
Message-Id: <20200326193156.4322-57-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/sparc64/sparc64.c | 4 ++--
 target/sparc/cpu.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index fe9c678459..191ebfbb93 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -57,7 +57,7 @@ void cpu_check_irqs(CPUSPARCState *env)
     /* The bit corresponding to psrpil is (1<< psrpil), the next bit
        is (2 << psrpil). */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -88,7 +88,7 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    } else if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
         trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
                                               env->interrupt_index);
         env->interrupt_index = 0;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3f05aba9d6..cef25238a5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -704,7 +704,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
 
-- 
2.17.1


