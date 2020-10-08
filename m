Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF9CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36FA204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyrxZREV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FA204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZea-0006NB-B9
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXI-0004tL-Ad
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:17:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXG-0006fW-N2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so7441976wru.12
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L1iwuBZlH4emBp6JRkoZKYjiVdXM0akqIZ599ofxEZI=;
 b=EyrxZREVUHgy5vw5UiEmWm03eUn0arKOFhK+mjzTZ7AeN/CRCExxvbDQ6i6krXVuKe
 9UFs4pVf6DVAHtgUO6pf2MNpnc8BdOkkcJU958m577J4kFZMZPVdvEQCUHhYFQ+VLdrx
 txNKQIIhOwSYvr8xV5DGNiIkAf972NCmn8JKUVa1lR05vRXh37sRheKkUw0S9H4cY0wk
 T/+FQQuKpwFB9C6hrT0Jg/Tj5RZ8KaOq5RS4A1bFs+xoV3JcEUHhLpFqdnDGgcX96tNB
 DBaWdY4tfrXFvEO6cjSiV9GE3DMh39O2Q1q86+QrS6/N4UoEMNBTa1LO63XzJ10wx3wp
 6vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1iwuBZlH4emBp6JRkoZKYjiVdXM0akqIZ599ofxEZI=;
 b=mPlDbWP+GL/VBMVT6hgjpAju1gp3hZ0BxDR1XMgGeenDUNdceswJby8DpWKGnBjoJP
 86Q4p/7aYhezczNoVIfX9KjM6FWI3/jNlYUgB+bQK+DMLnHT7Am8HhCD+Hda/fZBzkIG
 nWQRnGux/QhW5N6B6MatQqUhV49MH2Sg5KSpTndDiZQAa8KRx33wFZ5Ielseaersop3u
 LF9WdgAokWdLJuoNfavQia4eviRoelep8QDq25xQJ3hdf0YpUrJJrLpKgO855HGkvxtY
 1sdn8kR/b8IhnE4V/Z64a/qkfXO/5VXUcN/+oowtEds1rcR39JXiU57bhIkq36rfcoqY
 9aYg==
X-Gm-Message-State: AOAM5320+PBYlewNvX5KLDBRNj2KaSp3vGqew1e5IybRRRhM+BZYvkFd
 NFWrFIwGZg4lOtPtQhUWs5zcdA==
X-Google-Smtp-Source: ABdhPJwUD5wqrfTkVf7dJLrztglZojWpDXiWoQLF71FQHxzME82ACP02kH50uvUg3wnfQsj9ZFwVzQ==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr11122776wrt.255.1602177417377; 
 Thu, 08 Oct 2020 10:16:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 08/10] vfio: Set IOMMU page size as per host supported
 page size
Date: Thu,  8 Oct 2020 19:15:56 +0200
Message-Id: <20201008171558.410886-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x441.google.com
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

From: Bharat Bhushan <bbhushan2@marvell.com>

Set IOMMU supported page size mask same as host Linux supported page
size mask.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/vfio/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 13471ae2943..e66054b02a7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -636,6 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             int128_get64(llend),
                             iommu_idx);
 
+        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
+                                                     container->pgsizes,
+                                                     &err);
+        if (ret) {
+            g_free(giommu);
+            goto fail;
+        }
+
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
-- 
2.28.0


