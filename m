Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D889C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363C620838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lziW4pza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363C620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1PN-0001RJ-E0
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Km-000364-DR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kk-0002gA-Sq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id y12so14659324wrp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwsOKhAW+74BD2GAbdrqNd+j5DzxxpKUr1mlTm/twmU=;
 b=lziW4pza2F6T+QKnv7EF2LTo5wcWsiGfZKFxkkOcfrTNGVeDH3Ug/jwW/gNrDRgfZK
 d3+dOrkVH6ArESqdgE+p1J+TdR85UMubWwUO6fdtaHky+RlTHfsS7IduqKE1KlQ8o19P
 BvAtoalgINGOnbnqwW4PIFMcnCIVqoVjntYex+cuLZRj2fakatGATBX2Z4+054Y6Yxxq
 ee+3Cy+VOwgce/9Q19ed+FumSCheLEcHj92RUwsuzDtM0Bd0xvVvkTiXGlTfKUZt7weo
 xJ4IlVrHC011EgKBCRz3FSgWroaFfdBTnbm1UGezkLZ/7ZhEmThTCxHi/NMFOObGwRS7
 +fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vwsOKhAW+74BD2GAbdrqNd+j5DzxxpKUr1mlTm/twmU=;
 b=sq1qpNQ0ucirleo/BurcSVlhbV3wKgvE8GmhVmVHCJIr6eMK50qDmbQ/efmYmGJP3b
 guEFkGiSoYvQ0fFfHa4WukakCGocL2Mh9DNKKbZjKRY6Sv8lL7xB4jCGuI9KxD1X37ap
 XGwmsn3CJs2sSMXFpmlD5clzfJsxtlvWEGyz8XSA4qBg4RG0nOGn466anYoTYZxEBPbf
 NPNNPHNm2y53vGq5eT5g1MQdbqU78Oe+l3EQ/88k+eRJzzK4RyvGxLrNmncVjwbjbO1N
 St0xCKQWWppB+Gf/i9YcQoprISm8VZdl1c/JxK/suVYQi0EpYZJM+G/5A5j0j0/xsgSw
 wMQA==
X-Gm-Message-State: AOAM533fRxGZIVh9hYtufMJYxBPUTLQw2R6enVoh0lcaaLCtyZxOAK7G
 GCMl0J4ypZQrFuuE/h/H1VEE6NLfPuw=
X-Google-Smtp-Source: ABdhPJys3cOIo3gINMhbNO3UuWTjUtkGT55PGq+YoebOdjTOBR+G6+jqzsFfrD7Jc5srWX0hVA7bxg==
X-Received: by 2002:adf:912e:: with SMTP id j43mr30782924wrj.325.1602522601253; 
 Mon, 12 Oct 2020 10:10:01 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm24200745wmb.5.2020.10.12.10.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:10:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/pci-host/sabre: Remove superfluous address range check
Date: Mon, 12 Oct 2020 19:09:46 +0200
Message-Id: <20201012170950.3491912-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The region is registered as 64KiB in sabre_init():

    memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
                          "sabre-config", 0x10000);

Remove the superfluous check.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 3634f8369b7..0889c9369f6 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -120,7 +120,7 @@ static void sabre_config_write(void *opaque, hwaddr addr,
 
     trace_sabre_config_write(addr, val);
 
-    switch (addr & 0xffff) {
+    switch (addr) {
     case 0x30 ... 0x4f: /* DMA error registers */
         /* XXX: not implemented yet */
         break;
@@ -197,7 +197,7 @@ static uint64_t sabre_config_read(void *opaque,
     SabreState *s = opaque;
     uint32_t val;
 
-    switch (addr & 0xffff) {
+    switch (addr) {
     case 0x30 ... 0x4f: /* DMA error registers */
         val = 0;
         /* XXX: not implemented yet */
-- 
2.26.2


