Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFAAC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37380206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnHqDIsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37380206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYpv-0001RW-67
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmx-00059u-0E
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmm-0004qu-49
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so7414032wrg.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=12Ju8kXQSFpn0papdnxccSNLTxeP7E2Kw7ISAbJMDvA=;
 b=gnHqDIsVm60CzSvp3ox9M41hiKc0xgMyTHFXNxMiCYt9+Hc7FXB3f3JQdpN6xctB65
 17tPqA3r6A5TiHmwMlYTfmNqHG+bJuhsw5JK7dUAhIEe/n+xdL+nNOfQkrFDfBcNuRcV
 tsEgz1Dz8+YwrzDwkxQQhjcT/jX/GhaGv7K4mVI6mu2razq1xXywif76cD1aHXOyP9YV
 AzN6OAJ+DP9iZsQEhN8EXNcwiGD+FEPORgnkWN1OB3i5qdJdzmnVfScp2KbLNePy0TrA
 T/31/OODvxU3jZUcC7FtJMAKcQzrFybCg5e3hG/AYO57GrzFZnPjlqWM2g6JMiel57q5
 LQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=12Ju8kXQSFpn0papdnxccSNLTxeP7E2Kw7ISAbJMDvA=;
 b=oqzsxvug3Fn8rI0YHS6M/GfYZpyKU1kZ7p6BuBZB62SAEfb9ClTVc8raDzLE2Jjh3p
 pOt3Tx6Ko6Jlgy3A2gOWyUJ2o7ZFQooLzwpTqnbI8gRfp5FHYC7KU/xuk+WV6EHWdj6G
 MspPBotLgVOG6xZeRdv7MtmsfP37qir5sZ5+/4QZJUEP882W65KLuQLUpYE+ZCtrRkyp
 v0larOvciFY3MuE+1sPPtR+ne/nMPOQ5BNzDfxu4UCX01uwF0FecxXVWC+Y4EaBXsqLa
 JMjkf31BQpTL0KVqY+S9cl55VRUCBxMkqjT9l2agT+pC4bHKbydA/8i1QTXgGYDpJ6/y
 4GXQ==
X-Gm-Message-State: AOAM531E0T3Qzt089bfvh1Z31gl1ZyHT1b+cvPv3JuOIDoj4RCtpacnc
 CWHYArPq7ipEl5yba3KcOoNxCg==
X-Google-Smtp-Source: ABdhPJwbx4BxAg0T9Wm7S4xKTvG8ISfboebdWxrXsuZnP4IbjVwQLiW45u0wJrbGmuNDyC9noc0ROg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr4795705wrl.415.1604081156768; 
 Fri, 30 Oct 2020 11:05:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 08/10] vfio: Set IOMMU page size as per host supported
 page size
Date: Fri, 30 Oct 2020 19:05:08 +0100
Message-Id: <20201030180510.747225-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
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

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
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
2.29.1


