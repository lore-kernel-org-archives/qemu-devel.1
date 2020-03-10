Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6145C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC602468D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC602468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBeeR-0000R0-Kv
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBedU-0007rU-AF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBedT-0007bJ-8h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:09:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3195 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBedQ-0007A7-Jp; Tue, 10 Mar 2020 09:09:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8E56AFBD1529C551D146;
 Tue, 10 Mar 2020 21:09:13 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Mar 2020
 21:09:07 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
Date: Tue, 10 Mar 2020 21:08:44 +0800
Message-ID: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are some redundant statements, we can clean them up.
Clang static code analyzer show warning:
hw/scsi/megasas.c:1175:32: warning: Value stored to 'max_ld_disks' during=
 its initialization is never read
    uint32_t num_ld_disks =3D 0, max_ld_disks =3D s->fw_luns;
                               ^~~~~~~~~~~~   ~~~~~~~~~~
hw/scsi/megasas.c:1183:9: warning: Value stored to 'max_ld_disks' is neve=
r read
        max_ld_disks =3D 0;
        ^              ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Hannes Reinecke <hare@suse.com>
Cc: qemu-block@nongnu.org
---
 hw/scsi/megasas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index af18c88b65..3f982e1d3b 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1172,7 +1172,7 @@ static int megasas_dcmd_ld_list_query(MegasasState =
*s, MegasasCmd *cmd)
     uint16_t flags;
     struct mfi_ld_targetid_list info;
     size_t dcmd_size =3D sizeof(info), resid;
-    uint32_t num_ld_disks =3D 0, max_ld_disks =3D s->fw_luns;
+    uint32_t num_ld_disks =3D 0, max_ld_disks;
     BusChild *kid;
=20
     /* mbox0 contains flags */
@@ -1180,7 +1180,6 @@ static int megasas_dcmd_ld_list_query(MegasasState =
*s, MegasasCmd *cmd)
     trace_megasas_dcmd_ld_list_query(cmd->index, flags);
     if (flags !=3D MR_LD_QUERY_TYPE_ALL &&
         flags !=3D MR_LD_QUERY_TYPE_EXPOSED_TO_HOST) {
-        max_ld_disks =3D 0;
     }
=20
     memset(&info, 0, dcmd_size);
--=20
2.23.0



