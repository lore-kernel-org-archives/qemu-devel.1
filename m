Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A2C48BD3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D3520663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XqGYR2sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D3520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXHl-0004X4-48
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEM-0002Is-En
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEK-0008TU-CU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEK-0008N2-33; Mon, 24 Jun 2019 18:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561414512; x=1592950512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VSX/lTm1FfCnSq76Fl/EIw7/gylhHoPDOqjPWphv8bg=;
 b=XqGYR2sZ/d1wAwHOGLpzCIDHkDqFDy9dCyXU7gsMShVoZ1UnH3IlXPi4
 2tVR/0a8BElNi+EpEey78rnNekndhA3G4kY+U6iWRL+ROUEZDRa4Zhcgg
 d5UtiisWeKRvxf/5TqAoq+HO8mUr2TUREseYo9dbdMphtehS1CsJRJmWy
 fDpG0rkfZK71eKdmTG/MRz5TMD78tbtVuV9otpr7EW6U2GKMaxjk5hD5y
 koUEvUBE9Lubc8GkffJCKM2H4eA+/iadofbwiD15SzYt6JhUyBpioba+W
 ERruE8PiZGuxqRvgU6OSCNslG+eR80tZX7EGJ7WX3vZjAFSIZSdG0zyRQ A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211210911"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:15:05 +0800
IronPort-SDR: 8fDIrg/yh0nl3KRmnavelRJaNpJQ7/AVJjFbg1r3/2YJ5MnHEcfz4vC5EUTD6aydk9RZLhLm+u
 4QIyqdWZk/EKSKXX+jsuvPx6yu+HcNq3cBfmwWCalTiANnjl1Owe+PTPGy2O0NZ2QTlJxk5KqN
 fEP3wePmwnZysjkuY02Z9DF5X0ZNCKA+q21Kw12Be5pOQBDLDxcN6VN9w9bCWrz6CIl6xehYqu
 IYHMogItIqjzYjhCFVSU6+EsoYcPlWcn5MyiJH4yUXnn0XZH1SFrr45XxvabqubFeovwgwa7uA
 xXvuDpnpwxQ64Vs4u3oWX9DN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 15:13:41 -0700
IronPort-SDR: t9Mg3nqyYVmSibuFL+FLky+xBq+H1uCG1N76Bdlq6mJfekpLhqMyBCSQkX4emJLvG0EKi0tGgB
 Fthh/tsHBsWmxW4PuSXcAJ4oYEsk61VISu18IsD2XnfzZHgR079gYe1HQRaroT0G6PlE/EfGmG
 MGXdI2LbTiXn6oooSnVdz/yBy5knz2eCjyVr8LVhzoB1veaZ/KMiKIV/BwrSNA2uNM+PvI/YwD
 dex1UwITZ4+QiUmQkma7tPv4F7IOCIPtudyyOyAYpz2K6NEGWb2wJMHS3tUPX+2wUi3v+hjJ0W
 zng=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 15:14:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 15:11:54 -0700
Message-Id: <03cdfe700a884b52a9f6da0e50bc0693c9a61e03.1561414240.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561414240.git.alistair.francis@wdc.com>
References: <cover.1561414240.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 3/5] hw/riscv: Extend the kernel loading
 support
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the RISC-V kernel loader to support Image and uImage files.
A Linux kernel can now be booted with:

    qemu-system-riscv64 -machine virt -bios fw_jump.bin -kernel Image

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 883df49a0c..ff023f42d0 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -56,12 +56,22 @@ target_ulong riscv_load_kernel(const char *kernel_filename)
     uint64_t kernel_entry, kernel_high;
 
     if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
+                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
+        return kernel_entry;
     }
 
-    return kernel_entry;
+    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
+                       NULL, NULL, NULL) > 0) {
+        return kernel_entry;
+    }
+
+    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
+                               ram_size, NULL) > 0) {
+        return KERNEL_BOOT_ADDRESS;
+    }
+
+    error_report("could not load kernel '%s'", kernel_filename);
+    exit(1);
 }
 
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
-- 
2.22.0


