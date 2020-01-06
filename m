Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD3C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F592072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdJHk+dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F592072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXYZ-0000v6-70
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4r-0003Fv-Qk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4q-0004vr-P9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:09 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:44706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4q-0004va-Lf; Mon, 06 Jan 2020 13:26:08 -0500
Received: by mail-qv1-xf41.google.com with SMTP id n8so19407992qvg.11;
 Mon, 06 Jan 2020 10:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e2Pglg9q4RMFoXAtcnS8nyYGqCU2Tjq8RVW10uPUEeA=;
 b=PdJHk+dxqZORm7y8xJbfbi8AyLgfnD4aDeCYFLOeiHbk6FSIg1xKIWSA6cXNY2hrcT
 p1U98c0XD4iJxVvzonsagevv8f2o4xNMwnVPWe1i+03yeEFgBv5HWFdS1YqVp9St2RaR
 iEESSUn0ONAvWl/TL0V3FYkWi6Dg7kjF2t1tBkNurApYktaikl25//wppIT+8pwYK6C9
 RVE13ERlyHzzXRXNEUZMJQg3xKXc/BpqkahYfH2JR+7w+vC3CJph6mfR5yD75hAkgur6
 1eKHrlaqN2RL3BNKODPy7BGY46eh5kIfbhOZdKg7qKmstSi7EoGstEYzhG+KZJfn2lLb
 bFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e2Pglg9q4RMFoXAtcnS8nyYGqCU2Tjq8RVW10uPUEeA=;
 b=qYMfM6k5coz0ShGTqTI/t93vW/QDZ32dypFP/1gNqlQmivEEHxUVksu8UoGUGPlgXI
 GSZ01ivnaR97z2CgvHBLYlsvYEkharltGgwkpWXevTNy8tMA82h+9L1vXI+clwpOvEng
 M2/EHitUTBBYam+4K+AraHHo7K1QwIEw+YBEYYlTKSmdK1GqkrXUs7QARuu8KkKBRknx
 Aus4Eej9r3yUgfxF29ULDV3nGxTPfaLRwik+t8IWdbg3ZBoFfPmbw0XigUvvmkR4I7A9
 7IW/3LBrUeaT3mZQVFHGmwPVHFM+PYDTxhjIumeqgsIPtelZoUe0+8vo5TklrKugEFM/
 kw6Q==
X-Gm-Message-State: APjAAAXDRSZwgRh9vGk0X5YPZjHEj2lktGJSeXlvzY3HYb+WZEMaoiur
 reX5H0keb4/82jOoIGikzEisWpT7
X-Google-Smtp-Source: APXvYqyMOUdvQFsVG1KX82JecU22kDLwhxzjSAPzowB71iFledUIlr4Xia7OhmMcc+66CTt7CwzG+A==
X-Received: by 2002:a05:6214:923:: with SMTP id
 dk3mr77520156qvb.96.1578335168111; 
 Mon, 06 Jan 2020 10:26:08 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:07 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 42/59] i386/intel_iommu.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:08 -0300
Message-Id: <20200106182425.20312-43-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label in vtd_lookup_iotlb() and 'done' label in
vtd_process_device_iotlb_desc() can be replaced by
'return' with the apropriate value.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/i386/intel_iommu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b993b..e0dd987851 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -304,11 +304,10 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
                                 source_id, level);
         entry = g_hash_table_lookup(s->iotlb, &key);
         if (entry) {
-            goto out;
+            return entry;
         }
     }
 
-out:
     return entry;
 }
 
@@ -2380,12 +2379,12 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
 
     vtd_bus = vtd_find_as_from_bus_num(s, bus_num);
     if (!vtd_bus) {
-        goto done;
+        return true;
     }
 
     vtd_dev_as = vtd_bus->dev_as[devfn];
     if (!vtd_dev_as) {
-        goto done;
+        return true;
     }
 
     /* According to ATS spec table 2.4:
@@ -2410,7 +2409,6 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.translated_addr = 0;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
 
-done:
     return true;
 }
 
-- 
2.24.1


