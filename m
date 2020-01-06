Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B1C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44462072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhG6pGWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44462072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXb6-0004We-MH
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4y-0003S6-M2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4x-00053c-FP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:16 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4x-00053I-BG; Mon, 06 Jan 2020 13:26:15 -0500
Received: by mail-qt1-x843.google.com with SMTP id n15so43213366qtp.5;
 Mon, 06 Jan 2020 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vLkBK5lSWEkB9UXmndWqWUlDLfAZMhVOoZ7WRef+Ig4=;
 b=IhG6pGWJ6BRiXdPk0rw3Kv9D6qGDfbd3ECSNZ2+sAA/tXxgRYiVztrJBDuz4WGFREC
 rIana4JBxaZVXnlLcelSckeO/sL4PJQol+dhSin85HPt0PgNL/LdAXk6jRr+ITE4DBpm
 7pB063tzhD/thPSt/MjN4IlK7jUWwA8lOoi1IBnH9o6Umtg7a1wRxm8zbrq+xv9rDIFU
 TG8H1z/Yr2MTxFL3yP1QJLxdJBVNCBcuShcHnWF6VTQJsb/FTaAMclJQm9YZvzTqRQhU
 t7BU6m2tRWNUjNc8e3ZA9xyL1GYhMAU48VpZSa9TbIkhq+B/ft35pmeaPufAsXrP7LGo
 Dvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vLkBK5lSWEkB9UXmndWqWUlDLfAZMhVOoZ7WRef+Ig4=;
 b=i3VcEkS7gBUCTfq45v8REy2BN//EcR9pynw+jpQ+bkkWnXJauZSra/RVkBh/dCvDON
 OY7BZPlhqSoK07NzvVwj3LHXy7VPOhNrKH7q7nWGR405tuHMfngcb5su8e8RjwBLuEkw
 6Yl+8bto8cWV65s6JiEoYvyWnmEoT8C0j4xH1ICyABsiDbs/Ec7EXBAJazo2jj5cdR6J
 5VlwFKiQLVjTiOM59hi6oU07y562KN/7VuU654CcV9+QaJRqpvxq1mxlLB2X7NWSIUq6
 Jg00/LKQJvDzREB9H0IQjYlbGj6F4V18wI+AeP+YT09t4wYqqmQmPALsz7cGomLL+Lyp
 tH7g==
X-Gm-Message-State: APjAAAXnsQjtRywKZ53m5Rqet+CBCKtHHGkbslsYRIrT8Gi9pzIsF+f2
 26yAf68VjKU04ZjywPy2ZpTSWsBJ
X-Google-Smtp-Source: APXvYqz0JY9smgLFPzAiiETwEw3EDaNA9DaxSXm2oBrDtCaChGrePUXVRbUAYfq3Q9hxG9/fYtO3tA==
X-Received: by 2002:ac8:769a:: with SMTP id g26mr12100709qtr.259.1578335174763; 
 Mon, 06 Jan 2020 10:26:14 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:14 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 46/59] alpha/typhoon.c: remove unneeded label in
 typhoon_translate_iommu()
Date: Mon,  6 Jan 2020 15:24:12 -0300
Message-Id: <20200106182425.20312-47-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Label 'success' can be replaced by 'return ret'.

As a bonus, existing trailing whitespaces were automatically
deleted by the text editor while making this patch.

CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/alpha/typhoon.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 179e1f7658..af992883c7 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -34,7 +34,7 @@ typedef struct TyphoonWindow {
     uint64_t wsm;
     uint64_t tba;
 } TyphoonWindow;
- 
+
 typedef struct TyphoonPchip {
     MemoryRegion region;
     MemoryRegion reg_iack;
@@ -190,7 +190,7 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
     case 0x0780:
         /* PWR: Power Management Control.   */
         break;
-    
+
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -442,7 +442,7 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
     case 0x0780:
         /* PWR: Power Management Control.   */
         break;
-    
+
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -694,14 +694,14 @@ static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
         /* Check the first three windows.  */
         for (i = 0; i < 3; ++i) {
             if (window_translate(&pchip->win[i], addr, &ret)) {
-                goto success;
+                return ret;
             }
         }
 
         /* Check the fourth window for DAC disable.  */
         if ((pchip->win[3].wba & 0x80000000000ull) == 0
             && window_translate(&pchip->win[3], addr, &ret)) {
-            goto success;
+            return ret;
         }
     } else {
         /* Double-address cycle.  */
@@ -711,7 +711,7 @@ static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
             if (pchip->ctl & 0x40) {
                 /* See 10.1.4.4; in particular <39:35> is ignored.  */
                 make_iommu_tlbe(0, 0x007ffffffffull, &ret);
-                goto success;
+                return ret;
             }
         }
 
@@ -723,16 +723,14 @@ static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
                 pte_addr  = pchip->win[3].tba & 0x7ffc00000ull;
                 pte_addr |= (addr & 0xffffe000u) >> 10;
                 if (pte_translate(pte_addr, &ret)) {
-                        goto success;
+                    return ret;
                 }
             }
         }
     }
 
  failure:
-    ret = (IOMMUTLBEntry) { .perm = IOMMU_NONE };
- success:
-    return ret;
+    return (IOMMUTLBEntry) { .perm = IOMMU_NONE };
 }
 
 static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.24.1


