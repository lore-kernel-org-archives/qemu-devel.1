Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0535C2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8KrMzk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0535C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOos-0005qs-AJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOnp-0004g9-Ai
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:08:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOnn-0002YW-Iv
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:08:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so4980627wmj.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZygS7xMaq3Qs9CSNEUUqz2guLfBsLuHXGM1Pvcfwirc=;
 b=t8KrMzk5H3865SMwju8gMrI4lWmOz4rYS5NHRbnt1X2BJXaRA6Yos+3yOmEaZvoJ8T
 2nT/HX+lzaso1/BLO81zAX/xax8zfst3UexMOq/8ZKM1QfFzfJlvgIuKhXS/FYEgdQZ/
 sMPH/aklEZeWiP9gZLOFMJ0JdH4bxfT6IGQ4+mNFtl3hzsldCUB3H1g/gWUizFZM2Ads
 MeRp2nvh6A23/s8/bV6ASmuIvwR27a7BIJHENHtd9in7Fn3F7hq8DfXD8qo4BI8xc6sL
 GsoJR3Hd/jWmQlf2r+6r2sQOr/ba4isfblDeVQ9BFxz5gT/dg8G8Y1JZDyk3hAjecsno
 hfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZygS7xMaq3Qs9CSNEUUqz2guLfBsLuHXGM1Pvcfwirc=;
 b=M846K3DJUgF0qX6xYb8D/jj8BBTjndMvKRpC32xEBMykxHq9oXbXDZ3shiL8g/Uzfw
 0oNPkdMQg8Kt0nIKsyz+tY5Mc7bssKxRutcdhoEdywcu1Uaydzk/ZD8jymYQKFLLyf1u
 oveTYosos+0NhEuRQ6Ud3CxcqPi7dSretbZ04LelAqJZkHL9u0gb+2lr65cSgvVtxwJH
 quPVv9pOpwYeETw611fWrD/P2x6RL/mqhbdwJ1GbIt93x+tILlJayWp4CU379ML7rlOA
 6Rh0C7BXJmeZjikQpDO9INu62J3XJpUp1JGGqDh1Rf2VDq9rDFsDplH2r/iF2OTNd62t
 JWqg==
X-Gm-Message-State: AOAM531yW1EbNQrkzZHkej5dal2FhHcxY4ZZEMQSn+xYM56TAV+VymXY
 kUrJOF+HpIYtKsqSwrv/rpknXG+ZaDVKaQ==
X-Google-Smtp-Source: ABdhPJyk41XXMXNZbjy8ATIAmrkg4SMZzuaD8er0/9sW4G9S3EDfLyJpcNx+H7TKCqa32bgqgUyQaA==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr2621873wmk.171.1593079693318; 
 Thu, 25 Jun 2020 03:08:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b18sm1642459wmb.18.2020.06.25.03.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 03:08:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/virtio/virtio-iommu-pci.c: Fix typo in error message
Date: Thu, 25 Jun 2020 11:08:11 +0100
Message-Id: <20200625100811.12690-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo in an error message in virtio_iommu_pci_realize():
"Check you machine" should be "Check your machine".

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/virtio/virtio-iommu-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 632533abaf7..32e3215d1df 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -48,7 +48,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                    "%s machine fails to create iommu-map device tree bindings",
                    mc->name);
         error_append_hint(errp,
-                          "Check you machine implements a hotplug handler "
+                          "Check your machine implements a hotplug handler "
                           "for the virtio-iommu-pci device\n");
         error_append_hint(errp, "Check the guest is booted without FW or with "
                           "-no-acpi\n");
-- 
2.20.1


