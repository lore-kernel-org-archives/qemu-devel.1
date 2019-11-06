Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78913C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF982067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF982067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOAR-00066r-Fy
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSO6U-0002eX-LD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSO6T-0000LF-Gh
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:18 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSO6T-0000KH-7o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Md6dH-1hsm2D0fvH-00aHic; Wed, 06 Nov 2019 17:24:10 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 2/3] hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
Date: Wed,  6 Nov 2019 17:24:05 +0100
Message-Id: <20191106162406.27030-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106162406.27030-1-laurent@vivier.eu>
References: <20191106162406.27030-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8H19g5k0tZ5IS5wAvLOztZOlZfVwgHdxyki+sekE5FPdVJ7EBSP
 De5aqro8pcUaqxGlE29PoAbTCJzFz38j3u8EdAKz+A4l8YFehKD34OXiqKNTTjBBM/v4XKz
 MES7BHvVfhoTOypHczoCh8JVLqcTKWyY8A+tGwQ4KSgcExcPf/SC71YnWmGj32a6PTKimKd
 c4t2z31Xo8II/L1Lb0Jwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4fZm/hmD2b8=:hfm8+RpWPB01q0cpvF6UY4
 0MXf0xSpT9nkF4rbPdOhGirpbN8l/60eXU/wg5jJgw+Obw+rNR4TpqdnZEMa1V+9LGmh62Jmy
 Zrr2+NApVtGATGNm5D/AofbS9ToNM/UL48/Sg10zzRZuV1iIASjKUyrkIZguEats9YlKaWM+n
 peoEWAEcFjP2WKO9jMhEee8swT6dChOVj38eIaC0XN08nnQMKhUOfJwAJ25DTPs+uo2R3QRsX
 0AAPYh8/qMJXxvfAUDu/DFtB8auIbOW98Va4XFDzuC9IbwvHjJ2QXtTEgU4jN4MN0EP7JG0kT
 pgaKtD50pKSBM+mrASk8gdpdPq8obOlpXhw5sNNZ3j9qrXVoWdeZFuYidbURYdwAjYMSqCfvn
 j/k1LfGPj3Z0SG5dsvDlgdzZf22UrBWDVgz7ttBseW6Ae67QcOzo/1G88yFsnN7Bex8loll5M
 KbYhfs80+yozd/2BWiX+XkXqDo4asium3XfQqHUlgtqyR0WEA5uRF1k3mdPruP65+qk9LB4ND
 xxbcTR5o9VznFVduIaQw68+mLLRY/Wl5E7UQTJ70uexfOGre7yAeoc3//TR5qKMQkiC+PZXRK
 35ex6+xg8/04JlcYGF3JTFQsb0hdYGR55wEQY3UcqwvsVb6ivnutUKnrFWWh8tbaZstdu/30f
 gSbW0rwvP42Q10DVHcZARVr4PnHNx0viaAx5Un0dl/cjHoxVqrpSvElRaO2Jrui14OE3Dsf45
 2EIBQ1DiMCcSWE4mgzHMzdXEI3CzMm6LV+CLBEVX6vQSRmW7P01sCsI0Qg7WbTla8ipBhCOfm
 sv/BSmjbrSqfOW51uaeYAHWyOMj5sG4nHijNOj9k652YK8zNChs67UDwOF2pDjMzehBNxC72G
 5VVRo95W5QJpEp8fOnn3Z4yfO84UCd3mGnSy5Tk34=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
 Laurent Vivier <laurent@vivier.eu>, Jiri Gaisler <jiri@gaisler.se>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Plug & Play region of the AHB/APB bridge can be accessed
by various word size, however the implementation is clearly
restricted to 32-bit:

  static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
  {
      APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);

      return apb_pnp->regs[offset >> 2];
  }

Set the MemoryRegionOps::impl min/max fields to 32-bit, so
memory.c::access_with_adjusted_size() can adjust when the
access is not 32-bit.

This is required to run RTEMS on leon3, the grlib scanning
functions do byte accesses.

Reported-by: Jiri Gaisler <jiri@gaisler.se>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20191025110114.27091-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index f3c015d2c35f..e230e2536361 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -242,6 +242,10 @@ static const MemoryRegionOps grlib_apb_pnp_ops = {
     .read       = grlib_apb_pnp_read,
     .write      = grlib_apb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
-- 
2.21.0


