Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2135C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F03C206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F03C206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Dn-0004fC-9D
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zW-0005zg-KR; Tue, 01 Sep 2020 10:10:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zU-0003z9-MP; Tue, 01 Sep 2020 10:10:30 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXY2Z-1k55ZD1aOd-00Z03W; Tue, 01 Sep 2020 16:10:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 34/44] hw/arm/omap1:Remove redundant statement in
 omap_clkdsp_read()
Date: Tue,  1 Sep 2020 16:09:44 +0200
Message-Id: <20200901140954.889743-35-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MRDOMqanYQOUngXE/hWOxXm+U7mswvnyvT8rtz9CyUxC1N2ozry
 KfjHahMaJgHAyX5J6SrY5ItcL0K9bDEBJRN4fwbwGav5t0/TJxkb0k25YxFX7rtOSWI6m/9
 PkgiZ9Up9AKkJWG/xd0yR31MHsEMR3pXZ+L4rTaN0ElPJHhYI2IRIP6IlrZRr/mEK8A9XFj
 ibTiV8CUvO+CzegyGQdHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fLx71k1tseU=:p6PnZOAwUO/dqWc5UmRyxV
 TBo7N6Oq5VAOUDLFslM4001DNVLaATdWZmcdizFTWhBQdaUfN4H2ZWWEzDJ3GhjD0ku2y41Gk
 9JjEnXUJ3hzGdz5Jkw+1SpNKSRFQ9uDD4A+wMmCtdZ4XjmEXvlQFHWH52w7Mqk35DyCrcWXlD
 dDBJYjd1HLLTcgqRZa7spswoXkaYHZGeEkbwkweKTwtMX/7fLUi4ZPCn2sOXnDP1IUpRXN7sg
 E67z8J0liIeKAiy+8H7f/a1wzl26hxBkypNqP6pXm1nCx5n3yU1GHmy7nkOcZzi7YJ5Nl/B6l
 LgpR1tSE+/pgmarhTrUVI+KJ/UX3sgduNjBJHmIot2Rq7JwaR20cl3kRlFz1y0/M1GhoGm/fE
 DIKEvUrLKDZpszFchyaRXCWmY2VfQ6Jr0c5b5FRlb7tSVOFzTAzqloYZe5pvzvIh26+WxFfDW
 9EmWOF+D6fgwsvqAJIHnroIyUK4roCcb4gZxIZb4vNZfWPH7TJYUaZ9wHBdNjs5y5eQv1CTAa
 /tEEhlaj0auWxXSevkgblIhdswwJps92QxEFg2zmmcV/sz1X253e1ZIZ3tm5jzdnhBre5vivF
 7d1yt0UHH2QVNivbD55CpOtnP2cuYqQd60mlkwA6F7Ibh8q2VwrUjixdJdQjIHKFQMS1F0LcX
 blJlnl79uDEFSpf8+SczWrx6+cH9bgTvO62QvZRz7xL2glE5U1DYqoTYhS5UhaNMbLJKdubzI
 oA44A+aN3Dxgh0/pUiGlXmhcQdBs6PPx7fh+K80y35dWa4/GjuQ6qZkN7G1Fx+f7kZ+lRr/v4
 4C6hcOPqMJBoJo8POaU9C+YR3jnZCRYkKkkHRPyhhbYSp2PNWTh9jNoAUNd8qWD9T38eIqY
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/arm/omap1.c:1760:15: warning: Value stored to 'cpu' during its
initialization is never read
    CPUState *cpu = CPU(s->cpu);
              ^~~   ~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200827110311.164316-3-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/arm/omap1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 6ba0df6b6d09..02c0f66431b9 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1774,7 +1774,6 @@ static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
         return s->clkm.dsp_rstct2;
 
     case 0x18:	/* DSP_SYSST */
-        cpu = CPU(s->cpu);
         return (s->clkm.clocking_scheme << 11) | s->clkm.cold_start |
                 (cpu->halted << 6);      /* Quite useless... */
     }
-- 
2.26.2


