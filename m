Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0872AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D9D2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D9D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWveb-0005Vh-6I
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZE-0002z7-Bp; Mon, 26 Oct 2020 02:01:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZA-0000H1-Ca; Mon, 26 Oct 2020 02:01:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 1BD76E0C;
 Mon, 26 Oct 2020 02:01:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 26 Oct 2020 02:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=9zZ8E0ONIxjBb
 JWYOf+Ay6R3AqA3OblzO6hsEvXFjNM=; b=ddY8CD77vYEZiU1iubKFKzOHKxnIO
 XKlSouPtjVmbKpY5+ihvragGaIHXtscJllOfOJ/YLBOzCjAciWWDSIG9YzuahOxI
 EBw3ycqp73gx17BBimzsdh5qO4wkmCpzks7olSGCXrF9mQW8VcUjhik2vs8x7Cuu
 lp9qdbLVTkK6ygzihNkaFtcI5zUPHJUj8MS5j+fT2WltV3JdPBvS9fAzpd6U0LyF
 WHLL9NOISEmxFhF+H4VZranLaTQLkIolsXERwInu6Lip47oE26Ls4NaYKqwilUaZ
 /BsGZjj+Y1/TE1qo/3N4Mq9G/7HARzJ5wHeUARQ66lfV9WyJjKUPjAqog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=9zZ8E0ONIxjBbJWYOf+Ay6R3AqA3OblzO6hsEvXFjNM=; b=bmBB5Fba
 uYD9MYbckYLW7TXu4ZF4WuTZg1QezDCR+jfg7siWA6VfKXawwdJ1yVsn13C0zLQ7
 FJJu/qY8tIO+zGUXwjYeIlpYd8ep/Fzh9VtuYaLxgwjYrZcqXRayEAOwVQR1GNGM
 8+SA1AAngAce1yjJRoSu0zEjJcQk3q+WDU7qwaUo69zyTCpPUo0hzzj5/fDZwAW2
 S7bm1B10DHw+YL7id70rXMSO1hk++K1QhxY42WtH/C+z2JAVmOTCKc3QLpPF5eqR
 q8wONFJl8WVQOVtyun/lyHBqwYTaIGoXh5IW2+DMkVZej2beS11/4/mj75/GnVJN
 RW3sqGukjypvug==
X-ME-Sender: <xms:JWaWX5gsNX7irW2vOLfnTKBybzIil_JBcubu_nC9oZdvMxB_4AsX9g>
 <xme:JWaWX-CoyrZLOprCrYqYFFX_rYH6CslxxWiDwF7lsWxB4QyoyJ6hkeMdMtbA9iQ9q
 sLzJELMiL5uUz9H70I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdeludcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:JWaWX5F_483viQTfqiuISdqeh8w2kowH_4wKAy4PfXM_T0g-lkLz0w>
 <xmx:JWaWX-QCCau-m4iCZwHLRqhC_zkthsb-iJ8XaomsD369p_5mO2uzRw>
 <xmx:JWaWX2zX4onrsCi3GnSFnyZzxt2teIAnU-RxP525vW5cUjr_GaXj1g>
 <xmx:JWaWX9nnJlYtdV5HSLxU8_x3DgvLbUpc-VEi46sL1zJwPcd9xzwuyw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2FBAD328005A;
 Mon, 26 Oct 2020 02:01:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/3] nvme: add namespace I/O optimization fields to shared
 header
Date: Mon, 26 Oct 2020 07:01:00 +0100
Message-Id: <20201026060101.371900-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026060101.371900-1-its@irrelevant.dk>
References: <20201026060101.371900-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:01:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds the NPWG, NPWA, NPDG, NPDA and NOWS family of fields to the
shared nvme.h header for use by later patches.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
---
 include/block/nvme.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 966c3bb304bd..e95ff6ca9b37 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -990,7 +990,12 @@ typedef struct QEMU_PACKED NvmeIdNs {
     uint16_t    nabspf;
     uint16_t    noiob;
     uint8_t     nvmcap[16];
-    uint8_t     rsvd64[40];
+    uint16_t    npwg;
+    uint16_t    npwa;
+    uint16_t    npdg;
+    uint16_t    npda;
+    uint16_t    nows;
+    uint8_t     rsvd74[30];
     uint8_t     nguid[16];
     uint64_t    eui64;
     NvmeLBAF    lbaf[16];
-- 
2.29.1


