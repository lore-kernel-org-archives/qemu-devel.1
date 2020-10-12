Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA09D2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce6jyDHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA09D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS06L-00047R-VN
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqQ-00073n-6E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqM-0007Kl-Dl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so19670657wrp.10
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZygS7xMaq3Qs9CSNEUUqz2guLfBsLuHXGM1Pvcfwirc=;
 b=Ce6jyDHtzvLloLLAKvO7z15Q8cvs5dLx3C5wEefPUHUSvaYDZBoby/x/vpPfTFQNRI
 riTzK3LrhaxOTWpS9ceCHfs/ICXOMHmZttSXgcayy1GhjUdrVxrKNpyrmLa3AwoOYbcA
 0hHlzHDpKkVDGylDCaVNBuZbWnnIaS3kYQuT6S/br+nKxo3t+A+ibSYTPOQcYQZGfmC3
 SodEGb087qo8RpMeSMlUAOAKmgGkuKHPB3L2msboL64UNBMzl9ikSoZp+T6LSVynmYcJ
 7VpOlqJpNxIfngl+FC62CFEEuO9IU9XGbhxFUEYwMhQok73o/guDFTDAGvwnK4EIweeC
 WE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZygS7xMaq3Qs9CSNEUUqz2guLfBsLuHXGM1Pvcfwirc=;
 b=TR7q13fS/U8LHnf8/+80sZaWV7VMpplkmwmRbt+rsQlWDS6pP8X43NwecV/9HkVfRJ
 0MhXUVQfEI8mw+qBUXCNwGmgmOUOLrfhQRu0oiIfznB64SGoh8orjTAKYrCvGiEUH1Eq
 r2dbYuMQHn26veoakHKgXnhltcnHuLglL0lKo6q/Okaz89/LnUWovBy7RrGgodeWSxNC
 Q6N86QmDcUIRCekKxRrRdSULgB3GFrbG93PHPbjywR6JaSQmmVLFh2dw6016WwE0dArN
 Dl50EL+bBh/ArZAnCc5DQVZ+2spbJ+zrnKeDTvfqj94x/jygfM9hWTxtA9eTHXb4Hc3+
 Wm2g==
X-Gm-Message-State: AOAM532pq29zs+zUj7HMsAPlYSGzEjz4GprDIVEkeDkGHOJV9tnSLzD+
 aC+ayQhGCJrWtAYZVzl6+UNiAg==
X-Google-Smtp-Source: ABdhPJw9awCkp7QyesgefaMqZK5Q+Jrwh38JASnbjbfTYytIpnFvtPmRaw7r0qUrGr584fboAHnEKQ==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr27989065wrv.140.1602516873142; 
 Mon, 12 Oct 2020 08:34:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/virtio/virtio-iommu-pci.c: Fix typo in error message
Date: Mon, 12 Oct 2020 16:33:43 +0100
Message-Id: <20201012153408.9747-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
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


