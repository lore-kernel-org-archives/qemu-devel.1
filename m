Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2FBC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA69207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpZnOg3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA69207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNWB-0007M5-JB
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPc-0001Rr-U9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPY-0004YA-Ji
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id w23so1062001wmi.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=X7IyXvhKZGt2O32lbsG5+Ml4uk7Ee2kIFAZnUq6AVe0=;
 b=cpZnOg3eyOrPQB+WWUIV7oYiSjgoynU5Fb6VOr3fzYS3/k7EKKb/1R/cXnegfwz+pT
 sfwU8IctznPqO2tBlGRijiNBF50pZZlu091t3esIdAA0PXKMDNO7KhisyN4S9OuOugRH
 Qj4HRIwDI2jbBJOD034S2Lf34BDQU+zEy7uBXTG9IJrIaPOImPa9nu4QkHhVR0dRf6OE
 Psmyjxq+gdZ2wEk1RYvbJIO44aoW00wbV0mVdIewh/+T7b0DhM5b7X5sVkb9SDfoy5Hc
 3cTgRow+HNDgwhoeXGsEzIrnFqQTLJPzIucD3nn01zVZVyp6LVK9qPtDsFpE4aHgGvn4
 UJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X7IyXvhKZGt2O32lbsG5+Ml4uk7Ee2kIFAZnUq6AVe0=;
 b=rvI8d8+gocAsxaVrkqut0ePlzcXJ19hrPtCGNc6OWa7cY/FIfTdJiBQN37319dNk7a
 /wnDkFDofhr4kDoEoUSpftAKJHz2iX+mNFTVzy5+KOOfKbDp+VsTeo5ffQ8mGRzzxR40
 b8CEGzkcn6QYe+a8WCz8Cn0CPksmCUNjvCUa+sZgBlR1WX/ks29svzzPy+npeDI6qhl6
 8hYX+7L+Bz9lYwULBKnQQK7D3UV2kdCTuO+PsI+oSq7TqI73iikbRmymIXx+chzGwoOS
 WEad7ioTtCl/WCd+CKy7FzicrN3lGwP8aCM7I4b5mdcAp9BmqWM8Td8fSa5s1zK/m454
 pT9w==
X-Gm-Message-State: AOAM531OLa2qFROgj24DUcWfvHj4hxljirGONKzk9asML0Pgvy6P4Mvr
 YJGoDpfO+0Re3ZOqdwJzSEqq9A6UkP0uSg==
X-Google-Smtp-Source: ABdhPJycWvmssgjod7lxmgdq+MnM/G9G2u5UGJ48xOx3gsgTOW+N4uFlNHk2fYZonR3jCfsWgUtwqw==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr2248023wma.24.1603799105868;
 Tue, 27 Oct 2020 04:45:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/48] hw/arm/smmuv3: Set the restoration priority of the
 vSMMUv3 explicitly
Date: Tue, 27 Oct 2020 11:44:10 +0000
Message-Id: <20201027114438.17662-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zenghui Yu <yuzenghui@huawei.com>

Ensure the vSMMUv3 will be restored before all PCIe devices so that DMA
translation can work properly during migration.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Message-id: 20201019091508.197-1-yuzenghui@huawei.com
Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0122700e725..2017ba7a5a7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1440,6 +1440,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     .name = "smmuv3",
     .version_id = 1,
     .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
-- 
2.20.1


