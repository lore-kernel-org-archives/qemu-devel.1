Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD88C46460
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F326F2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxRYUzr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F326F2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9gT-00068N-Qo
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:03:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DU-OT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Pz-D2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-0006Ab-1N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so17083544wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Wb8cdfa9Eg5s6gQ+eGcSDonY8jBmo6zWITaft2LP+dI=;
	b=AxRYUzr9xp5HZfTOCh8LBE+GLlPULMeI9OmJ8bZCEGhHDJ+RKnhdO7TCArlzSN/Ony
	/Ktd3LUblYXsqFpksyprLI0oRNj+VKe4ufCUcPssA/DWAqtrRvpkLXe71iufj89jHFcw
	dVqocCBcHvW3iBds8sHseH43xAAFsK03MmhEsg3mmrfByTXyjEbv0vseEPAWNViil9er
	PWv8apmbohiHfUuTz8AcXyIU9o3o6XKGBb5R8bXjZLbEgRll81zw2HYuLzVwHXoqPh7z
	x9Cg0alMGh6lxp2SKpsTmrrogxQ7YaYin5oiN6PnOLCbae9/XlgWV1yaxfJvd/pMRMBq
	i/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Wb8cdfa9Eg5s6gQ+eGcSDonY8jBmo6zWITaft2LP+dI=;
	b=CMWSb5TzqHiH/JvDmKWx/o0rspIedpBv9plA1MCut55U0a1nfPcqBqiSBsGuaAe9hF
	2GXkfWcowcwmAo7tNjGgIvMPxltLoP22ZALhZEllya5NYv7WoiOtVti18bRoeuUPh5+y
	G6yGnGwrrODPhZWn1OzF4Xo1kFiNmWPF78+zPpKPv+qq70jElkBXTjoXxxOb+F96fJr0
	kM3g4CjaSv9O/UGXEDwShjfkhfArcEUuvtKpvuQnVQp433jdAILD44R0hYa0H1OP4tj8
	eWT4Y+KGBNgbDQlT+LUlgfCw8dMBc+D1k//WSAUBHan18lc5ouhXvKoVF833hThGQmEl
	Qv0g==
X-Gm-Message-State: APjAAAU81BYR8LDRTHyhHYG4F58Y1/YV6xLkkbT4GG2W+33uH2dhg1aA
	4CaE1DeyKcLWmWLjVaLifkdOYJeecG0=
X-Google-Smtp-Source: APXvYqx+tuZAMeWTmA0tC5iOMcf7MV2sFwWJQmFLJF4Wy27Ihyk+y5CVwLP8fuOdChmeHWxWRxSk9g==
X-Received: by 2002:adf:c002:: with SMTP id z2mr42930314wre.177.1556557239207; 
	Mon, 29 Apr 2019 10:00:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:53 +0100
Message-Id: <20190429170030.11323-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 05/42] hw/intc/armv7m_nvic: Allow reading of
 M-profile MVFR* registers
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
Message-ID: <20190429165953.Ks5Ob-cuzuv0s022HVxWjwRXo0oDHZtHJz6aZVqfAJI@z>

For M-profile the MVFR* ID registers are memory mapped, in the
range we implement via the NVIC. Allow them to be read.
(If the CPU has no FPU, these registers are defined to be RAZ.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-3-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index ab822f42514..45d72f86bdf 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1222,6 +1222,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return 0;
         }
         return cpu->env.v7m.sfar;
+    case 0xf40: /* MVFR0 */
+        return cpu->isar.mvfr0;
+    case 0xf44: /* MVFR1 */
+        return cpu->isar.mvfr1;
+    case 0xf48: /* MVFR2 */
+        return cpu->isar.mvfr2;
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
-- 
2.20.1


