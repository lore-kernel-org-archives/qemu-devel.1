Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE00C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C04206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C04206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG4T-0002Pl-8j
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwQ-0003Uy-Vw; Wed, 04 Nov 2020 05:22:59 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwO-0002Hj-Ee; Wed, 04 Nov 2020 05:22:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 6885C3D5;
 Wed,  4 Nov 2020 05:22:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 05:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=UA+VVCnGzkkNI
 uqKXObtavL8wxUG01U2iUsM9Tmlh44=; b=BM/q3bo/I6Yb8FmWFFvq8L7MmQ2hY
 JCt+6mUKjXSGM/O7LxS4rHyTy3tTts+h3IXPLqpUE/7etEH/mvTmkpKxhhAfxu+X
 2WF1JQKLzDzs9T51ud0wThWBuu1XAFY8HyhZ6rm6I/KjU5EtFMS5+vPS/BPLq8t6
 z5ZQIK6GmJYQ8kMO9By+s+YiahLBGEFKsOxDjK7oW4VDcibMF3rlp1yi1BMaO36O
 MTDYW/JgP5N9ECJ+epc+sWw8LCozgFAlyO74xWQILEaXbrTMDm/HKda7t4aSiBZh
 gU5d6ZjZrda81L/RjLpurg93Z3of6tqiXUsCQ6rRaRx+n/jfheGKSMJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=UA+VVCnGzkkNIuqKXObtavL8wxUG01U2iUsM9Tmlh44=; b=caGL0rwr
 QTwgyL5jhCAMOxGNcr8KEaL7jWOI6BQz5LY62eOBj1+d2dXWl00bW9XF/T4u8Hw/
 ja0CGfzl/ELIpz4a6oOfQSrk9HGsVdr/HG3R6rHz4j0bN4/yjZt+Eh6R+56wbvHt
 j34w6Vumz2G3yB9Fn7fOZhHKjTxbMNG8mkzyisMQN41PxQ7iPr2S2k/JHHroZRS8
 R2utYbgr9w+u9joQ3dVETptUH94iPutiz2sWhbpNV6+WuUfhuM7Tj5tsB8uYOaX/
 QcM7p8+IxyJ+GqvxPmJl5EipxDovcDYMqmG8lwXZvjI1oWWyqjn039EM66yg8xpT
 j86OeiJr5h/2+g==
X-ME-Sender: <xms:_YCiX2d8SLjNsJ68dnoBNyQCvYjM4_IOMiVWeGloDtgHaMbUWCVRwg>
 <xme:_YCiXwOei9-uNkUhgI8DHZuGdqXkplYpvEGiDaQxt_mtnmEx6vzZE5qIv4rcMvQ5w
 Ipg7qrN4t5_O_lYR9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_YCiX3hRjdp6mMkkNZl4RVuha6yYi5hj2I-tMergVx9StqUNRZ6EKQ>
 <xmx:_YCiXz_s4HSQXpTpeYPGQm6nhZuOkFq5FfBz_0IGFoeNSjoLyeqbyw>
 <xmx:_YCiXyv1XIDl_1fRHhjQ0ESSAPm-waeZ6ax3i4KMMQX52NHOVepqxw>
 <xmx:_oCiX_-udIULDQ3I9skdduOz8X9gdRdays8Wq-Sr6jxhjyn99QOC4Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 99ADC3280395;
 Wed,  4 Nov 2020 05:22:52 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 2/3] hw/block/nvme: fix uint16_t use of uint32_t sgls
 member
Date: Wed,  4 Nov 2020 11:22:47 +0100
Message-Id: <20201104102248.32168-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104102248.32168-1-its@irrelevant.dk>
References: <20201104102248.32168-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:22:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

nvme_map_sgl_data erroneously uses the sgls member of NvmeIdNs as a
uint16_t.

Reported-by: Coverity (CID 1436129)
Fixes: cba0a8a344fe ("hw/block/nvme: add support for scatter gather lists")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 080d782f1c2b..2bdc50eb6fce 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -452,7 +452,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
              * segments and/or descriptors. The controller might accept
              * ignoring the rest of the SGL.
              */
-            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
+            uint32_t sgls = le32_to_cpu(n->id_ctrl.sgls);
             if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
                 break;
             }
-- 
2.29.1


