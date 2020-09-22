Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A821C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4FC20715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4FC20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeCR-0000M0-VZ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwL-0006UK-98; Tue, 22 Sep 2020 04:46:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwJ-0000vb-9V; Tue, 22 Sep 2020 04:46:20 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 0F5DD5803A5;
 Tue, 22 Sep 2020 04:45:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=pI74XoY9YTtFV
 Y8r/NcYdsRNSfRcQvE606qFzlOBRKY=; b=h3vw25pdMfdh/iExP6Dy4wHpyzd/l
 Vz3/pGDeaUjgc2ExZiqEHgXeEP/5e8USqgw7/vzQFF4NtdBdN81AHKiETWHR7XEo
 2vpMpy/Ek/+GsvbIQTH/5ymjLBSIZwf4WhX4+cb6Ne3bQQPvW8IltBfmlzb/Iv5A
 ziZ0HaL8QDVuWJ3cO16w/jN2RFWN16piCPfVDXEhy5x9Hq9afGV6zZ0wLNZAsS9X
 Fv2PqJWjaN09lWqTyJb1Kc3QDAveabNfnNRmv7jgngo5e8VsFTDBdrpJRPaL9ayT
 GiLenKk87xfnSuX/e1SggfyiX4MfR7X2c0r4s5NnXO5ono4eUVTpeS0mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=pI74XoY9YTtFVY8r/NcYdsRNSfRcQvE606qFzlOBRKY=; b=YN4y2Vue
 8X1YR+dotEuvPK5HVjAH6w6kzALvQ1qDRXOibHcMErOrzWUb5AY6qVpjwHZgQkDl
 uajpjFu1Zd9fzesTi3rS32JLBsCILV/raUgsZfFABHni2SuDBhFden6DmO0MCKo3
 NG2JJmfk9mG2VY3ND59NYcqrUpMVXmyMuLTJwXLHNQJlkt0BtgJbNrvJHZOqTrlI
 2oibKi1lMog8AMlpwGegrwzBoPxg4iY4JT/YQ2BwwyzuEu61ffc+krZpEToKdSXJ
 jxQi0s60HUlmmD16BLJbhOjFDuEY2aX7uLlID2tkDYyUWCfTNbgWQZENaDlFETC6
 JIsli+mXKRv33A==
X-ME-Sender: <xms:xblpXyXa_D5F7Ws5klVpJObmu7LuzezjlQ3gnb1HYl3SLIN4H3g1Vg>
 <xme:xblpX-k7uHXeyiscBbxnthEJY0-Foth7PXh79qSemkCHVbYqCF7rUZtvCCgMU0AIz
 wCpSGf73ePbD9ZQ3vI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepgeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:xblpX2YwceX4AAgYimzOgrvRJy22gvqxOJYayiywRgMnr_pL5FwgeQ>
 <xmx:xblpX5WrmLkYhBpXsVssWXLjv6qeWVzAaahMU9r-l0-gqfJYm1B8Hw>
 <xmx:xblpX8mwyM-d3usDJJCEuiNxFfvh5yIgFhdNKEWFgvU-TasgMcGOtQ>
 <xmx:xblpX27-BIooRuY-Pjlv9zei9wgf1RtG3u3hVy7ikb1k-z4quD-KAUvcrKM>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 314023064687;
 Tue, 22 Sep 2020 04:45:56 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/17] hw/block/nvme: refactor identify active namespace id
 list
Date: Tue, 22 Sep 2020 10:45:30 +0200
Message-Id: <20200922084533.1273962-15-its@irrelevant.dk>
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
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
index 1fdd5c9c5ab0..f61076178a6d 100644
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
2.28.0


