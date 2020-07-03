Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC829C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD103208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qybWWgB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD103208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP0Z-0001yL-UL
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx7-0004aM-Nm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx5-0005en-QS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z15so22143991wrl.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=295eK5ijKQ0QsX4O3HxBkZyowFWTTmfTtCLGUV8KWHM=;
 b=qybWWgB86TqW4QOm8y+5eXTZA46C91bZTu64AVBPwyZIN/m7O1vqmvpJ3baou6DAGp
 jteupGK1EpJeAbpYE8cWX3qSajs7nafmeZj37jFpTf9IzIGMRVnuGqdHM8i1dgwegiPk
 0bnbeqg2lFtr8Yc6ObgJlmZ7Z5TRmx0MEkXNxiDhxl4Fk+X9KQMF+CATlMaQhtzAaoBg
 t3XI/nRv4dKwOOTbvDxGo27UosGWNf5AaFX4JSRNERIiH1uKI4F9axKC+z2uh6wfJAhm
 ZjZUWGYTfnxeuEcHt64wrUsbIIlHGD2U7FL/DgLj6enirg+9+MKgQTYWhybSWkaBDWD1
 LgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=295eK5ijKQ0QsX4O3HxBkZyowFWTTmfTtCLGUV8KWHM=;
 b=VUyojpHAqYfW0cuJ7dA4IncsSvQZnkwrOqyDBxeBl5PBNNtViywSoP16oPJVDBmcft
 4YEjNcPgUjEKDGv2+NM/lrGvhUTborj0exF79i7b/atxZRjNAK+5ENrLke1ITVVUnWW5
 9e0k2h3Cy3OXBR7U+UhzysEKiEHH+tXPn9aUjNfjzmiA00MRC/n9PUq8Vupz9isAo/dt
 +6KYXwU1N8pffLoP1G6loe9jhHLaHw30nMcyXVK5vCHGnXcqMcDDkmnRsYfXW9Nh+VHF
 3k24DH1Q02EUduvwJK0KRqSoX+YRv9wGTv5eDMKsavQN8ZQVZiqqPcpc77L/UnrPMk9L
 +1JQ==
X-Gm-Message-State: AOAM531b/2dvxaJxUwjynMaZB8/J69rISXt0yoPw43fWku2uMjeCVwTi
 VDD2hd6NiJsErBn+Q8PF2u6Jso9E2dRwig==
X-Google-Smtp-Source: ABdhPJzBu0yGYZlp/a6+l3xuM3NTW9zfJKpR5cTMKDxyayKw8K4ezucCjAyoWPIZ09OB333M0LnVfg==
X-Received: by 2002:adf:8444:: with SMTP id 62mr35980364wrf.278.1593795254148; 
 Fri, 03 Jul 2020 09:54:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] virtio-iommu: Handle reserved regions in the translation
 process
Date: Fri,  3 Jul 2020 17:53:37 +0100
Message-Id: <20200703165405.17672-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

When translating an address we need to check if it belongs to
a reserved virtual address range. If it does, there are 2 cases:

- it belongs to a RESERVED region: the guest should neither use
  this address in a MAP not instruct the end-point to DMA on
  them. We report an error

- It belongs to an MSI region: we bypass the translation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200629070404.10969-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/virtio/virtio-iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2cdaa1969bb..b39e836181e 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -607,6 +607,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     uint32_t sid, flags;
     bool bypass_allowed;
     bool found;
+    int i;
 
     interval.low = addr;
     interval.high = addr + 1;
@@ -640,6 +641,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto unlock;
     }
 
+    for (i = 0; i < s->nb_reserved_regions; i++) {
+        ReservedRegion *reg = &s->reserved_regions[i];
+
+        if (addr >= reg->low && addr <= reg->high) {
+            switch (reg->type) {
+            case VIRTIO_IOMMU_RESV_MEM_T_MSI:
+                entry.perm = flag;
+                break;
+            case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
+            default:
+                virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                          VIRTIO_IOMMU_FAULT_F_ADDRESS,
+                                          sid, addr);
+                break;
+            }
+            goto unlock;
+        }
+    }
+
     if (!ep->domain) {
         if (!bypass_allowed) {
             error_report_once("%s %02x:%02x.%01x not attached to any domain",
-- 
2.20.1


