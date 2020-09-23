Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88830C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B952220D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="bT90MOzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B952220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9VE-00032i-J2
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9Nx-0004w8-7i; Wed, 23 Sep 2020 14:20:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9Nt-00087W-LT; Wed, 23 Sep 2020 14:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600886176; x=1632422176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BYQ28XH8Ylx9Dq0KVPfvBpBWZp+s9KZQXJ7UPhfutPQ=;
 b=bT90MOzqUNHAZGkkWF0Xl4HYDE9tQLrAXqvPHUeOyyFCf+Em/jmvgicZ
 lPiWMwNZHxTKOWLsXYPEJdUkJHu+jy3DlUJOFNQq84kxg7KFxc8F5v0ef
 PkVwhXLbdOVC6EfAFnANTVyfVsGXDzcGsScl+9K1MFfv6XzCl1wKKZGgB
 B2ioBzuwMmZ5pH1eaCEATgry3gqSlBnvyp+h0XngegJ3+li6Kk+piMcKa
 8q04YugtseRJ1lFvERQInVKHQwNdKsVeM9OG5erPUWbUouUyDAGtz0+iv
 HdccHdp42pzNvxT2ZZsyREarbqEp3vUpAoMHsZs3w7ltf+eCoVc6ReCD0 w==;
IronPort-SDR: TiHUSmltTziy/7j1qOPpkAix79fxamHQUCgQF4kACKxjKT0mlgaBXLJk3b+JXzajEaySOUHTwP
 GhGIOhqKmaWchZs9nKR9HI2Of3X8XiCCF64VaTJj1BHMf46cohUYZk6PHlpG8DXXj+Zk3oZilO
 RK3xmUiL995Yd+9AeRgJGFD3jsP/LbPcd+M2rKdcHfsQ/XROgwRQC63jJeKQh/0QfahuREuZQw
 eZsDD9FFZhXKxgMc8NjqDdCgMHDYPYcWaK4u7WQZnRgWRObnZkmgmBjp4ynvw018Sx4LRMFpAn
 K0k=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="251496337"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 02:36:11 +0800
IronPort-SDR: C3iNJLdz73zPLik5kncSLPqdYqBl1uAQn3rzY4++wryxDVv6XMQAO4MedtATsxg/vo6TpXU86H
 WW3MBRqfyXpg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 11:06:56 -0700
IronPort-SDR: C98WqivzRrZP8+CiQ9nZMdxF9CZO784NGohbNFFi1Zjh/3QAQfW/U9nFkBvL+8ZjaLrAd8G2di
 3UcBUV2H1yuQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 11:20:48 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v4 01/14] hw/block/nvme: Report actual LBA data shift in LBAF
Date: Thu, 24 Sep 2020 03:20:08 +0900
Message-Id: <20200923182021.3724-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5287de305=dmitry.fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:20:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calculate the data shift value to report based on the set value of
logical_block_size device property.

In the process, use a local variable to calculate the LBA format
index instead of the hardcoded value 0. This makes the code more
readable and it will make it easier to add support for multiple LBA
formats in the future.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f6009..f60e968c4a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2203,6 +2203,7 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
     int64_t bs_size;
     NvmeIdNs *id_ns = &ns->id_ns;
+    int lba_index;
 
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
@@ -2212,7 +2213,8 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     n->ns_size = bs_size;
 
-    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+    lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    id_ns->lbaf[lba_index].ds = 31 - clz32(n->conf.logical_block_size);
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
 
     /* no thin provisioning */
-- 
2.21.0


