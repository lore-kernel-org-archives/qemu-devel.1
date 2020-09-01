Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD7C2BC0E
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3040C21532
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3040C21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Os-0002Kg-Bo
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zc-0006Io-SX; Tue, 01 Sep 2020 10:10:36 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zb-00041Z-4s; Tue, 01 Sep 2020 10:10:36 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLR5f-1jvASv0q1r-00IY4E; Tue, 01 Sep 2020 16:10:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 42/44] hw/display/vga:Remove redundant statement in
 vga_draw_graphic()
Date: Tue,  1 Sep 2020 16:09:52 +0200
Message-Id: <20200901140954.889743-43-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CpWqSw0iYOifLykI8qXVEfPyPNaZdTJdWWVn3nfPRIrxI8nS2Lu
 6AUIIcS9f7U6xRKXU7NLJ8nKrAGS4DDnXYpNMWJuiz2/RcrCicgMvkd84a8sARxVaD5TbFz
 zyr3/5T0hDNwlvd+CVDAL0pH7Oab+D/ZOV3YZm0RnTNbOV2So9LN3tvMe9Q5tuDtRIOLSuj
 I2xuOAGwHRZ3K9bhfm5eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10m+KQOEWnQ=:Ts4yNXi6sW2f9VcwdVRYMQ
 v12G155yBP1mBRMEU+gMd3rjnbTqpDPPj9RFquSpG1v1SFnitt0BCH35AYDBkeB3Ge24lhVpb
 O/NnAdgq/FWZClHAVSKf1Vt7BoPgvMigR4qTI0RaUPBqyBmvIFMwCxncEpqvEDRnQoH0VoBgE
 EBJsyYFxIzQ50EnkhRY4gPMYl9hNur6O0R2MdcP2Lg9M/RK37wreXbpeqE85UZxyLoqvVFag2
 BluMxlQQr8hdiMs/f9sCgajIVqxllPWnJaoCYk56ooohs6lxrTMub6PQJ5CGy0yrXvnlBh9Jm
 yy41a7gAuerwgVsGenZrXxQFqR5LXGqCe10RSxiCxO1aNzZ+Z1mSlwbTSH+lATSbU7kJoLPg2
 neIRKDhkiG6VlAPNaGvcscI09anYsdVNOGMlNWlkAFLd2u7KsJWoiUHlUJGNTGkP5HJo/Yda1
 G8UKpMZC5V5sZWr3IOYIfDZQsEJOMH1J7dNOcGa+ITadk7AGlqKAwc3TVDvp1QOSb9psYdmLr
 2zLcrReZmDyERy6WNXGV9lsjF651Dl2ULlOna2D04iXku8ogUkOG5ixU6ej9+25hDDOU5Jkbm
 tMA6edB2BHFpR/wsVsFQ44WHLz9m5E4FVgBE4GvAj+otFr8eZLgOi+OVOUno1/06Tb/F9xjHd
 KMB5xUn/g5oOJHyIZ5W2H+Gjr5evjjbEt/TX3rnloZ6xJJ6SpQ8Xtc7UIgs0p8ARqI8wQeMT6
 QHtj85dwwrxhOdFEk5WV7kBwej8WWmXKY+IjwTXwxFQxCPX/UudsSNHbfaeyQJqlK2SkW4hwt
 1+QRaTkxak9NoLUCZLSA7NMkP94ztS4131jgRWw6kp6fYGWkQxT7mi7U1AwJAuXcpa3CJVn
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/display/vga.c:1677:9: warning: Value stored to 'update' is never read
        update = full_update;
        ^        ~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200827110311.164316-11-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/vga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 061fd9ab8f6c..836ad50c7b6d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1674,7 +1674,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (!(s->cr[VGA_CRTC_MODE] & 2)) {
             addr = (addr & ~0x8000) | ((y1 & 2) << 14);
         }
-        update = full_update;
         page0 = addr & s->vbe_size_mask;
         page1 = (addr + bwidth - 1) & s->vbe_size_mask;
         if (full_update) {
-- 
2.26.2


