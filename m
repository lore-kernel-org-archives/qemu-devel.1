Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBB220650
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBB220650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS302-0004Ai-AI
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 12:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS2yd-0002O7-HA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS2yc-0004Y7-8g
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:47 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35453)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS2yc-0004Xc-0T; Tue, 05 Nov 2019 12:50:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS4ab-1iLlQr1IPT-00TQkF; Tue, 05 Nov 2019 18:50:22 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/3] hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to
 PnP registers
Date: Tue,  5 Nov 2019 18:50:08 +0100
Message-Id: <20191105175010.2591-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105175010.2591-1-laurent@vivier.eu>
References: <20191105175010.2591-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xIRSM2QcNuucJtLEhlYRpyW0YjRZeJsUZwbZz0pkdgW0UYo3LqF
 H3VqTkrZ07U49UA806XDzr3Eju+3GmLsm40n7fx4b0SzVs56y4F+xbyQCPixXFPc5Q3kgIw
 EY0j5y8UkYd5jzWOpVGbpISd6LfX6AOdxr175i30dnhQaF4Tim81ZAQcG9k2DA5PhoxKHze
 nBr5mcduF/rlk8MasQWLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+7GRlHCA3/U=:3wOwnQgqgieEE2UdVEQkBf
 AxFgA2QCER1KmhRTkqiCowOTDjBEHT4p2OJhihJVW4HDKwO9JRZu3zMNaMu+K8l925y4sU/oq
 tq6brI+MKJ0OWG1UjN5u5U4KphyWdBBVPZVomvckUNPB6O4hfs8nTkQAM4yuDyoqfPLUITO1F
 lFgUEMy1Sjo7mXi+QoWkF+rruNbYZTOtL2nzQw3W5l3Jvs5NxauTbs6A3iihSn7luS3wptloE
 BfAwrpiXClbcca518oryCGE944yV+vrYd0HJVNt9AWpFl0bKLvGuP4jtWo1v/qy/XDxQvUpFr
 j1sz9qF5aTU/u42lDa+YxPfxAqltPozm1ooO0yXHOu7ET1q7pDoFy/fhwhOFknTkYKUogzmzR
 rmD3j/IPjFsZHxCvnDbpzabNoxAvTiLpI3niJeLjojzjSqKgsphJrMl3FFykSTfwiavWzxahn
 yh8uIH+1n6COxaqx60fSXDu6zz/2M17c+G1zFRfkEarEt20g1BhWWKX4+8wSyqXIF3FHz6kZ0
 LSKjML7WmHEs8oNCzK6hdBTPUGl+LKH5UjwXoen1QojU7dhhEertzAQQJC6d6h2Ve5AcVM0GC
 qsR77WK7kwyudeZW2+qxomkznEFN6mAcqlNO045GqQ+eTc52iP9Ch8lu5m04350pl1WsiAEGe
 4XvlTTPWL8x9eqzkq4/NaRm7k+o34TkBhu+a7UoBySqTv4KGZZA2sMUlMbtjcvL/kIQ8JZwzc
 NbBoebBQrF0lC/hmPxWPOH0uOShbJZJFX9xgxvpUHm+4zkyI1okfvWFQBNK2O4jy+zCIPWViL
 bpwnT7JgeXZ1VHg8iQwGja8Lxq52IGp4X8Mnit8BxNRFnWCB7Wk7iPti+7zZHos3EKRHOvaYS
 N1CjbUT9twQNk3pBFKqsHEwjeLP4r/zwfcikmNwjY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 qemu-trivial@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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


