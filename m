Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8EFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02FC20790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwBYrj4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02FC20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRs8v-0005zU-Ui
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs7C-0004Oo-0r; Mon, 12 Oct 2020 03:19:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs7A-0007kz-Hl; Mon, 12 Oct 2020 03:19:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id d3so16472564wma.4;
 Mon, 12 Oct 2020 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0zIvNiiPuD3jbI/3K2hr7asrKbop6KgBlLoFr6P7Cg=;
 b=DwBYrj4iarsfdZqAG0JGjOLQAX2Ct2Jedc91riWUKh16WbCtwv/z55Y0GLKCD1c18w
 dyEpaNhTxdPBvN7X1N/kOojjvz8Ai2dI/DZM66kSxUKNRF68O2mGDdct5BUfB5/3i+2C
 mdYTuK0DN7F4YkmvEvAuNrTbXBjUfM1A9B2puRYBilGQZ5Q0Wwn50M+l3+hqMNPbmi3c
 OLvju6TioFIz50uiRJbJROstlepTcC4SbM7nC8zcjLUW9mgXQQGXbTZFQvoiVuw84nWq
 L98gQexhecOWDYMCqXDfOOOAPRKYGqF4lqK7DC08RTbP6j76aUCeEUkPohNpCwOTKRI9
 RlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g0zIvNiiPuD3jbI/3K2hr7asrKbop6KgBlLoFr6P7Cg=;
 b=ClVGr6XN1VEEsJ2ro5U83YpSGADACxO87ixgopvnlTnLtt5iLpQ3G7VHa64mqgCG1O
 4+CxBXPXsobXWvyx1InqSQCdctYpmCiiZxyBjaztwJzeOtt3M/re2xiIF/QCzPDzwizy
 FE2wUStsXaBF4H/Y/j2W9WiWUTXDaoy682QgYx/xnhN5Fis3uNPcvAt7KfGHaplLIIBr
 0w6v72KEYedUmQ99uXZJw1kQowwpMQtpRp78tN8CW80sVw1H1bjKcyJlbmepLosqSpAq
 eRmxumKoZnLeqvt3P/G2eIFo4D7EIy+z3TWQDcGmYsSbwFfgGhAsG8g3aX4WzodEptRV
 bI1A==
X-Gm-Message-State: AOAM531FcxG0JgxVwWtUolN5QdlbUh3EJlsAtN/F8N4vEo4P1NKRHfNi
 yGEkjIeXXZO9UfS5Pm+KxfjvjqPdWCM=
X-Google-Smtp-Source: ABdhPJyWpKeDDs5xuL5WPEYWcVXnqyp7ftM5jKJeFNQ6BFviUDbMc8+oaVFFWlf6URDxRnoJuKvBDA==
X-Received: by 2002:a1c:e3c6:: with SMTP id a189mr9224253wmh.167.1602487162785; 
 Mon, 12 Oct 2020 00:19:22 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w5sm22605270wmg.42.2020.10.12.00.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 00:19:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/pci-host/prep: Fix PCI swizzling in map_irq()
Date: Mon, 12 Oct 2020 09:19:05 +0200
Message-Id: <20201012071906.3301481-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012071906.3301481-1-f4bug@amsat.org>
References: <20201012071906.3301481-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Jocelyn Mayer <l_indien@magic.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Julian Seward <julian@valgrind.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit a01d8cadadf we changed the number of IRQs to 4 but
forgot to update the map_irq() function. Do it now.

Fixes: a01d8cadadf ("Fix memory corruption ... in PreP emulation")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Jocelyn Mayer <l_indien@magic.fr>
Cc: Julian Seward <julian@valgrind.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 064593d1e52..2224135fedb 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -195,7 +195,7 @@ static const MemoryRegionOps raven_io_ops = {
 
 static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
 {
-    return (irq_num + (pci_dev->devfn >> 3)) & 1;
+    return (irq_num + (pci_dev->devfn >> 3)) & 3;
 }
 
 static void raven_set_irq(void *opaque, int irq_num, int level)
-- 
2.26.2


