Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B00C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299B22071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su/EaZAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299B22071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXqZ-0003DS-Aw
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVXps-0002ip-06
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:56:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVXpr-0003wH-4X
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:56:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so8301270wmc.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W13Wy4KjfD9+hwao4Th2t0zPOqXVh48KYVCPXPEX4mw=;
 b=Su/EaZAY1qaPdtu0EYiXTdNL/DoEzmQXZm2TQSAF9v1HZl/InjW/yZD8RlY5u7yi+W
 Gb8+nTSE8jxeo8PM/y4ecA/meNgveANjmMx8+hOTb04nX/AWCi8hZBwSOPDzW6A9OD6L
 dkmm3+iCxrx+CLSaQB8kzg6RJWNPQbxxGKRlARi8R8OTzBaAWZGsyKDf/wZCy1Xl/wry
 oMNzGSC4lfRIsvIe0VItagTdnTpFJRflpEn6qJXTx4qonrA1+CbonwVmBmf26yv2sLAU
 h6IKd3QBnwow+gWfeeY1D7Jq5yTxg8LHZtKq2Q4SJdGwTMOgaOyGNX4IrDoRb0Ln8TyV
 itVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=W13Wy4KjfD9+hwao4Th2t0zPOqXVh48KYVCPXPEX4mw=;
 b=nxMI/KPb5hdRFAiEwx1oKNDENelDinEWJCPk5k0yniDXFZbPQRFzyqSgYxajdltPVY
 1D3f38dIqwzyyaxFbwWSkjZww5PxnhENGSO4cZAg5qMacAlSIp3YPCq5vMs8ThyIRswG
 AP2Hm3AR8et5qepCmSngjcnTESU5OM9xDHS+7px36LiE+q1cyE6QhaHK3oTEmE+gPj5Z
 6MgQUEZOd1GoV7dgYRYFmYHETVfeiI1o/q9PvGB9EjuqJlO4KzinoqyAkmIf8kGCV4/M
 t31UgizEl+BvuVfLXUcAxQAZPB7EG1oKpcws62GM834AGGPiAh2nGKaaNU20LsrKJwpG
 870w==
X-Gm-Message-State: AGi0PuYfODMJuiCNTAMNxisCETf2T91+326Y5XeTarGl7bxg+TQ213yJ
 hjMAN79UoH7jkBfVvzh0iO0ysf2g
X-Google-Smtp-Source: APiQypIMwquopydQlpMk/LvIcrwZhBJtjl4xTPuISfGEynXmkbBSiF37brdA5etafsxzLRN+04ylDw==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr13441711wmk.109.1588586185150; 
 Mon, 04 May 2020 02:56:25 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id b4sm17545873wrv.42.2020.05.04.02.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:56:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/char/parallel: Convert reset handler to DeviceReset
Date: Mon,  4 May 2020 11:56:23 +0200
Message-Id: <20200504095623.7252-1-f4bug@amsat.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As TYPE_ISA_PARALLEL inherits from TYPE_ISA_DEVICE, it also
inherits from the DEVICE methods. Convert its reset handler
into a proper DeviceReset method.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/parallel.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8dd67d1375..f68a96da8e 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -523,6 +523,13 @@ static int parallel_can_receive(void *opaque)
      return 1;
 }
 
+static void parallel_isa_reset(DeviceState *dev)
+{
+    ISAParallelState *isa = ISA_PARALLEL(dev);
+
+    parallel_reset(&isa->state);
+}
+
 static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
 {
     static int index;
@@ -552,7 +559,6 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
 
     base = isa->iobase;
     isa_init_irq(isadev, &s->irq, isa->isairq);
-    qemu_register_reset(parallel_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, parallel_can_receive, NULL,
                              NULL, NULL, s, NULL, true);
@@ -625,6 +631,7 @@ static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = parallel_isa_reset;
     dc->realize = parallel_isa_realizefn;
     dc->vmsd = &vmstate_parallel_isa;
     device_class_set_props(dc, parallel_isa_properties);
-- 
2.21.3


