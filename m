Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F073C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3932326B43
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7wmAFuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3932326B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXw2e-0001va-Gx
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 19:07:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin.i.oliveira@gmail.com>) id 1hXu34-0007xZ-PN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin.i.oliveira@gmail.com>) id 1hXu31-0005yO-Fu
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:59:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <martin.i.oliveira@gmail.com>)
	id 1hXu31-0005sn-4g
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:59:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id g69so7438531plb.7
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=zy9P7lHPl+58ghpQrfWCPHxnzwUbbD+8Om7PcPQwtX0=;
	b=V7wmAFuPwPmlzgRmdI0nygqiywsq5FWT1LeRYfkGSp43gZGTkYVZZC9cKIDI6Xvnf2
	CfmTU54R/aXzOShXLWUyKBU8fb0vVEoNTaM1CTkRQUFg+4HDzR3cpeAupBXn1fKqasgu
	qyhc0BV9R0xPfpilG3SnTFqCcBEtnbFM6QSxO6pgL+OiaDg8MPovHwSzpm+xaFT8zw4u
	53/BkKT2wLKGjtvgj5VBiAqmYwig7p/CVqJHe7QHfIfBY1a5uHKluwzdZgl7Sp5OtBwV
	da34pDwweFUDaVg0PHcTDTcNWCw90JGvJrbAlnIfpiouqZ/cSbotXTPl9oUn1D80KE1z
	eFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=zy9P7lHPl+58ghpQrfWCPHxnzwUbbD+8Om7PcPQwtX0=;
	b=DFvhVZdKqyssU+0T/BiMSXko4M0jmrKByXiI+c0k0s5ATclmiuWs9MGEoWmGskCE1f
	z0I0Ot9gnxDzukopNALKyRtnWMXBgxMAvO2/5u/MfWXA9VpAt8Kp46fLsSWlTOYfX2Zs
	oy0HVwMtzEJujrzRaicZLq7wdPPVtYjbN/lE9+QKvHRXGsykzFqaLZnHyHpZYPy9NpQd
	QA6hJSg6sMKzUi0hm0glnJ1nFnrwRwfo3Pmzp3+qKVntVUIHFK/fJbMC3gY3Bhykce8V
	RhFYxFtWvW/LFOudVxfmJPrWP51AkNrClj8QfZIS2Res/eziklkYOSx3eG/AahO8uaUX
	lSUA==
X-Gm-Message-State: APjAAAX6DA4NmojhJxA41J7dbw13JtkxpXCKb72bg5BH7k5ghtJ5EL9b
	r26gSpDif8OyqF3GREc2Ydg1aM6B
X-Google-Smtp-Source: APXvYqx6l5sGhPFs23ZO8mlagcg2COE8zx3u1NEuv0sEjDFx/OYONZ/O+qdSc1w01Ge6YDsmMQnJ/Q==
X-Received: by 2002:a17:902:112c:: with SMTP id
	d41mr31781218pla.33.1559595552228; 
	Mon, 03 Jun 2019 13:59:12 -0700 (PDT)
Received: from gamayun.hitronhub.home (S01069050ca325a43.ed.shawcable.net.
	[174.3.165.247]) by smtp.googlemail.com with ESMTPSA id
	b90sm789934pjc.0.2019.06.03.13.59.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 13:59:11 -0700 (PDT)
From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:58:26 -0600
Message-Id: <20190603205826.2345-1-martin.i.oliveira@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
X-Mailman-Approved-At: Mon, 03 Jun 2019 19:04:01 -0400
Subject: [Qemu-devel] [PATCH] [RFC] Add a eBPF-capable PCIe device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: javier@javigon.com,
	Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>,
	Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This RFC adds a PCIe device model that is capable of running machine
code complaint with the extended Berkeley Packet Filter (eBPF) virtual
machine [1]. This machine can then be used to run offloaded code in the
PCIe device against data passed to the PCIe device via DMA. eBPF is a
very well supported “virtual” ISA and has an increasingly level of
support within the Linux kernel. As such, it makes a good choice as a
vendor-agnostic ISA for application acceleration via PCIe offload
engines [2]. This RFC is useful for exploring this idea in an emulated
environment without needing physical PCIe attached eBPF offload engines.

The eBPF device model leverages a userspace eBPF C library (uBPF) [3] in
order to implement the model and this is therefore a dependency when
building QEMU. If this uBPF library is detected at configuration time
and --disable_libubpf is not set then this model will be enabled when
QEMU is built.

Documentation on how to program the eBPF PCIe device is included in
docs/specs/ebpf.txt.

A sample Linux kernel driver can be found in [4]. Note that this driver
also exposes a section of one of the BARs on the eBPF PCIe device as a
p2pdma capable memory [5] and as such requires a 4.20.x or more recent
kernel. This is done to explore the ability of combining the eBPF
offload engine with p2pdma to build more efficient systems.

Note that this RFC is just a starting point for a PCIe eBPF model. The
programming model for the device is not as efficient as it could be
right now. In the future we plan to add more parallelism and the ability
to handle multiple DMA requests. Long term we may add a NVMe controller
interface to this PCIe device to align with work being by SNIA and NVM
Express around NVMe Computational Storage [6]. Suggestions for other
enhancements are very welcome!

A simple “smoke-test” userspace application that utilizes both the
kernel driver and the PCIe model is available [7]. It shows how a C
program can be compiled to eBPF in user-space, pushed to the PCIe device
and be used to operate on data DMA’ed in from an NVMe SSD.

This patch applies to release v4.0.0 of QEMU.

[1]: https://www.kernel.org/doc/Documentation/networking/filter.txt
[2]: https://lkml.org/lkml/2019/2/7/647
[3]: https://github.com/iovisor/ubpf
[4]: https://github.com/iomartin/pci_ubpf_driver
[5]: https://www.kernel.org/doc/Documentation/driver-api/pci/p2pdma.rst
[6]: https://www.snia.org/computational
[7]: https://github.com/iomartin/ebpf-test

Signed-off-by: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 configure             |  27 +++
 docs/specs/ebpf.txt   | 182 +++++++++++++++
 hw/misc/Makefile.objs |   3 +
 hw/misc/pcie-ebpf.c   | 513 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 725 insertions(+)
 create mode 100644 docs/specs/ebpf.txt
 create mode 100644 hw/misc/pcie-ebpf.c

diff --git a/configure b/configure
index 1c563a7027..41b3b08cfb 100755
--- a/configure
+++ b/configure
@@ -491,6 +491,7 @@ docker="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+libubpf=""
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1518,6 +1519,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --disable-libubpf) libubpf="no"
+  ;;
+  --enable-libubpf) libubpf="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -3974,6 +3979,24 @@ elif test "$tpm" = "yes"; then
   fi
 fi
 
+##########################################
+# libubpf probe
+
+if test "$libubpf" != "no" ; then
+  cat > $TMPC <<EOF
+#include <ubpf.h>
+int main(void) { ubpf_create(); return 0; }
+EOF
+  if compile_prog "" "-lubpf" ; then
+    libubpf=yes
+  else
+    if test "$libubpf" = "yes" ; then
+      feature_not_found "libubpf" "Install libubpf"
+    fi
+    libubpf=no
+  fi
+fi
+
 ##########################################
 # attr probe
 
@@ -6438,6 +6461,7 @@ echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "libubpf           $libubpf"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -6833,6 +6857,9 @@ fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
 fi
+if test "$libubpf" = "yes" ; then
+  echo "CONFIG_LIBUBPF=y" >> $config_host_mak
+fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
 fi
diff --git a/docs/specs/ebpf.txt b/docs/specs/ebpf.txt
new file mode 100644
index 0000000000..7aa209f22c
--- /dev/null
+++ b/docs/specs/ebpf.txt
@@ -0,0 +1,182 @@
+
+EBPF device
+===========
+
+Copyright (c) 2019 Martin Ichilevici de Oliveira
+
+This document is licensed under the GPLv2 (or later).
+
+eBPF is a Linux kernel instruction set architecture and virtual machine
+specification, which can be used to insert code in the kernel at runtime. One
+of the use-cases is offloading eBPF to external devices. This is an example of
+a PCI device that can execute eBPF, using the uBPF library
+(https://github.com/iovisor/ubpf)
+
+A sample library is provided in https://github.com/iomartin/pci_ubpf_driver
+
+PCI specs
+---------
+
+PCI ID: 1de5:3000
+
+PCI Region 4:
+  ------------------------------------------------
+ |1MB|                  15MB                      |
+  ------------------------------------------------
+   ^                      ^
+   |-- I/O area           |-- RAM area
+
+I/O area spec
+-------------
+Used to program the device. See the commands section below.
+0x0: Opcode (1 byte)
+0x1: Control (start/stop the eBPF command) (1 byte)
+0x4: Length (4 bytes)
+0x8: Offset to write data to (from the start of the ".text" or ".data" segment)
+     (4 bytes)
+0xc: Source address (given as host address) (8 bytes)
+
+RAM area spec
+---------------
+0x100000: size of the ".text" segment
+0x100004: size of the ".data" segment
+0x100100: start of the ".text" segment (where the eBPF program will be stored)
+0x200000: eBPF program return code
+0x200004: 1 if eBPF program finished, 0 otherwise
+0x200008: eBPF registers (16 * uint64_t)
+0x400000: start of the ".data" segment (where the program's input will be
+          stored)
+0x800000: start of the p2pdma area
+
+Commands
+--------
+The device can receive the following commands, by writing to the begining of
+the I/O area:
+
+0x00: DMA_TEXT:      DMA the ".text" from the host to address 0x1000 of the
+                     device
+0x01: MOVE_P2P_TEXT: Copy the ".text" from 0x800000 to 0x1000
+0x02: DMA_DATA:      DMA the ".data" from the host to address 0x400000 of the
+                     device
+0x03: MOVE_P2P_DATA: Copy the ".data" from 0x800000 to 0x400000
+0x04: RUN_PROG:      Start program execution
+0xff: DUMP_MEM:      Print the ".text" and ".data" segments (for debugging, not
+                     transferred to the host)
+
+To program a device, the user must first transfer the eBPF program and,
+optionally, the data, to the device.  This can be done by either regular DMA
+(0x00 or 0x02) or by first using P2P-DMA to copy data to the p2pdma area and
+then issuing the 0x01 or 0x03 commands to tell the device to copy from the
+p2pdma area to the ".text" or ".data" regions, respectively.
+
+Then, it must issue the RUN_PROG command to start execution.
+
+For example, one could program the ".text" with:
+
+static int do_dma(struct pci_ubpf_dev *p, uint8_t opcode, unsigned long addr, unsigned long nbytes)
+{
+    int ret = 0;
+    int n_user_pages, n_sg;
+    unsigned i, offset = 0;
+    struct device *dev = &p->pdev->dev;
+    unsigned long first_page = (addr & PAGE_MASK) >> PAGE_SHIFT;
+    unsigned long last_page = ((addr + nbytes - 1) & PAGE_MASK) >> PAGE_SHIFT;
+    unsigned first_page_offset = offset_in_page(addr);
+    unsigned npages = last_page - first_page + 1;
+    struct page **pages;
+    struct scatterlist *sgl, *sg;
+
+    pages = kmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
+    if (unlikely(!pages)) {
+        ret = -ENOMEM;
+        goto out;
+    }
+
+    n_user_pages = get_user_pages_fast(addr, npages, 0, pages);
+    if (n_user_pages < 0) {
+        dev_err(dev, "Failed at get_user_pages(): %d\n", n_user_pages);
+        ret = n_user_pages;
+        goto out_free_pages;
+    }
+
+    sgl = kmalloc_array(n_user_pages, sizeof(struct scatterlist), GFP_KERNEL);
+    if (unlikely(!sgl)) {
+        ret = -ENOMEM;
+        goto out_free_pages;
+    }
+
+    sg_init_table(sgl, n_user_pages);
+    /* first page */
+    sg_set_page(&sgl[0], pages[0], nbytes < (PAGE_SIZE - first_page_offset) ? nbytes : (PAGE_SIZE -first_page_offset) /* len */, offset_in_page(addr));
+    /* middle pages */
+    for(int i = 1; i < n_user_pages - 1; i++)
+        sg_set_page(&sgl[i], pages[i], PAGE_SIZE, 0);
+    /* last page */
+    if (n_user_pages > 1)
+        sg_set_page(&sgl[n_user_pages-1], pages[n_user_pages-1], nbytes - (PAGE_SIZE - first_page_offset) - ((n_user_pages-2)*PAGE_SIZE), 0);
+
+    n_sg = dma_map_sg(dev, sgl, n_user_pages, DMA_TO_DEVICE);
+    if (n_sg == 0) {
+        ret = -EIO;
+        goto out_free_sgl;
+    }
+    for_each_sg(sgl, sg, n_sg, i) {
+        writeb(opcode,             p->registers.opcode);
+        writel(sg_dma_len(sg),     p->registers.length);
+        writeq(sg_dma_address(sg), p->registers.addr);
+        writel(offset,             p->registers.offset);
+        offset += sg_dma_len(sg);
+        writeb(EBPF_CTRL_START,    p->registers.ctrl);
+
+        /* Check if DMA is finished. This bit will be set by the device */
+        if (!watch_and_sleep(p->registers.ctrl, EBPF_CTRL_DMA_DONE, 100)) {
+            dev_err(dev, "DMA timed out\n");
+            ret = -ETIME;
+            break;
+        }
+    }
+    for (int i = 0; i < n_user_pages; i++) {
+        put_page(pages[i]);
+    }
+
+    dma_unmap_sg(dev, sgl, n_user_pages, DMA_TO_DEVICE);
+out_free_sgl:
+    kfree(sgl);
+out_free_pages:
+    kfree(pages);
+out:
+    return ret;
+}
+
+And it can start execution with
+
+/*
+ * We can "move" the start of the ".data" segment by specifing an offset
+ * (from the beginning of ".data")
+ */
+static int run_program(struct pci_ubpf_dev *p, uint64_t offset)
+{
+    int finished;
+    volatile uint8_t *ready = p->mmio + 0x200004;
+
+    writeb(0x04,   p->registers.opcode);
+    writel(offset, p->registers.offset);
+    writeb(0x1,    p->registers.ctrl);
+
+    finished = watch_and_sleep(ready, 0x1, 100);
+
+    return finished ? readq(p->registers.ret) : -ETIME;
+}
+
+static inline bool watch_and_sleep(volatile uint8_t *ptr, uint8_t mask, unsigned long ms)
+{
+    unsigned iters = 100;
+    unsigned long time_per_iter = ms/iters;
+
+    for (unsigned i = 0; i < iters; i++) {
+        if ((readb(ptr) & mask))
+            return 1;
+        msleep(time_per_iter);
+    }
+    return 0;
+}
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c71e07ae35..500bfd1931 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
 common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
+common-obj-$(CONFIG_LIBUBPF) += pcie-ebpf.o
 
 common-obj-y += unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
@@ -77,3 +78,5 @@ obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
+
+pcie-ebpf.o-libs   := -lubpf
diff --git a/hw/misc/pcie-ebpf.c b/hw/misc/pcie-ebpf.c
new file mode 100644
index 0000000000..af47c8d2d6
--- /dev/null
+++ b/hw/misc/pcie-ebpf.c
@@ -0,0 +1,513 @@
+/*
+ * QEMU BPF-capable PCI device
+ * Copyright (c) 2019 Martin Ichilevici de Oliveira
+ *
+ * Inspired by QEMU educational PCI device
+ * Copyright (c) 2012-2015 Jiri Slaby
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * This sample PCIe device shows how to offload eBPF computation using the uBPF
+ * library (https://github.com/iovisor/ubpf).
+ * A sample driver can be found at https://github.com/iomartin/pci_ubpf_driver
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "qemu/main-loop.h" /* iothread mutex */
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include <ubpf.h>
+#include <elf.h>
+
+#define TYPE_PCI_BPF_DEVICE "pcie-ubpf"
+#define BPF(obj)        OBJECT_CHECK(BpfState, obj, TYPE_PCI_BPF_DEVICE)
+
+#define DMA_SIZE        4096
+
+#define EBPF_OPCODE_OFFSET      0x00
+#define EBPF_CTRL_OFFSET        0x01
+#define EBPF_LENGTH_OFFSET      0x04
+#define EBPF_OFFSET_OFFSET      0x08
+#define EBPF_ADDR_OFFSET_LOW    0x0c
+#define EBPF_ADDR_OFFSET_HIGH   0x10
+
+#define EBPF_TEXT_LEN_OFFSET    0x100000
+#define EBPF_MEM_LEN_OFFSET     0x100004
+#define EBPF_TEXT_OFFSET        0x100100
+#define EBPF_RET_OFFSET         0x200000
+#define EBPF_READY_OFFSET       0x200004
+#define EBPF_REGS_OFFSET        0x200008
+#define EBPF_MEM_OFFSET         0x400000
+#define EBPF_P2P_OFFSET         0x800000
+
+#define EBPF_OFFLOAD_OPCODE_DMA_TEXT      0x00
+#define EBPF_OFFLOAD_OPCODE_MOVE_P2P_TEXT 0x01
+#define EBPF_OFFLOAD_OPCODE_DMA_DATA      0x02
+#define EBPF_OFFLOAD_OPCODE_MOVE_P2P_DATA 0x03
+#define EBPF_OFFLOAD_OPCODE_RUN_PROG      0x04
+#define EBPF_OFFLOAD_OPCODE_GET_REGS      0x05
+#define EBPF_OFFLOAD_OPCODE_DUMP_MEM      0xff
+
+#define EBPF_NOT_READY          0x0
+#define EBPF_READY              0x1
+#define DMA_DONE                0x4
+
+#define EBPF_BAR_SIZE           (16 * MiB)
+#define EBPF_RAM_SIZE           EBPF_BAR_SIZE
+#define EBPF_MMIO_SIZE          (1 * MiB)
+#define EBPF_RAM_OFFSET         (0x0)
+#define EBPF_MMIO_OFFSET        (0 * MiB)
+
+typedef struct {
+    PCIDevice pdev;
+    MemoryRegion bpf_bar;
+    MemoryRegion bpf_ram;
+    MemoryRegion bpf_mmio;
+
+    struct ubpf_vm *vm;
+
+    QemuThread thread;
+    QemuMutex thr_mutex;
+    QemuCond thr_cond;
+    bool stopping;
+
+#define BPF_STATUS_COMPUTING    0x01
+    uint32_t status;
+
+    struct command {
+        uint8_t opcode;
+        uint8_t ctrl;
+        uint32_t length;
+        uint32_t offset;
+        uint64_t addr;
+    } cmd;
+    char dma_buf[DMA_SIZE];
+    uint64_t dma_mask;
+} BpfState;
+
+/* Function hexDump was copied from https://stackoverflow.com/a/7776146 */
+static void hexDump (const char *desc, void *addr, int len)
+{
+    int i;
+    unsigned char buff[17];
+    unsigned char *pc = (unsigned char *)addr;
+
+    /* Output description if given. */
+    if (desc != NULL) {
+        printf("%s (%d bytes):\n", desc, len);
+    }
+
+    if (len == 0) {
+        printf("  ZERO LENGTH\n");
+        return;
+    }
+    if (len < 0) {
+        printf("  NEGATIVE LENGTH: %i\n", len);
+        return;
+    }
+
+    /* Process every byte in the data. */
+    for (i = 0; i < len; i++) {
+        /* Multiple of 16 means new line (with line offset). */
+
+        if ((i % 16) == 0) {
+            /* Just don't print ASCII for the zeroth line. */
+            if (i != 0) {
+                printf("  %s\n", buff);
+            }
+
+            /* Output the offset. */
+            printf("  %04x ", i);
+        }
+
+        /* Now the hex code for the specific character. */
+        printf(" %02x", pc[i]);
+
+        /* And store a printable ASCII character for later. */
+        if ((pc[i] < 0x20) || (pc[i] > 0x7e)) {
+            buff[i % 16] = '.';
+        } else {
+            buff[i % 16] = pc[i];
+        }
+        buff[(i % 16) + 1] = '\0';
+    }
+
+    /* Pad out last line if not exactly 16 characters. */
+    while ((i % 16) != 0) {
+        printf("   ");
+        i++;
+    }
+
+    /* And print the final ASCII bit. */
+    printf("  %s\n", buff);
+}
+
+/* Execute the eBPF program */
+static int bpf_start_program(BpfState *bpf)
+{
+    char *bpf_ram_ptr = (char *) memory_region_get_ram_ptr(&bpf->bpf_ram);
+    uint32_t code_len = *(uint32_t *) (bpf_ram_ptr + EBPF_TEXT_LEN_OFFSET);
+    uint32_t mem_len =  *(uint32_t *) (bpf_ram_ptr + EBPF_MEM_LEN_OFFSET);
+    void *code = bpf_ram_ptr + EBPF_TEXT_OFFSET;
+    void *mem  = bpf_ram_ptr + EBPF_MEM_OFFSET + bpf->cmd.offset;
+    uint64_t *regs = (uint64_t *) (bpf_ram_ptr + EBPF_REGS_OFFSET);
+    bool *ready_addr = (bool *) (bpf_ram_ptr + EBPF_READY_OFFSET);
+    uint64_t *ret_addr = (uint64_t *) (bpf_ram_ptr + EBPF_RET_OFFSET);
+
+    char *errmsg;
+    int32_t rv;
+    uint64_t ret;
+    bool elf;
+
+    /* This address is checked by the host to see if execution has finished */
+    *ready_addr = EBPF_NOT_READY;
+
+    bpf->vm = ubpf_create();
+    if (!bpf->vm) {
+        fprintf(stderr, "Failed to create VM\n");
+        return 1;
+    }
+
+    /* Check magic number (first 4 bytes), to see if program is in ELF format */
+    elf = code_len >= 4 && !memcmp(code, ELFMAG, 4);
+    if (elf) {
+        rv = ubpf_load_elf(bpf->vm, code, code_len, &errmsg);
+    } else {
+        rv = ubpf_load(bpf->vm, code, code_len, &errmsg);
+    }
+
+    if (rv < 0) {
+        fprintf(stderr, "Failed to load code: %s\n", errmsg);
+        ubpf_destroy(bpf->vm);
+        bpf->vm = NULL;
+        free(errmsg);
+        return 1;
+    }
+
+    ubpf_set_registers(bpf->vm, regs);
+    if (mem_len > 0) {
+        ret = ubpf_exec(bpf->vm, mem, mem_len);
+    } else {
+        ret = ubpf_exec(bpf->vm, NULL, 0);
+    }
+
+    *ret_addr = ret;
+
+    ubpf_destroy(bpf->vm);
+    bpf->vm = NULL;
+    *ready_addr = EBPF_READY;
+
+    return 0;
+}
+
+/*
+ * Copy data to the .text segment. If inp2p is true, then we copy from the
+ * p2pdma area. Otherwise, use DMA to copy from the host.
+ */
+static void load_text(BpfState *bpf, bool inp2p)
+{
+    char *bpf_ram_ptr = (char *) memory_region_get_ram_ptr(&bpf->bpf_ram);
+    void *code = bpf_ram_ptr + EBPF_TEXT_OFFSET;
+    uint32_t *code_len = (uint32_t *) (bpf_ram_ptr + EBPF_TEXT_LEN_OFFSET);
+
+    if (inp2p) {
+        memcpy(code, bpf_ram_ptr + EBPF_P2P_OFFSET + bpf->cmd.offset,
+                bpf->cmd.length);
+    } else {
+        pci_dma_read(&bpf->pdev, bpf->cmd.addr, code + bpf->cmd.offset,
+                bpf->cmd.length);
+    }
+
+    if (bpf->cmd.offset == 0) {
+        *code_len = bpf->cmd.length;
+    } else {
+        *code_len += bpf->cmd.length;
+    }
+
+    atomic_or(&bpf->cmd.ctrl, DMA_DONE);
+}
+
+/*
+ * Copy data to the .data segment. If inp2p is true, then we copy from the
+ * p2pdma area. Otherwise, use DMA to copy from the host.
+ */
+static void load_data(BpfState *bpf, bool inp2p)
+{
+    char *bpf_ram_ptr = (char *) memory_region_get_ram_ptr(&bpf->bpf_ram);
+    void *mem = bpf_ram_ptr + EBPF_MEM_OFFSET;
+    uint32_t *mem_len =  (uint32_t *) (bpf_ram_ptr + EBPF_MEM_LEN_OFFSET);
+
+    if (inp2p) {
+        memcpy(mem, bpf_ram_ptr + EBPF_P2P_OFFSET + bpf->cmd.offset,
+                bpf->cmd.length);
+    } else {
+        pci_dma_read(&bpf->pdev, bpf->cmd.addr, mem + bpf->cmd.offset,
+                bpf->cmd.length);
+    }
+
+    if (bpf->cmd.offset == 0) {
+        *mem_len = bpf->cmd.length;
+    } else {
+        *mem_len += bpf->cmd.length;
+    }
+
+    atomic_or(&bpf->cmd.ctrl, DMA_DONE);
+}
+
+static inline void run_program(BpfState *bpf)
+{
+    bpf_start_program(bpf);
+}
+
+/*
+ * Useful for debugging. Print both the .text and the .data segments to
+ * screen (note it is not transferred to the host).
+ */
+static void dump_memory(BpfState *bpf)
+{
+    char *bpf_ram_ptr = (char *) memory_region_get_ram_ptr(&bpf->bpf_ram);
+    uint32_t code_len = *(uint32_t *) (bpf_ram_ptr + EBPF_TEXT_LEN_OFFSET);
+    uint32_t mem_len =  *(uint32_t *) (bpf_ram_ptr + EBPF_MEM_LEN_OFFSET);
+
+    hexDump("prog", bpf_ram_ptr + EBPF_TEXT_OFFSET, code_len);
+    hexDump("data", bpf_ram_ptr + EBPF_MEM_OFFSET, mem_len);
+}
+
+static void process_command(BpfState *bpf)
+{
+    fprintf(stderr, "Process Command: Opcode: [0x%02x]\t"
+                    "Length: [%u]\tAddr: [0x%08lx]\tOffset: [0x%u]\n",
+            bpf->cmd.opcode, bpf->cmd.length, bpf->cmd.addr, bpf->cmd.offset);
+
+    switch (bpf->cmd.opcode) {
+    case EBPF_OFFLOAD_OPCODE_DMA_TEXT:
+    case EBPF_OFFLOAD_OPCODE_MOVE_P2P_TEXT:
+        load_text(bpf, bpf->cmd.opcode == EBPF_OFFLOAD_OPCODE_MOVE_P2P_TEXT);
+        break;
+    case EBPF_OFFLOAD_OPCODE_DMA_DATA:
+    case EBPF_OFFLOAD_OPCODE_MOVE_P2P_DATA:
+        load_data(bpf, bpf->cmd.opcode == EBPF_OFFLOAD_OPCODE_MOVE_P2P_DATA);
+        break;
+    case EBPF_OFFLOAD_OPCODE_RUN_PROG:
+        run_program(bpf);
+        break;
+    case EBPF_OFFLOAD_OPCODE_DUMP_MEM:
+        dump_memory(bpf);
+        break;
+    default:
+        fprintf(stderr, "Invalid opcode: %u\n", bpf->cmd.opcode & 0xff);
+    }
+}
+
+static uint64_t bpf_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BpfState *bpf = opaque;
+    uint64_t val = ~0ULL;
+
+    switch (addr) {
+    case EBPF_OPCODE_OFFSET:
+        val = bpf->cmd.opcode;
+        break;
+    case EBPF_CTRL_OFFSET:
+        val = bpf->cmd.ctrl;
+        break;
+    case EBPF_LENGTH_OFFSET:
+        val = bpf->cmd.length;
+        break;
+    case EBPF_OFFSET_OFFSET:
+        val = bpf->cmd.offset;
+        break;
+    case EBPF_ADDR_OFFSET_LOW:
+    case EBPF_ADDR_OFFSET_HIGH:
+        val = bpf->cmd.addr;
+        break;
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void bpf_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                unsigned size)
+{
+    BpfState *bpf = opaque;
+
+    switch (addr & 0xff) {
+    case EBPF_OPCODE_OFFSET:
+        bpf->cmd.opcode = val & 0xff;
+        break;
+    case EBPF_CTRL_OFFSET:
+        bpf->cmd.ctrl = val & 0xff;
+        qemu_mutex_lock(&bpf->thr_mutex);
+        atomic_or(&bpf->status, BPF_STATUS_COMPUTING);
+        qemu_cond_signal(&bpf->thr_cond);
+        qemu_mutex_unlock(&bpf->thr_mutex);
+        break;
+    case EBPF_LENGTH_OFFSET:
+        bpf->cmd.length = val;
+        break;
+    case EBPF_OFFSET_OFFSET:
+        bpf->cmd.offset = val;
+        break;
+    case EBPF_ADDR_OFFSET_LOW:
+        bpf->cmd.addr = val;
+        break;
+    case EBPF_ADDR_OFFSET_HIGH:
+        bpf->cmd.addr = (val << 32) | bpf->cmd.addr;
+        break;
+    }
+}
+
+static const MemoryRegionOps bpf_mmio_ops = {
+    .read = bpf_mmio_read,
+    .write = bpf_mmio_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+/*
+ * We purposely use a thread, so that users are forced to wait for the status
+ * register.
+ */
+static void *bpf_cmd_thread(void *opaque)
+{
+    BpfState *bpf = opaque;
+
+    while (1) {
+
+        qemu_mutex_lock(&bpf->thr_mutex);
+        while ((atomic_read(&bpf->status) & BPF_STATUS_COMPUTING) == 0 &&
+                        !bpf->stopping) {
+            qemu_cond_wait(&bpf->thr_cond, &bpf->thr_mutex);
+        }
+
+        if (bpf->stopping) {
+            qemu_mutex_unlock(&bpf->thr_mutex);
+            break;
+        }
+
+        process_command(bpf);
+        qemu_mutex_unlock(&bpf->thr_mutex);
+
+        atomic_and(&bpf->status, ~BPF_STATUS_COMPUTING);
+    }
+
+    return NULL;
+}
+
+static void pci_bpf_realize(PCIDevice *pdev, Error **errp)
+{
+    BpfState *bpf = BPF(pdev);
+    uint8_t *pci_conf = pdev->config;
+
+    pci_config_set_interrupt_pin(pci_conf, 1);
+
+    if (msi_init(pdev, 0, 1, true, false, errp)) {
+        return;
+    }
+
+    qemu_mutex_init(&bpf->thr_mutex);
+    qemu_cond_init(&bpf->thr_cond);
+    qemu_thread_create(&bpf->thread, "bpf", bpf_cmd_thread,
+                       bpf, QEMU_THREAD_JOINABLE);
+
+    memory_region_init(&bpf->bpf_bar, OBJECT(bpf), "bpf-bar", EBPF_BAR_SIZE);
+    memory_region_init_ram(&bpf->bpf_ram, OBJECT(bpf), "bpf-ram", EBPF_RAM_SIZE,
+            &error_fatal);
+    memory_region_init_io(&bpf->bpf_mmio, OBJECT(bpf), &bpf_mmio_ops, bpf,
+                    "bpf-mmio", EBPF_MMIO_SIZE);
+    memory_region_add_subregion_overlap(&bpf->bpf_bar, EBPF_RAM_OFFSET,
+            &bpf->bpf_ram, 1);
+    memory_region_add_subregion_overlap(&bpf->bpf_bar, EBPF_MMIO_OFFSET,
+            &bpf->bpf_mmio, 2);
+    pci_register_bar(pdev, 4,
+            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_PREFETCH,
+            &bpf->bpf_bar);
+}
+
+static void pci_bpf_uninit(PCIDevice *pdev)
+{
+    BpfState *bpf = BPF(pdev);
+
+    qemu_mutex_lock(&bpf->thr_mutex);
+    bpf->stopping = true;
+    qemu_mutex_unlock(&bpf->thr_mutex);
+    qemu_cond_signal(&bpf->thr_cond);
+    qemu_thread_join(&bpf->thread);
+
+    qemu_cond_destroy(&bpf->thr_cond);
+    qemu_mutex_destroy(&bpf->thr_mutex);
+}
+
+static void bpf_obj_uint64(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    uint64_t *val = opaque;
+
+    visit_type_uint64(v, name, val, errp);
+}
+
+static void bpf_instance_init(Object *obj)
+{
+    BpfState *bpf = BPF(obj);
+
+    bpf->dma_mask = ~0ULL; /* 64-bit */
+    object_property_add(obj, "dma_mask", "uint64", bpf_obj_uint64,
+                    bpf_obj_uint64, NULL, &bpf->dma_mask, NULL);
+}
+
+static void bpf_class_init(ObjectClass *class, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
+
+    k->realize = pci_bpf_realize;
+    k->exit = pci_bpf_uninit;
+    k->vendor_id = 0x1de5; /* Eideticom */
+    k->device_id = 0x3000;
+    k->revision = 0x10;
+    k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void pci_bpf_register_types(void)
+{
+    static InterfaceInfo interfaces[] = {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    };
+    static const TypeInfo bpf_info = {
+        .name          = TYPE_PCI_BPF_DEVICE,
+        .parent        = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(BpfState),
+        .instance_init = bpf_instance_init,
+        .class_init    = bpf_class_init,
+        .interfaces = interfaces,
+    };
+
+    type_register_static(&bpf_info);
+}
+type_init(pci_bpf_register_types)
-- 
2.21.0


