Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09EC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E212206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnPcSnIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E212206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYps-0001M9-BZ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmf-00055G-Ih
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmb-0004ot-DP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id h22so3768341wmb.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x+cvpu7ceWHktnpLf54xiiETIbszTKNIsMfFS/95CA0=;
 b=jnPcSnIREOXzqoUrjsQz/YmUF5n172hh7fbdxLDHsmBohlCVOTi6HSQvNf2N4Qtcnj
 ZCzDmF6fta5TR2MdxOsjBU2ZBHh2DwO3HXEq7fN+fKknA2EbEZQsL4FqzoDA1tnH6AAY
 8UXDj9992XoQehqM9IJKmixG4k2WRE8phwSOGqMMgYksdidkEqYiBHO4ZaIxUon+OZ2T
 TjHN9BJsS7xGILH7Ywf7vHB/FY9hZskxQ77IQQYwGjflGIkcI4CRSr9nXsWbQu9nRoXb
 yYVLLb25oG9hPwPUTZCuThJqCXIyws2M9UwKJbtFLEQrQC4i6NjTaFEF+D7nh5A9QGq6
 cEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x+cvpu7ceWHktnpLf54xiiETIbszTKNIsMfFS/95CA0=;
 b=S4DY8x4mDwggJb+NH5RWqo+xQxLUkdxDZFdVCnLNDBD8RD+HwyOzaK4JF6CM96wx4O
 PBz8L3E/2Y9SgpvrZiwsk2CGXVxewPOPXniVfJRwijegPJsIG6VN4uwFbHYhXhw4LIkF
 /yBmNxygV9DOjtLQN2uPNP3k+eC0dv1Bde6dFTFlEa9/AZMlZphnfRpTZT35AYMo5ax+
 NGiezFAyHwP6wahhr/xDm0tihmqwSRt76aLnmAEiUUVXigg/JuHCUEF97P2zmMrXOCHC
 an2bPUKPodt9ZjcgZsHaKyoovmYLhNQ3exRMEnhu+zk7isrbQrLEe0O0UOMqTQqqW0pW
 q1yg==
X-Gm-Message-State: AOAM533EolInXVeFm6ROqbF/a7cZbb+EEAoLKP9DiEFnRWgVZ7WVnYFS
 lTn6zHfZvYkd1yXS5JbQ/Cs92w==
X-Google-Smtp-Source: ABdhPJycfkGqQGLXB82Im0P3inWb2CLLsnwg522WPSaDqlKEi3SEAOhK1eZG3/wW/7cPjj4cvJE2Sg==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr4185427wmf.174.1604081147547; 
 Fri, 30 Oct 2020 11:05:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:46 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 01/10] virtio-iommu: Fix virtio_iommu_mr()
Date: Fri, 30 Oct 2020 19:05:01 +0100
Message-Id: <20201030180510.747225-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x343.google.com
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
 qemu-devel@nongnu.org, peterx@redhat.com, QEMU Stable <qemu-stable@nongnu.org>,
 pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to an invalid mask, virtio_iommu_mr() may return the wrong memory
region. It hasn't been too problematic so far because the function was
only used to test existence of an endpoint, but that is about to change.

Fixes: cfb42188b24d ("virtio-iommu: Implement attach/detach command")
Cc: QEMU Stable <qemu-stable@nongnu.org>
Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/virtio/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 21ec63b1082..4c8f3909b7d 100644
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
2.29.1


