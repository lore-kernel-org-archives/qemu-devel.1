Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE0C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1932083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWmvBL6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1932083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh9O-000055-WD
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5c-0002hX-FR; Sun, 11 Oct 2020 15:33:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5a-0006sD-UN; Sun, 11 Oct 2020 15:33:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id j136so15335478wmj.2;
 Sun, 11 Oct 2020 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WNozgBziJzkT1dGIty7aG0vAuuPyLVJMvqy8EJgjQmQ=;
 b=DWmvBL6IRfp99BX6ScEK2l7vWxbpQihjtrvIHXvb7k3RF3C5Ld1HPgFjhmstZkGXhU
 Gg9/IGJVL6vwxFl5E31OeToshS0ktziFNXtKXJ9+YLvSEKHnAnB4xlq4AYNHdiGnweYz
 +NicU+1RVd4SfQJNrCCLwBWX9oZ1WP75uQs04t0G8PF3gEvN1v2gRMbSQIS+Q0Vv6Wx9
 jaNewj+2pmQgC9Fa2ICcnwdC8Ov4izfSfFr4L+zEzi/ozMcgCcB6YWmXqYmvLXNZ1bZl
 f/NyMPUgFcH+1Kgqf792g2uRmj5F7lr89zdVSs+/sHXnoAKd2rBIcoCTcQqTmADg+A9H
 ssEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WNozgBziJzkT1dGIty7aG0vAuuPyLVJMvqy8EJgjQmQ=;
 b=mMG0Y0lK9Mgo1/NrnS477iIuT63VIGycPjTZPaJIFGvcx03ct0bnmO7cdOa4M+yA2Y
 s8Huph9F5li8q3KRZia2rbpwU4Yi7jUqSeJrV7A3XA7N36KJtrODzByUD06H5wFAZ0uD
 lIhWmqA0NRpy01+xyzRpjazetJPTr8UyIOe0uknIvkzI+AI0n1Cm2E95Tg+EVjtdxdMI
 5wyzgr5VEim6Mv/aT4SJDHdlzRghHIewu3Ak9nAvofdoZ009W9hxkaT67QRGyEmqODi7
 elktNoWtUkey7BJmhY5hh1244Zkl08ra+yIcr2xgHHmL04U1AICzU6QJo1UKIX7YmBpK
 8XuA==
X-Gm-Message-State: AOAM5328RgDU7b0zsx9yzuMzcWyrqV2wKJV5KDfDPwXWeSwlJZGRLDX+
 cMOL4WtNZ6EwIIFCbdWFcXJ+VSj0pEQ=
X-Google-Smtp-Source: ABdhPJz6AmeuRpZSCDikDKC2ojYg88N8DYb0MNlaB6nGe34OruJt1e0b/fQxXy+WKu6hXrNPAKi73A==
X-Received: by 2002:a1c:a5c4:: with SMTP id o187mr7716393wme.171.1602444780053; 
 Sun, 11 Oct 2020 12:33:00 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k18sm3380247wrx.96.2020.10.11.12.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] hw/isa: Add the ISA_IRQ_FDC_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:24 +0200
Message-Id: <20201011193229.3210774-6-f4bug@amsat.org>
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

The floppy disk controller uses IRQ #6 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/block/fdc.c       | 4 ++--
 hw/sparc64/sun4u.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e4f2aed004f..214a6730598 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -12,6 +12,7 @@ enum IsaIrqNumber {
     ISA_IRQ_KBD_DEFAULT =  1,
     ISA_IRQ_SER_DEFAULT =  4,
     ISA_IRQ_TPM_DEFAULT =  5,
+    ISA_IRQ_FDC_DEFAULT =  6,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4c2c35e223a..531fc4c0b72 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2855,7 +2855,7 @@ static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
     aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
-    aml_append(crs, aml_irq_no_flags(6));
+    aml_append(crs, aml_irq_no_flags(ISA_IRQ_FDC_DEFAULT));
     aml_append(crs,
         aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
 
@@ -2889,7 +2889,7 @@ static const VMStateDescription vmstate_isa_fdc ={
 
 static Property isa_fdc_properties[] = {
     DEFINE_PROP_UINT32("iobase", FDCtrlISABus, iobase, 0x3f0),
-    DEFINE_PROP_UINT32("irq", FDCtrlISABus, irq, 6),
+    DEFINE_PROP_UINT32("irq", FDCtrlISABus, irq, ISA_IRQ_FDC_DEFAULT),
     DEFINE_PROP_UINT32("dma", FDCtrlISABus, dma, 2),
     DEFINE_PROP_DRIVE("driveA", FDCtrlISABus, state.qdev_for_drives[0].blk),
     DEFINE_PROP_DRIVE("driveB", FDCtrlISABus, state.qdev_for_drives[1].blk),
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6e42467d5cc..458dc215e6f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -613,7 +613,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     /* Wire up "well-known" ISA IRQs to PBM legacy obio IRQs */
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 7,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_LPT_IRQ));
-    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 6,
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_FDC_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_FDD_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_KBD_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_KBD_IRQ));
-- 
2.26.2


