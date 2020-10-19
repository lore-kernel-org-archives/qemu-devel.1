Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93221C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C417F222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T23FQopO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C417F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKm4-0001Nb-KU
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKk3-0007yk-2H; Sun, 18 Oct 2020 22:17:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKk0-0004HN-Qs; Sun, 18 Oct 2020 22:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073860; x=1634609860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SMG2Ngfk2iZA+zlHITm2D7Ljs/qojB/EptGd2Tv57Vk=;
 b=T23FQopODkMV2FrdB0cKCl/dUpWzkBnJA6l7z7kQVqVcrjh39ZPKFhyb
 C0Bv35uZCv5y44UD6YpH6HM9HN18ssVOSCW3L+0OahYF9TqCSGKznL2rY
 g6aWK23s28jc/T875j8MBVaKM0nUu7JtRI4LyXh6ogzsq9YBzw83rd3p0
 FJwcQ9lIBqy3PiC0Xo0swHGNaMRRiRHlsPgKhB5ZYxasusGFrgOtoQHil
 H9rW2PDg1uyW/eEKe7GI0t/BHaaaU1OWfGHQUH8WfZN1q5oonkFZFrJyS
 5voV+GJv0jDe45uzyxMh0vQljAJlUAt6UG+V/MgeZHKbTafAS3XNc6Bo1 A==;
IronPort-SDR: Q4jg9hl2b32M4XjpU6F3D23oorXeAfw421It+Md3aYXRje1LYqE+zZgGGevD7MPCMvxFrN8L8Q
 kEFucQ1F+7lc797flUdLSqGBdBkvubUNvk309sPdRsDqHFNnf8qayLtDnDVg39kguRcyxA4R3h
 bWGzx7syk+eAcCyiRgpar7zN2X8Jmv6zapGF7AwOyvoXUkfjtDUQkckSbs8U9z43X/h3BWvdwP
 EUdq6ECZF3cP1JH3lwb9rJ2NiG1vi8WYLJn7/O0i7472lNn4XMNQzek0oYhQQdpOoNuynZNbfO
 TLI=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="150207953"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:17:36 +0800
IronPort-SDR: vJvuw3oZ+dksJGtfGVP72pkxbm+xCWlReSwjfQimDuGz2kPDGF09cAP2kTJb8U9W9A6OVdgbd4
 ITrbXZbENE9qx4f+4zQPKZ+1WYzW7NeY0YM24FpK4lykHMmfqnCcu8X6IMXXhGCIpNTM4/TcZs
 DHcgKs2I767uVFl8QhDScILkpzkcOSLyCp85xrLtUXo7ZKG2WX9kJ+sWSPO4Hw2/zDuatFAqSP
 gyMDJLnmo5wmpFWoVCFasoOyxbajdJHq6xULyeFuxRC4VX1CcbdpA7TKSf3jPbmpkEM9fLtdeK
 jpnezXoJldI5eO1W2WQuAw6V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 19:03:13 -0700
IronPort-SDR: 2nyalcMwhW2hQEqyL+YPE1vJgULz0IcsCV5RvqYQTSYxX2QofLg6WJ3V+dFndtXWDqmWa1NqnK
 +pO+SxwB8QjEdYegEI7UhmVrVrw2de8KrpareQqZ3ZdPN43PkKhW6FuhbubaKvzKXfxUVAEAZT
 Z6j5wrnc51VwmHzm3V3KhNOge2+s4ao6+snXDaiPxTf/SL09DhdZj0Ac85iewJSU9EZ5s7+HGZ
 +616iSO/OByHd1x1iquu/aSh3fCZFK42f54oUbEVj8qbYQGB0ID6Yk5Cjv8K8KvpCyzfjM4+sW
 hE4=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 19:17:35 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v7 02/11] hw/block/nvme: Generate namespace UUIDs
Date: Mon, 19 Oct 2020 11:17:17 +0900
Message-Id: <20201019021726.12048-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5541069a6=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:17:33
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
Reviewed-by: Klaus Jansen <its@irrelevant.dk>
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
index 5a9493d89f..29139d8a17 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1574,6 +1574,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
@@ -1593,7 +1594,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1602,12 +1604,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
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


