Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F48C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BD6208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M63J2xaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BD6208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwoN-0000oA-5U
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkk-0004BR-Cc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwki-0006Ly-GX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so2190033wrm.9
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=foOMmOGF2hVWCsGdHMVh8B2p3MaxLn0e54Hx5DC6ApI=;
 b=M63J2xafJrN4F7BQ0Ch6ErwIPxgVH+MCf/ISF8eQLt5CfneBPAMvbW1zXk1KTx1xUY
 Mexy+/0JhnUxnwau4LQnV8qAe9V9TxY1+PkCBGVmaDTVYiHd0d2RmUb4pk8ysrigMpu0
 eUMV/vGGxlgBJuNzVsrjoxwwGEPPsLEr62fI5S5jx+v5YOuQJkur3QMMWGXbwg+udjwS
 taJ67P3zguBxSy495mBHHuUUWlEqsCwIlO6VThq4KGWxelIVpt/7zTZlrLu6W/KdLGg4
 YWWWLGoI6In4tNhnJ+F2JoBLdYXf6zAoMBA50Yf+kIFNkvfSdVtrIOu+tGfTpKgZb15Y
 RRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=foOMmOGF2hVWCsGdHMVh8B2p3MaxLn0e54Hx5DC6ApI=;
 b=ZTdhwcRA3+Y7ACNUf1uqr6IEmjfrPPni8BuIj18ck79/OAql36MTYFoPiOyfUy5PXV
 pfnPVgWVzPjndvtERrEYVq36QrnQRiSLV+b35+NiNz+702Z3Usd8Ft33osdF425AcWFK
 5qGOB4IOVCPPOeFG66a4wS5fQASZfTLXZlREtTkQrx+E49FHY3UZBjlIVLSmW3bOg0Ay
 nSs1uIY+kSBzs5rin6TpdOoBtJb2BtAun6d7x3gVjono8cDhBZl7AhQwvjNiNgCjInqX
 S+qVdgJ5XU+c7GhnN9+YW8hi0O3ybQ2IyQb72gI2wKubN44H+ApovLja2svqsMhdTIJK
 4xeg==
X-Gm-Message-State: AOAM532R2dosgxMcwn070OdMKLAu0kTmkfmQghOTpQj6xo6b42Z9APZz
 vkZlW64cPxzN4o/aIO2euL9bAnEf+jQ=
X-Google-Smtp-Source: ABdhPJwRPnOBg+jy892hU3GZRP1sCNeq1bhwT4DzcWn3g+LSs4etgbCYQ+a56mKsOkdCLN5Qn9SF7g==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr2741538wrp.161.1601313349861; 
 Mon, 28 Sep 2020 10:15:49 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] target/mips/cpu: Set default CPU frequency to 200 MHz
Date: Mon, 28 Sep 2020 19:15:28 +0200
Message-Id: <20200928171539.788309-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

Since the introduction of the 'r4k' machine in commit 6af0bf9c7c3,
the MIPS target assumes a CPU running at 200 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c1c0f2e12ba..8d07a293a2e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -141,6 +141,14 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (!clock_get(cs->clock)) {
+        /*
+         * Initialize the frequency to 200MHz in case
+         * the clock remains unconnected.
+         */
+        clock_set_hz(cs->clock, 200000000);
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.26.2


