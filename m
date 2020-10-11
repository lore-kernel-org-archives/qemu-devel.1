Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FDC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE37D2083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glKKe2Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE37D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhA3-0000wx-UK
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5w-0003CF-4K; Sun, 11 Oct 2020 15:33:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5u-0006w8-Jd; Sun, 11 Oct 2020 15:33:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id t9so16558142wrq.11;
 Sun, 11 Oct 2020 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=76wJgIrqTSi0DDRrVUiOHwWarPfXaZKRh0PO2TH3Udg=;
 b=glKKe2MexCos8D4mlixBOKwOdTUN6RsBj1DiGhj3sc3TpL0PkRI2uq5EjQlyvJmlae
 GvVDZ+GpYX5iCitruMHihden4WKXVDfnzaesPSu/g45rxInn3hIQyLttEipiSCPO6beZ
 Rka9pIp9eni2aQCBduBCn9bnIkxH1U4CxO8GPLoVcMcj0Z3spMiLZkDVjJkhWuaLYzVR
 iIKGjsTW1Gn4/fYVTJ6/njhBtjGANDnhSa5LGV8or1Zs+gsEez9b8vKfA336eleFnG6F
 zO9PeT6SeIdQ477zmubsj1gBY4YmQvviCgU5qSg8N7GLmtZ5Mh27nxlPCtD6p712Psr9
 klww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=76wJgIrqTSi0DDRrVUiOHwWarPfXaZKRh0PO2TH3Udg=;
 b=OrWZgDto75eVOU9weg/fP7+0q5xcdi9/No49gqWUSdPGnOAuLAsE41FFmDNgrWuBOr
 f5lq+INPlStclfevTXoc/CPyX2iOdzVkkZ39YcPwd5rW3Gg23+kw4ITFuu+MFb4KWHRz
 JmdEkFcIgCczX2RQCwwVwYhXa85fxzJCDd+rkX7DEEvqI7QNOidXl6tFkpjZcRL5LVkx
 IZzMAC9KZ85Kx5muDfAgQGCZ0uyayc5ITq1LJOCs/wrNDL7u92TKKNq5EBdgIuh774R1
 5hk+DXk15ngylhHM6HrUL8hx30a4qUM8Co+on389Zy+qNHSH4VyNeYDs0SUBzP0TW5bF
 PmSA==
X-Gm-Message-State: AOAM533zi39oB8KfW/Y/Vk8DXwn30s2rTSQW8ff8766LTd10hNB4yBOu
 VQp19HQHaYbPyCMc85z0szXrqlT5a8A=
X-Google-Smtp-Source: ABdhPJzO9f2oN+VJQaGJdLE0ijcw7BO3YppTUBTPgvef2k2DlR+3vVWdWVgaMP9no0LDs/RazXUMQA==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr877669wrp.258.1602444800147; 
 Sun, 11 Oct 2020 12:33:20 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t5sm21663725wrb.21.2020.10.11.12.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:33:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] hw/isa: Add the ISA_IRQ_MOU_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:28 +0200
Message-Id: <20201011193229.3210774-10-f4bug@amsat.org>
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

The PS2 mouse uses IRQ #12 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/input/pckbd.c     | 2 +-
 hw/sparc64/sun4u.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 11166592246..43cdc3c47b6 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -16,6 +16,7 @@ enum IsaIrqNumber {
     ISA_IRQ_PAR_DEFAULT =  7,
     ISA_IRQ_RTC_DEFAULT =  8,
     ISA_IRQ_NET_DEFAULT =  9,
+    ISA_IRQ_MOU_DEFAULT = 12,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index dde85ba6c68..140c992b03b 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -577,7 +577,7 @@ static void i8042_build_aml(ISADevice *isadev, Aml *scope)
     aml_append(kbd, aml_name_decl("_CRS", crs));
 
     crs = aml_resource_template();
-    aml_append(crs, aml_irq_no_flags(12));
+    aml_append(crs, aml_irq_no_flags(ISA_IRQ_MOU_DEFAULT));
 
     mou = aml_device("MOU");
     aml_append(mou, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c5b3e838ac2..ddd51c7cbbe 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -617,7 +617,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_FDD_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_KBD_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_KBD_IRQ));
-    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 12,
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_MOU_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_MSE_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_SER_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_SER_IRQ));
-- 
2.26.2


