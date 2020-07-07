Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9409C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8663E206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSyrxASp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8663E206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssRn-0003Vc-PN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAP-0000KZ-Bw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAN-0002y6-GN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id o8so80250wmh.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tGv4CfBEXtuFyKALiKaIl9gTjn1aAhGIARznEXiT5/M=;
 b=BSyrxASpBcf0oib8H6lSAjSy9s/r1jeLnn/6zG/ZhKKvXtDfaB9Aw0L2ndQHS12jwd
 Rx97ZB9bXtFdNeZUOq5jz4tTKsVW0x2fhqubwfdMZvmu6V3XQGic2lQLEVTAWV2hTv62
 vQzyBO696AWLXvv4L/tAVyy2j5HyF6mWp8xkcwC2zE0s7xi84/GHVzbOh3My4LV6r13V
 kNl65lVWTQTbKvTLkcwaP0/4cSPd5/2r27FaNGf9LEtVVZwXQc0mO6DTirMSLXDwfbEh
 Tff2i1UJz7vyHjkudRdXzhBS22rMd/pm8tubdfKoLrrzmxPqLE8SmEwYCpdpAFY7om1g
 yRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tGv4CfBEXtuFyKALiKaIl9gTjn1aAhGIARznEXiT5/M=;
 b=b1Rr+DlRikAhO5HF6ZDGs5Tm8NUsObhyM5tqXS7w+2VoMqUptKxPiaxpQ6uR3IxxaR
 Zaq4fN3uF2fOi4OXsJ0R/Ay3QANpANgZyjl6GOLXtJRZkSf/vQl9ZRWOPfi2AAzv8m/V
 V6+weN/4l6+rLCFjOx/Q6vRP7PdBqwDJFennObaey5k+LsOCwu2cm1PDjdRPwYNrhRNt
 0sZ3aV6c1lut3y54GwJuGfm+uJoeohN5PEapaAyLDVqDYBxrFtxEjQN4sAUjPF6dW6CF
 NxtjrGO4aeTZBr6EmNG99UJzJytDKe4S6ivv4bdjQVeJabrv5ovrCqWuqnVxqPdv/H67
 MWWQ==
X-Gm-Message-State: AOAM530utd2UX3qvtpbDePdijYDN3n+MKE3/ydJs96Wax77SVGOemcLd
 x2ycQ7uKDnh8rgVZa7uABUaRq7ID
X-Google-Smtp-Source: ABdhPJyCQmIwBNywG9vXOa7eoq+3wjHdoN4LrLwaB9eJz0mce3Lq0IUp742oTTnzTTAcJhjzo3zJ4w==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr5481865wmc.150.1594145882055; 
 Tue, 07 Jul 2020 11:18:02 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:18:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] target/avr/cpu: Fix $PC displayed address
Date: Tue,  7 Jul 2020 20:17:09 +0200
Message-Id: <20200707181710.30950-32-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$PC is 16-bit wide. Other registers display addresses on a byte
granularity.
To have a coherent ouput, display $PC using byte granularity too.

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200707070021.10031-3-f4bug@amsat.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f0f992aa32..f659bc10f5 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -151,7 +151,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     int i;
 
     qemu_fprintf(f, "\n");
-    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
+    qemu_fprintf(f, "PC:    %06x\n", env->pc_w * 2); /* PC points to words */
     qemu_fprintf(f, "SP:      %04x\n", env->sp);
     qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
     qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
-- 
2.21.3


