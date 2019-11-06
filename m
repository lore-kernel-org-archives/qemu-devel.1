Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3196FC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040962178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040962178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOCR-0008Sb-Vn
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSO6V-0002gm-Lb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSO6U-0000MO-9T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:19 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34941)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSO6U-0000L9-08
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:18 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOzCW-1iIPpd1KP6-00PLNF; Wed, 06 Nov 2019 17:24:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 1/3] hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to
 PnP registers
Date: Wed,  6 Nov 2019 17:24:04 +0100
Message-Id: <20191106162406.27030-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106162406.27030-1-laurent@vivier.eu>
References: <20191106162406.27030-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xqHxOuOcbR5HhkI7dFHILMKAOXOpewRa3IX2sKcI9+qQ7MRYhjw
 7fRePBurg3PpvUzY7B3Rl0xvDcXD4W5P0ZLELkjUi/I4vO2jVsIqfIujbKQyUbqPoJBFWlr
 vKKfbvdYXfgxAC0B4DDG+naYiWrgWWETOtsY+HSw6eGxfgTQkG78LG+bLjI+zLEbPyrMk/y
 bI1hk6SQoBpOF8boaxodg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gzDSXSbdnVM=:9eHUV01wpuZOcw4CUEHEd7
 HA/XccQvPUYCikGIzzknVZeRaV86xt/PMAhDSX7OPdprYeUTCDAh7xCe08lVPOj5m2kKQhGbA
 iKJ6WQmB1Qrg0v+FC1+AKWCgp3mR6w64LPw4fs+QIA5L8Xnk9kLX/o+4dCRNqkzgIf+3PjEIb
 XSCO3RutTUjAKnHpp/FTL3Gk+E+QXxXdS7pMiGdxpUy1l3f55sAsETisAXRskwpNPorlyJtu1
 /w7k/GX7/dSuPG6fcDUKkJfDNP8GHRurgMKKkdCiolakzJiiTMwPl0dSqsbMriDgsQkIDPwp9
 JeMyN2E9tG+LGsB5leaxxhYKzCrIkJkMIbN0FGbxlJ0E9kD7rGybiM8yUqiub6arwFBNDFUnX
 kL3prlP4L/mi3abrn92upGS/eIVdttWjya5lG6Dgudi6f3kZsop857b6+qiA+WwJ8mZjegtAs
 TZ7qGUaOXvt/+s6s4Jg35kvoX5HrF+7Bvjz81XHEvuQWRVDFbScxBP2r4gG6hEQ7FmtMfrnkW
 potRmDkAqBFl44fgRjGPZF3LUd5LwLslGJxcpXReuD/TmDZ9yBmttgZ2a/SdJJiv6xZLP7tom
 5R/lXA+EcomVNnuQ2+T812G1zQxfJh/Vtnd/QUey7kE4u/rftu8WSCrk9pRDGREBy3TMq/v6b
 fun+cuqK5IPCq6VbHfaQzCP/CfG9yuMiNuPFwSYLw8DvINXeY0q8Vp2JmVWb23C/wHM1Q296n
 QZBS/DLGMnNbLfb36pTxJwld2Z4Wdy01o6Zp8PWkppXm6xHVnY2WpT29g+0Blao8lFVtWmTcv
 VJ4nAzWMkGJ5IIK6llqFz/K6kx/DAJQ1HIV7AHlOY0Xe0VCSCdLzRb7Q6KFtAseBvwkIPIpZF
 nOmNEm+d4gCUvjFpGgAq1zw+83LM75AKS9ruVGb7k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Guests can crash QEMU when writting to PnP registers:

  $ echo 'writeb 0x800ff042 69' | qemu-system-sparc -M leon3_generic -S -bios /etc/magic -qtest stdio
  [I 1571938309.932255] OPENED
  [R +0.063474] writeb 0x800ff042 69
  Segmentation fault (core dumped)

  (gdb) bt
  #0  0x0000000000000000 in  ()
  #1  0x0000555f4bcdf0bc in memory_region_write_with_attrs_accessor (mr=0x555f4d7be8c0, addr=66, value=0x7fff07d00f08, size=1, shift=0, mask=255, attrs=...) at memory.c:503
  #2  0x0000555f4bcdf185 in access_with_adjusted_size (addr=66, value=0x7fff07d00f08, size=1, access_size_min=1, access_size_max=4, access_fn=0x555f4bcdeff4 <memory_region_write_with_attrs_accessor>, mr=0x555f4d7be8c0, attrs=...) at memory.c:539
  #3  0x0000555f4bce2243 in memory_region_dispatch_write (mr=0x555f4d7be8c0, addr=66, data=69, op=MO_8, attrs=...) at memory.c:1489
  #4  0x0000555f4bc80b20 in flatview_write_continue (fv=0x555f4d92c400, addr=2148528194, attrs=..., buf=0x7fff07d01120 "E", len=1, addr1=66, l=1, mr=0x555f4d7be8c0) at exec.c:3161
  #5  0x0000555f4bc80c65 in flatview_write (fv=0x555f4d92c400, addr=2148528194, attrs=..., buf=0x7fff07d01120 "E", len=1) at exec.c:3201
  #6  0x0000555f4bc80fb0 in address_space_write (as=0x555f4d7aa460, addr=2148528194, attrs=..., buf=0x7fff07d01120 "E", len=1) at exec.c:3291
  #7  0x0000555f4bc8101d in address_space_rw (as=0x555f4d7aa460, addr=2148528194, attrs=..., buf=0x7fff07d01120 "E", len=1, is_write=true) at exec.c:3301
  #8  0x0000555f4bcdb388 in qtest_process_command (chr=0x555f4c2ed7e0 <qtest_chr>, words=0x555f4db0c5d0) at qtest.c:432

Instead of crashing, log the access as unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20191025110114.27091-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/grlib_ahb_apb_pnp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 7338461694c9..f3c015d2c35f 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 
@@ -231,8 +232,15 @@ static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
     return apb_pnp->regs[offset >> 2];
 }
 
+static void grlib_apb_pnp_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+}
+
 static const MemoryRegionOps grlib_apb_pnp_ops = {
     .read       = grlib_apb_pnp_read,
+    .write      = grlib_apb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-- 
2.21.0


