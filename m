Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034BC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F4E22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F4E22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN3H-00030A-2O
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYW-0000NR-CN; Tue, 27 Oct 2020 06:50:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYU-0002CP-Nj; Tue, 27 Oct 2020 06:50:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B496F5C0192;
 Tue, 27 Oct 2020 06:49:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=qbWEymWcc8PIf
 snra1IFx/bEQSN/YNwnHOYcSF057aw=; b=Zl/3EQgynOrPZYjSEUwrDg8+2fnUW
 tXst3BQ2d6v0SiBnDR8KqvAN4r6ispTiT/1nLmNIf9+lHK2ZDukNLN+DILGkDX4u
 yW/LYxO5AuKHOStbWL72FeTSkPIDzYs5KfXtpR525wZhx30ipNcP+OgI9gUBjiQ9
 6d/qCglmQveErIpvYoDTCB3cVhNNTcMcPkOrQyX+EyqFolwe/09qypJxjbatGVDf
 zhBRWXylv3B7F0qLBu4ZHIKSkwCQtXBXImpYiPLZnH/lnlXlBemuGLMCtBp6PDw2
 PDXh0tJ86KpwV8zPHAHAvQBo5bTKOrvaGt2BhYyyhIcmycBngXpqMFoKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=qbWEymWcc8PIfsnra1IFx/bEQSN/YNwnHOYcSF057aw=; b=WGw7lcQj
 LgtqHtkkI82z4ExGk75xdY8i18RN4rmpK85PbP2BbgCoI1KKKecQy/Ep5lkmuLFu
 w3BXNXrqdWdxkWEsuSDLUpdYk3j7fDiniQnWMhuO2gTYCUeC3NEJXk/bVu5DfINj
 DVRhYK9ZQNIcRAZB6oLMhcPcK/E11MDhPxMuL0Ge7dsKJnB/oiJPUAZ8EBeYA6h6
 +2e2zyCYIK+UgzZJ9mWgdeVzi5/dEEmoq2KeEngSWKXhxR1zw46MubR/2Ct4wEDF
 dV6tIK/RAawUcL1pAVIyTdSLl+mYc4zutXOrPolosNugkYlEp0oQR1r8BGzYr5uH
 G+XJyKAkNXHd3w==
X-ME-Sender: <xms:U_uXXxQG8MuoypdHeBGS6lJC3d2psZkFoNstskSr8zS3TKUFQPzpig>
 <xme:U_uXX6yqDrUFHM0C4PjPswDc2pf0P_qGYB2-70M8GUwzceCwdJJB1PUocKwbXlLv3
 fGR1l6uLG7y9ecGW54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepieenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:U_uXX22Lhboo20Z8B1OlL_6bl1gOdLOFW09NoDV3TP3h20ZtEAqfQg>
 <xmx:U_uXX5C3f7la-PjTotfRnKiHfTX4eRBy-GLBGOllWbH-l76dlnhk7w>
 <xmx:U_uXX6hMUA80dT9xd50PqoTUGuHrYu6we_ollI7AB5e68xVurAkypg>
 <xmx:U_uXXyevsmT2nNFxaDRqP0F-EV4WbqVd5oWOfhBiovl4rDV6uSD7gg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8BCB43280066;
 Tue, 27 Oct 2020 06:49:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/30] hw/block/nvme: update nsid when registered
Date: Tue, 27 Oct 2020 11:49:20 +0100
Message-Id: <20201027104932.558087-19-its@irrelevant.dk>
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

From: Klaus Jensen <k.jensen@samsung.com>

If the user does not specify an nsid parameter on the nvme-ns device,
nvme_register_namespace will find the first free namespace id and assign
that.

This fix makes sure the assigned id is saved.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5768a6804f41..2225b944f935 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2578,7 +2578,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         for (int i = 1; i <= n->num_namespaces; i++) {
             NvmeNamespace *ns = nvme_ns(n, i);
             if (!ns) {
-                nsid = i;
+                nsid = ns->params.nsid = i;
                 break;
             }
         }
-- 
2.29.1


