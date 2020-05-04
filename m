Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDEB2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHqtklSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDEB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXn5-00074S-D7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVXih-0008Be-Sn; Mon, 04 May 2020 05:49:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVXih-0006jW-6J; Mon, 04 May 2020 05:49:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so8276772wmc.5;
 Mon, 04 May 2020 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ssoRuPeDJk5YGl+5sziAPBq69sYcV4AG56/rZ9eqAM=;
 b=hHqtklSLvTb7cWng/YVVDar118wBwkqjnvfYBdjP8o0kHbR8M7qa4rAXYgIbgphwkJ
 DFMNja+XttmegpweGi16iq4S3kFeELKJAaQ2CfI9edh7hSimb8jye882MUYkp+Toekla
 hRHsDSmpckZIrpfIOOxeK4PCLD/Vv8p9yk2CY04o5LqUjOcYfOaiEMoxdlGJ0+yQCUbk
 aBiMFJZnzRUCFl8Casmy73FtUGruQao65mmxMNIgAgQi+9iGcOug9ljvxHCMWlJ6AsNt
 efihugwFjVp8/1x2uy+07jhcJOr2bW/wrshG9xpynaBPUX5I66buAYjA5izW1psuoJ2l
 1G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+ssoRuPeDJk5YGl+5sziAPBq69sYcV4AG56/rZ9eqAM=;
 b=Q78TmU6sa6s5VDZlBVnnlnp5/L5RjjEQSEvJz+7yw6Iu+pNYUlMHDquGjpZYcAYFM9
 6NNteMJD6NSu5NUdF4ofgeg64CLdh14NE/YF4ApjyUeCqSSWCAr4tTSTH2bErtCJlr3w
 1Ld7K4QpnUwZ8YnoLtCzQC/R33eDwY6rFZW08ZW4XJluJ3idBrbJjSoMuk/4txnfow12
 oqyUsEWyzDONlT4gMpC81E3f5Z4zLru7tuKJkyn1w9kTd4fWyZPSg2N7T0/LjIwXbCbF
 rPGmjkV6WzFZgzkG4vrPDg522jbKeM2VmnXjHC1Cawy3SYZXqW1b0yDLv8oZxHzPKPMl
 wnqQ==
X-Gm-Message-State: AGi0PuYOXawoNzuNTpN3flzqjzdxSDhmG56JU+hoyQycjTlfY0g+Q9ow
 pfmvifFrAAn/Feht0ddMA9F++hJK
X-Google-Smtp-Source: APiQypJPWwB52KD+faDiLP3Q1oLaq/Y9rNAvL2VaA6I/47vs0NVllON/f1RvlC5Ex0N19OoBKq3viQ==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr13384644wmi.148.1588585740135; 
 Mon, 04 May 2020 02:49:00 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id i25sm12167726wml.43.2020.05.04.02.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:48:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ide/ahci: Log lost IRQs
Date: Mon,  4 May 2020 11:48:58 +0200
Message-Id: <20200504094858.5975-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might find interesting to look at AHCI IRQs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 13d91e109a..fc82cbd5f1 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1509,6 +1509,7 @@ static void ahci_cmd_done(IDEDMA *dma)
 
 static void ahci_irq_set(void *opaque, int n, int level)
 {
+    qemu_log_mask(LOG_UNIMP, "ahci: IRQ#%d level:%d\n", n, level);
 }
 
 static const IDEDMAOps ahci_dma_ops = {
-- 
2.21.3


