Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938AC207FB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwAhmhqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938AC207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRM2W-0007IW-Pr
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 17:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLic-0000xC-9Q
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLia-0007Ww-08
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so14147330wrq.11
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VteZSfKnRVCLsYtZHNYo1AU9nWTlWiBOrpFD9RH1hDg=;
 b=RwAhmhqQzoWm28PJUhmuLlWgOD1rbb8fusxp9EwYg912hs44oYYykIWrpYMjCAravH
 qPjTMRx1pFLyynbibxi8f9ajm0dTXGa7fYGD80+OKSYmK2P3+MIKZIOj2p5YwPZpwDRl
 6m59NFahnqC17sgM/702nbUe2+XKP1WA/Mw4whh1F7+wETE33XVPE3fb9R0DH2PFm4ca
 3Mm9enyfT27ZW0k/4IjmXfvC6tKlXHV4A9A8bzHN/SqC/5+/LAPV+70AyoQohNb4lp0U
 8f2+8+qRi/A8LOGX/wED4mmFROzaZ9QRX6/w7bI+bpJQZ2b4/GeWJK2yPzQnxfkNzslb
 Awcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VteZSfKnRVCLsYtZHNYo1AU9nWTlWiBOrpFD9RH1hDg=;
 b=t1nmo6aHqqDZheFmlygE1hPPqcF/OqMSis1fDSZgQncy+4pYU9L+2aASPzD0yu/hSK
 KBCD+lWV1QEoIM00HkI7T8qn/Gd3WODtRf6WUNfAZbisHBVcEoX/AHxh1Uik1/MljOb4
 PRygj00DuwZiuDx5ctlSqmLkQ98NTqT9G8eNboPkwUCrMnM3qRK+jrXNAhYanh+ej6X7
 eKnQxn+B/I7nKJRWbv3NKiaqssWkTc/0eb3A8oV9Rtd1B4gp3NY2vMwA4blrlkTvDC2z
 privr3+51SivgQElh/aMdW9V32yYtpEamccL76/a4ZkZzs/37k/8En/hfcXN9CEl8ZY/
 cDFA==
X-Gm-Message-State: AOAM533AnARRgJjg3lcvBhXRl+ayuwm5ALvgvygTcpH7XuCxZ2JsOGBE
 XpXBw3OoZoajWZzYiwI0C9jKDgBxzno=
X-Google-Smtp-Source: ABdhPJzEQhIuL6nbTfdCbWSKR6JpWMpjieMQWeK38qzhrMsGfgHDgK+gXbBQxaUaXRhgmTJTBFJOFQ==
X-Received: by 2002:adf:f305:: with SMTP id i5mr16051782wro.346.1602362628265; 
 Sat, 10 Oct 2020 13:43:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] hw/mips/cps: Do not allow use without input clock
Date: Sat, 10 Oct 2020 22:43:18 +0200
Message-Id: <20201010204319.3119239-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than all QOM users provides the input clock, do not allow
using a CPS without input clock connected.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 915655b91e0..c624821315a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,6 +74,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
     bool saar_present = false;
 
+    if (!clock_get(s->clock)) {
+        error_setg(errp, "CPS input clock is not connected to an output clock");
+        return;
+    }
+
     for (i = 0; i < s->num_vp; i++) {
         cpu = MIPS_CPU(object_new(s->cpu_type));
 
@@ -82,6 +87,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
-- 
2.26.2


