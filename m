Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B0C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DCE21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DCE21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMvq-0006yC-TN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYR-0000FN-1O; Tue, 27 Oct 2020 06:50:15 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYN-0002B7-Ly; Tue, 27 Oct 2020 06:50:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DBBB75C0127;
 Tue, 27 Oct 2020 06:49:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=5tbGUBYHu9lqV
 cdoBRiaq6frdkmiCkcHmgO9wgQ0fmA=; b=kC/pnQceiyjwvaqzVb8ogrybRUGa3
 7uaUgpDMwAD83Gd86csbCti/X3A822NOG5o6R3+ebp2SBVHJbbSEv2Kjati3dVd7
 DKFsAwqFGrq+aqqxI86UV6uBlUTPx20i2Y37H7Dkoi5VCU7khqYBzsjpxj3Noe28
 ywSHkLcCdtc2FNVS4htseyL9yt7InRs3JP+9JxwpHEO16a5QZDzgayd7T4u5XwFO
 KPMb24PEYM+hgTZ0phxkLIJFrpxaSt3ITECiHber7Lbo7UiAanEQ8lloGs1MaX93
 pb/XZoIGFPraOufQk6DTFo0XpK49UcBrg+kH88PIYUBnJ+4xOMFqv7ApA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=5tbGUBYHu9lqVcdoBRiaq6frdkmiCkcHmgO9wgQ0fmA=; b=Nrc3Axza
 M+CqY4IDMNzM7hWPPSNyJN2fY3Ryis9yP4edcm0rA9Nm0CT/yI8uATjxaUohRXqI
 7227/AemaZwEIvjrkBdhQzRPFTfwnepx3C0kB7djxLSHM03pmulQZYnyyntcnjz1
 iraIstiuoP4iErq/v/MF6PgOsZGbr19u7Bf3p4+D776kpxyUC1W2b/A222AMOwnG
 qB3o1ZcG75YKQYJWz901csHbgQS8rXyIlYmCI2+JBAyRKJPowUDbnoJcHVI5JQ4V
 Y6GphfVFy3b1EJa7KYN3lP18jWk6KHCPU44zTD6v7EAvfRfbbxPI2GxN9Uz0hcXm
 UJZGT7nAbvf3BA==
X-ME-Sender: <xms:TvuXX5bMF1HOWdLrrqAkKGCUN09JUvpCSMnH83WEd1OQ8fO41RiYhQ>
 <xme:TvuXXwb8Lt_UjMguRox1YaAsAJokar0Xe-1bAOSqtsgtLrAsPJGM9AJapsDUMwqCu
 dJyBBvSYapxq7LuoLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepgeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:TvuXX78KV76Wo4oMeTBkXO5DsnP6arTqt2atgz8RwkXoiv6S_fQz-Q>
 <xmx:TvuXX3qZrg3PTf-ap2pu7IYK-Z9rMaOsiYowfvCJeqZcZo0nf2LJrA>
 <xmx:TvuXX0q59jXjp5CLH2jjx8H29IN6_ezMYkTYMcN0SzbUI0Wbjo1sOg>
 <xmx:TvuXX9mtLiEcuLGb3oM17nxNjUGfJvz-eBGH1DEAmNbSGaQQoMzkEA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B81BB3280066;
 Tue, 27 Oct 2020 06:49:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/30] hw/block/nvme: refactor identify active namespace id list
Date: Tue, 27 Oct 2020 11:49:16 +0100
Message-Id: <20201027104932.558087-15-its@irrelevant.dk>
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
 Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Prepare to support inactive namespaces.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4f08f55a76a0..924279d6027c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1473,7 +1473,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     uint32_t min_nsid = le32_to_cpu(c->nsid);
     uint32_t *list;
     uint16_t ret;
-    int i, j = 0;
+    int j = 0;
 
     trace_pci_nvme_identify_nslist(min_nsid);
 
@@ -1488,11 +1488,11 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     }
 
     list = g_malloc0(data_len);
-    for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+    for (int i = 1; i <= n->num_namespaces; i++) {
+        if (i <= min_nsid) {
             continue;
         }
-        list[j++] = cpu_to_le32(i + 1);
+        list[j++] = cpu_to_le32(i);
         if (j == data_len / sizeof(uint32_t)) {
             break;
         }
-- 
2.29.1


