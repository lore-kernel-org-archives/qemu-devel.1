Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAA5C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2B520801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jk3iHgqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2B520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70dV-00076H-4h
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j70cj-00063N-L6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j70ci-0002Xq-Hw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:37:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j70ci-0002VR-Cb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582738647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTU2pN4ffXUG7OkrmHSdQ/hb5L4r0rRvF2zRZkH1X80=;
 b=Jk3iHgqale2vPYaZdh3tBy6k/9DR4PZME+Q4W9++B5qL90Q/HmiiQNuMEsJFHXPzqpfQES
 8vVh5Bprj1bybPmO5CjaaV0xklYY50Qoxl2cxDUpURZPHccXcoW7ZEx8nly9/G0PeLdle+
 2YjOfqk2iS9EfF4cTu+46dh/rd4Gyfg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-5uYdU4h7ORCLryjcdT3Gog-1; Wed, 26 Feb 2020 12:37:26 -0500
X-MC-Unique: 5uYdU4h7ORCLryjcdT3Gog-1
Received: by mail-wm1-f72.google.com with SMTP id j130so968131wmj.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XTU2pN4ffXUG7OkrmHSdQ/hb5L4r0rRvF2zRZkH1X80=;
 b=JKfQC4zD3V12urfavC3YwWt2X6a3ibjYNukPVvMHiKVzR0GFMdP1RmiTfvjGZrHIQq
 dalnsfdLc49fhGTnfP2ptr2zeY0P+V6hukM1xDLOjrOOuLOiNXq7vDqTRmoHGM+/TzKg
 umk8tpeOi96G8wu6KPtT+QVEJ4W0xaJuAXTojeC4i0aJGdJAQC3woxBNsLejPioAVwPZ
 1bFiUV1NtHx5ERJHP5ouAmHRE7dnnV9qzXZve75ibdK65+L85ia+Nn3pM4lYEqpSrxw7
 CB6tyv6aNae6awPQjcwxPFCZi7qrw1oH9zrPBNxXBSPSEkwxIwCpSqOv4ZcIqa8jTKUk
 rEVg==
X-Gm-Message-State: APjAAAVX3VaXyKoPNvC1TVfAye54yxnTvlOjtSYejvYTcGqCRKU4gzXS
 RN/rcCkM4McB6xi83o5M5pKmRIsrdbxP9y8xjOkro2trKbGQcLw/87k+qbHP/3nG1g9OGLuEEQS
 1JHH9sWkY3E1thBM=
X-Received: by 2002:adf:90cb:: with SMTP id i69mr6764658wri.205.1582738645093; 
 Wed, 26 Feb 2020 09:37:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjUkWMMglgN5xkf16vjjJ3GUhons5WW6ybowSLcka82B0vWVZQgpAQ6dMppAlNcSYmgQjLEQ==
X-Received: by 2002:adf:90cb:: with SMTP id i69mr6764623wri.205.1582738644683; 
 Wed, 26 Feb 2020 09:37:24 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s15sm4138759wrp.4.2020.02.26.09.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 09:37:24 -0800 (PST)
Subject: Re: [PATCH] hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 peterx@redhat.com
References: <20200226172628.17449-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f82ec7a-fb74-a47a-100b-325d5de36a7d@redhat.com>
Date: Wed, 26 Feb 2020 18:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226172628.17449-1-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2/26/20 6:26 PM, Eric Auger wrote:
> Make sure a null SMMUPciBus is returned in case we were
> not able to identify a pci bus matching the @bus_num.
> 
> This matches the fix done on intel iommu in commit:
> a2e1cd41ccfe796529abfd1b6aeb1dd4393762a2
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/smmu-common.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0f2573f004..67d7b2d0fd 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -301,6 +301,7 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>                   return smmu_pci_bus;
>               }
>           }
> +        smmu_pci_bus = NULL;
>       }
>       return smmu_pci_bus;
>   }
> 

Patch is easy to review but code not. By inverting the if() statement I 
find the code easier to review. The patch isn't however:

-- >8 --
@@ -284,25 +284,27 @@ inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t 
iova, IOMMUAccessFlags perm,
  /**
   * The bus number is used for lookup when SID based invalidation occurs.
   * In that case we lazily populate the SMMUPciBus array from the bus hash
   * table. At the time the SMMUPciBus is created (smmu_find_add_as), 
the bus
   * numbers may not be always initialized yet.
   */
  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
  {
      SMMUPciBus *smmu_pci_bus = s->smmu_pcibus_by_bus_num[bus_num];
+    GHashTableIter iter;

-    if (!smmu_pci_bus) {
-        GHashTableIter iter;
+    if (smmu_pci_bus) {
+        return smmu_pci_bus;
+    }

-        g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
-        while (g_hash_table_iter_next(&iter, NULL, (void 
**)&smmu_pci_bus)) {
-            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
-                s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
-                return smmu_pci_bus;
-            }
+    g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
+        if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
+            s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
+            return smmu_pci_bus;
          }
      }
-    return smmu_pci_bus;
+
+    return NULL;
  }
---

The code is easier although:

SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
{
     SMMUPciBus *smmu_pci_bus = s->smmu_pcibus_by_bus_num[bus_num];
     GHashTableIter iter;

     if (smmu_pci_bus) {
         return smmu_pci_bus;
     }

     g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
     while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
         if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
             s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
             return smmu_pci_bus;
         }
     }

     return NULL;
}

What do you think?


