Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76540C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8E2083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyhEDrzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh6s-0004Po-2m
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5M-0002Ks-Cq; Sun, 11 Oct 2020 15:32:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5K-0006rA-Re; Sun, 11 Oct 2020 15:32:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id n18so16576106wrs.5;
 Sun, 11 Oct 2020 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KNrZ+qtKi0zNMWfipUbnBZPxCaUXk1d2Q2TEnE3E2xk=;
 b=qyhEDrzJeDz52xoatSi74sFpVvUSxTWSOg9vhzvqcWGcIYm++zmA0hTZIWyOrg3tKX
 BUhSMsCPhUf5mYYl+jYALWSWBU/iWa+d12aUl1Q0R+mkdIs2IZKv9xbAO7zdWX6UCmKJ
 G9MBdkQuccs3QUov9AQa9KQWMhbh8hLZ3QOPeTny4n5o50W1suF8b93sNcWadmHcIvF9
 R3xNufZsnx+n+nd4c+iRhj8c56xU7CL7VwwXgcQh8cQYTyShr/vpq8kiUZglqKQk5CUI
 J02wJh357SsHTZPuV2XogXyQabSmXTLbbkgvYCoriswBxjePnSQYJLkxA5IbSFVUEQ54
 Gq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KNrZ+qtKi0zNMWfipUbnBZPxCaUXk1d2Q2TEnE3E2xk=;
 b=ty9d3ySWVQj2fIwIA+TDLWrKaeIykdkdkXNQd5W6yC7mKCXr7DIoG2WX3l1nW2AEh6
 qrZv2IMYPm1/MygD8DIGoIQGpe/6Bu+1N6IHZsLk14pi46VvGxezHuZGF5+p7YHJpKaF
 7WT8mBQX7X8LC8g4ejixd1HznDNkfnQjmG57YKFHU/zG+bM+mBYOQR+c/QQRGuBIxOXM
 1tcAaCwhFM4YImjT/tCOSJtn6FyGRTamZqSozVzWiTjKccUnfjy97ihCGoV8riv4eRB3
 aTiMgGEjBfVjW7pRlZYxiIxkS7J28H/45Pq35F1bCNkxHMQnMCZ+hN8TbIX9inwGrAT3
 dDZQ==
X-Gm-Message-State: AOAM5332p5H8edBYJwTArCWSloSnMEDIwEQHumj3LCX/99jgiN8wrSWx
 kXehBdq/uJeu8ciZoQH+Gyh44muzSqI=
X-Google-Smtp-Source: ABdhPJyWUKibpQ3WuPa7rpong1wHY4Bi5G98qh48QJpelYdlg+Inl4jBHACkMDF6xUAJ/M05PA+UTw==
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr1270365wrk.226.1602444764214; 
 Sun, 11 Oct 2020 12:32:44 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 64sm1625675wmd.3.2020.10.11.12.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] hw/isa: Add the ISA_IRQ_KBD_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:21 +0200
Message-Id: <20201011193229.3210774-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

The PS2 keyboard uses IRQ #1 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/sparc64/sun4u.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 2a052ffa025..e139b88c992 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -9,6 +9,7 @@
 #include "qom/object.h"
 
 enum IsaIrqNumber {
+    ISA_IRQ_KBD_DEFAULT =  1,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index ad5ca2472a4..d4c39490cd9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -615,7 +615,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_LPT_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 6,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_FDD_IRQ));
-    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 1,
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", ISA_IRQ_KBD_DEFAULT,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_KBD_IRQ));
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 12,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_MSE_IRQ));
-- 
2.26.2


