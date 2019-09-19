Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B29208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN7/2o9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B29208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4QQ-0002s1-Gi
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49f-0001Z1-T1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49Y-0006Db-01
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49S-0006C1-9r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id g25so4486150otl.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FcIfcrqIGdpNZl0S22ugT9WUisJdVXVDfqKYhKlZSoQ=;
 b=kN7/2o9D03jyfVfwsavgiTyiXYcyNW8sRl6OzafoArVqj3AzOookWMYd2DqwlQRaiH
 ppYM+xc/jH2mwmDwjDos8KCfMv8C/34a4WW2cefD8YdkJE7osjXxxOWjodzLxSqHvtif
 PP02ShaZLnFfLg3U0e63mkQjzKJpBsWYAi2m5OlKKamtBlfVX2dU/4718BiiXJQNoUS6
 FCWYm+nGWncfmLDLrzT5fCDWwzEKiCeSc6+5iBUPjok39jXelAOIL3Kr3AoJZJb7bsJW
 b7HaAlwCZGiyGYw7Zx0VPiUKvV93RlZGdUV1hSjen0if14MESehaFuMxkREyUlhqByw/
 3QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=FcIfcrqIGdpNZl0S22ugT9WUisJdVXVDfqKYhKlZSoQ=;
 b=VldzhyX7naJ4WPNkpnawbSy7Hy+R2ASKLrdifX39cx+Br52Ps6mCLaC7bzXQOSJU62
 GgrHmSl//AVAstQTbfqCpfzhhT2MH4taHrUyB5/FvEYMnW5nK4G31p/lYq9s18OBrWtm
 WHxZhm0w5TMaJHOUI6BGuN+nAPgrK7dPsz6Y5x4ex1yRTXu82Ik62n+rBhqqDYZpCD33
 TEF3nowRZO9LlOyV9uSsw9M/G0981NA9DjJfx4/oGHFGlERLiTJWdI8Ve5FozRAW7/je
 0LS2CCRzGb7PuNpPB6JHUWkGlKSwCBMhldVniQlF592c91Auf6iUDoegRmkT5FGVmrd/
 xsxA==
X-Gm-Message-State: APjAAAVAiJxjhNRg4wCAEgQFnTZ0vcK/c+GSw3i3hAUYSmpqjvWq0X3p
 x3m1l2FLRmp5aNOktxOvqg==
X-Google-Smtp-Source: APXvYqxiFLyFY+o48vbm299gHXPWa27uVdt3yg15qm0GzO96vexGrxFJ/Ph0hzb/x4IZvacYhxn3pw==
X-Received: by 2002:a05:6830:1d6c:: with SMTP id
 l12mr8885792oti.140.1568929185358; 
 Thu, 19 Sep 2019 14:39:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id g129sm32949oib.50.2019.09.19.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id D13901805A1;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 09/15] ipmi: Allow a size value to be passed for I/O space
Date: Thu, 19 Sep 2019 16:39:18 -0500
Message-Id: <20190919213924.31852-10-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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


