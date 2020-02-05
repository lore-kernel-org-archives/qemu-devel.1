Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9BDC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370BE2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y+KgpVgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370BE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHCO-0003E7-Ck
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3l-0000rB-Ki
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004yP-Bg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004eN-UJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316euoutp018d0905840addc411a8378a5753466920~wd84PqF6U2272522725euoutp01w
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205093316euoutp018d0905840addc411a8378a5753466920~wd84PqF6U2272522725euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895196;
 bh=eA2VRTKHri+EcLrE9E0xX8BQK07jxM4QOEd083wQnCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y+KgpVguNSLTQgM8+JaXqB6Dmb+rMSH3Z7yEhv4akMR29AqGSVDZdnWHjTC9aCPT0
 D5Ybve+0DxcwYhbvgzICA74108TmlymgDZJTJV9COAl7XsVTOtc/PDED47LM6XBAHI
 DQl+FjoyKfVP04Y96+lP/jYO8dcEV5CP4ua8dhmg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eucas1p161b8aae2796f4857b0700c26d1920f6a~wd84Db7-u3063030630eucas1p1c;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.39.60679.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eucas1p19f8f9a40b48b8917d5e2cd6c8a4f010e~wd83xBSFE3269132691eucas1p1a;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eusmtrp1020e979679240f3da540b84ac15a7a20~wd83wixEX1029010290eusmtrp1Y;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-96-5e3a8bdb0371
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.8D.08375.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eusmtip230fdffe31af0b2cabcf8d54bd59f8e7a~wd83b05cg0072900729eusmtip2M;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 5/9] hw/misc/memexpose: Add core memexpose files
Date: Wed,  5 Feb 2020 10:33:01 +0100
Message-Id: <1580895185-24341-6-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87q3u63iDPafNbbYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlbD5w
 lqWg9RRTxburnxgbGFs/MXYxcnJICJhILN//lRnEFhJYwSixaGcZhP2FUeL0Ee8uRi4g+zOj
 RM/zX0wwDcenzWWBSCxnlNi/5i0jhAPUcfPkTjaQKjYBNYmdRz6DrRARkJT43XUabAWzQIbE
 81ndYLawgLvEuwnfwaayCKhKvJzzEayeVyBAYsHXBhaIbXISN891gtVzCgRKbPr0kQ1kmYTA
 ZTaJYzu+Qp3kIvFv+TU2CFtY4tXxLewQtozE6ck9UIPqJVru7GCCaO5glOhbOR2qwVriy4al
 QEUcQNdpSqzfpQ8RdpQ4tfYfI0hYQoBP4sZbQYj7+SQmbZvODBHmlehoE4Ko1pPofnKTCWbr
 ssZHUFs9JPrXLmKDhM8SRomjP96yTmCUn4WwbAEj4ypG8dTS4tz01GKjvNRyveLE3OLSvHS9
 5PzcTYzABHD63/EvOxh3/Uk6xCjAwajEw7tikmWcEGtiWXFl7iFGCQ5mJRHe8/pAId6UxMqq
 1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhhjlqzucbnO1GrG9rS3
 NDfxbFl6+Lx/DEkbN9lfnr7LiPv6y8y+3oI0t4jgXvmlz7rYZS0XPSgQLBJhqliiH/TlQ1vH
 VNk7bxK9EiOaKjMsln4LZoqPaTbYU/rx5uL0XB/mSRpPjEJtS6brVTVfzig98fJrXBfnz2TX
 /UK+IYV/P8+919PSrMRSnJFoqMVcVJwIALvvzVr8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t/xe7q3u63iDJpXKVnsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYovRsivJLS1IVMvKLS2yVog0t
 jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyNh84y1LQeoqp4t3VT4wNjK2fGLsY
 OTkkBEwkjk+by9LFyMUhJLCUUeLGw19MEAkZiR+n17BB2MISf651sUEUfWKU2LdyDjNIgk1A
 TWLnkc9gk0QEJCV+d50GizMLZEnsnH0fbJCwgLvEuwnfwWwWAVWJl3M+gtXzCgRILPjawAKx
 QE7i5rlOsF5OgUCJTZ8+gi0WAqq59vUr6wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
 NzECQ3LbsZ+bdzBe2hh8iFGAg1GJh3fFJMs4IdbEsuLK3EOMEhzMSiK85/WBQrwpiZVVqUX5
 8UWlOanFhxhNgY6ayCwlmpwPjJe8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWp
 RTB9TBycUg2M85OE+Db8iDK8Km4QtU5XWPSHXu/PlbPfMJvwd5UkM2YvmDrhf8tZod+MM2yk
 2LdwrC3I3j1z706/xVc9g9xvCpY+vG3h8YunJIDrA/c8xZRMd77Yf0aX40IdJv3uSfPkOTqR
 qX4Gw2xWvo1Tm63lT731ePi7WfmSu8JuQZdpu5aLzuu8O/2dEktxRqKhFnNRcSIAUMnCFV8C
 AAA=
X-CMS-MailID: 20200205093315eucas1p19f8f9a40b48b8917d5e2cd6c8a4f010e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093315eucas1p19f8f9a40b48b8917d5e2cd6c8a4f010e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093315eucas1p19f8f9a40b48b8917d5e2cd6c8a4f010e
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093315eucas1p19f8f9a40b48b8917d5e2cd6c8a4f010e@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 Kconfig.host                       |   3 +
 MAINTAINERS                        |   4 +
 Makefile                           |   1 +
 configure                          |   8 +
 hw/mem/Kconfig                     |   3 +
 hw/misc/Makefile.objs              |   1 +
 hw/misc/memexpose/Makefile.objs    |   2 +
 hw/misc/memexpose/memexpose-core.c | 630 +++++++++++++++++++++++++++++++++++++
 hw/misc/memexpose/memexpose-core.h | 109 +++++++
 hw/misc/memexpose/memexpose-msg.c  | 261 +++++++++++++++
 hw/misc/memexpose/memexpose-msg.h  | 161 ++++++++++
 11 files changed, 1183 insertions(+)
 create mode 100644 hw/misc/memexpose/Makefile.objs
 create mode 100644 hw/misc/memexpose/memexpose-core.c
 create mode 100644 hw/misc/memexpose/memexpose-core.h
 create mode 100644 hw/misc/memexpose/memexpose-msg.c
 create mode 100644 hw/misc/memexpose/memexpose-msg.h

diff --git a/Kconfig.host b/Kconfig.host
index 55136e0..7470210 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -20,6 +20,9 @@ config SPICE
 config IVSHMEM
     bool
 
+config MEMEXPOSE
+    bool
+
 config TPM
     bool
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 73dd571..7c98fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1643,6 +1643,10 @@ memexpose
 M: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
 S: Maintained
 F: docs/specs/memexpose-spec.txt
+F: hw/misc/memexpose/memexpose-core.h
+F: hw/misc/memexpose/memexpose-core.c
+F: hw/misc/memexpose/memexpose-msg.h
+F: hw/misc/memexpose/memexpose-msg.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/Makefile b/Makefile
index 461d40b..82e7259 100644
--- a/Makefile
+++ b/Makefile
@@ -387,6 +387,7 @@ MINIKCONF_ARGS = \
     CONFIG_KVM=$(CONFIG_KVM) \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
+    CONFIG_MEMEXPOSE=$(CONFIG_MEMEXPOSE) \
     CONFIG_TPM=$(CONFIG_TPM) \
     CONFIG_XEN=$(CONFIG_XEN) \
     CONFIG_OPENGL=$(CONFIG_OPENGL) \
diff --git a/configure b/configure
index 115dc38..9c63c21 100755
--- a/configure
+++ b/configure
@@ -505,6 +505,7 @@ debug_mutex="no"
 libpmem=""
 default_devices="yes"
 plugins="no"
+memexpose="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1020,6 +1021,10 @@ for opt do
   ;;
   --without-default-devices) default_devices="no"
   ;;
+  --enable-memexpose) memexpose="yes"
+  ;;
+  --disable-memexpose) memexpose="no"
+  ;;
   --enable-gprof) gprof="yes"
   ;;
   --enable-gcov) gcov="yes"
@@ -7400,6 +7405,9 @@ fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
+if test "$memexpose" = "yes" ; then
+  echo "CONFIG_MEMEXPOSE=y" >> $config_host_mak
+fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
 fi
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 620fd4c..e377b05 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -5,6 +5,9 @@ config DIMM
 config MEM_DEVICE
     bool
 
+config MEM_EXPOSE
+    bool
+
 config NVDIMM
     bool
     default y
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f4..7e9a692 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -27,6 +27,7 @@ common-obj-$(CONFIG_PUV3) += puv3_pm.o
 common-obj-$(CONFIG_MACIO) += macio/
 
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
+common-obj-$(CONFIG_MEMEXPOSE) += memexpose/
 
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
diff --git a/hw/misc/memexpose/Makefile.objs b/hw/misc/memexpose/Makefile.objs
new file mode 100644
index 0000000..f405fe7
--- /dev/null
+++ b/hw/misc/memexpose/Makefile.objs
@@ -0,0 +1,2 @@
+common-obj-y += memexpose-msg.o
+common-obj-y += memexpose-core.o
diff --git a/hw/misc/memexpose/memexpose-core.c b/hw/misc/memexpose/memexpose-core.c
new file mode 100644
index 0000000..3b6ef3c
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-core.c
@@ -0,0 +1,630 @@
+/*
+ *  Memexpose core
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "memexpose-core.h"
+#include "exec/address-spaces.h"
+#include "exec/cpu-common.h"
+
+static int memexpose_pop_intr(MemexposeIntr *s)
+{
+    if (s->queue_count == 0) {
+        MEMEXPOSE_DPRINTF("No queued interrupts\n");
+        return 0;
+    }
+    struct memexpose_op_intr *head = &s->intr_queue[s->queue_start];
+    s->intr_rx = *head;
+    s->queue_start = (s->queue_start + 1) % MEMEXPOSE_INTR_QUEUE_SIZE;
+    s->queue_count--;
+
+    if (!s->queue_count) {
+        s->ops.intr(s->ops.parent, 0);
+    }
+    MEMEXPOSE_DPRINTF("Popped interrupt %lx\n", s->intr_rx.type);
+    return 1;
+}
+
+static void memexpose_push_intr(MemexposeIntr *s, struct memexpose_op_intr *msg)
+{
+    int signal = 0, free_slot;
+
+    if (s->queue_count == MEMEXPOSE_INTR_QUEUE_SIZE) {
+        MEMEXPOSE_DPRINTF("Interrupt queue is already full!\n");
+        return;
+    }
+    free_slot = (s->queue_start + s->queue_count) % MEMEXPOSE_INTR_QUEUE_SIZE;
+    s->intr_queue[free_slot] = *msg;
+    if (!s->queue_count) {
+        signal = 1;
+    }
+    s->queue_count++;
+
+    if (signal) {
+        s->ops.intr(s->ops.parent, 1);
+    }
+}
+
+static void process_intr(void *opaque, struct memexpose_op *op, Error **err)
+{
+    MemexposeIntr *s = opaque;
+    switch (op->head.ot) {
+    case MOP_INTR:
+        memexpose_push_intr(s, &op->body.intr);
+        break;
+    default:
+        error_setg(err, "Unknown memexpose intr command %u", op->head.ot);
+    }
+}
+
+static void memexpose_send_intr(MemexposeIntr *s)
+{
+    struct memexpose_op msg;
+
+    msg.head.ot = MOP_INTR;
+    msg.head.size = sizeof(msg.head) + sizeof(msg.body.intr);
+    msg.head.prio = 0;
+    msg.body.intr = s->intr_tx;
+    memexpose_ep_write_async(&s->ep, &msg);
+    MEMEXPOSE_DPRINTF("Sending interrupt %lx\n", msg.body.intr.type);
+}
+
+#define IN_INTR_DATA_RANGE(a, s, r) \
+    (a >= r && \
+     a < r + MEMEXPOSE_MAX_INTR_DATA_SIZE && \
+     (s = MIN(s, r + MEMEXPOSE_MAX_INTR_DATA_SIZE - a), 1))
+
+static uint64_t memexpose_intr_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    MemexposeIntr *s = opaque;
+    uint64_t ret = 0;
+    unsigned int boff = 8 * (addr & 0x7);
+
+    switch (addr & (~0x7)) {
+    case MEMEXPOSE_INTR_RX_TYPE_ADDR:
+        ret = s->intr_rx.type;
+        ret >>= boff;
+        return ret;
+    case MEMEXPOSE_INTR_TX_TYPE_ADDR:
+        ret = s->intr_tx.type;
+        ret >>= boff;
+        return ret;
+    case MEMEXPOSE_INTR_RECV_ADDR:
+        /* Make multiple read calls in readq and such behave as expected */
+        if (addr & 0x7) {
+            return 0;
+        }
+
+        ret = memexpose_pop_intr(s);
+        return ret;
+    case MEMEXPOSE_INTR_ENABLE_ADDR:
+        if (addr & 0x7) {
+            return 0;
+        }
+        return s->enabled;
+    default:
+        break;
+    }
+
+    if (IN_INTR_DATA_RANGE(addr, size, MEMEXPOSE_INTR_RX_DATA_ADDR)) {
+        uint64_t off = addr - MEMEXPOSE_INTR_RX_DATA_ADDR;
+        memcpy(&ret, s->intr_rx.data + off, size);
+        return ret;
+    } else if (IN_INTR_DATA_RANGE(addr, size, MEMEXPOSE_INTR_TX_DATA_ADDR)) {
+        uint64_t off = addr - MEMEXPOSE_INTR_TX_DATA_ADDR;
+        memcpy(&ret, s->intr_tx.data + off, size);
+        return ret;
+    } else {
+        MEMEXPOSE_DPRINTF("Invalid mmio read at " TARGET_FMT_plx "\n", addr);
+        ret = 0;
+        return ret;
+    }
+}
+
+static void memexpose_intr_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    MemexposeIntr *s = opaque;
+    unsigned int boff = 8 * (addr & 0x7);
+    uint64_t mask = ((1LL << (size * 8)) - 1) << boff;
+
+    switch (addr & (~0x7)) {
+    case MEMEXPOSE_INTR_RX_TYPE_ADDR:
+        s->intr_rx.type &= ~mask;
+        s->intr_rx.type |= (val << boff);
+        return;
+    case MEMEXPOSE_INTR_TX_TYPE_ADDR:
+        s->intr_tx.type &= ~mask;
+        s->intr_tx.type |= (val << boff);
+        return;
+    case MEMEXPOSE_INTR_SEND_ADDR:
+        /* Make multiple write calls in writeq and such behave as expected */
+        if (addr & 0x7) {
+            return;
+        }
+        memexpose_send_intr(s);
+        return;
+    case MEMEXPOSE_INTR_ENABLE_ADDR:
+        if (addr & 0x7) {
+            return;
+        }
+        if (val) {
+            if (s->ops.enable) {
+                s->enabled = s->ops.enable(s->ops.parent) ? 0 : 1;
+            } else {
+                s->enabled = 1;
+            }
+        } else {
+            if (s->ops.disable) {
+                s->ops.disable(s->ops.parent);
+            }
+            s->enabled = 0;
+        }
+        return;
+    }
+
+    if (IN_INTR_DATA_RANGE(addr, size, MEMEXPOSE_INTR_RX_DATA_ADDR)) {
+        uint64_t off = addr - MEMEXPOSE_INTR_RX_DATA_ADDR;
+        memcpy(s->intr_rx.data + off, &val, size);
+    } else if (IN_INTR_DATA_RANGE(addr, size, MEMEXPOSE_INTR_TX_DATA_ADDR)) {
+        uint64_t off = addr - MEMEXPOSE_INTR_TX_DATA_ADDR;
+        memcpy(s->intr_tx.data + off, &val, size);
+    } else {
+        MEMEXPOSE_DPRINTF("Invalid mmio write at " TARGET_FMT_plx "\n", addr);
+    }
+}
+
+static const MemoryRegionOps memexpose_intr_ops = {
+    .read = memexpose_intr_read,
+    .write = memexpose_intr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+void memexpose_intr_init(MemexposeIntr *s, struct memexpose_intr_ops *ops,
+                         Object *parent, CharBackend *chr, Error **errp)
+{
+    if (!qemu_chr_fe_backend_connected(chr)) {
+        error_setg(errp, "You must specify a 'intr_chardev'");
+        return;
+    }
+
+    s->parent = parent;
+    s->ops = *ops;
+    s->enabled = 0;
+    s->queue_start = 0;
+    s->queue_count = 0;
+    memexpose_ep_init(&s->ep, chr, s, 0, process_intr);
+    s->ep.is_async = true;
+    memory_region_init_io(&s->shmem, parent, &memexpose_intr_ops, s,
+                          "memexpose-intr", MEMEXPOSE_INTR_MEM_SIZE);
+}
+
+int memexpose_intr_enable(MemexposeIntr *s)
+{
+    return memexpose_ep_connect(&s->ep);
+}
+
+void memexpose_intr_disable(MemexposeIntr *s)
+{
+    memexpose_ep_disconnect(&s->ep);
+}
+
+void memexpose_intr_destroy(MemexposeIntr *s)
+{
+    memexpose_intr_disable(s);
+    /* Region will be collected with its parent */
+    memexpose_ep_destroy(&s->ep);
+}
+
+static bool memshare_region_overlaps(MemexposeMem *s,
+                                     struct memexpose_memshare_info_fd *share)
+{
+    MemexposeRemoteMemory *mem;
+    QLIST_FOREACH(mem, &s->remote_regions, list) {
+        uint64_t start = memory_region_get_ram_addr(&mem->region);
+        uint64_t size = memory_region_size(&mem->region);
+        MEMEXPOSE_DPRINTF("Comparing regions: received %"PRIx64"-%"PRIx64", "\
+                          "current mapped %"PRIx64"-%"PRIx64"\n",
+                          share->start, share->start + share->size,
+                          start, start + size);
+        if (start < share->start + share->size ||
+            share->start < start + size)
+            return true;
+    }
+    return false;
+}
+
+static void memshare_add_region(MemexposeMem *s, int fd,
+                                struct memexpose_memshare_info_fd *share,
+                                Error **errp)
+{
+    if (share->start >= s->shmem_size) {
+        /* TODO - error out */
+        MEMEXPOSE_DPRINTF("Shared memory start too high: "
+                          "%" PRIx64 " >= %" PRIx64,
+                          share->start, s->shmem_size);
+        close(fd);
+        return;
+    }
+
+    if (memshare_region_overlaps(s, share)) {
+        /* TODO - error out */
+        MEMEXPOSE_DPRINTF("Shared memory %" PRIx64 "-%" PRIx64
+                          " overlaps with existing region",
+                          share->start, share->start + share->size);
+        close(fd);
+        return;
+    }
+
+    uint64_t clamped_size = s->shmem_size - share->start;
+    share->size = MIN(share->size, clamped_size);
+
+    MemexposeRemoteMemory *mem = g_malloc(sizeof(*mem));
+    char *rname = g_strdup_printf("Memexpose shmem "
+                                  "%" PRIx64 "-%" PRIx64" -> %" PRIx64,
+                                  share->start, share->start + share->size,
+                                  share->mmap_start);
+
+    MEMEXPOSE_DPRINTF("Mapping remote memory: %" PRIx64 \
+                      "-%" PRIx64 ", fd offset %" PRIx64 "\n",
+                      share->start, share->size, share->mmap_start);
+
+    memory_region_init_ram_from_fd(&mem->region, s->parent, rname,
+                                   share->size, share->mmap_start,
+                                   true, fd, errp);
+    if (*errp) {
+        error_report_err(*errp);
+        close(fd);
+        return;
+    }
+
+    memory_region_set_nonvolatile(&mem->region, share->nonvolatile);
+    memory_region_set_readonly(&mem->region, share->readonly);
+    g_free(rname);
+    memory_region_add_subregion_overlap(&s->shmem, share->start,
+                                        &mem->region, 1);
+    QLIST_INSERT_HEAD(&s->remote_regions, mem, list);
+}
+
+static void memshare_remove_region(MemexposeMem *s, MemexposeRemoteMemory *reg)
+{
+    /* TODO is this correct? Docs warn about leaked refcounts */
+    QLIST_REMOVE(reg, list);
+    memory_region_del_subregion(&s->shmem, &reg->region);
+    object_unparent(OBJECT(&reg->region));
+}
+
+static void memshare_handle(MemexposeMem *s,
+                            struct memexpose_memshare_info *share)
+{
+    int fd;
+    switch (share->type) {
+    case MEMSHARE_NONE:
+        return;
+    case MEMSHARE_FD:
+        fd = memexpose_ep_recv_fd(&s->ep);
+        MEMEXPOSE_DPRINTF("Received memshare fd: %d\n", fd);
+        if (s->pending_invalidation) {
+            close(fd);
+            return;
+        }
+        Error *err = NULL;
+        memshare_add_region(s, fd, &share->fd, &err); /* TODO - handle errors */
+        return;
+    default:
+        MEMEXPOSE_DPRINTF("Invalid memshare type: %u\n", share->type);
+        return;
+    }
+}
+
+static MemTxResult memexpose_read_slow(void *opaque, hwaddr addr,
+                                       uint64_t *data, unsigned size,
+                                       MemTxAttrs attrs)
+{
+    MemexposeMem *s = opaque;
+
+    struct memexpose_op msg;
+    msg.head.size = sizeof(msg.head) + sizeof(msg.body.read);
+    msg.head.ot = MOP_READ;
+    msg.head.prio = memexpose_ep_msg_prio(&s->ep, msg.head.ot);
+    msg.body.read.offset = addr;
+    msg.body.read.size = size;
+    memexpose_ep_write_sync(&s->ep, &msg);
+
+    MemTxResult res = msg.body.read_ret.ret;
+    if (res == MEMTX_OK) {
+        memshare_handle(s, &msg.body.read_ret.share);
+    }
+    memcpy(data, &msg.body.read_ret.value, size);
+    return res;
+}
+
+static MemTxResult memexpose_write_slow(void *opaque, hwaddr addr,
+                                        uint64_t val, unsigned size,
+                                        MemTxAttrs attrs)
+{
+    MemexposeMem *s = opaque;
+    struct memexpose_op msg;
+    msg.head.size = sizeof(msg.head) + sizeof(msg.body.write);
+    msg.head.ot = MOP_WRITE;
+    msg.head.prio = memexpose_ep_msg_prio(&s->ep, msg.head.ot);
+    msg.body.write.offset = addr;
+    msg.body.write.size = size;
+    msg.body.write.value = val;
+    memexpose_ep_write_sync(&s->ep, &msg);
+
+    MemTxResult res = msg.body.write_ret.ret;
+    if (res == MEMTX_OK) {
+        memshare_handle(s, &msg.body.write_ret.share);
+    }
+    return res;
+}
+
+static const MemoryRegionOps memexpose_region_ops = {
+    .read_with_attrs = memexpose_read_slow,
+    .write_with_attrs = memexpose_write_slow,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void prepare_memshare(MemexposeMem *s,
+                             uint64_t size, uint64_t offset,
+                             struct memexpose_memshare_info *info) {
+    MemoryRegionSection section = memory_region_find_flat_range(
+            s->as.root, offset, size);
+    if (!section.mr) {
+        MEMEXPOSE_DPRINTF("No memory region under %lu!\n", offset);
+        goto unref;
+    }
+
+    int fd = memory_region_get_fd(section.mr);
+    if (fd != -1 && qemu_ram_is_shared(section.mr->ram_block)) {
+        info->type = MEMSHARE_FD;
+        info->fd.mmap_start = section.offset_within_region;
+        info->fd.start = section.offset_within_address_space;
+        info->fd.size = section.size;
+        info->fd.readonly = memory_region_is_rom(section.mr);
+        info->fd.nonvolatile = memory_region_is_nonvolatile(section.mr);
+
+        MEMEXPOSE_DPRINTF("Prepared a memshare fd: %" PRIx64 \
+                          "-%" PRIx64 ", fd offset %" PRIx64 "\n",
+                          info->fd.start, info->fd.size, info->fd.mmap_start);
+        memexpose_ep_send_fd(&s->ep, fd);
+        s->nothing_shared = false;
+    } else {
+        info->type = MEMSHARE_NONE;
+    }
+unref:
+    memory_region_unref(section.mr);
+}
+
+static void memexpose_perform_read_request(
+        MemexposeMem *s, struct memexpose_op_read *in,
+        struct memexpose_op *out)
+{
+    out->head.ot = MOP_READ_RET;
+    out->head.size = sizeof(out->head) + sizeof(out->body.read_ret);
+    out->body.read_ret.ret = 0;
+    out->body.read_ret.share.type = MEMSHARE_NONE;
+
+    MEMEXPOSE_DPRINTF("Reading %u from %lx\n", in->size, in->offset);
+    MemTxResult r = address_space_read(&s->as, in->offset,
+                                       MEMTXATTRS_UNSPECIFIED,
+                                       (uint8_t *) &out->body.read_ret.value,
+                                       in->size);
+    out->body.read_ret.ret = r;
+    if (r != MEMTX_OK) {
+        MEMEXPOSE_DPRINTF("Failed to read\n");
+    } else {
+        prepare_memshare(s, in->size, in->offset, &out->body.read_ret.share);
+    }
+}
+
+static void memexpose_perform_write_request(
+        MemexposeMem *s, struct memexpose_op_write *in,
+        struct memexpose_op *out)
+{
+    out->head.ot = MOP_WRITE_RET;
+    out->head.size = sizeof(out->head) + sizeof(out->body.write_ret);
+    out->body.write_ret.ret = 0;
+    out->body.write_ret.share.type = MEMSHARE_NONE;
+
+    MEMEXPOSE_DPRINTF("Writing %u to %lx\n", in->size, in->offset);
+    MemTxResult r = address_space_write(&s->as, in->offset,
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        (uint8_t *) &in->value,
+                                        in->size);
+    if (r != MEMTX_OK) {
+        out->body.write_ret.ret = -EIO;
+        MEMEXPOSE_DPRINTF("Failed to write\n");
+        return;
+    }
+
+    out->body.write_ret.ret = r;
+    if (r != MEMTX_OK) {
+        MEMEXPOSE_DPRINTF("Failed to read\n");
+    } else {
+        prepare_memshare(s, in->size, in->offset, &out->body.write_ret.share);
+    }
+}
+
+static bool region_is_ours(MemexposeMem *s, MemoryRegion *mr)
+{
+    if (mr == &s->shmem) {
+        return true;
+    }
+
+    MemexposeRemoteMemory *mem;
+    QLIST_FOREACH(mem, &s->remote_regions, list) {
+        if (mr == &mem->region) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void memexpose_remote_invalidate(MemoryListener *inv,
+                                        MemoryRegionSection *sect)
+{
+    MemexposeMem *s = container_of(inv, MemexposeMem, remote_invalidator);
+    struct memexpose_op msg;
+    struct memexpose_op_reg_inv *ri = &msg.body.reg_inv;
+
+    if (!sect->mr || region_is_ours(s, sect->mr)) {
+        return;
+    }
+    if (s->nothing_shared) {
+        return;
+    }
+
+    msg.head.size = sizeof(msg.head) + sizeof(msg.body.reg_inv);
+    msg.head.ot = MOP_REG_INV;
+    msg.head.prio = memexpose_ep_msg_prio(&s->ep, msg.head.ot);
+
+    ri->start = sect->offset_within_address_space;
+    ri->size = int128_get64(sect->size);
+    MEMEXPOSE_DPRINTF("Region %"PRIx64"-%"PRIx64" changed, "
+                      "sending invalidation request\n",
+                      ri->start, ri->start + ri->size);
+    memexpose_ep_write_sync(&s->ep, &msg);
+}
+
+static void memexpose_invalidate_region(MemexposeMem *s,
+                                        struct memexpose_op_reg_inv *ri,
+                                        struct memexpose_op *out)
+{
+    MemexposeRemoteMemory *mem;
+
+    QLIST_FOREACH(mem, &s->remote_regions, list) {
+        uint64_t start = memory_region_get_ram_addr(&mem->region);
+        uint64_t size = memory_region_size(&mem->region);
+        if (start < ri->start + ri->size ||
+            start + size > ri->start) {
+            mem->should_invalidate = true;
+            s->pending_invalidation = true;
+        }
+    }
+
+    if (s->pending_invalidation) {
+        qemu_bh_schedule(s->reg_inv_bh);
+    }
+
+    out->head.ot = MOP_REG_INV_RET;
+    out->head.size = sizeof(out->head);
+}
+
+static void memexpose_do_reg_inv_bh(void *opaque)
+{
+    MemexposeMem *s = opaque;
+
+    MemexposeRemoteMemory *mem, *tmp;
+    QLIST_FOREACH_SAFE(mem, &s->remote_regions, list, tmp) {
+        if (mem->should_invalidate) {
+            memshare_remove_region(s, mem);
+        }
+    }
+    s->pending_invalidation = false;
+}
+
+static void process_mem(void *opaque, struct memexpose_op *op, Error **err)
+{
+    MemexposeMem *s = opaque;
+    struct memexpose_op resp;
+    resp.head.prio = op->head.prio;
+    switch (op->head.ot) {
+    case MOP_READ:
+        memexpose_perform_read_request(s, &op->body.read, &resp);
+        break;
+    case MOP_WRITE:
+        memexpose_perform_write_request(s, &op->body.write, &resp);
+        break;
+    case MOP_REG_INV:
+        memexpose_invalidate_region(s, &op->body.reg_inv, &resp);
+        break;
+    default:
+        error_setg(err, "Unknown memexpose command %u", op->head.ot);
+        return;
+    }
+    memexpose_ep_write_async(&s->ep, &resp);
+}
+
+void memexpose_mem_init(MemexposeMem *s, Object *parent,
+                        MemoryRegion *as_root,
+                        CharBackend *chr, int prio, Error **errp)
+{
+    if (!qemu_chr_fe_backend_connected(chr)) {
+        error_setg(errp, "You must specify a 'mem_chardev'");
+        return;
+    }
+
+    QLIST_INIT(&s->remote_regions);
+    s->parent = parent;
+    address_space_init(&s->as, as_root, "Memexpose");
+
+    memexpose_ep_init(&s->ep, chr, s, prio, process_mem);
+    s->ep.is_async = false;
+    memory_region_init_io(&s->shmem, parent, &memexpose_region_ops, s,
+                          "memexpose-shmem", s->shmem_size);
+    MEMEXPOSE_DPRINTF("Shmem size %lx\n", memory_region_size(&s->shmem));
+
+    s->nothing_shared = true;
+    s->remote_invalidator = (MemoryListener) {
+        .region_add = memexpose_remote_invalidate,
+            .region_del = memexpose_remote_invalidate,
+    };
+    s->reg_inv_bh = qemu_bh_new(memexpose_do_reg_inv_bh, s);
+    memory_listener_register(&s->remote_invalidator, &s->as);
+}
+
+int memexpose_mem_enable(MemexposeMem *s)
+{
+    return memexpose_ep_connect(&s->ep);
+}
+
+void memexpose_mem_disable(MemexposeMem *s)
+{
+    memexpose_ep_disconnect(&s->ep);
+
+    MemexposeRemoteMemory *mem, *tmp;
+    QLIST_FOREACH_SAFE(mem, &s->remote_regions, list, tmp) {
+        memshare_remove_region(s, mem);
+    }
+    qemu_bh_cancel(s->reg_inv_bh);
+    s->pending_invalidation = false;
+}
+
+void memexpose_mem_destroy(MemexposeMem *s)
+{
+    memexpose_mem_disable(s);
+    /* Region will be collected with its parent */
+    memory_listener_unregister(&s->remote_invalidator);
+    memexpose_ep_destroy(&s->ep);
+    qemu_bh_delete(s->reg_inv_bh);
+    address_space_destroy(&s->as);
+}
diff --git a/hw/misc/memexpose/memexpose-core.h b/hw/misc/memexpose/memexpose-core.h
new file mode 100644
index 0000000..fd0ac60
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-core.h
@@ -0,0 +1,109 @@
+/*
+ *  Memexpose core
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _MEMEXPOSE_CORE_H_
+#define _MEMEXPOSE_CORE_H_
+#include "qemu/osdep.h"
+
+#include <inttypes.h>
+#include "chardev/char-fe.h"
+#include "hw/hw.h"
+#include "exec/memory.h"
+#include "memexpose-msg.h"
+
+#define MEMEXPOSE_INTR_QUEUE_SIZE 16
+
+#define MEMEXPOSE_DEBUG 1
+#define MEMEXPOSE_DPRINTF(fmt, ...)                       \
+    do {                                                \
+        if (MEMEXPOSE_DEBUG) {                            \
+            printf("MEMEXPOSE: " fmt, ## __VA_ARGS__);    \
+        }                                               \
+    } while (0)
+
+#define MEMEXPOSE_INTR_MEM_SIZE 0x1000
+
+
+#define MEMEXPOSE_INTR_ENABLE_ADDR  0x0
+#define MEMEXPOSE_INTR_RECV_ADDR    0x400
+#define MEMEXPOSE_INTR_RX_TYPE_ADDR 0x408
+#define MEMEXPOSE_INTR_RX_DATA_ADDR 0x410
+#define MEMEXPOSE_INTR_SEND_ADDR    0x800
+#define MEMEXPOSE_INTR_TX_TYPE_ADDR 0x808
+#define MEMEXPOSE_INTR_TX_DATA_ADDR 0x810
+
+struct memexpose_intr_ops {
+    void *parent;
+    void (*intr) (void *opaque, int dir);
+    int (*enable) (void *opaque);
+    void (*disable) (void *opaque);
+};
+
+typedef struct MemexposeIntr {
+    Object *parent;
+    struct memexpose_intr_ops ops;
+    int enabled;
+
+    MemexposeEp ep;
+    MemoryRegion shmem;
+
+    struct memexpose_op_intr intr_queue[MEMEXPOSE_INTR_QUEUE_SIZE];
+    int queue_start;
+    int queue_count;
+    struct memexpose_op_intr intr_tx;
+    struct memexpose_op_intr intr_rx;
+} MemexposeIntr;
+
+typedef struct MemexposeMem {
+    Object *parent;
+    MemexposeEp ep;
+
+    AddressSpace as;
+    MemoryRegion shmem;
+    uint64_t shmem_size;
+    QLIST_HEAD(, MemexposeRemoteMemory) remote_regions;
+
+    MemoryListener remote_invalidator;
+    QEMUBH *reg_inv_bh;
+    bool pending_invalidation;
+    bool nothing_shared;
+} MemexposeMem;
+
+typedef struct MemexposeRemoteMemory {
+    MemoryRegion region;
+    bool should_invalidate;
+    QLIST_ENTRY(MemexposeRemoteMemory) list;
+} MemexposeRemoteMemory;
+
+void memexpose_intr_init(MemexposeIntr *s, struct memexpose_intr_ops *ops,
+                         Object *parent, CharBackend *chr, Error **errp);
+void memexpose_intr_destroy(MemexposeIntr *s);
+int memexpose_intr_enable(MemexposeIntr *s);
+void memexpose_intr_disable(MemexposeIntr *s);
+
+void memexpose_mem_init(MemexposeMem *s, Object *parent,
+                        MemoryRegion *as_root,
+                        CharBackend *chr, int prio, Error **errp);
+void memexpose_mem_destroy(MemexposeMem *s);
+int memexpose_mem_enable(MemexposeMem *s);
+void memexpose_mem_disable(MemexposeMem *s);
+
+#endif /* _MEMEXPOSE_CORE_H_ */
diff --git a/hw/misc/memexpose/memexpose-msg.c b/hw/misc/memexpose/memexpose-msg.c
new file mode 100644
index 0000000..7205dd0
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-msg.c
@@ -0,0 +1,261 @@
+/*
+ *  Memexpose core
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "memexpose-msg.h"
+#include "memexpose-core.h"
+
+#define MIN_MSG_SIZE (sizeof(struct memexpose_op_head))
+#define MAX_MSG_SIZE (sizeof(struct memexpose_op))
+
+int memexpose_ep_msg_prio(MemexposeEp *ep, enum memexpose_op_type ot)
+{
+    int ot_prio;
+    switch (ot) {
+    case MOP_READ:
+    case MOP_READ_RET:
+    case MOP_WRITE:
+    case MOP_WRITE_RET:
+        ot_prio = 2;
+        break;
+    default:
+        ot_prio = 0;
+    }
+    return ot_prio + ep->prio;
+}
+
+static int mep_can_receive(void *opaque)
+{
+    int sz;
+    MemexposeEp *ep = opaque;
+    MemexposeMsg *msg = &ep->msg;
+
+    switch (msg->read_state) {
+    case MEMEXPOSE_MSG_BROKEN:
+        return 0;
+    case MEMEXPOSE_MSG_READ_SIZE:
+        return sizeof(msg->buf.head.size) - msg->bytes;
+    case MEMEXPOSE_MSG_READ_BODY:
+        sz = msg->buf.head.size - msg->bytes;
+        if (sz > MAX_MSG_SIZE) {
+            return MAX_MSG_SIZE;  /* We'll handle this as an error later */
+        }
+        return sz;
+    default:
+        MEMEXPOSE_DPRINTF("Invalid read state %d\n", msg->read_state);
+        return 0;
+    }
+}
+
+static int mep_do_receive(MemexposeMsg *msg,
+                          const uint8_t *buf, int size)
+{
+    switch (msg->read_state) {
+    case MEMEXPOSE_MSG_BROKEN:
+        return -1;
+    case MEMEXPOSE_MSG_READ_SIZE:
+        memcpy((unsigned char *)&msg->buf + msg->bytes, buf, size);
+        msg->bytes += size;
+        if (msg->bytes == sizeof(msg->buf.head.size)) {
+            msg->read_state = MEMEXPOSE_MSG_READ_BODY;
+        }
+        return 0;
+    case MEMEXPOSE_MSG_READ_BODY:
+        if (msg->buf.head.size < MIN_MSG_SIZE ||
+            msg->buf.head.size > MAX_MSG_SIZE) {
+            MEMEXPOSE_DPRINTF("Invalid message size %d, protocol broken!\n",
+                              msg->buf.head.size);
+            msg->read_state = MEMEXPOSE_MSG_BROKEN;
+            return -1;
+        }
+        memcpy((unsigned char *)&msg->buf + msg->bytes, buf, size);
+        msg->bytes += size;
+        if (msg->bytes < msg->buf.head.size) {
+            return 0;
+        }
+        msg->bytes = 0;
+        msg->read_state = MEMEXPOSE_MSG_READ_SIZE;
+        return 1;
+    default:
+        MEMEXPOSE_DPRINTF("Invalid read state %d\n", msg->read_state);
+        return -1;
+    }
+}
+
+static void mep_receive(void *opaque, const uint8_t *buf, int size)
+{
+    MemexposeEp *ep = opaque;
+    Error *err = NULL;
+    int new_msg = mep_do_receive(&ep->msg, buf, size);
+    if (new_msg) {
+        ep->handle_msg(ep->data, &ep->msg.buf, &err);
+        if (err) {
+            error_report_err(err);
+        }
+    } else if (new_msg < 0) {
+        error_setg(&err, "Failed to receive memexpose message"); /* FIXME */
+        error_report_err(err);
+    }
+}
+
+static int mep_receive_sync(MemexposeEp *ep, struct memexpose_op *op)
+{
+    int ret = 0;
+    MemexposeMsg *msg = &ep->msg;
+    assert(!ep->is_async);
+
+    while (!ret) {
+        int can_receive = mep_can_receive(ep);
+        unsigned char *msgbuf = (unsigned char *)&msg->buf + msg->bytes;
+        qemu_chr_fe_read_all(ep->chr, msgbuf, can_receive);
+        ret = mep_do_receive(msg, msgbuf, can_receive);
+        if (ret == -1) {
+            return -1;
+        }
+    }
+    *op = msg->buf;
+    return 0;
+}
+
+void memexpose_ep_write_async(MemexposeEp *ep, struct memexpose_op *op)
+{
+    qemu_chr_fe_write_all(ep->chr, (unsigned char *) op, op->head.size);
+}
+
+static void mep_queue_msg(MemexposeEp *ep, struct memexpose_op *op)
+{
+    ep->queued_op = *op;
+    qemu_bh_schedule(ep->queue_msg_bh);
+}
+
+static void mep_queue_msg_bh(void *epp)
+{
+    Error *err = NULL;
+    MemexposeEp *ep = epp;
+    if (!ep->queued_op.head.size) {
+        return;
+    }
+    ep->handle_msg(ep->data, &ep->queued_op, &err); /* FIXME - handle */
+    ep->queued_op.head.size = 0;
+}
+
+/*
+ * Synchronously write a message to another QEMU and receive a response.
+ * To avoid deadlocks, each message type has its priority and no more than one
+ * message of each priority is in flight.
+ *
+ * After we send a message, we await a response while handling all messages of
+ * higher priority and deferring messages of lower priority. This way each side
+ * will have its requests handled until they have time to handle ours.
+ *
+ * The above means that a handler for a message must be able to run while an
+ * operation that sends any other lower priority message is in progress. Make
+ * sure to order operations in an order that does not upset QEMU!
+ */
+void memexpose_ep_write_sync(MemexposeEp *ep, struct memexpose_op *op)
+{
+    assert(!ep->is_async);
+    qemu_chr_fe_write_all(ep->chr, (unsigned char *) op, op->head.size);
+
+    struct memexpose_op resp;
+    int prio = op->head.prio;
+
+    /* FIXME - handle errors */
+    while (true) {
+        Error *err = NULL;
+        mep_receive_sync(ep, &resp);
+        int resp_prio = resp.head.prio;
+        if (resp_prio > prio) {
+            ep->handle_msg(ep->data, &resp, &err);
+        } else if (resp_prio < prio) {
+            mep_queue_msg(ep, &resp);
+        } else {
+            *op = resp;
+            return;
+        }
+    }
+}
+
+void memexpose_ep_init(MemexposeEp *ep, CharBackend *chr, void *data, int prio,
+                       void (*handle_msg)(void *data, struct memexpose_op *op,
+                                          Error **errp))
+{
+    ep->queue_msg_bh = qemu_bh_new(mep_queue_msg_bh, ep);
+    ep->queued_op.head.size = 0;
+    ep->handle_msg = handle_msg;
+    ep->msg.bytes = 0;
+    ep->msg.read_state = MEMEXPOSE_MSG_READ_SIZE;
+    ep->chr = chr;
+    ep->data = data;
+    ep->prio = prio;
+    ep->connected = 0;
+
+    if (handle_msg)
+        qemu_chr_fe_set_handlers(ep->chr, mep_can_receive,
+                                 mep_receive, NULL, NULL, ep, NULL, true);
+    Chardev *chrd = qemu_chr_fe_get_driver(ep->chr);
+    assert(chrd);
+    MEMEXPOSE_DPRINTF("Memexpose endpoint at %s\n",
+                      chrd->filename);
+
+}
+
+/* TODO - protocol for synchronously ending connection */
+void memexpose_ep_destroy(MemexposeEp *ep)
+{
+    qemu_chr_fe_set_handlers(ep->chr, NULL, NULL, NULL, NULL, NULL, NULL, true);
+}
+
+void memexpose_ep_send_fd(MemexposeEp *ep, int fd)
+{
+    qemu_chr_fe_set_msgfds(ep->chr, &fd, 1);
+}
+
+int memexpose_ep_recv_fd(MemexposeEp *ep)
+{
+    return qemu_chr_fe_get_msgfd(ep->chr);
+}
+
+int memexpose_ep_connect(MemexposeEp *ep)
+{
+    /* FIXME - report errors */
+    Error *err = NULL;
+    if (ep->connected) {
+        return 0;
+    }
+
+    int ret = qemu_chr_fe_wait_connected(ep->chr, &err);
+    if (ret) {
+        return ret;
+    }
+
+    ep->connected = 1;
+    return 0;
+}
+
+void memexpose_ep_disconnect(MemexposeEp *ep)
+{
+    if (ep->connected) {
+        qemu_chr_fe_disconnect(ep->chr);
+    }
+    ep->connected = 0;
+}
diff --git a/hw/misc/memexpose/memexpose-msg.h b/hw/misc/memexpose/memexpose-msg.h
new file mode 100644
index 0000000..5543cd4
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-msg.h
@@ -0,0 +1,161 @@
+/*
+ *  Memexpose core
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _MEMEXPOSE_MSG_H_
+#define _MEMEXPOSE_MSG_H_
+
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "chardev/char-fe.h"
+#include "exec/memattrs.h"
+#include <inttypes.h>
+
+#define MEMEXPOSE_MAX_INTR_DATA_SIZE 128
+
+enum memexpose_op_type {
+    MOP_READ,
+    MOP_READ_RET,
+    MOP_WRITE,
+    MOP_WRITE_RET,
+    MOP_REG_INV,
+    MOP_REG_INV_RET,
+    MOP_INTR,
+};
+
+enum memexpose_memshare_type {
+    MEMSHARE_NONE,
+    MEMSHARE_FD,
+};
+
+/*
+ * TODO - we'll need to share more info here, like access permissions for
+ * example
+ */
+struct memexpose_memshare_info_fd {
+    uint64_t start;
+    uint64_t mmap_start;
+    uint64_t size;
+    uint8_t readonly;
+    uint8_t nonvolatile;
+} __attribute__((packed));
+
+/* TODO - this might have variable size in the future */
+struct memexpose_memshare_info {
+    uint8_t type;
+    union {
+        struct memexpose_memshare_info_fd fd;
+    };
+} __attribute__((packed));
+
+/* TODO - endianness */
+struct memexpose_op_head {
+    uint32_t size;
+    uint8_t ot;
+    uint8_t prio;
+} __attribute__((packed));
+
+struct memexpose_op_read {
+    uint64_t offset;
+    uint8_t size;
+} __attribute__((packed));
+
+struct memexpose_op_write {
+    uint64_t offset;
+    uint64_t value;
+    uint8_t size;
+} __attribute__((packed));
+
+struct memexpose_op_read_ret {
+    MemTxResult ret;
+    uint64_t value;
+    struct memexpose_memshare_info share;
+} __attribute__((packed));
+
+struct memexpose_op_write_ret {
+    MemTxResult ret;
+    struct memexpose_memshare_info share;
+} __attribute__((packed));
+
+struct memexpose_op_intr {
+    uint64_t type;
+    uint8_t data[MEMEXPOSE_MAX_INTR_DATA_SIZE];
+} __attribute__((packed));
+
+struct memexpose_op_reg_inv {
+    uint64_t start;
+    uint64_t size;
+} __attribute__((packed));
+
+union memexpose_op_all {
+    struct memexpose_op_read read;
+    struct memexpose_op_write write;
+    struct memexpose_op_read_ret read_ret;
+    struct memexpose_op_write_ret write_ret;
+    struct memexpose_op_intr intr;
+    struct memexpose_op_reg_inv reg_inv;
+} __attribute__((packed));
+
+struct memexpose_op {
+    struct memexpose_op_head head;
+    union memexpose_op_all body;
+} __attribute__((packed));
+
+enum MemexposeMsgState {
+    MEMEXPOSE_MSG_READ_SIZE,
+    MEMEXPOSE_MSG_READ_BODY,
+    MEMEXPOSE_MSG_BROKEN,
+};
+
+typedef struct MemexposeMsg {
+    int read_state;
+    int bytes;
+    struct memexpose_op buf;
+} MemexposeMsg;
+
+typedef struct MemexposeEp {
+    CharBackend *chr;
+    MemexposeMsg msg;
+    bool is_async;
+    int prio;
+    void *data;
+    void (*handle_msg)(void *data, struct memexpose_op *op, Error **err);
+
+    int connected;
+    struct memexpose_op queued_op;
+    QEMUBH *queue_msg_bh;
+} MemexposeEp;
+
+void memexpose_ep_init(MemexposeEp *ep, CharBackend *chr, void *data, int prio,
+                       void (*handle_msg)(void *data, struct memexpose_op *op,
+                                          Error **errp));
+void memexpose_ep_destroy(MemexposeEp *ep);
+
+int memexpose_ep_connect(MemexposeEp *ep);
+void memexpose_ep_disconnect(MemexposeEp *ep);
+
+/* TODO - functions for header boilerplate */
+void memexpose_ep_write_sync(MemexposeEp *ep, struct memexpose_op *op);
+void memexpose_ep_write_async(MemexposeEp *ep, struct memexpose_op *op);
+void memexpose_ep_send_fd(MemexposeEp *ep, int fd);
+int memexpose_ep_recv_fd(MemexposeEp *ep);
+int memexpose_ep_msg_prio(MemexposeEp *ep, enum memexpose_op_type);
+
+#endif /* _MEMEXPOSE_MSG_H_ */
-- 
2.7.4


