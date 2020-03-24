Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A2C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2647F207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2647F207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGerK-0006eg-6o
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 04:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGeq8-0005DW-UR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGeq7-0004X3-Q6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:23:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3211 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGeq7-0004S9-Bg; Tue, 24 Mar 2020 04:23:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BEC028E7C208AB8015FF;
 Tue, 24 Mar 2020 16:23:05 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 16:22:58 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant statement in
 exynos4210_mct_write()
Date: Tue, 24 Mar 2020 16:22:35 +0800
Message-ID: <20200324082235.27980-4-kuhn.chenqun@huawei.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, laurent@vivier.eu,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 944120aea5..570cf7075b 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
=20
     case L0_TCNTB: case L1_TCNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
=20
         /*
          * TCNTB is updated to internal register only after CNT expired.
@@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
=20
     case L0_ICNTB: case L1_ICNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
=20
         s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_ICNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] =3D value &
@@ -1438,8 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
=20
     case L0_FRCNTB: case L1_FRCNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
-
         DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
=20
         s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_FRCCNTB_WRITE;
--=20
2.23.0



