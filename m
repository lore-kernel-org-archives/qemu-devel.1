Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF50C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D72522207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k6oCJhsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D72522207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj3P-0008SG-4I
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj0w-0006Ur-8m; Sun, 27 Sep 2020 22:35:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj0s-0003Li-KN; Sun, 27 Sep 2020 22:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260538; x=1632796538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FdcPU9BnrZi3NPj38GmeY1mLOczZxKVC6LrD2h8UTBU=;
 b=k6oCJhspPWXm0JTbvNQVKbyAgJfrMGzgw3XYitMQBRxNPGvKyeNjOtrf
 mV+ElB3MtXBrDwS4GWDc1S2O0Vmd9wucL1QK97RHSFmrznuwj27wj/huD
 +Nhah1rypifHS5kB5CZwEQY8gWFJPygILKFMc8ywtVgUnL0XXYZEELi/M
 KxelmKl8qFavLNfMIKViAvRxiY/fM+u88a+c56W3PKM6uzlIX+4XxExsI
 X8xzvnW7+tvTtHhthV1ZSE9OsyrL6OOYiWQPWrtk1YaozexhrdsQfGQPl
 OJseHJ+ntUkUs69eC8f3MiA7D6DgTfbzqkyvbz8OJ2LBmAA3Jl7KDC3I8 g==;
IronPort-SDR: 1OH6S2WlnY3BmA5XkdB4ZUWXHsz+9lAABVangna3SSKfx2tEhRHB6lSnU6PSgwQTOU9oQS+Q7d
 tmBnPzUDLt5+Sw623pEW94frmfNz55s+NAbIRUKRnoVeehG9/rZWlWXkKuRnX/hrnFDijygSIX
 oUArQpOnjXwX5wHONnakCKdliBsphTJLX47Lne767QNpB/dE4knrMIgDbVnryvBEsC67UVvC4Y
 qzKi6HBLFUVaPzczxDLAyYxO39WQ6rJiXhJOMUaLHP6a1G+SvqZOVdjaloRalDWcWysSblhGMV
 i0Y=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125225"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:36 +0800
IronPort-SDR: T+pCHnq7ZHiF2VbzSnCiWkYB4jjMaGjBV37p76PeKL1rCnMp+7utXKloakFzsWQI0sBx6RV+iO
 rnvG0xayp/VA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:32 -0700
IronPort-SDR: ngUfx7ozmazbInmh6By1PgHdolbI4ETsm6RS6b5Sm5HOXEggNm6ya3TCiJYrrA7NY/o6C9Dyxv
 YMyFU+IuflZQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:35 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 01/14] hw/block/nvme: Report actual LBA data shift in LBAF
Date: Mon, 28 Sep 2020 11:35:15 +0900
Message-Id: <20200928023528.15260-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
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
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 2ba0263dda..bbd7879492 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -47,6 +47,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
+    int lba_index;
+
     if (!blkconf_blocksizes(&ns->blkconf, errp)) {
         return -1;
     }
@@ -67,6 +69,9 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         n->features.vwc = 0x1;
     }
 
+    lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    ns->id_ns.lbaf[lba_index].ds = 31 - clz32(n->conf.logical_block_size);
+
     return 0;
 }
 
-- 
2.21.0


