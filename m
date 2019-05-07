Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB9C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37001204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjrPnYyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37001204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45785 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyxN-0000XH-Fd
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylu-0007h6-PI
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylt-0003yK-M5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylt-0003xq-FW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id h4so2678719wre.7
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=0E/GB8BOaQHYgNe4bA1uWRBqwj8g9GMMZpj2tYiWP00=;
	b=MjrPnYyChAahm6QraFZfhIUd5ppVBxf/lh5+2g5d0kQ/WWFMOhpIiU1k+w1ZgI6XB1
	/jUO/ZLW1s1/v4M3kQLKUbKKGZGTRUZ4UE7iNkTFYMhSB7RYCSSL+UIucDG9z+xj7ihA
	X/XTMfK5biWPc5/EzbBGVF8F3syPwu+6z802dy8OFJ4GaB9SqoMyM3yWKuUerBq7i73f
	aevbQBoJnpgZ8aRHhfRB4dcbvU7VY3no1bv9QZmoweWQObxobcgYk5o2zfmet52n442W
	kWcXUfSKlDTUsOnBObz3f/2/ubhxgf4N/m1q7iLMG3lAGQeBv/r5bmFftVqQEFqVuFF3
	ERpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0E/GB8BOaQHYgNe4bA1uWRBqwj8g9GMMZpj2tYiWP00=;
	b=HU/OGY27TfLno5olvuuhiR0KrR3tcHMKPW/zT3EAFFmwOS/cN71lljI3M8Fgz75LCX
	191/xG/qu+T5ZnWuZTJSmIkGXBQ/97rcy8XUyo/mbdyPkNg1OX/ebh7TyFXw52ThoOkJ
	DEDtQqXOM7r52Ez+BOVfqJ/IArs3VUdy5KpSsvMFP4BsqQUN2oQlGZl1QLbsm5bgXAVr
	J0gJHY1ZjC6hA50wAU69azxyhiVAfn1yJ4L1CAVrQQX6k61aZE9SW6FfYx0oR8AGa0GA
	54XzEKx1uMdA8Pu34cbycz9wjrlpJrTHdrQGvZKCRlACPUmow1LR0W29Pq8mjiq6U+Ft
	cvyw==
X-Gm-Message-State: APjAAAXYbbCM0YSkpIecbEraLwZkmDVjv0S0A6IK42S7YMZb49TVbVPj
	3cQOAL2mQLeEXlg/yWd2N/D7jZ5UjO8=
X-Google-Smtp-Source: APXvYqwJJ6Gjt8sYahUZ+cxxqAU9ZlwyylTWtDMmf2RbB7t0FB3M570SxBHf6QFgV+O9dl11WSktpA==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr7478316wrv.90.1557230432200;
	Tue, 07 May 2019 05:00:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:09 +0100
Message-Id: <20190507120011.18100-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 13/15] hw/intc/armv7m_nvic: Don't enable
 ARMV7M_EXCP_DEBUG from reset
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

The M-profile architecture specifies that the DebugMonitor exception
should be initially disabled, not enabled. It should be controlled
by the DEMCR register's MON_EN bit, but we don't implement that
register yet (like most of the debug architecture for M-profile).

Note that BKPT instructions will still work, because they
will be escalated to HardFault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190430131439.25251-4-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 15cba63c964..3a346a682a3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2491,10 +2491,12 @@ static void armv7m_nvic_reset(DeviceState *dev)
      * the System Handler Control register
      */
     s->vectors[ARMV7M_EXCP_SVC].enabled = 1;
-    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 1;
     s->vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
     s->vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
 
+    /* DebugMonitor is enabled via DEMCR.MON_EN */
+    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 0;
+
     resetprio = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? -4 : -3;
     s->vectors[ARMV7M_EXCP_RESET].prio = resetprio;
     s->vectors[ARMV7M_EXCP_NMI].prio = -2;
-- 
2.20.1


