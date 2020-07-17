Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB26FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859820704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U++a87U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859820704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLC8-0001IL-R9
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLBK-0000KB-QM; Fri, 17 Jul 2020 03:53:22 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:34987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLBJ-0003X0-Ad; Fri, 17 Jul 2020 03:53:22 -0400
Received: by mail-ej1-x629.google.com with SMTP id rk21so9810536ejb.2;
 Fri, 17 Jul 2020 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FJ1tf4qbatTndPOfdRaDTzxz07OMiFLDimu/y/P84Ic=;
 b=U++a87U1PTL3GJYC1xLptgbfTx2iKXVXgRaGqdbLdlGVdNkmFPiJW44Ne3byC+Y0tJ
 zjblfzzwdCkT203gbS3mmnKXkulEA0UWIZ6oNuYCd56fGOPfnaYhGtl+GUDOOO01PFeg
 KRo8N5N+0n+eCP5768RkWjeL9d+HjLJi1v83yt+y5tmUURx/LoCMYGWsHVc2JmFMwWs7
 DX3Bu2ssM7ON8SwBHFR7Avd237qtVqv01UAfLWV0pjcjjkFLwobdNBpkJMtrqPhT8gIq
 WjgaPGjsDyuTv5mQLPRpGGLhfpgZcei2UYE9aqDz0G34Fts5IAiunjXK4gpuC18V2RHe
 t5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FJ1tf4qbatTndPOfdRaDTzxz07OMiFLDimu/y/P84Ic=;
 b=CsUy+I5A/2YpIUd5BmYl66yTXDJO0TcjkOxqELQ8TfM5HFCK06ecx12cxznTTHS4zV
 3KDDFNHky55nA9c9S4pst1HxNpsbZ3n65HuOE7ZyvSKQZQ40ACJpBEY87YBTugMYaf98
 Yk6lK7CYh0FKX3YUL9/j4FaY0xlrrFLfpG7Em5ZM+OJSMrR4CiaWmO2xfRq4vv7gqfJ0
 HoZtNfykRlSiFs2HNHIGCYsLodBcCvFLk/HH7MrvVF7HYyeSZORcxU7LushlqcthL/DK
 C1bU/NHxqqWUvxKuXwxU9gmN1twB1YP2qRauZlYBfE2xg/md8PsaJ2iQ93VHnADW1Af5
 EITA==
X-Gm-Message-State: AOAM5313utLT3GqmnP/3z5pZO2xfdld8Ey/N9ZUPgAiE6TtYTMt+dvjT
 eOCCsIrpoebvDzKy77bXQFapvI0DR2Y=
X-Google-Smtp-Source: ABdhPJyYAca6loWPnP0DWMzeZAOl0879XcYScF0iDOKK5FFPsa2nad7tMCU25VsLedjNy83S05DABQ==
X-Received: by 2002:a17:906:5f98:: with SMTP id
 a24mr7187547eju.241.1594972399239; 
 Fri, 17 Jul 2020 00:53:19 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id lm22sm7044918ejb.109.2020.07.17.00.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 00:53:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1 v2] hw/ide: Cancel pending DMA requests before
 setting as inactive
Date: Fri, 17 Jul 2020 09:53:17 +0200
Message-Id: <20200717075317.5376-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer found a case where requests are queued for later in the
AIO context, but a command set the bus inactive, then when finally
the requests are processed by the DMA it aborts because it is
inactive:

 include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.

Reproducer available on the BugLink.

Fix by draining the pending DMA requests before inactivating the bus.

BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I don't have much clue about block drive and IDE,
so block-team please be very careful while reviewing this bug.
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..f7affafb0c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -804,7 +804,7 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
 
 void ide_set_inactive(IDEState *s, bool more)
 {
-    s->bus->dma->aiocb = NULL;
+    ide_cancel_dma_sync(s);
     ide_clear_retry(s);
     if (s->bus->dma->ops->set_inactive) {
         s->bus->dma->ops->set_inactive(s->bus->dma, more);
-- 
2.21.3


