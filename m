Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D53C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612DA218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvVcZVEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612DA218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4U9-00077V-W1
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49f-0001Z0-S1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49R-0006C4-VX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49R-0006BA-6J
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id g25so4486110otl.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8rVa9CFTYqJ95fuPu+QB6hOLbcYInouzovgeRrSODuo=;
 b=mvVcZVEdrItYKdmJKrYyGWmNRJVXmDbRQTs4nQUpZ7Jvb3kLbqKO6kyDczMMikrGaM
 Jl0M3gEZOL6AVgaDilFHANJAeKnuznq8f4d7SrIMg6dYd/p5fVOn6mGQH759LzlG6fTb
 oZ8FQC3Jmr7lWz1iMFOr5H8jLjKQdmAI/CP0U6VR913mahxAr7c4eRVo4cxH7rC4jy+m
 KcEIHG/70QfS7qTv/6a+XUkaKP6BE3DWNVLIOTE9TzRlXjLWZMb9b2jH954uVYbWFhpU
 ExrqfOGXQAEVasfGtyAK6ZLFyVclg9KjDAfvvNkZyrWPeDV5zGFX0GqiacB6CtxWSPk2
 EiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8rVa9CFTYqJ95fuPu+QB6hOLbcYInouzovgeRrSODuo=;
 b=ZSnJiz2w4WfZri9EVFfXzNoy7/wkFIuq4EANZnn1ngHP0qqsYdJ9iK7oAxUNfelHT+
 8Jss2PjDXl+dTD/PLTIcXAYUkmSXRe7mqI6gFlX3SmFxcTu8KmwgMTcz5v2YlA55I7Js
 b/VAew1jCz0oOik0YFOZ0Rugz89pTdiO1B1eW5refO+2sBNUoBBi983LRQ3uwwTEJY2M
 xLSyAtLjOnMbnDCP64df4b4+5zGd3hG9/YBQpp3EQl4FarGl6O7L90J4KDyFqe9sQEzW
 jR7Kqtrrgh5NeGsB7uYrERra+iiewhh0Q7h0d834fTiTTHVMNw/wkFIWOgDd/lE+PpjL
 OjZw==
X-Gm-Message-State: APjAAAWMMGsEpxIZ/bJyWTI5AIq6m5B50kKkbR+hpOn98bJjeCL9m6bA
 BwSKVCtjA5PNgLmYjDlq0g==
X-Google-Smtp-Source: APXvYqyMcCQ06/DBrZfFypYoY0oQMLHY9YPp24vioNDJLj2QOZQ4OLbj2Qz3nxtvS1HDHjKXe8BuVA==
X-Received: by 2002:a05:6830:134b:: with SMTP id
 r11mr4365530otq.154.1568929183699; 
 Thu, 19 Sep 2019 14:39:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id o184sm40134oia.28.2019.09.19.14.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 7B1301805A0;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/15] ipmi: Split out KCS-specific code from ISA KCS code
Date: Thu, 19 Sep 2019 16:39:16 -0500
Message-Id: <20190919213924.31852-8-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

Get ready for PCI and other KCS interfaces.

No functional changes, just split the code into the generic KCS code
and the ISA-specific code.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ipmi/Makefile.objs      |   2 +-
 hw/ipmi/ipmi_kcs.c         | 408 ++++++++++++++++++++++++++++++++++++
 hw/ipmi/isa_ipmi_kcs.c     | 417 ++-----------------------------------
 include/hw/ipmi/ipmi_kcs.h |  75 +++++++
 4 files changed, 505 insertions(+), 397 deletions(-)
 create mode 100644 hw/ipmi/ipmi_kcs.c
 create mode 100644 include/hw/ipmi/ipmi_kcs.h

diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 1b422bbee0..6835d2f64a 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o
+common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o
 common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
 common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
 common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
new file mode 100644
index 0000000000..dab1af8bc8
--- /dev/null
+++ b/hw/ipmi/ipmi_kcs.c
@@ -0,0 +1,408 @@
+/*
+ * QEMU IPMI KCS emulation
+ *
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_kcs.h"
+
+#define IPMI_KCS_OBF_BIT        0
+#define IPMI_KCS_IBF_BIT        1
+#define IPMI_KCS_SMS_ATN_BIT    2
+#define IPMI_KCS_CD_BIT         3
+
+#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
+#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
+#define IPMI_KCS_SET_OBF(d, v)     (d) = (((d) & ~IPMI_KCS_OBF_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_OBF_BIT))
+#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
+#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
+#define IPMI_KCS_SET_IBF(d, v)     (d) = (((d) & ~IPMI_KCS_IBF_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_IBF_BIT))
+#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
+#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x1)
+#define IPMI_KCS_SET_SMS_ATN(d, v) (d) = (((d) & ~IPMI_KCS_SMS_ATN_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_SMS_ATN_BIT))
+#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
+#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
+#define IPMI_KCS_SET_CD(d, v)      (d) = (((d) & ~IPMI_KCS_CD_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_CD_BIT))
+
+#define IPMI_KCS_IDLE_STATE        0
+#define IPMI_KCS_READ_STATE        1
+#define IPMI_KCS_WRITE_STATE       2
+#define IPMI_KCS_ERROR_STATE       3
+
+#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
+#define IPMI_KCS_SET_STATE(d, v) ((d) = ((d) & ~0xc0) | (((v) & 0x3) << 6))
+
+#define IPMI_KCS_ABORT_STATUS_CMD       0x60
+#define IPMI_KCS_WRITE_START_CMD        0x61
+#define IPMI_KCS_WRITE_END_CMD          0x62
+#define IPMI_KCS_READ_CMD               0x68
+
+#define IPMI_KCS_STATUS_NO_ERR          0x00
+#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
+#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
+#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
+
+static void ipmi_kcs_raise_irq(IPMIKCS *ik)
+{
+    if (ik->use_irq && ik->irqs_enabled && ik->raise_irq) {
+        ik->raise_irq(ik);
+    }
+}
+
+static void ipmi_kcs_lower_irq(IPMIKCS *ik)
+{
+    if (ik->lower_irq) {
+        ik->lower_irq(ik);
+    }
+}
+
+#define SET_OBF() \
+    do {                                                                      \
+        IPMI_KCS_SET_OBF(ik->status_reg, 1);                                  \
+        if (!ik->obf_irq_set) {                                               \
+            ik->obf_irq_set = 1;                                              \
+            if (!ik->atn_irq_set) {                                           \
+                ipmi_kcs_raise_irq(ik);                                  \
+            }                                                                 \
+        }                                                                     \
+    } while (0)
+
+static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    ik->do_wake = 1;
+    while (ik->do_wake) {
+        ik->do_wake = 0;
+        iic->handle_if_event(ii);
+    }
+}
+
+static void ipmi_kcs_handle_event(IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (ik->cmd_reg == IPMI_KCS_ABORT_STATUS_CMD) {
+        if (IPMI_KCS_GET_STATE(ik->status_reg) != IPMI_KCS_ERROR_STATE) {
+            ik->waiting_rsp++; /* Invalidate the message */
+            ik->outmsg[0] = IPMI_KCS_STATUS_ABORTED_ERR;
+            ik->outlen = 1;
+            ik->outpos = 0;
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+            SET_OBF();
+        }
+        goto out;
+    }
+
+    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
+    case IPMI_KCS_IDLE_STATE:
+        if (ik->cmd_reg == IPMI_KCS_WRITE_START_CMD) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
+            ik->cmd_reg = -1;
+            ik->write_end = 0;
+            ik->inlen = 0;
+            SET_OBF();
+        }
+        break;
+
+    case IPMI_KCS_READ_STATE:
+    handle_read:
+        if (ik->outpos >= ik->outlen) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
+            SET_OBF();
+        } else if (ik->data_in_reg == IPMI_KCS_READ_CMD) {
+            ik->data_out_reg = ik->outmsg[ik->outpos];
+            ik->outpos++;
+            SET_OBF();
+        } else {
+            ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
+            ik->outlen = 1;
+            ik->outpos = 0;
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+            SET_OBF();
+            goto out;
+        }
+        break;
+
+    case IPMI_KCS_WRITE_STATE:
+        if (ik->data_in_reg != -1) {
+            /*
+             * Don't worry about input overrun here, that will be
+             * handled in the BMC.
+             */
+            if (ik->inlen < sizeof(ik->inmsg)) {
+                ik->inmsg[ik->inlen] = ik->data_in_reg;
+            }
+            ik->inlen++;
+        }
+        if (ik->write_end) {
+            IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
+            ik->outlen = 0;
+            ik->write_end = 0;
+            ik->outpos = 0;
+            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
+                               ik->waiting_rsp);
+            goto out_noibf;
+        } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
+            ik->cmd_reg = -1;
+            ik->write_end = 1;
+        }
+        SET_OBF();
+        break;
+
+    case IPMI_KCS_ERROR_STATE:
+        if (ik->data_in_reg != -1) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
+            ik->data_in_reg = IPMI_KCS_READ_CMD;
+            goto handle_read;
+        }
+        break;
+    }
+
+    if (ik->cmd_reg != -1) {
+        /* Got an invalid command */
+        ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
+        ik->outlen = 1;
+        ik->outpos = 0;
+        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+    }
+
+ out:
+    ik->cmd_reg = -1;
+    ik->data_in_reg = -1;
+    IPMI_KCS_SET_IBF(ik->status_reg, 0);
+ out_noibf:
+    return;
+}
+
+static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
+                                unsigned char *rsp, unsigned int rsp_len)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (ik->waiting_rsp == msg_id) {
+        ik->waiting_rsp++;
+        if (rsp_len > sizeof(ik->outmsg)) {
+            ik->outmsg[0] = rsp[0];
+            ik->outmsg[1] = rsp[1];
+            ik->outmsg[2] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
+            ik->outlen = 3;
+        } else {
+            memcpy(ik->outmsg, rsp, rsp_len);
+            ik->outlen = rsp_len;
+        }
+        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
+        ik->data_in_reg = IPMI_KCS_READ_CMD;
+        ipmi_kcs_signal(ik, ii);
+    }
+}
+
+
+static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+    uint32_t ret;
+
+    switch (addr & 1) {
+    case 0:
+        ret = ik->data_out_reg;
+        IPMI_KCS_SET_OBF(ik->status_reg, 0);
+        if (ik->obf_irq_set) {
+            ik->obf_irq_set = 0;
+            if (!ik->atn_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+        break;
+    case 1:
+        ret = ik->status_reg;
+        if (ik->atn_irq_set) {
+            ik->atn_irq_set = 0;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+        break;
+    }
+    return ret;
+}
+
+static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
+        return;
+    }
+
+    switch (addr & 1) {
+    case 0:
+        ik->data_in_reg = val;
+        break;
+
+    case 1:
+        ik->cmd_reg = val;
+        break;
+    }
+    IPMI_KCS_SET_IBF(ik->status_reg, 1);
+    ipmi_kcs_signal(ik, ii);
+}
+
+const MemoryRegionOps ipmi_kcs_io_ops = {
+    .read = ipmi_kcs_ioport_read,
+    .write = ipmi_kcs_ioport_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
+    if (val) {
+        if (irq && !ik->atn_irq_set) {
+            ik->atn_irq_set = 1;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_raise_irq(ik);
+            }
+        }
+    } else {
+        if (ik->atn_irq_set) {
+            ik->atn_irq_set = 0;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+    }
+}
+
+static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    ik->irqs_enabled = val;
+}
+
+static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    ik->io_length = 2;
+    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
+}
+
+int ipmi_kcs_vmstate_post_load(void *opaque, int version)
+{
+    IPMIKCS *ik = opaque;
+
+    /* Make sure all the values are sane. */
+    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
+        ik->outpos >= ik->outlen) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:kcs: vmstate transfer received bad out values: %d %d\n",
+                      ik->outpos, ik->outlen);
+        ik->outpos = 0;
+        ik->outlen = 0;
+    }
+
+    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:kcs: vmstate transfer received bad in value: %d\n",
+                      ik->inlen);
+        ik->inlen = 0;
+    }
+
+    return 0;
+}
+
+static bool vmstate_kcs_before_version2(void *opaque, int version)
+{
+    return version <= 1;
+}
+
+const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .post_load = ipmi_kcs_vmstate_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
+        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
+        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
+        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
+        VMSTATE_UINT32(outpos, IPMIKCS),
+        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
+        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_BOOL(write_end, IPMIKCS),
+        VMSTATE_UINT8(status_reg, IPMIKCS),
+        VMSTATE_UINT8(data_out_reg, IPMIKCS),
+        VMSTATE_INT16(data_in_reg, IPMIKCS),
+        VMSTATE_INT16(cmd_reg, IPMIKCS),
+        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info)
+{
+    info->interface_name = "kcs";
+    info->interface_type = IPMI_SMBIOS_KCS;
+    info->ipmi_spec_major_revision = 2;
+    info->ipmi_spec_minor_revision = 0;
+    info->base_address = ik->io_base;
+    info->i2c_slave_address = ik->bmc->slave_addr;
+    info->register_length = ik->io_length;
+    info->register_spacing = 1;
+    info->memspace = IPMI_MEMSPACE_IO;
+    info->irq_type = IPMI_LEVEL_IRQ;
+}
+
+void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
+{
+    iic->init = ipmi_kcs_init;
+    iic->set_atn = ipmi_kcs_set_atn;
+    iic->handle_rsp = ipmi_kcs_handle_rsp;
+    iic->handle_if_event = ipmi_kcs_handle_event;
+    iic->set_irq_enable = ipmi_kcs_set_irq_enable;
+}
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 374b2a0709..8e32774f85 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -1,7 +1,7 @@
 /*
  * QEMU ISA IPMI KCS emulation
  *
- * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -26,338 +26,12 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
+#include "hw/ipmi/ipmi_kcs.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
-#define IPMI_KCS_OBF_BIT        0
-#define IPMI_KCS_IBF_BIT        1
-#define IPMI_KCS_SMS_ATN_BIT    2
-#define IPMI_KCS_CD_BIT         3
-
-#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
-#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
-#define IPMI_KCS_SET_OBF(d, v)     (d) = (((d) & ~IPMI_KCS_OBF_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_OBF_BIT))
-#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
-#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
-#define IPMI_KCS_SET_IBF(d, v)     (d) = (((d) & ~IPMI_KCS_IBF_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_IBF_BIT))
-#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
-#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x1)
-#define IPMI_KCS_SET_SMS_ATN(d, v) (d) = (((d) & ~IPMI_KCS_SMS_ATN_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_SMS_ATN_BIT))
-#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
-#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
-#define IPMI_KCS_SET_CD(d, v)      (d) = (((d) & ~IPMI_KCS_CD_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_CD_BIT))
-
-#define IPMI_KCS_IDLE_STATE        0
-#define IPMI_KCS_READ_STATE        1
-#define IPMI_KCS_WRITE_STATE       2
-#define IPMI_KCS_ERROR_STATE       3
-
-#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
-#define IPMI_KCS_SET_STATE(d, v) ((d) = ((d) & ~0xc0) | (((v) & 0x3) << 6))
-
-#define IPMI_KCS_ABORT_STATUS_CMD       0x60
-#define IPMI_KCS_WRITE_START_CMD        0x61
-#define IPMI_KCS_WRITE_END_CMD          0x62
-#define IPMI_KCS_READ_CMD               0x68
-
-#define IPMI_KCS_STATUS_NO_ERR          0x00
-#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
-#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
-#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
-
-typedef struct IPMIKCS {
-    IPMIBmc *bmc;
-
-    bool do_wake;
-
-    qemu_irq irq;
-
-    uint32_t io_base;
-    unsigned long io_length;
-    MemoryRegion io;
-
-    bool obf_irq_set;
-    bool atn_irq_set;
-    bool use_irq;
-    bool irqs_enabled;
-
-    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t outpos;
-    uint32_t outlen;
-
-    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t inlen;
-    bool write_end;
-
-    uint8_t status_reg;
-    uint8_t data_out_reg;
-
-    int16_t data_in_reg; /* -1 means not written */
-    int16_t cmd_reg;
-
-    /*
-     * This is a response number that we send with the command to make
-     * sure that the response matches the command.
-     */
-    uint8_t waiting_rsp;
-} IPMIKCS;
-
-#define SET_OBF() \
-    do {                                                                      \
-        IPMI_KCS_SET_OBF(ik->status_reg, 1);                                  \
-        if (ik->use_irq && ik->irqs_enabled && !ik->obf_irq_set) {            \
-            ik->obf_irq_set = 1;                                              \
-            if (!ik->atn_irq_set) {                                           \
-                qemu_irq_raise(ik->irq);                                      \
-            }                                                                 \
-        }                                                                     \
-    } while (0)
-
-static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-
-    ik->do_wake = 1;
-    while (ik->do_wake) {
-        ik->do_wake = 0;
-        iic->handle_if_event(ii);
-    }
-}
-
-static void ipmi_kcs_handle_event(IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (ik->cmd_reg == IPMI_KCS_ABORT_STATUS_CMD) {
-        if (IPMI_KCS_GET_STATE(ik->status_reg) != IPMI_KCS_ERROR_STATE) {
-            ik->waiting_rsp++; /* Invalidate the message */
-            ik->outmsg[0] = IPMI_KCS_STATUS_ABORTED_ERR;
-            ik->outlen = 1;
-            ik->outpos = 0;
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-            SET_OBF();
-        }
-        goto out;
-    }
-
-    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
-    case IPMI_KCS_IDLE_STATE:
-        if (ik->cmd_reg == IPMI_KCS_WRITE_START_CMD) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
-            ik->cmd_reg = -1;
-            ik->write_end = 0;
-            ik->inlen = 0;
-            SET_OBF();
-        }
-        break;
-
-    case IPMI_KCS_READ_STATE:
-    handle_read:
-        if (ik->outpos >= ik->outlen) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
-            SET_OBF();
-        } else if (ik->data_in_reg == IPMI_KCS_READ_CMD) {
-            ik->data_out_reg = ik->outmsg[ik->outpos];
-            ik->outpos++;
-            SET_OBF();
-        } else {
-            ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
-            ik->outlen = 1;
-            ik->outpos = 0;
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-            SET_OBF();
-            goto out;
-        }
-        break;
-
-    case IPMI_KCS_WRITE_STATE:
-        if (ik->data_in_reg != -1) {
-            /*
-             * Don't worry about input overrun here, that will be
-             * handled in the BMC.
-             */
-            if (ik->inlen < sizeof(ik->inmsg)) {
-                ik->inmsg[ik->inlen] = ik->data_in_reg;
-            }
-            ik->inlen++;
-        }
-        if (ik->write_end) {
-            IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
-            ik->outlen = 0;
-            ik->write_end = 0;
-            ik->outpos = 0;
-            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
-                               ik->waiting_rsp);
-            goto out_noibf;
-        } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
-            ik->cmd_reg = -1;
-            ik->write_end = 1;
-        }
-        SET_OBF();
-        break;
-
-    case IPMI_KCS_ERROR_STATE:
-        if (ik->data_in_reg != -1) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
-            ik->data_in_reg = IPMI_KCS_READ_CMD;
-            goto handle_read;
-        }
-        break;
-    }
-
-    if (ik->cmd_reg != -1) {
-        /* Got an invalid command */
-        ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
-        ik->outlen = 1;
-        ik->outpos = 0;
-        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-    }
-
- out:
-    ik->cmd_reg = -1;
-    ik->data_in_reg = -1;
-    IPMI_KCS_SET_IBF(ik->status_reg, 0);
- out_noibf:
-    return;
-}
-
-static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-                                unsigned char *rsp, unsigned int rsp_len)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (ik->waiting_rsp == msg_id) {
-        ik->waiting_rsp++;
-        if (rsp_len > sizeof(ik->outmsg)) {
-            ik->outmsg[0] = rsp[0];
-            ik->outmsg[1] = rsp[1];
-            ik->outmsg[2] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
-            ik->outlen = 3;
-        } else {
-            memcpy(ik->outmsg, rsp, rsp_len);
-            ik->outlen = rsp_len;
-        }
-        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
-        ik->data_in_reg = IPMI_KCS_READ_CMD;
-        ipmi_kcs_signal(ik, ii);
-    }
-}
-
-
-static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-    uint32_t ret;
-
-    switch (addr & 1) {
-    case 0:
-        ret = ik->data_out_reg;
-        IPMI_KCS_SET_OBF(ik->status_reg, 0);
-        if (ik->obf_irq_set) {
-            ik->obf_irq_set = 0;
-            if (!ik->atn_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-        break;
-    case 1:
-        ret = ik->status_reg;
-        if (ik->atn_irq_set) {
-            ik->atn_irq_set = 0;
-            if (!ik->obf_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-        break;
-    }
-    return ret;
-}
-
-static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
-                                  unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
-        return;
-    }
-
-    switch (addr & 1) {
-    case 0:
-        ik->data_in_reg = val;
-        break;
-
-    case 1:
-        ik->cmd_reg = val;
-        break;
-    }
-    IPMI_KCS_SET_IBF(ik->status_reg, 1);
-    ipmi_kcs_signal(ik, ii);
-}
-
-const MemoryRegionOps ipmi_kcs_io_ops = {
-    .read = ipmi_kcs_ioport_read,
-    .write = ipmi_kcs_ioport_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
-    if (val) {
-        if (irq && !ik->atn_irq_set && ik->use_irq && ik->irqs_enabled) {
-            ik->atn_irq_set = 1;
-            if (!ik->obf_irq_set) {
-                qemu_irq_raise(ik->irq);
-            }
-        }
-    } else {
-        if (ik->atn_irq_set) {
-            ik->atn_irq_set = 0;
-            if (!ik->obf_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-    }
-}
-
-static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    ik->irqs_enabled = val;
-}
-
-static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    ik->io_length = 2;
-    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
-}
-
 #define TYPE_ISA_IPMI_KCS "isa-ipmi-kcs"
 #define ISA_IPMI_KCS(obj) OBJECT_CHECK(ISAIPMIKCSDevice, (obj), \
                                        TYPE_ISA_IPMI_KCS)
@@ -365,36 +39,32 @@ static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
 typedef struct ISAIPMIKCSDevice {
     ISADevice dev;
     int32_t isairq;
+    qemu_irq irq;
     IPMIKCS kcs;
     uint32_t uuid;
 } ISAIPMIKCSDevice;
 
-static void ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
+static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
 {
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
 
-    info->interface_name = "kcs";
-    info->interface_type = IPMI_SMBIOS_KCS;
-    info->ipmi_spec_major_revision = 2;
-    info->ipmi_spec_minor_revision = 0;
-    info->base_address = iik->kcs.io_base;
-    info->i2c_slave_address = iik->kcs.bmc->slave_addr;
-    info->register_length = iik->kcs.io_length;
-    info->register_spacing = 1;
-    info->memspace = IPMI_MEMSPACE_IO;
-    info->irq_type = IPMI_LEVEL_IRQ;
+    ipmi_kcs_get_fwinfo(&iik->kcs, info);
     info->interrupt_number = iik->isairq;
     info->uuid = iik->uuid;
 }
 
-static void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
+static void isa_ipmi_kcs_raise_irq(IPMIKCS *ik)
 {
-    iic->init = ipmi_kcs_init;
-    iic->set_atn = ipmi_kcs_set_atn;
-    iic->handle_rsp = ipmi_kcs_handle_rsp;
-    iic->handle_if_event = ipmi_kcs_handle_event;
-    iic->set_irq_enable = ipmi_kcs_set_irq_enable;
-    iic->get_fwinfo = ipmi_kcs_get_fwinfo;
+    ISAIPMIKCSDevice *iik = ik->opaque;
+
+    qemu_irq_raise(iik->irq);
+}
+
+static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
+{
+    ISAIPMIKCSDevice *iik = ik->opaque;
+
+    qemu_irq_lower(iik->irq);
 }
 
 static void ipmi_isa_realize(DeviceState *dev, Error **errp)
@@ -412,14 +82,17 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     iik->uuid = ipmi_next_uuid();
 
     iik->kcs.bmc->intf = ii;
+    iik->kcs.opaque = iik;
 
     iic->init(ii, errp);
     if (*errp)
         return;
 
     if (iik->isairq > 0) {
-        isa_init_irq(isadev, &iik->kcs.irq, iik->isairq);
+        isa_init_irq(isadev, &iik->irq, iik->isairq);
         iik->kcs.use_irq = 1;
+        iik->kcs.raise_irq = isa_ipmi_kcs_raise_irq;
+        iik->kcs.lower_irq = isa_ipmi_kcs_lower_irq;
     }
 
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
@@ -427,60 +100,11 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
 }
 
-static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
-{
-    IPMIKCS *ik = opaque;
-
-    /* Make sure all the values are sane. */
-    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
-        ik->outpos >= ik->outlen) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "ipmi:kcs: vmstate transfer received bad out values: %d %d\n",
-                      ik->outpos, ik->outlen);
-        ik->outpos = 0;
-        ik->outlen = 0;
-    }
-
-    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "ipmi:kcs: vmstate transfer received bad in value: %d\n",
-                      ik->inlen);
-        ik->inlen = 0;
-    }
-
-    return 0;
-}
-
 static bool vmstate_kcs_before_version2(void *opaque, int version)
 {
     return version <= 1;
 }
 
-static const VMStateDescription vmstate_IPMIKCS = {
-    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
-    .version_id = 2,
-    .minimum_version_id = 1,
-    .post_load = ipmi_kcs_vmstate_post_load,
-    .fields      = (VMStateField[]) {
-        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
-        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
-        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
-        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
-        VMSTATE_UINT32(outpos, IPMIKCS),
-        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
-        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
-        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
-        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
-        VMSTATE_BOOL(write_end, IPMIKCS),
-        VMSTATE_UINT8(status_reg, IPMIKCS),
-        VMSTATE_UINT8(data_out_reg, IPMIKCS),
-        VMSTATE_INT16(data_in_reg, IPMIKCS),
-        VMSTATE_INT16(cmd_reg, IPMIKCS),
-        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 2,
@@ -531,6 +155,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
 
     iic->get_backend_data = isa_ipmi_kcs_get_backend_data;
     ipmi_kcs_class_init(iic);
+    iic->get_fwinfo = isa_ipmi_kcs_get_fwinfo;
 }
 
 static const TypeInfo isa_ipmi_kcs_info = {
diff --git a/include/hw/ipmi/ipmi_kcs.h b/include/hw/ipmi/ipmi_kcs.h
new file mode 100644
index 0000000000..91d76d08f4
--- /dev/null
+++ b/include/hw/ipmi/ipmi_kcs.h
@@ -0,0 +1,75 @@
+/*
+ * QEMU IPMI KCS emulation
+ *
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_IPMI_KCS_H
+#define HW_IPMI_KCS_H
+
+#include "hw/ipmi/ipmi.h"
+
+typedef struct IPMIKCS {
+    IPMIBmc *bmc;
+
+    bool do_wake;
+
+    bool obf_irq_set;
+    bool atn_irq_set;
+    bool irqs_enabled;
+
+    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t outpos;
+    uint32_t outlen;
+
+    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t inlen;
+    bool write_end;
+
+    uint8_t status_reg;
+    uint8_t data_out_reg;
+
+    int16_t data_in_reg; /* -1 means not written */
+    int16_t cmd_reg;
+
+    /*
+     * This is a response number that we send with the command to make
+     * sure that the response matches the command.
+     */
+    uint8_t waiting_rsp;
+
+    uint32_t io_base;
+    unsigned long io_length;
+    MemoryRegion io;
+
+    void (*raise_irq)(struct IPMIKCS *ik);
+    void (*lower_irq)(struct IPMIKCS *ik);
+    void *opaque;
+
+    bool use_irq;
+} IPMIKCS;
+
+void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info);
+void ipmi_kcs_class_init(IPMIInterfaceClass *iic);
+extern const VMStateDescription vmstate_IPMIKCS;
+int ipmi_kcs_vmstate_post_load(void *opaque, int version);
+
+#endif /* HW_IPMI_KCS_H */
-- 
2.17.1


