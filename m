Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC42208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhWq9+Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC42208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaWI-0006iR-6P
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxaUU-00061m-Ju
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:26:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxaUS-0004PL-SY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:26:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so18779449wrl.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fiWZ7ZCS7JvebFEZ8o5COLaHhu5Dx6oYVhzVUzG7i6A=;
 b=XhWq9+Jid9CfTl0ITutQrW3ZLe/HVTGPwK7yukavpCDmqKkirPZDuSEbJnRcWKfhpw
 0mG8qf5ZwAQugCAZj4rFiQVLoKNEA0OSJo3JAQWCI9v6yXGYAd6+Fk5hH7YNbjW1IbCa
 kXETliOgfBTg3WD8OLi9RB1cUyffpIcKMMWJ/iJibCgmSt8mBR4NRr5kMHwfXelYVaKN
 Tq2Je6NgffnI5dim3gvNwSBivYggpLenhSehFhsX5xA28l1qpGkE6ngJAXDQ5O3c0P68
 urAFFny1i1WFfZg8kWLN8X2HmKLsnS18GffnfEBh8rJJfgdpVx8VGAfsdJP4we2WqeaP
 Rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fiWZ7ZCS7JvebFEZ8o5COLaHhu5Dx6oYVhzVUzG7i6A=;
 b=pfSwvagjWZG+vKWegae2VlcdzdiS7ma3qCS4+ZD/eFOUViREerHBYcl7FoysgAFdH4
 Nc/Cmys1qBXFtUGZPkOYCVicANjjgQM6f0xfwWA7wpctHapWy9W9kOvD3LJ9Xov6ZPfn
 LgMxH9tQqFu8JfI3ko4bdwUifT/X13a3rAjKTyx36i7gHLl6Tbqhrrz9IrNYx5EiT75c
 oam0damGz86C6GpTmIimMe1AkjpdHteK79nUiADxOVf3VcH38ihx7VXaaTHqR4xvcd9d
 s512jtTLsRkSVyRxciJOdLBFgYYu3tHVtyLePQf4rAtO61LZQoozCfP/pKX988cWmdeK
 yFXw==
X-Gm-Message-State: AOAM531Fu59QiW39Rx3fc7a6TMh2Z0UQa/GR3npr6JFsbXGZY6FHAccY
 qjSMaX2EjNtJGeuiVAqtwEDKVDAoFoQ=
X-Google-Smtp-Source: ABdhPJxHLsWV0V8GvTy36Ig1Sxeh6sXPC0eYX+24+8lYVJfZ4Bac5puWtzS+ZnbvepPQ3dhpTiwWdg==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr24410834wru.187.1595269574946; 
 Mon, 20 Jul 2020 11:26:14 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm637932wmb.1.2020.07.20.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 11:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-not-for-5.1?] hw/isa/isa-bus: Ensure ISA I/O regions are
 8/16/32-bit accessible
Date: Mon, 20 Jul 2020 20:26:13 +0200
Message-Id: <20200720182613.10857-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 5d971f9e67 we don't accept mismatching sizes
in memory_region_access_valid(). This gives troubles when
a device is on an ISA bus, because the CPU is free to use
8/16/32-bit accesses on the bus, regardless what range is
valid for the device.

Add a check to ensure devices plugged on the ISA bus can
accept 8/16/32-bits accesses.

Related bug reports:

- https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
- https://bugs.debian.org/964793
- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
- https://bugs.launchpad.net/bugs/1886318

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
MST: I really don't like this approach, I think the ISA bus
     should adjust the access.
---
 hw/isa/isa-bus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 58fde178f9..3d97ad1bdd 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -132,6 +132,17 @@ static inline void isa_init_ioport(ISADevice *dev, uint16_t ioport)
 
 void isa_register_ioport(ISADevice *dev, MemoryRegion *io, uint16_t start)
 {
+    if (io->ops->valid.min_access_size > 1) {
+        /* CPU can always use 8-bit accesses on an ISA bus */
+        error_report("ISA device '%s' requires I/O min_access_size of 1",
+                     object_get_typename(OBJECT(dev)));
+        exit(1);
+    } else if (io->ops->valid.max_access_size < 4) {
+        /* CPU can always use 32-bit accesses on an ISA bus */
+        error_report("ISA device '%s' requires I/O max_access_size of 4",
+                     object_get_typename(OBJECT(dev)));
+        exit(1);
+    }
     memory_region_add_subregion(isabus->address_space_io, start, io);
     isa_init_ioport(dev, start);
 }
-- 
2.21.3


