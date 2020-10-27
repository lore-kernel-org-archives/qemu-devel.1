Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E9C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6876822263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6876822263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN29-0002Rz-4J
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYP-0000ED-RB; Tue, 27 Oct 2020 06:50:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYK-00029t-Qa; Tue, 27 Oct 2020 06:50:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 62C985C0114;
 Tue, 27 Oct 2020 06:49:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=o//1n+YIuj+Dy
 VMAB+zHlNElHxubd/CXxNEeoskQLBU=; b=Pn5gY40VuH8DZUGRZKzKbRvXjnRkQ
 3t2tNbw+bRo/hxDX55d5i+5FVMWD3tBoWYPjdec8qoiNeAqIhUJP19qBLOyFzzZ6
 ikqP2rWgMn/4QXjrHj3j0nsejKkT7GjR9iTTLdpNwc8a7o+kcXL6K3VV0+XbRytt
 5zGUijKLkccytk57Bqy32PU2gJ3JqdOmtaE2XhxoMtRUgD1m4vKnLxk62EWNsulC
 fKcqRXpRzCugK8UNThENRPhrGWLy/DmpExF9ASwHN3gpfp68pGtKJ4KO4ofso6aa
 HXLs9ybqnWlqgS/R8XctyCoyAutYD6uRvCSU3t5sScytgidZNH2xbI9yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=o//1n+YIuj+DyVMAB+zHlNElHxubd/CXxNEeoskQLBU=; b=FOItmqoW
 b8dAgnCKqiUX61sOgMTPKJNQX3fL9ePHskflrmlSxFpRRUyEgkW7E6yYaalskBS5
 GM1JtZuqccj6OaBXJPmKXFTGYtJye8vaTo0t2MQm3SjnhaoCDrtDGXIZW/FFUNlV
 3JfNy2Cj35vvJdeodQ3G13qmWZoFsg93Gbw3jjFxCYKIPeO2dYIJonre/29UOCi1
 MYGE//M2E/p8b+FU6GAFeBPHea8ytAxlflhx033Kr7//+jTuWwqopEDw1XGeErrT
 39gQxZ4knCoIYqqsQQq+O/ePO/YfwnI87qHRb4w/4w/r+jQUJ+km3LnxJQNNd5/v
 JRue+GksjeHspw==
X-ME-Sender: <xms:S_uXX6MzyGlTvu7naFs1rn4BImE0ejaAna3g7fZDx_-BUsdHMnCPjA>
 <xme:S_uXX4-K3CSxIUOc96PD8IFMa1UYonXrWTEK0WBg2RtVnoNRzX3BH_gkQLjza_xog
 6pvdxWe0AQbADzN1Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepgeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:S_uXXxTRl4uS2xQIaFQSLhdE4xmg-PJp9mQdviAIQkRwCwnAFe1E2Q>
 <xmx:S_uXX6tpzzCfcerLGxx56Ig31xmSthB87gjOuYOVu0JPXbp2z7YnPw>
 <xmx:S_uXXydkJxGSLmGO8tu6hwkY27Jr0RqVbHoH0OfwK8rtoY4nlv7qXQ>
 <xmx:S_uXXy5Bd8xTwypo7csteiD4uIISpXvjtB08_pS6vi0kZ2RD7r3i_Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 54FF93280060;
 Tue, 27 Oct 2020 06:49:46 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/30] hw/block/nvme: harden cmb access
Date: Tue, 27 Oct 2020 11:49:13 +0100
Message-Id: <20201027104932.558087-12-its@irrelevant.dk>
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

From: Klaus Jensen <k.jensen@samsung.com>

Since the controller has only supported PRPs so far it has not been
required to check the ending address (addr + len - 1) of the CMB access
for validity since it has been guaranteed to be in range of the CMB.

This changes when the controller adds support for SGLs (next patch), so
add that check.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0e916d48d763..c0f1f8ccd473 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -142,7 +142,12 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 
 static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
+    hwaddr hi = addr + size - 1;
+    if (hi < addr) {
+        return 1;
+    }
+
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return 0;
     }
-- 
2.29.1


