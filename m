Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC772204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIw1MAKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC772204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZeK-0006Kf-MS
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXK-0004yX-Mw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:17:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXJ-0006fr-0P
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:17:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so7473672wrn.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p50MWhGLP7hiQqo9k1Cd/hlKchaRnczIO062DRXykeA=;
 b=yIw1MAKayAf8CcmYBRcz1zSVjIHA2H8NHC5brGv6QPyhJgr59niuFEFagtORN2/L+6
 SBrmOgZrXrubkw/AYVv5yvyRT8vpolsAF2dvulie5Jhh17xRagfltp8WJ0RiYsx8DeeN
 VRNkCa7H9gpm9aa3znGgwNLHsIcFovDaosH/88DzCkMZjFjbkJ7NAjcvcg2XbK2Lz3/x
 UimfQmNn1qHLhsud3Yq+W3j5p4FQPsE5b2kTt3uMe9RdaY4E9oSUpN5lkQ9qvOMvgpDp
 7uiI2AIpUu1FEoUpnvqhPPf/APQ4MZtV/SajK83EaqHUw9gdqtfRtkZ5hyExbyLZ09XP
 Q2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p50MWhGLP7hiQqo9k1Cd/hlKchaRnczIO062DRXykeA=;
 b=OG0v0mVV/b27B/iW+JL8+IEGKOWSaHL0wqYm8aJhky8YmqAMNkCpmX6U069Ap1GzQT
 mLWyRfLEJUoaZkcjd1ZRRc00U6Mj427dR4oqNNo4bXraqzyYSAkrY2XZ+47sYx/1oxmw
 jrWrz4ZL8jzdEg0WTnTcqkWgahXnR8JxXw/VAACjldPDUdG8SLsE4eNw8UaMzJ3LD6tn
 P0JskkKQmP0KVXHAABpM3QYlAAH1TL++l212u5ekIQNQibrFJBUXUVEoL5MpVdTD0zLO
 e2mI4d9D8HVzr+T3isH7grn2HDRybpX2tddT2bbvvOBd8B88M/s8CZQMWYTxhLbURJtt
 Fawg==
X-Gm-Message-State: AOAM530nDnL+Wr51gdb7yYttYS1GBvj/Tz4hD1wojka+k7smBhKl7mMs
 BXlTgs74QvVYK66Hb57Udje94A==
X-Google-Smtp-Source: ABdhPJz4WnokWMCtKF28HBnMb9p1e5OoHBhB5yOGo+66ZSP6TVJY6+dY+UIDqeJLVinwMxq9tkMbVw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr10377411wrt.366.1602177419675; 
 Thu, 08 Oct 2020 10:16:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Date: Thu,  8 Oct 2020 19:15:58 +0200
Message-Id: <20201008171558.410886-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x444.google.com
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

IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
attempting to deal with such region, vfio_listener_region_del() passes a
size of 2^64 to int128_get64() which throws an assertion failure.  Even
ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
since the size field is 64-bit. Split the request in two.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
For me this happens when memory_region_iommu_set_page_size_mask()
returns an error because a hotplugged endpoint uses an incompatible page
mask. vfio_connect_container() releases the memory listener which calls
region_del() with the 2^64 IOMMU region. There are probably other ways
to reach this.
---
 hw/vfio/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e66054b02a7..e90a89c389e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -797,6 +797,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        if (llsize == int128_2_64()) {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            llsize = int128_rshift(llsize, 1);
+            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+            if (ret) {
+                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                             "0x%"HWADDR_PRIx") = %d (%m)",
+                             container, iova, int128_get64(llsize), ret);
+            }
+            iova += int128_get64(llsize);
+        }
         ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-- 
2.28.0


