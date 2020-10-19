Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7510C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262CB2224F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRyovOyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262CB2224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUaWj-0006PZ-UJ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUaVi-0005Na-DX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:07:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUaVf-0001as-GU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:07:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id j7so912520wrt.9
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5pk54uNqONM2yLrMyPPZQokvjsI/4SuiXncS3dHM5Y=;
 b=JRyovOyfT4YAXvyMrpgxBi44RMyB/KUuV8+dNF1FhL8c+I8Gocv4zVO9Uh53Z1dJ6T
 eq6jv+kyjvDiMVwUYYwg9TqyzscY47DZPNCI8njyXLLes0ppzoEb/N6NEBLaIZflwZo4
 1JaGYpa5hq+X3YrKkMm4nDetKq3coo6jMw+kP0HJGL4RX3CL4zioJaSpdRpaDb6VFA/G
 0gwVIy5h+exWwMXENJmRcRxvMf/Lim8e9ghxz+P7w297R+uuvLl4oU341/FZb6HyiUVA
 1JineKCTlhRs0Vl8ufVSCe8mZuzW5mmJgiOpSv2Vsmp5INWZy5yJHv/gRU9SgI6qFdkk
 C/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5pk54uNqONM2yLrMyPPZQokvjsI/4SuiXncS3dHM5Y=;
 b=ZcLbE4xm06xFCkQKJXoD6LQ3ioP+TmT/Q9dDwhwiQxEzGxxDA8/XOP41YaoptYuB0H
 +YHmKm1KWqkJVVhEsN+P42vRR9I3Uc+Qz5sGsmEYVCBTqw/5QCsb6+JNqaCDTjlpehy5
 2HbpsHp8qGfaUpprUWaUGDU5QxZil3pfegu08QdkLwDQln2ToqOIoFRAKVT9zlg8fKG5
 BA1DuTI84UG0kmbBWwhUcYYgbp8VXGfOYcg2cXKMjh9VIvqCpgMUhrqivIJX1I7Wmxn2
 Sv26vZkpTFRaCVjwt48GXebEsTwpE6KCtYJybTayU4Qnj0Esd0dgGdSlK8q0Fafg+K74
 gp+A==
X-Gm-Message-State: AOAM531NkGftVXoy3+HH+M6sRjGS31yPTbM7riKF3G/nfv3q0ElG5D/u
 7s43RdShxykZR4UmaV7HOzrsAQ==
X-Google-Smtp-Source: ABdhPJyJV8maj99ik2TKgf1dcIxNLnzU/NIOau5UcBbxtZ/+/6HFcG+10Bjz4crqOY3dRk2/cdPXPw==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr777519wrw.126.1603134473838; 
 Mon, 19 Oct 2020 12:07:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm833844wrt.10.2020.10.19.12.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 12:07:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/trace-events: Fix misuse of '0x' prefix with '%d'
 format
Date: Mon, 19 Oct 2020 20:07:51 +0100
Message-Id: <20201019190751.24453-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The smmuv3_cmdq_cfgi_ste_range trace event prints decimal values with
an 0x prefix, which is confusing. We're printing a range of stream IDs
here, which elsewhere we do in decimal, so use decimal here too and
just drop the '0x' prefix.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c8a4d80f6bd..806e1d89d2b 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -41,7 +41,7 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
 smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
-smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
+smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=%d - end=%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-- 
2.20.1


