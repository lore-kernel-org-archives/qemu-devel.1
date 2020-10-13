Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AA2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA21820872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SCP0lha7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA21820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSS97-00033R-OF
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS3y-0005X7-9P; Tue, 13 Oct 2020 17:42:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS3v-0001mW-BN; Tue, 13 Oct 2020 17:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602625347; x=1634161347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1HggLFcC+uXBTV/4bp7bcM6T4bLVE6zSM5nuTBrcaa8=;
 b=SCP0lha7OAaVf3uf0M+l7qBblIDr8Mg7n5NqwXBitZdrsGySBytb43V7
 2kg01BZX8pwI1p44LS7XvHF+bVVO/vdUXK6w/8SZ8tMbB4nAjUnUVRmAn
 Er1uUEdnjNBE1ztMd7Y0GeVJdI5roRa9i+gZ8zVa1nauzNeAeCLSCGOB9
 fza47TgcAvWbrEewu0mjf54i/WPVIuwYxQJSlSBmFxavbFn6Hpmbir29w
 KBLymPi55sS3lFDDcXax/NaHiTm2tzedq8+xLnj6j4ChQjdTy4MLdJqCU
 HTd4AeKp1MBDkln8f04FXMqtbrQ8yHVRaZo+iGJcRq0KqLZO21SKuAYKS g==;
IronPort-SDR: sfOsuv29Dpw3O1T3xyDdl3PnEPZNQioRlWZ3LjGr/7bPYGV75JTObNyTvUnMonXPkWLlo/vQj7
 oJPOHPkiMnC/3tBLSpD3bRb8l73ZujJs0LTlx6YTH0FafHsJfLyQQ9o4HbuV9Xra+masklHM98
 efgX8Ec87zMHwomvqfmza+F3F/hvgKiIxIUokdMq9kojHZiTZzq9t+AzL9NwfP4XPzXbjjTJnK
 fyCxbZGzFgUfB4PIzOn+TVmR0MyF59YOh9OZ4w7BdD2K4hp4BapTrpWdtpF+78CI6gmMAHLH/o
 EkI=
X-IronPort-AV: E=Sophos;i="5.77,371,1596470400"; d="scan'208";a="154185924"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 05:42:23 +0800
IronPort-SDR: kDqHx6EC0SKaRJfuEhc2r0opICq5sQum/9tyegJq7sJP6V1j7WxFlmhAX8sq8Z+YaGGfga+ZSe
 LNQFm/MO5RbeA+c8b3E8fNup3pQtLuofRa6qzPgeXJ13rjnvdTOqGvG0HWPoK9Q1rrGejhFi9Y
 BBaU+wSYKOmeXT83xh7dFNgW6HeByKUqrBK0nLurxd9BDy+ZvtU0WBtyyeinYjoF0Vcqknqjac
 smKJoGcOf41y6aYRW/PzOlGtG3QlIufUPmTiFBcrSOToNTW6BD9gqW2M1OxeXGB+Gw/Bqw/1nZ
 5r4rgTyb9LsNP3vAetDpWMaF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 14:28:57 -0700
IronPort-SDR: 5uISiDgT/ilw94GAzgQB8OvORvKVj4Aj+BN0+EixZ5WSqaK2LmWwGbyBgr7qGhyDqrCWvPKQBV
 f9p2j/8oSolXteKBRlvkmJRHvrR1zZuyvq8WDh2mpYYKfuieYa/mLtqMNFB15uqoJUGDjilo7I
 ax3vmkYB4fNd7hJAuDpb5JFyO+2k9MqNM1dhZofITRGie3ZmFs9m9SoECLrVpR4pAROIKT7A/i
 SJUHVMj4pST1OrkVyv0YtKWvqemWnI+hPMp8HI0fzGH3jCAJeN6OIW/msuQxxXBybITHmjVD8/
 VuA=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 14:42:21 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v6 02/11] hw/block/nvme: Generate namespace UUIDs
Date: Wed, 14 Oct 2020 06:42:03 +0900
Message-Id: <20201013214212.2152-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5487bf209=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:42:19
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

In NVMe 1.4, a namespace must report an ID descriptor of UUID type
if it doesn't support EUI64 or NGUID. Add a new namespace property,
"uuid", that provides the user the option to either specify the UUID
explicitly or have a UUID generated automatically every time a
namespace is initialized.

Suggested-by: Klaus Jansen <its@irrelevant.dk>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c | 1 +
 hw/block/nvme-ns.h | 1 +
 hw/block/nvme.c    | 9 +++++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index b69cdaf27e..de735eb9f3 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -129,6 +129,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index ea8c2f785d..a38071884a 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    QemuUUID uuid;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ee0eff98da..89d91926d9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1571,6 +1571,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
@@ -1590,7 +1591,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1599,12 +1601,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     /*
      * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
      * structure, a Namespace UUID (nidt = 0x3) must be reported in the
-     * Namespace Identification Descriptor. Add a very basic Namespace UUID
-     * here.
+     * Namespace Identification Descriptor. Add the namespace UUID here.
      */
     ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
-    stl_be_p(&ns_descrs->uuid.v, nsid);
+    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDT_UUID_LEN);
 
     return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
-- 
2.21.0


