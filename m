Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B949C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DB420675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/CRAFLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DB420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9sp-0000GC-4c
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:16:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0004uU-9a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0006m1-3F
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006IG-LZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id o25so148750wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=C5QzvnZSqvAHI4meFaiTxEyfhM2e9uuOHfPDatPGWdU=;
	b=t/CRAFLx+KIdfIfSE/4paSxRpvQPoOvlIwt0/1Zuc7Ud4ldevhlvVLeJLD4PjdYUAq
	JW0TnibQzkEBjzpQKZMwhMTCKXjCIYxHXzt8IA9Lohn4L3gQSbRKv3GxYhZSFB7UqaTx
	w0dt4IagzvcZrDL7hhHd5WvjhQROB3gpupNsMIRJDLmrxap835ltiZbMH1bp4k0falZm
	xbcXOP8XspLSXA31kuRf4aafVaEOsNvGsJ0xwKP7PbaZj0KktH1/hGR138wSUuLzfX1c
	ehisxtkAnMgJMw/M/eF30ldpZHpAwr4Bz7L2U0475FsijhzZtABeouqB3tCxcIgZns4U
	fqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5QzvnZSqvAHI4meFaiTxEyfhM2e9uuOHfPDatPGWdU=;
	b=EYQn359VvvgmKAUuqjJd6Nyi/P9Lm9j7xXN7emTRdQI5ps/Znwboc/66OdrYqBzgC5
	EFn/bmcWq8BgCKMcY+OFQLm2rjtlk/5DC/8HKg+uhbbXuqlVjzJ6X1iI9E/cbokWy9Dk
	J0KlC6ZVxZttOHHhoAbCOHwigeOoQLBhK4cRcP7WDvjK2zi1MHJn2rokWHlFc5xuvQMg
	Sw2KROSx8nlpaodVAiM9FvHJJ8+TnUb4GWv5nETd8v7kTf2zdgv2JmPU/R0haUZPPqfi
	ZAqqkuRrIytZgKngenWIBxyXvMB5UrJ6wQYgVC2gt+3/0XmCi8hEZaPq2ESl2MuzZiCk
	U4CA==
X-Gm-Message-State: APjAAAUGt6PqI/3OQlAGUHQQNaSGLuhB3SNYxwh0GwOPWTjQOs4szCdm
	i3EZL/ldwI9ZhOZELGsRaTmi1l1fDoI=
X-Google-Smtp-Source: APXvYqziWLyG+ytkZUkcqS96aowud8RJB6RrMVoHZQ+y6XAMGsCeU/rLVHWTJokE7QFKQPYouB9RwA==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr61347wmh.40.1556557245309;
	Mon, 29 Apr 2019 10:00:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.44
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:58 +0100
Message-Id: <20190429170030.11323-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 10/42] target/arm: Clear CONTROL_S.SFPA in SG
 insn if FPU present
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165958.ipc1qAKrjMVTY0hlC38-MHmm7Z9EA_-hh_xYsiNBkBw@z>

If the floating point extension is present, then the SG instruction
must clear the CONTROL_S.SFPA bit. Implement this.

(On a no-FPU system the bit will always be zero, so we don't need
to make the clearing of the bit conditional on ARM_FEATURE_VFP.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-8-peter.maydell@linaro.org
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3d5fe09cdc..45a9d92e505 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8804,6 +8804,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PRIx32
                   ", executing it\n", env->regs[15]);
     env->regs[14] &= ~1;
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, true);
     xpsr_write(env, 0, XPSR_IT);
     env->regs[15] += 4;
-- 
2.20.1


