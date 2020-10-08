Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8030221FD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9HfeWHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8030221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZah-00019o-Rj
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXA-0004gx-DI
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZX8-0006e1-Qr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so7457095wrt.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wm2zb0owiv9tq4nre7MhuXhiCixqU1B1oDsIMQzJnyg=;
 b=v9HfeWHeCnq5E8/UUljUKtOmYwMtBoNa3MA940kpi6NUdfJCJRyM/BhMa86iJKBhVH
 yjxfKh28Mhz/w7dDLYGNYHDrm4YM7+FvX+FFQMuQ7YkW4wBOa5yNeBqkhS8UeLJmwDvX
 z8cgcF4l6tfkNCeaeHmHKSLnGP7VY8mkwHHIy2ubF73Se/46CKINlF5owwJ4E/lj1i4X
 s7AHV+bs2PZc2GRgMFQg6TIrf/gmJ1gVKJFsfCQ5n/8NlXfdrNK+a3Dbd9mbsHhJe8Xl
 WGcN3ugtgFQJUSjcIFrA2CrYgN0yfwPkjhey0dJ4irrYU1oba+QBtGZj13wrdm6+A1dw
 l91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wm2zb0owiv9tq4nre7MhuXhiCixqU1B1oDsIMQzJnyg=;
 b=JkqouV016rcTUBzvYF9oCNLSDvYIf9dWC366kUV9Q8S1ZKLb2N4YzFvYHHGcd+36Dp
 dG2dCbrMW2OLpXWzKq8zGCXrhmNNJ8uhM1KuUiv0s+akhj8AxUED3SDpCZZ+po8U+wHU
 y6ApUrj2NMTDWcq4fksjskLbs0od6ibXK8dkpOeC+GLZTw5oL2kU48FXFmiPL6N0OqpT
 j/RRxt6vhZueMM30m7Q4kHeA4PV0crJ0O9IlZcKCtdJqZ9R15QWMfVSk4atBLdvjKv6K
 q4pu4HV9G6H6+MkuYW5pF8JCTaehiRHNH51NK0/s9YZIW3sUCTrYHvlCmMxgAo/AVHth
 Ns6Q==
X-Gm-Message-State: AOAM530/iRc4PrWTouTbEkGFy1fIWzhhUZWTNKMNmB93yGrl0pwC4RSD
 z7GCYyjjinzjxVMmWzZiBbTgmw==
X-Google-Smtp-Source: ABdhPJwPB4T3aZZHNUYRyJocMaJAoJqGIzqz7WLsjsOpJgV5jAkMELcDyh2mFNm8NBppHWs+3rrgoA==
X-Received: by 2002:adf:c5c3:: with SMTP id v3mr10793943wrg.205.1602177409417; 
 Thu, 08 Oct 2020 10:16:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 01/10] virtio-iommu: Fix virtio_iommu_mr()
Date: Thu,  8 Oct 2020 19:15:49 +0200
Message-Id: <20201008171558.410886-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to an invalid mask, virtio_iommu_mr() may return the wrong memory
region. It hasn't been too problematic so far because the function was
only used to test existence of an endpoint, but that is about to change.

Fixes: cfb42188b24d ("virtio-iommu: Implement attach/detach command")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/virtio/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a91fa2f674c..543fbbb24fb 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -101,7 +101,7 @@ static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
     bus_n = PCI_BUS_NUM(sid);
     iommu_pci_bus = iommu_find_iommu_pcibus(s, bus_n);
     if (iommu_pci_bus) {
-        devfn = sid & PCI_DEVFN_MAX;
+        devfn = sid & (PCI_DEVFN_MAX - 1);
         dev = iommu_pci_bus->pbdev[devfn];
         if (dev) {
             return &dev->iommu_mr;
-- 
2.28.0


