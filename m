Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C1C4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75B3239CF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75B3239CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeKU-0006AP-U7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwH-0006OQ-Ez; Tue, 22 Sep 2020 04:46:17 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwF-0000ud-MQ; Tue, 22 Sep 2020 04:46:17 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 209EB5803E0;
 Tue, 22 Sep 2020 04:45:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=qJeTGug5PQ2GC
 84jvTPZNu+vyo6hsGM5cWlpsifuT6Q=; b=TltjP7vjuG8eHsFKDo2VD2UDzmUVH
 ydPEovuasAD0w2fNNmxgl7FGzYhayzAydLNojoYiNY9v45BW2Tw8VCCLdHjt1gtm
 aeuyTnfxQnSc5qSRSK1tOnXN2Ri5/LSXZoV3i/p1WDQf++zMwiEAMIaaty9DIrcl
 NpJWw6IdoTvDyf4WkOJmiUL3f7NAuvvjZ+HJSI9Z1fRSVsSZH589odX+yqHpBFcM
 q2044hOf0XolgYn64tyDtdurJwHOATt1TRM4yvjh6ZqtdmlwNpI88B2dC5AQIjL3
 aFJhQvHAMf+uHqB/oXOdAqjhuX3s0TlUlPHc8ee1mLsrqr3CTzcP9Giaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=qJeTGug5PQ2GC84jvTPZNu+vyo6hsGM5cWlpsifuT6Q=; b=FrHKndCN
 pkjtwqUntI5J4/t4NxB05bv7OHkgRD3oPJmG2Ry+QYb7NMwUgYFb4r+DuZpOzJsz
 QorKrhnhHMD/R+iSLaL5ypLv5oXH392XJn606hHnh9OjMFS8AQwqkDKZsafbvpoX
 G8ErBcW5xBnY0jOUzJmnZLZQ80wf9ankrGWbpXgKjwQ8vqUW930KSQT9nYy/7msE
 +FbwilOo0PioYVKES5+nTQQMcurYD3qg5mwVS3aNflVU2Xa3vItcI5I1pkG4Hs/i
 u2l0u/zjN/iMx+VCfBAOmVXMf472LHJPganMAtGKmxbi0TC12TfHBaiKv6HGMUI8
 QuI1BGWOSJ3t3g==
X-ME-Sender: <xms:wLlpX2kunghWpquYlMzpSj_eVnKGNSHaEUGwkoYxxwDd4PAyJ2Mzww>
 <xme:wLlpX900zufXNLw-D4Bvu1ruPPzUzmf9ZiecgyR8iv8dOjPIhJEwvbXXnuOfghBIc
 W0E13IiyYlGAafj8jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepgeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:wLlpX0poZ08FDf1LMJjPkUUQHdXLF1v52Oa9OFDZWT1LjfCLRIisvw>
 <xmx:wLlpX6lP1Uu0fC_27zvqh-GSNz7twXkDMGXFw3JRAaqal6f5CT215g>
 <xmx:wLlpX02FdCnUWG2FRcjaQaSvWvmEeyi9m_3FqtH69Z9phnXGzr52Rw>
 <xmx:wLlpX1mwUj6vk5_Ew4sQD1fnxpw6Tl_20UzgRkp3zVyTC_fqQ-S1Bw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 683F53064686;
 Tue, 22 Sep 2020 04:45:51 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/17] hw/block/nvme: harden cmb access
Date: Tue, 22 Sep 2020 10:45:27 +0200
Message-Id: <20200922084533.1273962-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
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
index 7c9ea792483c..3b901efd1ec0 100644
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
2.28.0


