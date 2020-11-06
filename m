Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77196C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D798522202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgo/+5ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D798522202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5J8-000358-QT
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HV-0001I6-Fe
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HP-0003NF-2a
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id k18so1998151wmj.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nE1i2hAAqaIuOFEo+8UFV1Ok6/fO1ASvmRXI23HSnQQ=;
 b=qgo/+5ERyCclTWErEzcmtlr813OxzasDLZPv3kGPFB+AWSaQI//UjJxi5Q7MMI05dp
 HJAcF4xqKYnOmIW5WiuFpEAU6xFrKiwGglz2u2NhxnyxqwdNYKSbaPDyfo5BGBY5iF/J
 LVsPAni/KdliaS8UL36MOl0GpiMTydgz34e/UUjzhDs0gaYGYMrdLzMYUoxFAp6For31
 zbzjnlD7wjBH9JWOZ4794W34ZFs66XRdAAI76fUfhMKdIGFGmxeSHa9GvkZjJPdn/ZmO
 Dp5qX84GQcCMM54qMk8tkOZe3i7dpPnZPmL7lA9YVsOgwc5fZxqYNSMNMOWrJuyPQNzv
 dj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nE1i2hAAqaIuOFEo+8UFV1Ok6/fO1ASvmRXI23HSnQQ=;
 b=NhwX4bfbqWm/nNRLU+Eswx5a+TvVaQco9RNyHibRvCGQKZWO9UL1RD2tpGwHRxkEkE
 eEv3y4SVWdAWbxyBjSdCoYiNdRJ1GApArv2Tx65HePq6/lWGGzU0uR90T9SIjr4Xi3w9
 ZVxgZra+NMKsaKDkmP41DvSh9oErmeKB619/cENcS8e4dzHHTvQNS1cM+mhftF22ZkM9
 oPYZhEG7odpQAzEtrvbwq/WZH7JvKjmAJ1XjmnN9ivyYkSuI7ghijHGmI0gGtQ91ZKZA
 u/XAFvO1dC8tVmx+9WUgZAEH+w4d0dvudYdUAanGlHFPTRctw2av59t9qsw1TRWtzgn7
 ODgg==
X-Gm-Message-State: AOAM531/vXqiKZMQoFxC1HXZiFmiPbkM2n7I3/YWNNR2xtmEs8m/9Hg5
 +miSCtTiLyAebb/meoB/FNZk8seo4J43AA==
X-Google-Smtp-Source: ABdhPJwE7UbCW3ZL5xhezAlpe5z3+Kb5RRqpkxzitOCO1y9e4AdNpt71q2wKpSDOCsbMItbxEHAexA==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr672541wmf.38.1604682721478; 
 Fri, 06 Nov 2020 09:12:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm3162649wrb.1.2020.11.06.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:12:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
Date: Fri,  6 Nov 2020 17:11:53 +0000
Message-Id: <20201106171153.32673-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106171153.32673-1-peter.maydell@linaro.org>
References: <20201106171153.32673-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of casting an address within a uint8_t array to a
uint32_t*, use stl_le_p(). This handles possibly misaligned
addresses which would otherwise crash on some hosts.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/ctucan_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index f2ce978e5ec..e66526efa83 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -305,8 +305,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
         addr %= CTUCAN_CORE_TXBUFF_SPAN;
         assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
         if (addr < sizeof(s->tx_buffer[buff_num].data)) {
-            uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
-            *bufp = cpu_to_le32(val);
+            stl_le_p(s->tx_buffer[buff_num].data + addr, val);
         }
     } else {
         switch (addr & ~3) {
-- 
2.20.1


