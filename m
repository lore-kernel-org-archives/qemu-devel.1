Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E700C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DC620737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DC620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhnN-0002VS-5K
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOhgV-0007F7-BD
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOhgU-0004Mi-95
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:31 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOhgN-00045z-0c; Wed, 15 Apr 2020 09:02:23 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id CE692BFD25;
 Wed, 15 Apr 2020 13:02:21 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/16] nvme: use constants in identify
Date: Wed, 15 Apr 2020 15:01:48 +0200
Message-Id: <20200415130159.611361-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415130159.611361-1-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/nvme.c      | 8 ++++----
 include/block/nvme.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a2b15a0ebd87..563cccae6795 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -682,7 +682,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
=20
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
 {
-    static const int data_len =3D 4 * KiB;
+    static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
@@ -712,11 +712,11 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd =
*cmd)
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
=20
     switch (le32_to_cpu(c->cns)) {
-    case 0x00:
+    case NVME_ID_CNS_NS:
         return nvme_identify_ns(n, c);
-    case 0x01:
+    case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, c);
-    case 0x02:
+    case NVME_ID_CNS_NS_ACTIVE_LIST:
         return nvme_identify_nslist(n, c);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8fb941c6537c..c2fd01cf2f1d 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -533,6 +533,14 @@ typedef struct NvmePSD {
     uint8_t     resv[16];
 } NvmePSD;
=20
+#define NVME_IDENTIFY_DATA_SIZE 4096
+
+enum {
+    NVME_ID_CNS_NS             =3D 0x0,
+    NVME_ID_CNS_CTRL           =3D 0x1,
+    NVME_ID_CNS_NS_ACTIVE_LIST =3D 0x2,
+};
+
 typedef struct NvmeIdCtrl {
     uint16_t    vid;
     uint16_t    ssvid;
--=20
2.26.0


