Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6AFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DE52064A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DE52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kvM-0002zo-TW
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knl-0006Gt-TG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knk-0003PB-JS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51760 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j8knk-0003Mp-6A; Mon, 02 Mar 2020 08:08:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 374647BF6694896F34FF;
 Mon,  2 Mar 2020 21:07:58 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 21:07:50 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v3 09/12] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
Date: Mon, 2 Mar 2020 21:07:12 +0800
Message-ID: <20200302130715.29440-11-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, Francisco
 Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never r=
ead
            dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR=
_WORD3,
            ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
Cc: Alistair Francis <alistair@alistair23.me>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

v1->v2: move the 'dst_type' declaration.(Base on Philippe's suggestion).
---
 hw/dma/xlnx-zdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 8fb83f5b07..eeacad59ce 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -373,7 +373,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, b=
ool type,
 static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
 {
     uint32_t dst_size, dlen;
-    bool dst_intr, dst_type;
+    bool dst_intr;
     unsigned int ptype =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POIN=
T_TYPE);
     unsigned int rw_mode =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, MO=
DE);
     unsigned int burst_type =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_DATA_A=
TTR,
@@ -387,17 +387,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *bu=
f, uint32_t len)
     while (len) {
         dst_size =3D FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WO=
RD2,
                               SIZE);
-        dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WO=
RD3,
-                              TYPE);
         if (dst_size =3D=3D 0 && ptype =3D=3D PT_MEM) {
             uint64_t next;
+            bool dst_type =3D FIELD_EX32(s->dsc_dst.words[3],
+                                       ZDMA_CH_DST_DSCR_WORD3,
+                                       TYPE);
+
             next =3D zdma_update_descr_addr(s, dst_type,
                                           R_ZDMA_CH_DST_CUR_DSCR_LSB);
             zdma_load_descriptor(s, next, &s->dsc_dst);
             dst_size =3D FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSC=
R_WORD2,
                                   SIZE);
-            dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSC=
R_WORD3,
-                                  TYPE);
         }
=20
         /* Match what hardware does by ignoring the dst_size and only us=
ing
--=20
2.23.0



