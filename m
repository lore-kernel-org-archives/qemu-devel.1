Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0313D2145D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC1slaEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhA4-0000vb-12
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5g-0002l5-Rj; Sun, 11 Oct 2020 15:33:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5f-0006sl-B5; Sun, 11 Oct 2020 15:33:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id f21so15212466wml.3;
 Sun, 11 Oct 2020 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T47fdn4RxOEr/33O8p4c1fGY3UD39OWzHlO0HGQUKaU=;
 b=mC1slaEerXeh3/utyzoo5ACyMyf3Uyzu0ByT32VzXV0ZAGOzsxTHm59fCAreGa37sB
 s9sy5HEqF+6m5iiyTUz1BchC6JRy7vrxUJ/VV+CB6hjMekOdQd1Vua2HlbTO9lzdhLjy
 BzNKy6oZ67uRWx+nHvKq0YeJP+lMte3UNFHQE/pW9rbUH90pblr83VgFvVkgQbnycvlG
 x8KQVx/pwjPO75dQ0MjwTQjqeDWrSMMmRDMPZL1MhFXGYpyzxBvTG3xQvk0ifLluGF8R
 5tmJ+eqt0zVF83s3mukbRsCKIFN4pA//5wi7REfSH7FiWyAI+5Bzw7H6Xyih1AM7Mzhz
 bU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T47fdn4RxOEr/33O8p4c1fGY3UD39OWzHlO0HGQUKaU=;
 b=LxGct3xMQLpiBWnQdCZRXoMxMCcaAlJh8139VLLGB8XlB0y4Pi0k0174J3/yF0NsSP
 dA2bIi5PbzDqBg/uqtJwh4L4FzwifTRO7YoMFNJYgkx2oGyGGARlnQhMFn869QkylDO0
 o+8QIqSr5K7kr8qlEMpYH2FpiXUA3oZ0WE/fI85yarMs7CkuX7ZiXUBck33rR/3kXex4
 HeoEslCTiS9zzVBbIlk0ypYuEcFEHcdADV473Q3JfhCmMzBBXGJtS4V4TL9i8Un9l9ye
 IZgR5bwubQ6Dj/vqPVxzGSRk2LmqmnjhO2X7R3UnYMBBQncSEzTSdrK310vElKMw3bXP
 Nd3A==
X-Gm-Message-State: AOAM531jW06n5yRZp1NcBRXnUWVS0jAbnUpVq9vfUylsU8eWzmDIneBQ
 ZHU8C2Y2nJxINykStz1MXnM8G7F9tzo=
X-Google-Smtp-Source: ABdhPJz2DOe4Z1/29V0nxb/owBp2f0xdwN7f8+GhaG+tphVo+1QSQfP243Li5kkzVC/ofYRDjbJtlg==
X-Received: by 2002:a05:600c:210f:: with SMTP id
 u15mr8170317wml.53.1602444785001; 
 Sun, 11 Oct 2020 12:33:05 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm21770729wrt.82.2020.10.11.12.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:33:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] hw/isa: Add the ISA_IRQ_PAR_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:25 +0200
Message-Id: <20201011193229.3210774-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
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

The parallel port uses IRQ #7 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/char/parallel.c   | 2 +-
 hw/sparc64/sun4u.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 214a6730598..081fa446152 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -13,6 +13,7 @@ enum IsaIrqNumber {
     ISA_IRQ_SER_DEFAULT =  4,
     ISA_IRQ_TPM_DEFAULT =  5,
     ISA_IRQ_FDC_DEFAULT =  6,
+    ISA_IRQ_PAR_DEFAULT =  7,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8b418abf719..9e0d80ec0d0 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -636,7 +636,7 @@ bool parallel_mm_init(MemoryRegion *address_space,
 static Property parallel_isa_properties[] = {
     DEFINE_PROP_UINT32("index", ISAParallelState, index,   -1),
     DEFINE_PROP_UINT32("iobase", ISAParallelState, iobase,  -1),
-    DEFINE_PROP_UINT32("irq",   ISAParallelState, isairq,  7),
+    DEFINE_PROP_UINT32("irq",   ISAParallelState, isairq,  ISA_IRQ_PAR_DEFAULT),
     DEFINE_PROP_CHR("chardev",  ISAParallelState, state.chr),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 458dc215e6f..c5b3e838ac2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -611,7 +611,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_realize_and_unref(ebus, pci_busA, &error_fatal);
 
     /* Wire up "well-known" ISA IRQs to PBM legacy obio IRQs */
-    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 7,
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_PAR_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_LPT_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_FDC_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_FDD_IRQ));
-- 
2.26.2


