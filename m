Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC2D22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0olLEB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC2D22CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoCJ-0008P0-48
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5p-0007i9-QX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5i-0003LB-N4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5i-0003KT-He
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id r20so2890090ota.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FcIfcrqIGdpNZl0S22ugT9WUisJdVXVDfqKYhKlZSoQ=;
 b=e0olLEB8tJ0kShDTL0mQ+xOapVASbrWCE4FQKLqYFABiTtfaao7di+g1dRLmN8SObV
 TZKadJcYn3Amx6HUlT6WbqaEjlMsqYRrff1xbE8M6Ygr7W9khHo1xpXp53R2Hf6FSlcL
 DotYWm0Q4F2OsYksBAJKMj6PT7OrZTnVuc+NKhuoR17vW8DbFW68KBxbl5t1X8CWO+Hf
 UZT6Yfu+Gd0QGcIjLdBXIPhzi9mniYXu8eCclI7Wab+SFu7zavvmclQVsmg+vsmtTQcN
 UwmZELG+u8nMeodsAptVFj846vplQyiLJpIIBVWyNFXrPyCD0WV+TwbbZBQfwz/594WJ
 IjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=FcIfcrqIGdpNZl0S22ugT9WUisJdVXVDfqKYhKlZSoQ=;
 b=aUbCNqx99as0ckUVaRLYWNW8UolXCCZrT47otfW/5A2f12giDI2Orh3mxkldFIDSuc
 NzLUAMxz9ho1RkaVjKc2B/UZY/HmqxptWd9w/udm726kF+gyGSsvoylIUSF1+39G+N6T
 3b6mieQvay2oWBw+0+YHDikAPy9fmHtXguCab3fjp2TsXoW/8TOZblFTMNxuHZTK+Sod
 60TMvYprktVFImO2A7iTZ8uzggaMVIQwNscc1s5svVNFq8CQATAms46qa/qqmNbwk7Ny
 SN+g8ZjhF9OCybQ8bxpEeb1IarPwnE9ebWxmNR0x8iwyZqz3j3gyIW3csljsLe3xt9ce
 K/mw==
X-Gm-Message-State: APjAAAWP+3owP5IKwlvVwvrl5ukxRCUYCJCUkALr66p3UY+VoDY/YjyO
 9dZE8W4k9Oz65rfllO+uLpHktug=
X-Google-Smtp-Source: APXvYqyGNG/PZqTsM/XAGPkSNmAhLvJYvDCpyP/YKR0NLgxPK+lzKqzXH1avwwgH0ieBOfbAQrreCQ==
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr13057026otn.171.1566245841747; 
 Mon, 19 Aug 2019 13:17:21 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id i16sm5661752otc.65.2019.08.19.13.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id AC8251805AC;
 Mon, 19 Aug 2019 20:17:17 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 77A6130232A; Mon, 19 Aug 2019 15:17:17 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:59 -0500
Message-Id: <20190819201705.31633-10-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 09/15] ipmi: Allow a size value to be passed
 for I/O space
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

PCI device I/O must be >= 8 bytes in length or they don't work.
Allow the size to be passed in, the default size of 2 or 3
won't work.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bt.c          | 19 +++++++++++++++----
 hw/ipmi/ipmi_kcs.c         | 23 +++++++++++++++++++----
 hw/ipmi/isa_ipmi_bt.c      |  2 +-
 hw/ipmi/isa_ipmi_kcs.c     |  2 +-
 include/hw/ipmi/ipmi.h     |  7 ++++++-
 include/hw/ipmi/ipmi_bt.h  |  1 +
 include/hw/ipmi/ipmi_kcs.h |  1 +
 7 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index e6765ca4f8..22f94fb98d 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -189,7 +189,7 @@ static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
     IPMIBT *ib = iic->get_backend_data(ii);
     uint32_t ret = 0xff;
 
-    switch (addr & 3) {
+    switch (addr & ib->size_mask) {
     case 0:
         ret = ib->control_reg;
         break;
@@ -208,6 +208,9 @@ static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
     case 2:
         ret = ib->mask_reg;
         break;
+    default:
+        ret = 0xff;
+        break;
     }
     return ret;
 }
@@ -230,7 +233,7 @@ static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
-    switch (addr & 3) {
+    switch (addr & ib->size_mask) {
     case 0:
         if (IPMI_BT_GET_CLR_WR(val)) {
             ib->inlen = 0;
@@ -285,6 +288,9 @@ static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
             ipmi_bt_lower_irq(ib);
         }
         break;
+    default:
+        /* Ignore. */
+        break;
     }
 }
 
@@ -346,14 +352,19 @@ static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
     ib->irqs_enabled = val;
 }
 
-static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
+static void ipmi_bt_init(IPMIInterface *ii, unsigned int min_size, Error **errp)
 {
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
+    if (min_size == 0) {
+        min_size = 4;
+    }
+    ib->size_mask = min_size - 1;
     ib->io_length = 3;
 
-    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt", 3);
+    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt",
+                          min_size);
 }
 
 int ipmi_bt_vmstate_post_load(void *opaque, int version)
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index dab1af8bc8..a77612946a 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -232,7 +232,7 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
     IPMIKCS *ik = iic->get_backend_data(ii);
     uint32_t ret;
 
-    switch (addr & 1) {
+    switch (addr & ik->size_mask) {
     case 0:
         ret = ik->data_out_reg;
         IPMI_KCS_SET_OBF(ik->status_reg, 0);
@@ -243,6 +243,7 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
             }
         }
         break;
+
     case 1:
         ret = ik->status_reg;
         if (ik->atn_irq_set) {
@@ -252,6 +253,9 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
             }
         }
         break;
+
+    default:
+        ret = 0xff;
     }
     return ret;
 }
@@ -267,7 +271,7 @@ static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    switch (addr & 1) {
+    switch (addr & ik->size_mask) {
     case 0:
         ik->data_in_reg = val;
         break;
@@ -275,6 +279,10 @@ static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     case 1:
         ik->cmd_reg = val;
         break;
+
+    default:
+        /* Ignore. */
+        break;
     }
     IPMI_KCS_SET_IBF(ik->status_reg, 1);
     ipmi_kcs_signal(ik, ii);
@@ -321,13 +329,20 @@ static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
     ik->irqs_enabled = val;
 }
 
-static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
+/* min_size must be a power of 2. */
+static void ipmi_kcs_init(IPMIInterface *ii, unsigned int min_size,
+                          Error **errp)
 {
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
+    if (min_size == 0) {
+        min_size = 2;
+    }
+    ik->size_mask = min_size - 1;
     ik->io_length = 2;
-    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
+    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs",
+                          min_size);
 }
 
 int ipmi_kcs_vmstate_post_load(void *opaque, int version)
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index c102778712..9a87ffd3f0 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -85,7 +85,7 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     iib->bt.bmc->intf = ii;
     iib->bt.opaque = iib;
 
-    iic->init(ii, errp);
+    iic->init(ii, 0, errp);
     if (*errp)
         return;
 
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 8e32774f85..ca3ea36a3f 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -84,7 +84,7 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     iik->kcs.bmc->intf = ii;
     iik->kcs.opaque = iik;
 
-    iic->init(ii, errp);
+    iic->init(ii, 0, errp);
     if (*errp)
         return;
 
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 70871da0a7..6f2413b39b 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -118,7 +118,12 @@ typedef struct IPMIInterface IPMIInterface;
 typedef struct IPMIInterfaceClass {
     InterfaceClass parent;
 
-    void (*init)(struct IPMIInterface *s, Error **errp);
+    /*
+     * min_size is the requested I/O size and must be a power of 2.
+     * This is so PCI (or other busses) can request a bigger range.
+     * Use 0 for the default.
+     */
+    void (*init)(struct IPMIInterface *s, unsigned int min_size, Error **errp);
 
     /*
      * Perform various operations on the hardware.  If checkonly is
diff --git a/include/hw/ipmi/ipmi_bt.h b/include/hw/ipmi/ipmi_bt.h
index 9667aaa88a..8a4316ea7c 100644
--- a/include/hw/ipmi/ipmi_bt.h
+++ b/include/hw/ipmi/ipmi_bt.h
@@ -56,6 +56,7 @@ typedef struct IPMIBT {
     uint32_t io_base;
     unsigned long io_length;
     MemoryRegion io;
+    unsigned long size_mask;
 
     void (*raise_irq)(struct IPMIBT *ib);
     void (*lower_irq)(struct IPMIBT *ib);
diff --git a/include/hw/ipmi/ipmi_kcs.h b/include/hw/ipmi/ipmi_kcs.h
index 91d76d08f4..6e6ef4c539 100644
--- a/include/hw/ipmi/ipmi_kcs.h
+++ b/include/hw/ipmi/ipmi_kcs.h
@@ -59,6 +59,7 @@ typedef struct IPMIKCS {
     uint32_t io_base;
     unsigned long io_length;
     MemoryRegion io;
+    unsigned long size_mask;
 
     void (*raise_irq)(struct IPMIKCS *ik);
     void (*lower_irq)(struct IPMIKCS *ik);
-- 
2.17.1


