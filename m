Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8E722482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0qIH5ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8E722482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxazn-00014R-Tw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxazE-0000e7-HB
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:58:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxazC-0000H3-W8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:58:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id q15so526934wmj.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CNb0bok8A2GvYk4uLFq3HwZGJ739nczlW4+FlSKYeSo=;
 b=o0qIH5irZhHh1htoa8MO0cDyotelKeyMw3yk5v7fbpRjPXAVxBYHbGauc7MtCSJV5x
 EFWFLJyqLdoOpxEKmUq+APL6RFBdiZg25ODdSf/IPg57s8htO02+ehrXj/L0kASqRtfE
 s6q5VrLHqgptRxYu8U8CDs+amamKXpaejHh70AFWpuInTAMQO+LujidcVu3yWzSDgBhh
 r3q2bzblglyp4v08gEmoM4e0pILCXXmeo7F2xKBHppDOqL9yhBZF7mKFku4QIRWHGh08
 9/IZP4tv1ODBQ+scZTSsUJvGP+74RFJeP7J+ja9TlsNdoWwCwL7B731zKCg9/SiEVWVy
 Cn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CNb0bok8A2GvYk4uLFq3HwZGJ739nczlW4+FlSKYeSo=;
 b=N/CYY9BgRRZzf7V9HH88O7vD77/H5UjE0G1++TyTHgbams61OTg2zq7MKFlnWgs3u6
 N+h4YNRuvlKg4ROGl1Uxp2K/yJ5uWz1lxJk19f4rmYDb1Y42ZAJP+N79b4aAKHyG7mnn
 qGnUpEFc3C8Ox9JTw4Etabl2vDBiXLYpVk8gXKooBUNILWyg/tt0LGmHwQjrQF4YDsHn
 a2QuMjISpw3lfBhg+itdjcJKxjGSY5zEqYtDiqLOcFrBS1vdutULHxtaHGc7/AANidUL
 FAyM1/63fbVtwaeohK0mqYcCOH913qjeZAFYQ45QGcM0VV7+np3LUV8gwucMKFDjOMnM
 dYOQ==
X-Gm-Message-State: AOAM530kyzpz+hkpHz0mmzc/aFVggKNjVKgoztY+zCEBW1to5OpqpxY6
 hfqNNGjfgn1IZyGyt5aRea223p38tQg=
X-Google-Smtp-Source: ABdhPJxVaQtYACLXyYSRAlq/31SyzZQsxQnh2AMkwhyDYq9PBDcl+J9HvlrCivV1jdKMehXCht5zbw==
X-Received: by 2002:a1c:7f0e:: with SMTP id a14mr663334wmd.21.1595271481153;
 Mon, 20 Jul 2020 11:58:01 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 129sm490256wmd.48.2020.07.20.11.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 11:58:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-not-for-5.1? v2] hw/isa/isa-bus: Ensure ISA I/O regions
 are 8/16-bit accessible
Date: Mon, 20 Jul 2020 20:57:58 +0200
Message-Id: <20200720185758.21280-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 5d971f9e67 we don't accept mismatching sizes
in memory_region_access_valid(). This gives troubles when
a device is on an ISA bus, because the CPU is free to use
8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
regardless what range is valid for the device.

Add a check to ensure devices plugged on the ISA bus can
accept 8/16-bits accesses.

Related bug reports:

- https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
- https://bugs.debian.org/964793
- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
- https://bugs.launchpad.net/bugs/1886318

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
MST: I really don't like this approach, I think the ISA bus
     should adjust the access.

since v1: only 8/16-bit accesses enforced
---
 hw/isa/isa-bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 58fde178f9..e142eeef06 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -132,6 +132,20 @@ static inline void isa_init_ioport(ISADevice *dev, uint16_t ioport)
 
 void isa_register_ioport(ISADevice *dev, MemoryRegion *io, uint16_t start)
 {
+    if (io->ops->valid.min_access_size > 1) {
+        /*
+         * To be backward compatible with IBM-PC bus, ISA bus must accept
+         * 8-bit accesses.
+         */
+        error_report("ISA device '%s' requires I/O min_access_size of 1 (byte)",
+                     object_get_typename(OBJECT(dev)));
+        exit(1);
+    } else if (io->ops->valid.max_access_size < 2) {
+        /* ISA bus must accept 16-bit accesses (EISA accepts 32-bit) */
+        error_report("ISA device '%s' requires I/O max_access_size of "
+                     "at least 2 (bytes)", object_get_typename(OBJECT(dev)));
+        exit(1);
+    }
     memory_region_add_subregion(isabus->address_space_io, start, io);
     isa_init_ioport(dev, start);
 }
-- 
2.21.3


