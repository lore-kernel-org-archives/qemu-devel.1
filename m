Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE63C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83E121548
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h+1LlDRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83E121548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaKC-0005Pz-2P
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGs-00086Z-PL; Sun, 13 Sep 2020 18:14:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGp-00019x-Vq; Sun, 13 Sep 2020 18:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035291; x=1631571291;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U0YF82MA56tPKneosTj7Mr55BcKBrlkeEjxyv7jPa74=;
 b=h+1LlDRcR6U2RV8FZ5rtDRxw1sHMbS4yIfTy/LuZJpWkfv9g/3ep45cc
 7wp0mFnrr3gxT1izn4fT3+Ok+EbtJXvW3VfnerFbEt4c8bMU6RZNYAYmv
 8gtMxRi0REZHddlZOsgxP8nt8VMnp5w4rH2+sxyfV51tAWgkO2zvHWMa6
 uzr0I+/sjja3MH+6Ihe26nNv3owcvx5kn5mjNGHhEa8jCpnDvB8ZBw/mJ
 I1w9lA0Q6521xkjRYcPEksor5tfR/E+D8rfom56sB8Rg1e2HAQDvOUuxn
 GLBfx8USPHhN+sGvzACqXT4MJhh78ck81Dp4qZ1RqfAO+1e1U2Rg/v9Ks A==;
IronPort-SDR: k+VSASc6E2Dsz/gbEqq9H7a4UwKUuIZA9kgxV1gZaYweK4wfAHbyl/qDiqKkQ4UVXbe8GTcgF9
 mHBnyeyM8IejyKWdETyxzRWWQpKP9zNmtklxj2MnTvdJ7olpAn9fpPcd7wVRCIJlLLeDt0xBT8
 s3rSFmsWLcUO/j5J4iymUViLrlGggu9x/qcXSVZoK9J/oesLLpQSBKELFGF2hhWJPCwxSJA/T6
 duiECT0oSdnKem/pRvUAyFCJ7n3doaCXl1WIslFeFTfiSbhWi2x2NHnvAMdo2aKxABk3612fCa
 EoE=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179046"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:14:48 +0800
IronPort-SDR: zdJ8C8RWfU9bxDzK2/dNJZjhoh3mXCGk8iKA5L4rpdT8v8fJ1aR1C2G1gGRLQHLrhqV3T07vOi
 Fxz2/DyqasCA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:02:00 -0700
IronPort-SDR: 99h3rAr29vs+Wm45sgbv21tezYOqzPX8ou6ckyu0yTARZauYSIJrkKp0xvdTbFsAoYOkXXeIH8
 bxRxs4Lns6kw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:14:47 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 02/15] hw/block/nvme: Report actual LBA data shift in LBAF
Date: Mon, 14 Sep 2020 07:14:23 +0900
Message-Id: <20200913221436.22844-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
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
 hw/block/nvme.c |  4 +++-
 hw/block/nvme.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3a90d80694..1cfc136042 100644
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
+    id_ns->lbaf[lba_index].ds = nvme_ilog2(n->conf.logical_block_size);
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
 
     /* no thin provisioning */
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 52ba794f2e..190c974b6c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -137,4 +137,15 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
 
+static inline int nvme_ilog2(uint64_t i)
+{
+    int log = -1;
+
+    while (i) {
+        i >>= 1;
+        log++;
+    }
+    return log;
+}
+
 #endif /* HW_NVME_H */
-- 
2.21.0


