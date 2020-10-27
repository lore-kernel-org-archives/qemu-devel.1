Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902DC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D5522265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D5522265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNBU-0000AE-6F
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYn-0000i8-W4; Tue, 27 Oct 2020 06:50:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYk-0002Gn-Dk; Tue, 27 Oct 2020 06:50:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 1A3D75C0190;
 Tue, 27 Oct 2020 06:50:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=u08EJyS6cwoQ3
 cc/ISxpr793ADeDZnwfNXgvEhjr9J0=; b=XJ4WfCm9aibKLrRlEMjgHH4t5AjLI
 2Q4/llvKn3b/Yn2htSos4fCYtJHTqQE/ssC6Y4I0RvyxdtLHFqof/zcB/fRs9c4X
 Bu+dvC4nV3tOcQYyQ4utKNhLmpPkTCUvRID0LvNck+PGn7tgE+Gim7rTZJ9A5OVO
 WfvGtL3TG539ZFz+AK2SJyhrzrVgJCvIH1fG1XGhgypO9jraau6hKPYdaFhgo9xh
 0ouplS0LQNNTrxa0CiAZ6/24H1UNI20/RwkzvFpAr2xrFxlLWgij1kGZd1XcCoA4
 NkJoTr+V5tfNlvo0HUCFR/RHjCs0a4O2USYpWI8GpcrQFE7v4H5F3KSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=u08EJyS6cwoQ3cc/ISxpr793ADeDZnwfNXgvEhjr9J0=; b=cUpPkQ7g
 xPaYUfFjDunoB1sC+AM6HsjTqnZQ+2I94oZIYNetF5clbj6KJwCmmatwJdR1BjPL
 exd0pKN/hAiTZGpQo9WiQdSmx30wki0pEckqY7o6p9pdOW2WuRM/UQapIMc6WQMn
 ZaP2CxAw90TBVrrs39rlpJbWO3waRNnOWvaQ55yIOKgKKwTDk3/2J1TpuB4QrDJ5
 tNYqVFy/kY+Uk4eYmpraH5gv2X1LK3bhv+uZdGYDFGTHxwJpbDKlmBPsXd5TxKrJ
 KrO8wKYieeL+o08BsfzIIjn3N2JtQEbLLqBuq51R1ovXqQJAF3UDH+ourds5ZWMT
 1O52uSa3OiAPjg==
X-ME-Sender: <xms:V_uXX4d811-tcUzYG3qUjV5GjqQykhyih9mjvszjt43TrcO7O4ha2g>
 <xme:V_uXX6NrC4-qJbX-UmlPxJXQqNCI_gkwVbt1rFNNQWiy1xu7kNL9hjL0R-t9QYre9
 wbOqT54vpH--o8NyNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepuddtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:V_uXX5ieNbbDnFgKUn81SlEN-dxxxEddIleCATZ6I-x38FrqGCrubg>
 <xmx:V_uXX9-CVAomgftM_vjw5aHRVngPbifMyV2eSpqhaUwkoqKjUe1-5A>
 <xmx:V_uXX0vXZ5eEt0dISxNQbaj1zz7ge8yFF5Dlj7AT_KWENMia-BWFxQ>
 <xmx:WPuXXwKWsNKuZmD5xzVsVbSP60b3RztwTae7AvKqD9JjJD2yCe6hcA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0CAAA328005E;
 Tue, 27 Oct 2020 06:49:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 22/30] hw/block/nvme: validate command set selected
Date: Tue, 27 Oct 2020 11:49:24 +0100
Message-Id: <20201027104932.558087-23-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Busch <kbusch@kernel.org>

Fail to start the controller if the user requests a command set that the
controller does not support.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h  | 4 ++++
 hw/block/nvme.c       | 6 +++++-
 hw/block/trace-events | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 868cf53f0b25..bc20a2ba5e87 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -82,6 +82,10 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
                                                             << CAP_PMR_SHIFT)
 
+enum NvmeCapCss {
+    NVME_CAP_CSS_NVM = 1 << 0,
+};
+
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
     CC_CSS_SHIFT    = 4,
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5a9ae699afab..94db06cf72be 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2045,6 +2045,10 @@ static int nvme_start_ctrl(NvmeCtrl *n)
         trace_pci_nvme_err_startfail_acq_misaligned(n->bar.acq);
         return -1;
     }
+    if (unlikely(!(NVME_CAP_CSS(n->bar.cap) & (1 << NVME_CC_CSS(n->bar.cc))))) {
+        trace_pci_nvme_err_startfail_css(NVME_CC_CSS(n->bar.cc));
+        return -1;
+    }
     if (unlikely(NVME_CC_MPS(n->bar.cc) <
                  NVME_CAP_MPSMIN(n->bar.cap))) {
         trace_pci_nvme_err_startfail_page_too_small(
@@ -2746,7 +2750,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
-    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index e56d688b88d3..7b28091bd60a 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -132,6 +132,7 @@ pci_nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
 pci_nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too large: log2size=%u, max=%u"
 pci_nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too small: log2size=%u, min=%u"
 pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too large: log2size=%u, max=%u"
+pci_nvme_err_startfail_css(uint8_t css) "nvme_start_ctrl failed because invalid command set selected:%u"
 pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
 pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
 pci_nvme_err_startfail(void) "setting controller enable bit failed"
-- 
2.29.1


