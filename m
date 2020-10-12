Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ECC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352BC20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6YxX7ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352BC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRun0-00078X-7Y
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucR-0002JD-J7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucQ-0002vr-3y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id e23so9626360wme.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SeH+Hehlck8m/GFTKOCzWoLDNRcm+8wSSlkI3BiVy4c=;
 b=A6YxX7ESw+gclZM/z8xR/asoA5OhwTWI7qG9sHW82+U+zrn+80rr9Ojqi1KyutO/wV
 DKMzOMOe4mk/zKsDWZTqTGNnJpDuTklMCndJsehdG5T3fO7pEix9b+N82xVZonxtQ9xC
 /8rUraUjzMuxamC+aVEnN+eP+8SX5sDvkcZ5eRFJfZ5SqN+c75VB1LHteR+bujaN2eND
 THnYakbZKi7AjQHMxR1Xypuj+fPe966DpwKkl8RLlKzVCy57lNijj7DWTawzvkemddJs
 TtXtfCoFbzXXbtqvXf+XapljUz77IbvQEsFTypGTXcYCI8gE8ru/BHnh0DsrYgVkK/Lu
 7Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SeH+Hehlck8m/GFTKOCzWoLDNRcm+8wSSlkI3BiVy4c=;
 b=qBijqOOBH80gnYPurFFiK8U35g+9/yqxpzyq7N+iAXJGdQHOkDI7a/zYJp9OoLbDAT
 DOFHiSP9nOgrl7WfrfA7gEk4D+FlLHmFYf2nVUeVTYCZNntqM9mcibKQZ89QAjTPgFR+
 /BP3fgcTsdHXwmu2EqUMwUmjARn6Zcdp6G8HT3voX0o+yW3nlp5DAoATQkJRUCV8Fu1I
 vw6wGfkrgzhDJ3CrpVPrRv+g8JoLXHvoEVx/+GZxRU+AW/2uL0+yJ1jsBLpBKLLvjscJ
 EsndNBqFTZuVWHG3m8yizXLvDxHdmp69Ikdkio5l9lDUQAlcPtYdFrtQ0MeKU5axQTmq
 U8pg==
X-Gm-Message-State: AOAM532GWKdZeqyYObNCkx7qVmJZFLLDTYzEQUpmrKOuNo+AFHsVkrf/
 kTeJarHtgwmPyLMrn6dZe4vZCpKI1wo=
X-Google-Smtp-Source: ABdhPJyowOAjINWJ2GAVaThUvGccTMgBtWglz0jRIzrT8RnVW4rhSmEwB5shZxmTfQ+NnX3FFnEerg==
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr10430939wml.145.1602496788576; 
 Mon, 12 Oct 2020 02:59:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u15sm23953845wrm.77.2020.10.12.02.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/21] hw/mips/cps: Do not allow use without input clock
Date: Mon, 12 Oct 2020 11:58:03 +0200
Message-Id: <20201012095804.3335117-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than all QOM users provides the input clock, do not allow
using a CPS without input clock connected.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index af7b58c4bdd..c624821315a 100644
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
 
-- 
2.26.2


