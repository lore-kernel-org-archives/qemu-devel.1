Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B0C4CED0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B72222BD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvWyjs77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B72222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4iG-0006HQ-HQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49t-0001g3-QV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49h-0006Fz-1Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49f-0006Cc-Rs
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id 67so4471096oto.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HuIlwjKgrYEWVysrX6UaajuLncKSjIW4O4CwrkB0y4Y=;
 b=PvWyjs77AR/GCV9MoxR3KPs9pIIv64biuBt1NPwYGTVmt52LKUc2wtyl8h4bpE+QQb
 A3c0tRd0OvozF6tefKImb8Ta3DdbzefYTgHbGy7fAn6+LsDk81jU33EpLHKcvnan+nAo
 hCOCCfEvrdI1U+a7U6UtZafdL3ezGNFniWrwVLAHuc0MMcUkpr33zK4kwmZLllBPcwJ2
 wUTMK3OyvXlPCYQiCofiKfc5BWznugqH52OUTUL6vZFFv5z7tNpMegpRi3hrEQBuy1uH
 QyD82N9kTRzfeOAO8I3AS8oohx3VL7rd1cBEaYNlFYaNpDokBGKBqI3ZR3yOlQOI3Qzd
 ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HuIlwjKgrYEWVysrX6UaajuLncKSjIW4O4CwrkB0y4Y=;
 b=cX5IQB5klOZMauwlhiNfVY/ayT0A35jd7E5peZZwrc5TUzdE/2xJ3xf57hgI4qXTwi
 G/bh7k+tDi5Lefd4jbFikuVV8vJiax3R2YP0ragVEtTG5mL6eHSU6lbRHN5J3peUStnb
 9LRCovOuu2d/P5+HuPyw+mXz5JH66G7s1dzXrIJgJ1YOG7Wclnu5B1cVJEV9NLrjrhpm
 wKkmevQ6z6yOA6pyyX5LtCXZLB9lc8gTOQySBJ3J6ZdemE/vGERnkOvDcaSY72Z62IX0
 dWEwUK3tTlG6FwEOtdCtTEfEOWEQFKLtQym5SBDlGa3AZ5rQYnQqmnbrkgGPlpxA2g/t
 0WNw==
X-Gm-Message-State: APjAAAV8azjykqOYPyk9c03ZL4Lz7ZLZMFnbjglk8Ft2OWa+lwRhf4p4
 GU+AP5Z8tMS/V4q4DUCkgg==
X-Google-Smtp-Source: APXvYqyeIX6yy/oitmkSzrYZnNOmZuVIEqGRE18sOrLz8zikNST3+a16geQfsdRQqUuN9TGAqft37Q==
X-Received: by 2002:a9d:962:: with SMTP id 89mr4800417otp.261.1568929186957;
 Thu, 19 Sep 2019 14:39:46 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id e9sm29432oie.58.2019.09.19.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 560DD1805A3;
 Thu, 19 Sep 2019 21:39:37 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 12/15] ipmi: Add an SMBus IPMI interface
Date: Thu, 19 Sep 2019 16:39:21 -0500
Message-Id: <20190919213924.31852-13-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 default-configs/i386-softmmu.mak |   1 +
 hw/i386/Kconfig                  |   1 +
 hw/ipmi/Kconfig                  |   5 +
 hw/ipmi/Makefile.objs            |   1 +
 hw/ipmi/smbus_ipmi.c             | 384 +++++++++++++++++++++++++++++++
 5 files changed, 392 insertions(+)
 create mode 100644 hw/ipmi/smbus_ipmi.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 2294c0be5a..4229900f57 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -12,6 +12,7 @@
 #CONFIG_ISA_IPMI_KCS=n
 #CONFIG_PCI_IPMI_KCS=n
 #CONFIG_PCI_IPMI_BT=n
+#CONFIG_IPMI_SSIF=n
 #CONFIG_PCI_DEVICES=n
 #CONFIG_PVPANIC=n
 #CONFIG_QXL=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d10f4e3e8b..c5c9d4900e 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,7 @@ config PC
     imply ISA_IPMI_BT
     imply PCI_IPMI_KCS
     imply PCI_IPMI_BT
+    imply IPMI_SSIF
     imply ISA_DEBUG
     imply PARALLEL
     imply PCI_DEVICES
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
index 12db4e81ad..9befd4f422 100644
--- a/hw/ipmi/Kconfig
+++ b/hw/ipmi/Kconfig
@@ -30,3 +30,8 @@ config PCI_IPMI_BT
     bool
     depends on PCI
     select IPMI
+
+config IPMI_SSIF
+    bool
+    depends on I2C
+    select IPMI
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 2d7f080a86..3cca10bc50 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -5,3 +5,4 @@ common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
 common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
 common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
 common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
+common-obj-$(CONFIG_IPMI_SSIF) += smbus_ipmi.o
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
new file mode 100644
index 0000000000..2a9470d9df
--- /dev/null
+++ b/hw/ipmi/smbus_ipmi.c
@@ -0,0 +1,384 @@
+/*
+ * QEMU IPMI SMBus (SSIF) emulation
+ *
+ * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
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
+#include "hw/i2c/smbus_slave.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/ipmi/ipmi.h"
+
+#define TYPE_SMBUS_IPMI "smbus-ipmi"
+#define SMBUS_IPMI(obj) OBJECT_CHECK(SMBusIPMIDevice, (obj), TYPE_SMBUS_IPMI)
+
+#define SSIF_IPMI_REQUEST                       2
+#define SSIF_IPMI_MULTI_PART_REQUEST_START      6
+#define SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE     7
+#define SSIF_IPMI_MULTI_PART_REQUEST_END        8
+#define SSIF_IPMI_RESPONSE                      3
+#define SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE    9
+#define SSIF_IPMI_MULTI_PART_RETRY              0xa
+
+#define MAX_SSIF_IPMI_MSG_SIZE 255
+#define MAX_SSIF_IPMI_MSG_CHUNK 32
+
+#define IPMI_GET_SYS_INTF_CAP_CMD 0x57
+
+typedef struct SMBusIPMIDevice {
+    SMBusDevice parent;
+
+    IPMIBmc *bmc;
+
+    uint8_t outmsg[MAX_SSIF_IPMI_MSG_SIZE];
+    uint32_t outlen;
+    uint32_t currblk;
+
+    /* Holds the SMBUS message currently being sent to the host. */
+    uint8_t outbuf[MAX_SSIF_IPMI_MSG_CHUNK + 1]; /* len + message. */
+    uint32_t outpos;
+
+    uint8_t inmsg[MAX_SSIF_IPMI_MSG_SIZE];
+    uint32_t inlen;
+
+    /*
+     * This is a response number that we send with the command to make
+     * sure that the response matches the command.
+     */
+    uint8_t waiting_rsp;
+
+    uint32_t uuid;
+} SMBusIPMIDevice;
+
+static void smbus_ipmi_handle_event(IPMIInterface *ii)
+{
+    /* No interrupts, so nothing to do here. */
+}
+
+static void smbus_ipmi_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
+                                  unsigned char *rsp, unsigned int rsp_len)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    if (sid->waiting_rsp == msg_id) {
+        sid->waiting_rsp++;
+
+        if (rsp_len > MAX_SSIF_IPMI_MSG_SIZE) {
+            rsp[2] = IPMI_CC_REQUEST_DATA_TRUNCATED;
+            rsp_len = MAX_SSIF_IPMI_MSG_SIZE;
+        }
+        memcpy(sid->outmsg, rsp, rsp_len);
+        sid->outlen = rsp_len;
+        sid->outpos = 0;
+        sid->currblk = 0;
+    }
+}
+
+static void smbus_ipmi_set_atn(IPMIInterface *ii, int val, int irq)
+{
+    /* This is where PEC would go. */
+}
+
+static void smbus_ipmi_set_irq_enable(IPMIInterface *ii, int val)
+{
+}
+
+static void smbus_ipmi_send_msg(SMBusIPMIDevice *sid)
+{
+    uint8_t *msg = sid->inmsg;
+    uint32_t len = sid->inlen;
+    IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(sid->bmc);
+
+    sid->outlen = 0;
+    sid->outpos = 0;
+    sid->currblk = 0;
+
+    if (msg[0] == (IPMI_NETFN_APP << 2) && msg[1] == IPMI_GET_SYS_INTF_CAP_CMD)
+    {
+        /* We handle this ourself. */
+        sid->outmsg[0] = (IPMI_NETFN_APP + 1) << 2;
+        sid->outmsg[1] = msg[1];
+        if (len < 3) {
+            sid->outmsg[2] = IPMI_CC_REQUEST_DATA_LENGTH_INVALID;
+            sid->outlen = 3;
+        } else if ((msg[2] & 0x0f) != 0) {
+            sid->outmsg[2] = IPMI_CC_INVALID_DATA_FIELD;
+            sid->outlen = 3;
+        } else {
+            sid->outmsg[2] = 0;
+            sid->outmsg[3] = 0;
+            sid->outmsg[4] = (2 << 6); /* Multi-part supported. */
+            sid->outmsg[5] = MAX_SSIF_IPMI_MSG_SIZE;
+            sid->outmsg[6] = MAX_SSIF_IPMI_MSG_SIZE;
+            sid->outlen = 7;
+        }
+        return;
+    }
+
+    bk->handle_command(sid->bmc, sid->inmsg, sid->inlen, sizeof(sid->inmsg),
+                       sid->waiting_rsp);
+}
+
+static uint8_t ipmi_receive_byte(SMBusDevice *dev)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+
+    if (sid->outpos >= sizeof(sid->outbuf)) {
+        return 0xff;
+    }
+
+    return sid->outbuf[sid->outpos++];
+}
+
+static int ipmi_load_readbuf(SMBusIPMIDevice *sid)
+{
+    unsigned int block = sid->currblk, pos, len;
+
+    if (sid->outlen == 0) {
+        return -1;
+    }
+
+    if (sid->outlen <= 32) {
+        if (block != 0) {
+            return -1;
+        }
+        sid->outbuf[0] = sid->outlen;
+        memcpy(sid->outbuf + 1, sid->outmsg, sid->outlen);
+        sid->outpos = 0;
+        return 0;
+    }
+
+    if (block == 0) {
+        sid->outbuf[0] = 32;
+        sid->outbuf[1] = 0;
+        sid->outbuf[2] = 1;
+        memcpy(sid->outbuf + 3, sid->outmsg, 30);
+        sid->outpos = 0;
+        return 0;
+    }
+
+    /*
+     * Calculate the position in outmsg.  30 for the first block, 31
+     * for the rest of the blocks.
+     */
+    pos = 30 + (block - 1) * 31;
+
+    if (pos >= sid->outlen) {
+        return -1;
+    }
+
+    len = sid->outlen - pos;
+    if (len > 31) {
+        /* More chunks after this. */
+        len = 31;
+        /* Blocks start at 0 for the first middle transaction. */
+        sid->outbuf[1] = block - 1;
+    } else {
+        sid->outbuf[1] = 0xff; /* End of message marker. */
+    }
+
+    sid->outbuf[0] = len + 1;
+    memcpy(sid->outbuf + 2, sid->outmsg + pos, len);
+    sid->outpos = 0;
+    return 0;
+}
+
+static int ipmi_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+    bool send = false;
+    uint8_t cmd;
+    int ret = 0;
+
+    /* length is guaranteed to be >= 1. */
+    cmd = *buf++;
+    len--;
+
+    /* Handle read request, which don't have any data in the write part. */
+    switch (cmd) {
+    case SSIF_IPMI_RESPONSE:
+        sid->currblk = 0;
+        ret = ipmi_load_readbuf(sid);
+        break;
+
+    case SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE:
+        sid->currblk++;
+        ret = ipmi_load_readbuf(sid);
+        break;
+
+    case SSIF_IPMI_MULTI_PART_RETRY:
+        if (len >= 1) {
+            sid->currblk = buf[0];
+            ret = ipmi_load_readbuf(sid);
+        } else {
+            ret = -1;
+        }
+        break;
+
+    default:
+        break;
+    }
+
+    /* This should be a message write, make the length is there and correct. */
+    if (len >= 1) {
+        if (*buf != len - 1 || *buf > MAX_SSIF_IPMI_MSG_CHUNK) {
+            return -1; /* Bogus message */
+        }
+        buf++;
+        len--;
+    }
+
+    switch (cmd) {
+    case SSIF_IPMI_REQUEST:
+        send = true;
+        /* FALLTHRU */
+    case SSIF_IPMI_MULTI_PART_REQUEST_START:
+        if (len < 2) {
+            return -1; /* Bogus. */
+        }
+        memcpy(sid->inmsg, buf, len);
+        sid->inlen = len;
+        break;
+
+    case SSIF_IPMI_MULTI_PART_REQUEST_END:
+        send = true;
+        /* FALLTHRU */
+    case SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE:
+        if (!sid->inlen) {
+            return -1; /* Bogus. */
+        }
+        if (sid->inlen + len > MAX_SSIF_IPMI_MSG_SIZE) {
+            sid->inlen = 0; /* Discard the message. */
+            return -1; /* Bogus. */
+        }
+        if (len < 32) {
+            /*
+             * Special hack, a multi-part middle that is less than 32 bytes
+             * marks the end of a message.  The specification is fairly
+             * confusing, so some systems to this, even sending a zero
+             * length end message to mark the end.
+             */
+            send = true;
+        }
+        memcpy(sid->inmsg + sid->inlen, buf, len);
+        sid->inlen += len;
+        break;
+    }
+
+    if (send && sid->inlen) {
+        smbus_ipmi_send_msg(sid);
+    }
+
+    return ret;
+}
+
+static const VMStateDescription vmstate_smbus_ipmi = {
+    .name = TYPE_SMBUS_IPMI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(parent, SMBusIPMIDevice),
+        VMSTATE_UINT8(waiting_rsp, SMBusIPMIDevice),
+        VMSTATE_UINT32(outlen, SMBusIPMIDevice),
+        VMSTATE_UINT32(currblk, SMBusIPMIDevice),
+        VMSTATE_UINT8_ARRAY(outmsg, SMBusIPMIDevice, MAX_SSIF_IPMI_MSG_SIZE),
+        VMSTATE_UINT32(outpos, SMBusIPMIDevice),
+        VMSTATE_UINT8_ARRAY(outbuf, SMBusIPMIDevice,
+                            MAX_SSIF_IPMI_MSG_CHUNK + 1),
+        VMSTATE_UINT32(inlen, SMBusIPMIDevice),
+        VMSTATE_UINT8_ARRAY(inmsg, SMBusIPMIDevice, MAX_SSIF_IPMI_MSG_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void smbus_ipmi_realize(DeviceState *dev, Error **errp)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+    IPMIInterface *ii = IPMI_INTERFACE(dev);
+
+    if (!sid->bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    sid->uuid = ipmi_next_uuid();
+
+    sid->bmc->intf = ii;
+}
+
+static void smbus_ipmi_init(Object *obj)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(obj);
+
+    ipmi_bmc_find_and_link(OBJECT(obj), (Object **) &sid->bmc);
+}
+
+static void smbus_ipmi_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    info->interface_name = "smbus";
+    info->interface_type = IPMI_SMBIOS_SSIF;
+    info->ipmi_spec_major_revision = 2;
+    info->ipmi_spec_minor_revision = 0;
+    info->i2c_slave_address = sid->bmc->slave_addr;
+    info->base_address = sid->parent.i2c.address;
+    info->memspace = IPMI_MEMSPACE_SMBUS;
+    info->register_spacing = 1;
+    info->uuid = sid->uuid;
+}
+
+static void smbus_ipmi_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+    SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(oc);
+
+    sc->receive_byte = ipmi_receive_byte;
+    sc->write_data = ipmi_write_data;
+    dc->vmsd = &vmstate_smbus_ipmi;
+    dc->realize = smbus_ipmi_realize;
+    iic->set_atn = smbus_ipmi_set_atn;
+    iic->handle_rsp = smbus_ipmi_handle_rsp;
+    iic->handle_if_event = smbus_ipmi_handle_event;
+    iic->set_irq_enable = smbus_ipmi_set_irq_enable;
+    iic->get_fwinfo = smbus_ipmi_get_fwinfo;
+}
+
+static const TypeInfo smbus_ipmi_info = {
+    .name          = TYPE_SMBUS_IPMI,
+    .parent        = TYPE_SMBUS_DEVICE,
+    .instance_size = sizeof(SMBusIPMIDevice),
+    .instance_init = smbus_ipmi_init,
+    .class_init    = smbus_ipmi_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { }
+    }
+};
+
+static void smbus_ipmi_register_types(void)
+{
+    type_register_static(&smbus_ipmi_info);
+}
+
+type_init(smbus_ipmi_register_types)
-- 
2.17.1


