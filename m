Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20416C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C42022265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C42022265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNZY-0001xd-0P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYr-0000mG-28; Tue, 27 Oct 2020 06:50:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002Ic-Bh; Tue, 27 Oct 2020 06:50:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 7E0965C019D;
 Tue, 27 Oct 2020 06:50:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=C6P4ifCaNLzGL
 E7SqOde8mTBWzA+3zSpM+2Fhgy2lSs=; b=kIT4SEqhGpGhQd5lfKhyCizs6DSR0
 PDCd76KilYD093Jv7Wd54ws06GCFt1Ly6T5uCpNznEw0hKscCCUsKCruX373VNYE
 MfKRy9ej+UW2DxiRNCFWpy79T2znRSgxIFxgNKm2bb0LNJcLXi+WjGjaige2AfKM
 IFRBWL+HeA6roqrqkdlBPY+1smksSLTdkdLTe325vTvxeOoF0LwmWWkaXElDr1EP
 8p7L0vlzskRLJZc83bYkBmm3OXyRFxEWojRYQPbbYe05gzxv5syJ9j3G1x+tpgvX
 vizmsHrsjPuZFLGCLK/UJ66f1vAholNe0ECsIDvf+4qa19Kp4Jy2Ha0LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=C6P4ifCaNLzGLE7SqOde8mTBWzA+3zSpM+2Fhgy2lSs=; b=JuEIVJeB
 iIuuEjh+mbGGoC8cWfdi9TqzXFqo9HghoAYpD6jVgs4yIZCT9eMptu2XdBUaHJmV
 8W3nmpvkZH9gl17qFnOBjCTPkL8y0d1I3TMAOanDGPV9IlhV6B9HXIWYBbdFW7da
 iXVdpyo5ec1A8xmlM/c3WEeR7NJNJrdLlmqCeZmP71LiEwVPWdm4+IazmWq782ik
 Xa8NQHpO79cTVJ5+xAobM3nlfN1oqfZESoxTcKmrjat/J2GqIS8xjxJJsTX6oFXl
 7vr4HPD/9BogZ4uZx9NbRXbhfuZSd9MbxfWm7SJEUKFae9Qp/c52Pl/a8PraGLBy
 7SL8cxoocIlGBw==
X-ME-Sender: <xms:XvuXXxruwQ0wE_ktxvBGi_GMBMIe7Th6bThQjFbqDAG1FJ2aoHH3sQ>
 <xme:XvuXXzrZa2ssdCRfawAr2ECxJ-f_pm2WFb5Kv-UH7GohBOztCi1xwKNxRbK_Keplj
 RYxOQwfRJ4VECyycSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XvuXX-Px7Sawhl2vG4IwEBnQmQuZaCDDfCKlgEZhL35MbIT4hcUZbw>
 <xmx:XvuXX85byXZR0cbZgU-zLEuA-QjGBtwnVe_og6mUohrxD978zbzDlg>
 <xmx:XvuXXw7vYv54JjEDum57q8tCly_vbw8JvsRNCmPN50OVQlHl4iKJzQ>
 <xmx:XvuXX70rvjHJgqEUeSptEny8JUgfEQ1ksl06vwdQR2LITHKeGA4neA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 55EBE3280065;
 Tue, 27 Oct 2020 06:50:05 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 27/30] hw/block/nvme: report actual LBA data shift in LBAF
Date: Tue, 27 Oct 2020 11:49:29 +0100
Message-Id: <20201027104932.558087-28-its@irrelevant.dk>
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
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Calculate the data shift value to report based on the set value of
logical_block_size device property.

In the process, use a local variable to calculate the LBA format
index instead of the hardcoded value 0. This makes the code more
readable and it will make it easier to add support for multiple LBA
formats in the future.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 2ba0263ddaca..31c80cdf5b5f 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -31,12 +31,13 @@
 static void nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
+    int lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
 
     if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
         ns->id_ns.dlfeat = 0x9;
     }
 
-    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+    id_ns->lbaf[lba_index].ds = 31 - clz32(ns->blkconf.logical_block_size);
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
-- 
2.29.1


