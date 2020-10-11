Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424B52083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz+5gg1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424B52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhCr-0003cc-6P
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5R-0002WT-Hn; Sun, 11 Oct 2020 15:32:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5Q-0006rS-1y; Sun, 11 Oct 2020 15:32:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so16270999wrm.13;
 Sun, 11 Oct 2020 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0jpaxMymalQzJe7nkt3fK37nWgDJARQE9RMKxlzHDKI=;
 b=uz+5gg1wHDtPr/S5ORv4Td1PAh5DSIAfCQWuFHeFFoQsmiwviFwUO9X+mxPY4AcYvY
 dhEklevtq1PXGH+HkTxJ3yLLf65URD5rG/8a9FTAiShuYX4A5SYs+Zpqy8/3fNWflOhW
 fFtuldLo4fTV2TxhVgyaoxqkIYIocYWAKRKzwdax30CpjGi1oRo3ojqEFiby0OlDJjZr
 KtFy4Kq9WsGkvJUD6QfCL643E3hjiQvlQJ/121uiF/CEdiDItNOXUMYwBoE4wAv803Zo
 txC9m71bcSEWbXa3lSSaSve+AU8z6U8MKvjtXyToez1LfPTD3pMY9McEdi+ujrY0blKX
 yO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0jpaxMymalQzJe7nkt3fK37nWgDJARQE9RMKxlzHDKI=;
 b=lwZkdqlCkKQvUYkBOFoNkhyrMy3CxiLF1oVrjkYKiY+hGY1f5ecfmGHpLvCKlavv3a
 RIB66SyhtLZRNuFl1C3p5YrEUOTxdl7qyYqI9Git4//tL3fVyhd78Kn7P75ZMFO+t10B
 +6u/E/O5ul8jxtNuFgkFeYoGIRq7YLTbRjYF6RzmoDPzkWCuRgLQxINm3VmA8VlXJlq2
 f6v4wMKCo7VJc71IYuif3YPXAz6ekZgJN+n0fJJyVVRQ8ixPCdeq8h34IKC5KLJW0nl/
 gyITn2IntvPylUSvSP1JOYGSV9W+zdej2ShVG3L1berSLV31zuLjg7ZP9D3EKTR7+CG2
 XkFA==
X-Gm-Message-State: AOAM533QC5mXLAp03cN8Po7owt82QAuQVfYE4RtOcKU1mruoHdSXz2Ca
 jB2fDkky7px+Y/hXnbZDqnG85kqhm/k=
X-Google-Smtp-Source: ABdhPJzhnI81QO4NuG8+dCiW+MMDXBui58TatPQ8g+Lc44KzsdSlLSS4QaC7ExFGWP3IQSy0YyDHJQ==
X-Received: by 2002:adf:bacc:: with SMTP id w12mr16965624wrg.66.1602444769499; 
 Sun, 11 Oct 2020 12:32:49 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a81sm23030618wmf.32.2020.10.11.12.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] hw/isa: Add the ISA_IRQ_SER_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:22 +0200
Message-Id: <20201011193229.3210774-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first serial port uses IRQ #4 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/sparc64/sun4u.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e139b88c992..519296d5823 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -10,6 +10,7 @@
 
 enum IsaIrqNumber {
     ISA_IRQ_KBD_DEFAULT =  1,
+    ISA_IRQ_SER_DEFAULT =  4,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d4c39490cd9..6e42467d5cc 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -619,7 +619,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_KBD_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 12,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_MSE_IRQ));
-    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 4,
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_SER_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_SER_IRQ));
 
     switch (vga_interface_type) {
-- 
2.26.2


