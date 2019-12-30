Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0BC2D0D3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317B82071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFxQen8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317B82071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilt0O-0003QY-BS
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsw2-0005cF-Cx
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsw0-0003At-PF
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:06 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsw0-0003AP-Iv; Mon, 30 Dec 2019 06:10:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id d139so11394629wmd.0;
 Mon, 30 Dec 2019 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kbgM4Ne22SluUF47X/B01KZXKLPLegc6jsc8WwYNVxA=;
 b=iFxQen8GL3YPwpoJG8jfad8Pivw/ogKUMe5HS2+mXB5dOeAeA7Jcj+qq9xJamU475f
 tl2FmaXARsXTOrRqIPwj2kP/lIBppt8taUs1LELwMbQgfpYxDtbmCm+qD0+MQNep8V3Z
 xIBAZF8U6mmZir5E/sP+ACBgsvGW+H3XCJrI2YpRJbCs1nEwhVd39GvwiTi4krQBpDKL
 0alsKbhXOlRJLhV+TfvqpPg22A7slxxZo5hPUUojW4IKQFmxI2mZ6x1b/ep5ynK+wmND
 TaETZ6pjq0H8n+v9Rs4jTgUq/cWcbQW8DN30HyQLcFtjMJIAwDRz9Bk/Bgh5Gbuh815d
 C9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kbgM4Ne22SluUF47X/B01KZXKLPLegc6jsc8WwYNVxA=;
 b=hQyT5p/kLL7gSq9j+05tv/095JDrzYMOKgg9ml0JqkeOBFQ8HlrCuKYyKnfCkS2mIs
 cH4tO3ES5/yJKcsX+25PMMoelo21XgN66hDhcFtts9lmzuH7zw8H4OrS3lzqVo+3TWk2
 pXTxfQnI8qDTZxS8RXJQ1mP8khr7fmMkQ6CtbDocYbOwg2WiIYhK2DLduaF87ieh2fXt
 zMBlyslAaWj2AF5xoKNJSWgHiyrjhCP9q4JkJz0ETr/ikD7R/kPD5EoZnVWuzrbd43/B
 rPrrhSebuXVdir0xfotJWIqY4e3aZu7K3ClUjr6TYX4q7UNRGi4YBimlAgspMM8aZJ92
 XoIw==
X-Gm-Message-State: APjAAAVdtGyvsJs60JqpwQ8oorSOEOLA9j/Tl16puaoyHYK5b04oCg/p
 K+8LmHcTPimMd9t3WavCsSoO6gs9xpo=
X-Google-Smtp-Source: APXvYqzCNuHTV8Mx5FOu8PSXKiTUR99AG10TI0XlI3m4vR9aPUBVktuHlXH0Z6JdYP91CK/y492SFw==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr33497289wmi.149.1577704203142; 
 Mon, 30 Dec 2019 03:10:03 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:10:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/6] hw/arm/cubieboard: Disable unsupported M-USB in
 device tree blob
Date: Mon, 30 Dec 2019 12:09:53 +0100
Message-Id: <20191230110953.25496-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not model the Sunxi Multipoint USB.
The Linux kernel OOPS when booting:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 144 at drivers/usb/musb/sunxi.c:400 sunxi_musb_ep_offset+0x39/0x3c
  sunxi_musb_ep_offset called with non 0 offset
  Modules linked in:
  CPU: 0 PID: 144 Comm: kworker/0:2 Not tainted 4.20.7-sunxi #5.75
  Hardware name: Allwinner sun4i/sun5i Families
  Workqueue: events deferred_probe_work_func
  [<c010d77d>] (unwind_backtrace) from [<c010a425>] (show_stack+0x11/0x14)
  [<c010a425>] (show_stack) from [<c08d9141>] (dump_stack+0x69/0x78)
  [<c08d9141>] (dump_stack) from [<c011b161>] (__warn+0xa1/0xb4)
  [<c011b161>] (__warn) from [<c011b1a7>] (warn_slowpath_fmt+0x33/0x48)
  [<c011b1a7>] (warn_slowpath_fmt) from [<c0725c81>] (sunxi_musb_ep_offset+0x39/0x3c)
  [<c0725c81>] (sunxi_musb_ep_offset) from [<c071b481>] (ep_config_from_hw+0x99/0x104)
  [<c071b481>] (ep_config_from_hw) from [<c071c8d9>] (musb_probe+0x765/0xa0c)
  [<c071c8d9>] (musb_probe) from [<c063fa4f>] (platform_drv_probe+0x33/0x68)
  [<c063fa4f>] (platform_drv_probe) from [<c063e4ef>] (really_probe+0x16f/0x1e0)
  [<c063e4ef>] (really_probe) from [<c063e67f>] (driver_probe_device+0x43/0x11c)
  [<c063e67f>] (driver_probe_device) from [<c063d0cf>] (bus_for_each_drv+0x37/0x70)
  [<c063d0cf>] (bus_for_each_drv) from [<c063e32f>] (__device_attach+0x83/0xc8)
  [<c063e32f>] (__device_attach) from [<c063da8b>] (bus_probe_device+0x5b/0x60)
  [<c063da8b>] (bus_probe_device) from [<c063b7a5>] (device_add+0x2f5/0x474)
  [<c063b7a5>] (device_add) from [<c063f8ef>] (platform_device_add+0xb7/0x184)
  [<c063f8ef>] (platform_device_add) from [<c06400df>] (platform_device_register_full+0xb3/0xc4)
  [<c06400df>] (platform_device_register_full) from [<c0725a2f>] (sunxi_musb_probe+0x1d7/0x2f4)
  [<c0725a2f>] (sunxi_musb_probe) from [<c063fa4f>] (platform_drv_probe+0x33/0x68)
  [<c063fa4f>] (platform_drv_probe) from [<c063e4ef>] (really_probe+0x16f/0x1e0)
  [<c063e4ef>] (really_probe) from [<c063e67f>] (driver_probe_device+0x43/0x11c)
  [<c063e67f>] (driver_probe_device) from [<c063d0cf>] (bus_for_each_drv+0x37/0x70)
  [<c063d0cf>] (bus_for_each_drv) from [<c063e32f>] (__device_attach+0x83/0xc8)
  [<c063e32f>] (__device_attach) from [<c063da8b>] (bus_probe_device+0x5b/0x60)
  [<c063da8b>] (bus_probe_device) from [<c063ddcf>] (deferred_probe_work_func+0x4b/0x6c)
  [<c063ddcf>] (deferred_probe_work_func) from [<c012e38b>] (process_one_work+0x167/0x384)
  [<c012e38b>] (process_one_work) from [<c012f07d>] (worker_thread+0x251/0x3fc)
  [<c012f07d>] (worker_thread) from [<c0132949>] (kthread+0xfd/0x104)
  [<c0132949>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
  Exception stack(0xc6999fb0 to 0xc6999ff8)
  9fa0:                                     00000000 00000000 00000000 00000000
  9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
  ---[ end trace b309edbca98c7de2 ]---
  musb-sunxi 1c13000.usb: Error unknown readb offset 128
  musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status -22
  musb-hdrc: probe of musb-hdrc.1.auto failed with error -22

This is not critical but confusing. To avoid the Linux kernel to
probe this device, mark it disabled in the device tree blob.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I'm not sure if this is a QEMU anti-pattern or bad practice.
I know we prefer to be as close to the hardware as possible,
but here the hardware is not changed, the dtb is. However
this makes the guest behave differently. At least we don't
have to manually edit the dts. If this is only annoying for
acceptance testing, we might consider manually editing the
dts in the tests setup().
---
 hw/arm/cubieboard.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 6dc2f1d6b6..dd10577696 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,10 +22,34 @@
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "hw/arm/allwinner-a10.h"
+#include <libfdt.h>
+
+static void cubieboard_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    static const char unsupported_compat[] = "allwinner,sun4i-a10-musb";
+    char node_path[72];
+    int offset;
+
+    offset = fdt_node_offset_by_compatible(fdt, -1, unsupported_compat);
+    while (offset >= 0) {
+        int r = fdt_get_path(fdt, offset, node_path, sizeof(node_path));
+        assert(r >= 0);
+        r = fdt_setprop_string(fdt, offset, "status", "disabled");
+        if (r < 0) {
+            error_report("%s: Couldn't disable %s: %s", __func__,
+                         unsupported_compat, fdt_strerror(r));
+            exit(1);
+        }
+        warn_report("cubieboard: disabled unsupported node %s (%s) "
+                    "in device tree", node_path, unsupported_compat);
+        offset = fdt_node_offset_by_compatible(fdt, offset, unsupported_compat);
+    }
+}
 
 static struct arm_boot_info cubieboard_binfo = {
     .loader_start = AW_A10_SDRAM_BASE,
     .board_id = 0x1008,
+    .modify_dtb = cubieboard_modify_dtb,
 };
 
 typedef struct CubieBoardState {
-- 
2.21.0


