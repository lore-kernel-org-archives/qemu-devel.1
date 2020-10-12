Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD483C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4569320790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfFllSo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4569320790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsBL-0008W7-AL
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs72-0004GA-Ge; Mon, 12 Oct 2020 03:19:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs71-0007jI-2o; Mon, 12 Oct 2020 03:19:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id b8so4662170wrn.0;
 Mon, 12 Oct 2020 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FNdBGLPtUmVgTnuJXhsVPUN2AJb8yl0wVfZR/zSesG8=;
 b=pfFllSo4wPcfOL5nfEYYQGO+RFiHSqSqh1GIfRBmfXe/xhGgsNbofZlLZG+OyuFQND
 oFMekdD3p17psKz3AKCO+QsTmnb2i8tDoC/BjX0533st0mmuE7gplb8iDdKXWVXW+Vnh
 zCp+bYETTRNIHDOh0ZyIM9X2O3wWcOLG1IKWtkrN8CfpFmf9P/jTvwKOOFc2qrhDF19o
 daPl3crQzmVHHL6sL4pdBqfGIXEI1kT4rIq0AV9z7PSUzCuXq+3+I4FxTQB+UI6fDoqj
 PXOjL1GwN6DgMCivcm5NQ60w2rRMyndnQSE14z7EhaPFT25e5xtwzkvjNAh2VZ01LbxJ
 t+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FNdBGLPtUmVgTnuJXhsVPUN2AJb8yl0wVfZR/zSesG8=;
 b=in2JQ0K5Q60XNv4NdrDqERnzhKGOAoSCHtKHrUx8LuLIs9Z5zE+gK7+5CkAsv+Frt2
 y+xgqjV9y9V4YY74ecZ431Ffd6juiPwZVO9RyVM6FNbJCUl/vX3gjq+hTPixakvPB4ud
 q6+DVNtaO14jH99HZ8SwGU2q7Lw8riuBnoGekQWT6S1GJL7EA0UzQesT1jbGFFWjFAoq
 0cr35t1i2ZHQps3oxs6NRzip7T13XpUeuj/cm59y2IE0VM1EIHL4TWhDw3/2wg94vIUN
 qLNmjoTUfLDQVggPLweANaGJmUImcasdOgrZIiLjvKpka1Z07KGoZJO5+rfQ0dNp3zMS
 WzSg==
X-Gm-Message-State: AOAM530gnEC6v/1Pzsjvs4Z73zG90UGjULvzRwRAQWzFdPDy1ihY05zy
 2xR0MczD7mxOpUIucJ24olP7BRoshoM=
X-Google-Smtp-Source: ABdhPJzEzzm0FwZernmGPYHASlngnmunDkeK2EmNJ/XBpOIjCHXZXUIsX6G9hWKrGwZ8Tqm1BVuxWQ==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr13152054wrt.183.1602487153125; 
 Mon, 12 Oct 2020 00:19:13 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s11sm19372193wrm.56.2020.10.12.00.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 00:19:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/pci-host/prep: Update coding style to make
 checkpatch.pl happy
Date: Mon, 12 Oct 2020 09:19:03 +0200
Message-Id: <20201012071906.3301481-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012071906.3301481-1-f4bug@amsat.org>
References: <20201012071906.3301481-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the next commit easier to review, clean this code first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/prep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index d0323fefb10..80dfb67da43 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -234,8 +234,10 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
             sysbus_init_irq(dev, &s->pci_irqs[i]);
         }
     } else {
-        /* According to PReP specification section 6.1.6 "System Interrupt
-         * Assignments", all PCI interrupts are routed via IRQ 15 */
+        /*
+         * According to PReP specification section 6.1.6 "System Interrupt
+         * Assignments", all PCI interrupts are routed via IRQ 15
+         */
         s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
         object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
                                 &error_fatal);
-- 
2.26.2


