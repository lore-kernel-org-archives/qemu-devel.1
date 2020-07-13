Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17F82072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6CBjEWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17F82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzIg-00035V-UB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAs-00055d-9P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAq-0006co-Gu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id f18so13313836wml.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aypUxU7C2gYLlTPZ8asdzkNfN+z6lUCzbwNisQbIlr4=;
 b=g6CBjEWZi3idyWARMDdSRQbdouAMNIEAOGeNx8OJ27gxIdaO6ezZxtyoZ5W/GzwKH5
 E3tFXlEFGPOjx9X9YhorEkYTpCGWKb+ecT4jhc5wQquqUG1L2VlMyIH+7BPe4s2uHvYp
 XBwKTFFM4BWG+ncBJoli1RFWNDSWiesETIxeqlUTZt3WexW8PCGUsjxl1vOLpebSc22x
 bOtDi6oZhk3/O02tdrUkfh2T9dtAtYrbLAo3hf4xSgq6FYtGbYgQii3Y7kx/eFyRR3IZ
 NS6AzrtzIMUilItYMHfbT53czYcBWHGlFDyO/8y8LjQjy0LWBwYCqDaUiZv3qlRgC4/k
 gWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aypUxU7C2gYLlTPZ8asdzkNfN+z6lUCzbwNisQbIlr4=;
 b=LVt50HUDAJU/1sIKvvNHhcALSAIFsYaEldVKGMCElltvgHAqQCru6tEVAfooYchaka
 TWx2ROaHtN6Tjz2YXa2rWmVkTpNFBdkg1q35wXXxml+w1FUpFE508yfzJk5x1X0HYvgy
 DUDKL6r8tSI8JtYAIAO5tQhmdWijvP0WQttNeNthYanYpN7jMA/eseaH6z8r0VvEQLXy
 vqdN6lisEeDk0FpMafc8ock4BP9skBUnhVTHiE7WmDFJZhcjOq4mtj3tSvYZw2oKme7x
 COfwOj0yV4nD43OI3RXvCKV6pCzikGFimtVVvwiozD8L9+HElIrJAbHFVN4aD43j9DMy
 0SIg==
X-Gm-Message-State: AOAM533OSw1srHFZzCui/zmCctdhgHFJsKx536GjBnEs1StG72FYWj9D
 VdtCWCHXI+ToV0CKXxrvIjZZ20jKy3yzDw==
X-Google-Smtp-Source: ABdhPJzq3bvoJBGgjamjjDQjzXQxsqDr/Q2k1TVMMftrra/4zKKot1orO/O5q1HQFC5GjxvRgMU0sA==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr182121wmf.28.1594649474583;
 Mon, 13 Jul 2020 07:11:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] virtio-iommu: Fix coverity issue in
 virtio_iommu_handle_command()
Date: Mon, 13 Jul 2020 15:10:46 +0100
Message-Id: <20200713141104.5139-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Coverity points out (CID 1430180) that the new case is missing
break or a /* fallthrough */ comment. Break is the right thing to
do as in that case, tail is not used.

Fixes 1733eebb9e ("virtio-iommu: Implement RESV_MEM probe request")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200708160147.18426-1-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/virtio/virtio-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b39e836181e..5d56865e569 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -534,6 +534,7 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
             ptail = (struct virtio_iommu_req_tail *)
                         (buf + s->config.probe_size);
             ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
+            break;
         }
         default:
             tail.status = VIRTIO_IOMMU_S_UNSUPP;
-- 
2.20.1


