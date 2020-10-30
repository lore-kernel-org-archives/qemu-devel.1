Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A61CC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC63220702
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+9jC9AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC63220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYuM-0006Kd-Ib
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmw-00059r-Vr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmp-0004r8-Bf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id d3so3744894wma.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PVmUxGETfBJ3WJRj1ZG9T2/QT+bDC3bRHPQVEh7hMSk=;
 b=g+9jC9ARXcJYS9wk6JShPK0IRscgnd175zibqDgx1TEtnKBEIblpqRm/JsBC55eedU
 HjIEUTBqmMOrVvv7HlmAmhl/foKaXr0BagZBcIu55oTrSMjw5jXrRfl/cukSMYLylx3A
 RdZLejB+sNr3bhOK0HT24bQMQuLmtVOQpudBe7UXIZ1oi0+GVmE2xeuN/xnwmCusqtbI
 kt0LmacAPfm54eCLIceMGUlSizjc8ipSkOf7XjZs9IAd47vveQ4mtQv8/gyB3JnowfGx
 vKgJ/9GAFDFWASt3H4DPRm6hBHzIzYAl98BNHAvFCXArERnXPjSaQsBeFD7Jn1HduVUE
 becQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PVmUxGETfBJ3WJRj1ZG9T2/QT+bDC3bRHPQVEh7hMSk=;
 b=YabIkV4vRRcRKhY6zN3jIDNjgHXmKpvOvfIuq971xh62qi5mWcyuR7N1VoQj7RDYof
 ugrI1dMD3u5Hb2+8ijlljsEsfTh8mBbVWjQMfVveV6Z6Yf9xxiL8KUBFHjqcSJLY9d/j
 PPgsCVI9u78wSpFxXga1ArvqknWr581JPw7I5ftAaBT7Ilq7N315t1D8dA1MkpTXPsYH
 dj3y2i3HbYeKWDndYdon3M6T8r6NAZGkTkxH+qcCXw3IO6lMs1p9Rh9IslXFvh6uc0h5
 YDPZPRCM5m0tEUrALo6IxQULEZpd179uaIe9YaUVajsamruNmolzNvDeK8hMAhprg/ta
 4mHA==
X-Gm-Message-State: AOAM531WBPW2Xj0O1pmmD7USVBBbcHMaR6vK526CZNseFGH15n1LkhHO
 xoCuxV3ChYh8xhHiHBmPvbXJnxEwyW0y0A==
X-Google-Smtp-Source: ABdhPJwwjv7DyC8JVHbJe6mnqo8R72gOAGxCzLVg88Me9to2SYVOKUMFNtmzMb/4WBFI99796anwqg==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr4295594wmk.106.1604081159183; 
 Fri, 30 Oct 2020 11:05:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 10/10] vfio: Don't issue full 2^64 unmap
Date: Fri, 30 Oct 2020 19:05:10 +0100
Message-Id: <20201030180510.747225-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x344.google.com
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

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.29.1


