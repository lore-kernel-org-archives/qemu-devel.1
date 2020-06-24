Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2558C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D09A20823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="ce/fSDkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D09A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0kx-0002Xi-Oc
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jo0kM-00028V-A0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:27:06 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:34656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jo0kJ-0007MJ-2w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ifRmDmpAiuLc8szhRsPc1HIUP5X2VpVMYfZ/s/WXDI=; b=ce/fSDkHljpRxH4Oytgv3H7sK
 emz5fSt9dHX74CPw4F0AT3pW4cz2ZWZQuk33r+oBhU2nj34p3JU4c3GRmddf3OnfaCnEjygZ2BGDR
 fUxDRTazcPRYtGxY8y2MWyTKEl+2TVAFZhCjnjUWQlqcFe8oo2EKCM8tL3g3QNRyJJd0E=;
Date: Wed, 24 Jun 2020 10:26:55 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: David Brenken <david.brenken@efs-auto.org>
Subject: Re: [PATCH v3 1/1] tricore: added triboard with tc27x_soc
Message-ID: <20200624082655.wotnfeha24ctul2r@schnipp-desktop>
References: <20200622131934.10328-1-david.brenken@efs-auto.org>
 <20200622131934.10328-2-david.brenken@efs-auto.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622131934.10328-2-david.brenken@efs-auto.org>
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=8624600, da=80596281,
 mc=208, sc=3, hc=205, sp=1, fso=8624600, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.24.81818, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.24.5740000
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 03:19:34PM +0200, David Brenken wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> +const MemmapEntry tc27x_soc_memmap[] = {
> +    [TC27XD_DSPR2]     = { 0x50000000,   0x1E000 },
> +    [TC27XD_DCACHE2]   = { 0x5001E000,    0x2000 },
> +    [TC27XD_DTAG2]     = { 0x500C0000,     0xC00 },

The size changed from 0xa00 to 0xc00 from v2. The manual states that it has no
size. I guess you inferred the size from the address range. How does real hw
behave if you access DTAG2?

> +    [TC27XD_PSPR2]     = { 0x50100000,    0x8000 },
> +    [TC27XD_PCACHE2]   = { 0x50108000,    0x4000 },
> +    [TC27XD_PTAG2]     = { 0x501C0000,    0x1800 },
> +    [TC27XD_DSPR1]     = { 0x60000000,   0x1E000 },
> +    [TC27XD_DCACHE1]   = { 0x6001E000,    0x2000 },
> +    [TC27XD_DTAG1]     = { 0x600C0000,     0xC00 },
> +    [TC27XD_PSPR1]     = { 0x60100000,    0x8000 },
> +    [TC27XD_PCACHE1]   = { 0x60108000,    0x4000 },
> +    [TC27XD_PTAG1]     = { 0x601C0000,    0x1800 },
> +    [TC27XD_DSPR0]     = { 0x70000000,   0x1C000 },
> +    [TC27XD_PSPR0]     = { 0x70100000,    0x6000 },
> +    [TC27XD_PCACHE0]   = { 0x70106000,    0x2000 },
> +    [TC27XD_PTAG0]     = { 0x701C0000,     0xC00 },
> +    [TC27XD_PFLASH0_C] = { 0x80000000,  0x200000 },
> +    [TC27XD_PFLASH1_C] = { 0x80200000,  0x200000 },
> +    [TC27XD_OLDA_C]    = { 0x8FE70000,    0x8000 },
> +    [TC27XD_BROM_C]    = { 0x8FFF8000,    0x8000 },
> +    [TC27XD_LMURAM_C]  = { 0x90000000,    0x8000 },
> +    [TC27XD_EMEM_C]    = { 0x9F000000,  0x100000 },
> +    [TC27XD_PFLASH0_U] = { 0xA0000000,       0x0 },
> +    [TC27XD_PFLASH1_U] = { 0xA0200000,       0x0 },
> +    [TC27XD_DFLASH0]   = { 0xAF000000,  0x104000 },
> +    [TC27XD_DFLASH1]   = { 0xAF110000,   0x10000 },
> +    [TC27XD_OLDA_U]    = { 0xAFE70000,       0x0 },
> +    [TC27XD_BROM_U]    = { 0xAFFF8000,       0x0 },
> +    [TC27XD_LMURAM_U]  = { 0xB0000000,       0x0 },
> +    [TC27XD_EMEM_U]    = { 0xBF000000,       0x0 },
> +    [TC27XD_PSPRX]     = { 0xC0000000,       0x0 },
> +    [TC27XD_DSPRX]     = { 0xD0000000,       0x0 },
> +};

Why not use KiB/MiB sizes as before? I created a patch for that. Can you check
that I didn't skrew up the sizes?

--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -26,44 +26,45 @@
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "cpu.h"

 #include "hw/tricore/tc27x_soc.h"
 #include "hw/tricore/triboard.h"

 const MemmapEntry tc27x_soc_memmap[] = {
-    [TC27XD_DSPR2]     = { 0x50000000,   0x1E000 },
-    [TC27XD_DCACHE2]   = { 0x5001E000,    0x2000 },
-    [TC27XD_DTAG2]     = { 0x500C0000,     0xC00 },
-    [TC27XD_PSPR2]     = { 0x50100000,    0x8000 },
-    [TC27XD_PCACHE2]   = { 0x50108000,    0x4000 },
-    [TC27XD_PTAG2]     = { 0x501C0000,    0x1800 },
-    [TC27XD_DSPR1]     = { 0x60000000,   0x1E000 },
-    [TC27XD_DCACHE1]   = { 0x6001E000,    0x2000 },
-    [TC27XD_DTAG1]     = { 0x600C0000,     0xC00 },
-    [TC27XD_PSPR1]     = { 0x60100000,    0x8000 },
-    [TC27XD_PCACHE1]   = { 0x60108000,    0x4000 },
-    [TC27XD_PTAG1]     = { 0x601C0000,    0x1800 },
-    [TC27XD_DSPR0]     = { 0x70000000,   0x1C000 },
-    [TC27XD_PSPR0]     = { 0x70100000,    0x6000 },
-    [TC27XD_PCACHE0]   = { 0x70106000,    0x2000 },
-    [TC27XD_PTAG0]     = { 0x701C0000,     0xC00 },
-    [TC27XD_PFLASH0_C] = { 0x80000000,  0x200000 },
-    [TC27XD_PFLASH1_C] = { 0x80200000,  0x200000 },
-    [TC27XD_OLDA_C]    = { 0x8FE70000,    0x8000 },
-    [TC27XD_BROM_C]    = { 0x8FFF8000,    0x8000 },
-    [TC27XD_LMURAM_C]  = { 0x90000000,    0x8000 },
-    [TC27XD_EMEM_C]    = { 0x9F000000,  0x100000 },
-    [TC27XD_PFLASH0_U] = { 0xA0000000,       0x0 },
-    [TC27XD_PFLASH1_U] = { 0xA0200000,       0x0 },
-    [TC27XD_DFLASH0]   = { 0xAF000000,  0x104000 },
-    [TC27XD_DFLASH1]   = { 0xAF110000,   0x10000 },
-    [TC27XD_OLDA_U]    = { 0xAFE70000,       0x0 },
-    [TC27XD_BROM_U]    = { 0xAFFF8000,       0x0 },
-    [TC27XD_LMURAM_U]  = { 0xB0000000,       0x0 },
-    [TC27XD_EMEM_U]    = { 0xBF000000,       0x0 },
-    [TC27XD_PSPRX]     = { 0xC0000000,       0x0 },
-    [TC27XD_DSPRX]     = { 0xD0000000,       0x0 },
+    [TC27XD_DSPR2]     = { 0x50000000,            120 * KiB },
+    [TC27XD_DCACHE2]   = { 0x5001E000,              8 * KiB },
+    [TC27XD_DTAG2]     = { 0x500C0000,                0xC00 },
+    [TC27XD_PSPR2]     = { 0x50100000,             32 * KiB },
+    [TC27XD_PCACHE2]   = { 0x50108000,             16 * KiB },
+    [TC27XD_PTAG2]     = { 0x501C0000,               0x1800 },
+    [TC27XD_DSPR1]     = { 0x60000000,            120 * KiB },
+    [TC27XD_DCACHE1]   = { 0x6001E000,              8 * KiB },
+    [TC27XD_DTAG1]     = { 0x600C0000,                0xC00 },
+    [TC27XD_PSPR1]     = { 0x60100000,             32 * KiB },
+    [TC27XD_PCACHE1]   = { 0x60108000,             16 * KiB },
+    [TC27XD_PTAG1]     = { 0x601C0000,               0x1800 },
+    [TC27XD_DSPR0]     = { 0x70000000,            112 * KiB },
+    [TC27XD_PSPR0]     = { 0x70100000,             24 * KiB },
+    [TC27XD_PCACHE0]   = { 0x70106000,              8 * KiB },
+    [TC27XD_PTAG0]     = { 0x701C0000,                0xC00 },
+    [TC27XD_PFLASH0_C] = { 0x80000000,              2 * MiB },
+    [TC27XD_PFLASH1_C] = { 0x80200000,              2 * MiB },
+    [TC27XD_OLDA_C]    = { 0x8FE70000,             32 * KiB },
+    [TC27XD_BROM_C]    = { 0x8FFF8000,             32 * KiB },
+    [TC27XD_LMURAM_C]  = { 0x90000000,             32 * KiB },
+    [TC27XD_EMEM_C]    = { 0x9F000000,              1 * MiB },
+    [TC27XD_PFLASH0_U] = { 0xA0000000,                  0x0 },
+    [TC27XD_PFLASH1_U] = { 0xA0200000,                  0x0 },
+    [TC27XD_DFLASH0]   = { 0xAF000000,   1 * MiB + 16 * KiB },
+    [TC27XD_DFLASH1]   = { 0xAF110000,             64 * KiB },
+    [TC27XD_OLDA_U]    = { 0xAFE70000,                  0x0 },
+    [TC27XD_BROM_U]    = { 0xAFFF8000,                  0x0 },
+    [TC27XD_LMURAM_U]  = { 0xB0000000,                  0x0 },
+    [TC27XD_EMEM_U]    = { 0xBF000000,                  0x0 },
+    [TC27XD_PSPRX]     = { 0xC0000000,                  0x0 },
+    [TC27XD_DSPRX]     = { 0xD0000000,                  0x0 },

The remainder looks good to me.

Cheers,
Bastian

