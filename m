Received: from eggs.gnu.org ([2001:4830:134:3::10]:36785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxo-0000Zo-Pb
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxn-0008LP-9g
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:56824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxm-0008Jd-Vv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:43 -0500
Date: Thu, 19 Jan 2017 23:09:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-11-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/17] virtio_mmio: add standard header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/virtio_mmio.h | 141 +++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_mmio.h

diff --git a/include/standard-headers/linux/virtio_mmio.h b/include/standard-headers/linux/virtio_mmio.h
new file mode 100644
index 0000000..c4b0968
--- /dev/null
+++ b/include/standard-headers/linux/virtio_mmio.h
@@ -0,0 +1,141 @@
+/*
+ * Virtio platform device driver
+ *
+ * Copyright 2011, ARM Ltd.
+ *
+ * Based on Virtio PCI driver by Anthony Liguori, copyright IBM Corp. 2007
+ *
+ * This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _LINUX_VIRTIO_MMIO_H
+#define _LINUX_VIRTIO_MMIO_H
+
+/*
+ * Control registers
+ */
+
+/* Magic value ("virt" string) - Read Only */
+#define VIRTIO_MMIO_MAGIC_VALUE		0x000
+
+/* Virtio device version - Read Only */
+#define VIRTIO_MMIO_VERSION		0x004
+
+/* Virtio device ID - Read Only */
+#define VIRTIO_MMIO_DEVICE_ID		0x008
+
+/* Virtio vendor ID - Read Only */
+#define VIRTIO_MMIO_VENDOR_ID		0x00c
+
+/* Bitmask of the features supported by the device (host)
+ * (32 bits per set) - Read Only */
+#define VIRTIO_MMIO_DEVICE_FEATURES	0x010
+
+/* Device (host) features set selector - Write Only */
+#define VIRTIO_MMIO_DEVICE_FEATURES_SEL	0x014
+
+/* Bitmask of features activated by the driver (guest)
+ * (32 bits per set) - Write Only */
+#define VIRTIO_MMIO_DRIVER_FEATURES	0x020
+
+/* Activated features set selector - Write Only */
+#define VIRTIO_MMIO_DRIVER_FEATURES_SEL	0x024
+
+
+#ifndef VIRTIO_MMIO_NO_LEGACY /* LEGACY DEVICES ONLY! */
+
+/* Guest's memory page size in bytes - Write Only */
+#define VIRTIO_MMIO_GUEST_PAGE_SIZE	0x028
+
+#endif
+
+
+/* Queue selector - Write Only */
+#define VIRTIO_MMIO_QUEUE_SEL		0x030
+
+/* Maximum size of the currently selected queue - Read Only */
+#define VIRTIO_MMIO_QUEUE_NUM_MAX	0x034
+
+/* Queue size for the currently selected queue - Write Only */
+#define VIRTIO_MMIO_QUEUE_NUM		0x038
+
+
+#ifndef VIRTIO_MMIO_NO_LEGACY /* LEGACY DEVICES ONLY! */
+
+/* Used Ring alignment for the currently selected queue - Write Only */
+#define VIRTIO_MMIO_QUEUE_ALIGN		0x03c
+
+/* Guest's PFN for the currently selected queue - Read Write */
+#define VIRTIO_MMIO_QUEUE_PFN		0x040
+
+#endif
+
+
+/* Ready bit for the currently selected queue - Read Write */
+#define VIRTIO_MMIO_QUEUE_READY		0x044
+
+/* Queue notifier - Write Only */
+#define VIRTIO_MMIO_QUEUE_NOTIFY	0x050
+
+/* Interrupt status - Read Only */
+#define VIRTIO_MMIO_INTERRUPT_STATUS	0x060
+
+/* Interrupt acknowledge - Write Only */
+#define VIRTIO_MMIO_INTERRUPT_ACK	0x064
+
+/* Device status register - Read Write */
+#define VIRTIO_MMIO_STATUS		0x070
+
+/* Selected queue's Descriptor Table address, 64 bits in two halves */
+#define VIRTIO_MMIO_QUEUE_DESC_LOW	0x080
+#define VIRTIO_MMIO_QUEUE_DESC_HIGH	0x084
+
+/* Selected queue's Available Ring address, 64 bits in two halves */
+#define VIRTIO_MMIO_QUEUE_AVAIL_LOW	0x090
+#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH	0x094
+
+/* Selected queue's Used Ring address, 64 bits in two halves */
+#define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
+#define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
+
+/* Configuration atomicity value */
+#define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
+
+/* The config space is defined by each driver as
+ * the per-driver configuration space - Read Write */
+#define VIRTIO_MMIO_CONFIG		0x100
+
+
+
+/*
+ * Interrupt flags (re: interrupt status & acknowledge registers)
+ */
+
+#define VIRTIO_MMIO_INT_VRING		(1 << 0)
+#define VIRTIO_MMIO_INT_CONFIG		(1 << 1)
+
+#endif
-- 
MST
