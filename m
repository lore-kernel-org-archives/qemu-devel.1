Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39088C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B1820732
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3KxYLcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B1820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3yP-0008Kt-QE
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tl-0001S6-9h; Sat, 12 Sep 2020 07:40:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tj-0000U9-MS; Sat, 12 Sep 2020 07:40:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id k15so13889912wrn.10;
 Sat, 12 Sep 2020 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N67Bz+24f+wBD0rV7TEX/Zf0E80v4TcJaPqWQArNwlY=;
 b=r3KxYLcuUvV5lUkpg0Lhq85OYjCS6HCUPCKAyTSuwAFh/TbyHTeg+AOdnAR471PXKD
 FYgYUHnNUdTY8qvDpV+9dGGJWirGICJb/W4BZ+4IBU4QOFihaqAYhEBhJ0v1t8xOVaQT
 sBZ4zrKX7uHgKVizIIVHLKziLKKHDsmq6NrSzpKiUWO03xS0rGUIzSTUcBNyrxUCNFOk
 FHAoV3iB4+E0Jv2pkbBbLTnN/DG8H0gpYHDrcAGSpHhA3+im3Rwg2CLreea48VxGx9Zn
 wOmsC1gT3HQgZO9SN0myyI8+uP89MPTQoktWAMzwzKM80RcgAHyaQw4//UovpiqH65ep
 55FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N67Bz+24f+wBD0rV7TEX/Zf0E80v4TcJaPqWQArNwlY=;
 b=qqQhAZKFty78Oo7kERnzVee3YLxu0mTPFLY32tbdLZyILvAxKGnpFx4Gs9EJCnCai6
 UvTAifcMVNtPUrdOp7As004V9bFua5o9qx40nxNzc49bYf9JQOk7kYHGtSiBJIaYQl4x
 +PGIEhZlMkwu62tEjW2K8E0nPJqGSDX7stHiFxbfRn5qg6NJEIBXuZTFF3UndNnShlj6
 ibjgrzXhJTxWAprLalEmROhFjqsRVYISHjxYgP7CfqovHRNj6nCBFXP3OrEocANuVrzN
 IGOFgkXlMKc9xVEi9gzeLztiCyF9U3tZ95xcuTLRGJuAUC0VGK9f3B9oTWOf59uiDv5S
 jz/Q==
X-Gm-Message-State: AOAM531szLuwNmlKmm6GmOzesqsWSSUk1C1flL94KU2KqSk7pi9l8BDq
 Cy5CpttAmw25oc9+OTGfPbw=
X-Google-Smtp-Source: ABdhPJzZAm4pWL8H6baPYXXgcOzlWCXgOnzB4LqyQPJZG6W+h6+NwoQLRu18srNripdb1hp2adChEA==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr7020429wrr.390.1599910850109; 
 Sat, 12 Sep 2020 04:40:50 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] hw/char/serial: Alias QDEV properties from generic
 serial object
Date: Sat, 12 Sep 2020 13:40:39 +0200
Message-Id: <20200912114040.918464-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of overwritting the properties of the generic 'state'
object, alias them.
Note we can now propagate the "baudbase" property (except on
the PCI multi-UART device).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial-isa.c | 4 ++--
 hw/char/serial-pci.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 7e1b36c3f67..c0607476c22 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -118,8 +118,6 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
-    DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -140,6 +138,8 @@ static void serial_isa_initfn(Object *o)
     ISASerialState *self = ISA_SERIAL(o);
 
     object_initialize_child(o, "serial", &self->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&self->state), o);
 }
 
 static const TypeInfo serial_isa_info = {
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index f68948154e0..81da2783f9e 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -84,7 +84,6 @@ static const VMStateDescription vmstate_pci_serial = {
 };
 
 static Property serial_pci_properties[] = {
-    DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -109,6 +108,8 @@ static void serial_pci_init(Object *o)
     PCISerialState *ps = PCI_SERIAL(o);
 
     object_initialize_child(o, "serial", &ps->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&ps->state), o);
 }
 
 static const TypeInfo serial_pci_info = {
-- 
2.26.2


