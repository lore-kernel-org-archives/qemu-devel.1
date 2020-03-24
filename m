Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573BFC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8B0207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B0207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGeu2-000160-At
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 04:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGeq8-0005DL-Ri
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGeq7-0004Wr-MR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:23:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3210 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGeq7-0004S5-9N; Tue, 24 Mar 2020 04:23:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B57C214C98A19D3E52B3;
 Tue, 24 Mar 2020 16:23:05 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 16:22:56 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v4 1/3] scsi/esp-pci: Remove redundant statement in
 esp_pci_io_write()
Date: Tue, 24 Mar 2020 16:22:33 +0800
Message-ID: <20200324082235.27980-2-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
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
Cc: zhang.zhanghailiang@huawei.com, laurent@vivier.eu,
 Paolo Bonzini <pbonzini@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
  hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
        size =3D 4;
        ^      ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc:Fam Zheng <fam@euphon.net>
v1->v2:
keep ' size =3D 4'  and  add 'g_assert(size >=3D 4)' after if() statement=
.
(Base on Laurent's comments)
---
 hw/scsi/esp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e017..497a8d5901 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -197,6 +197,7 @@ static void esp_pci_io_write(void *opaque, hwaddr add=
r,
         addr &=3D ~3;
         size =3D 4;
     }
+    g_assert(size >=3D 4);
=20
     if (addr < 0x40) {
         /* SCSI core reg */
--=20
2.23.0



