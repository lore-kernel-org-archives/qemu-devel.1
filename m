Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9371AC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7892073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7892073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZlK-00051o-J3
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZje-0002oU-QJ; Mon, 04 May 2020 07:58:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjd-0001mg-Pa; Mon, 04 May 2020 07:58:10 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUog3-1jekfK0kJF-00Qi79; Mon, 04 May 2020 13:58:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] display/blizzard: use extract16() for fix clang analyzer
 warning in blizzard_draw_line16_32()
Date: Mon,  4 May 2020 13:57:40 +0200
Message-Id: <20200504115758.283914-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:foyPSr7xsSevWh/8RpltGSGoNnpQUkoxfNoJfKzpLy2pDhFRZuw
 9i6AvXlNwaFpIy1fjQxKlCdAVkUL26S6pnRB71Nk2rgbTGocd8DGvBKV7RkCEiE4ECIJIr4
 x4wiNs3C8Qom709dEcQIQzv9kgoVSfbAGAyddGEn4qI0XZq9Hos2fHqxAzwml1FyMiKa54g
 mX/4fC/PsP9hUovG9ACfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IlICTlhBH4Y=:bw3P7mCJcpuQH/5fL1qitb
 gbDpr8+IgvYTMmc8TsQc6EFp04kmgnpCXb7DR1sMti7TNQETDgM6UtY8DhNZTVN04vF5goCjk
 7+Yve4GOo45Q/JdoMvI9YRUBDX+8IFbYeDBuMZLlv9NeXkDUJa7nXundwO1EGt6VaPNVjOzlk
 bEVCIlLHGyoW+X9lrBnk/Q3CBqJJSGHk2mExGX49zrdHxuKd46z5bkJXWuTyLzFviFwrBhb8W
 mKn4wg+wbF06sppNavdLetoiNoMFUl30WxOTHQ93wEJvdqUxPcZsQvsD9i8nUrNN5CSGn2Yf/
 qg+3qt38Amm7KVyN20A1n5Vi5lmIQlJIvmt7qQIXyWEJqbNoMOWWRK2f5GYEgRGCe8IWBTT/g
 VZC7keXet0s/shpKNpwk1toe+SDEH2Rn3982PXxABBNiuKM4aCa8SNzb2yyEnenVXOv/1NlV7
 0s6JCndZ1RsdOteKV+Q5dISgaO0bcU14B9qRwIBxeHSV4YZvCkqYdhmPuo3Nl+gxbif9oFmKl
 3SC80hahz9LL4rr2HnDQfVCtw1YyPqMUa4LTrWI26/IbRYkWlIhc6oFPxtNfUskvANHLgMDED
 HeAyEWBbmUC76VtT2pTGvQ2+0pUMxvtYZqcq9o7KE3gR849WIys+NAcX9Ux/isGPx8A3rGxkW
 G+K6s/8/r0e7wMzT3bv4xOMrSK9O+DbQvbs0qlQCyhXaFvvkKOgimP7xSd1u7xX+M9fqcV6EP
 THPe30z4+g84vuBZZw5GCzwoN0FrLFVoKtc0mFceeFauIvFILApA6yvEF/zb5ck1Wjb0sk0vR
 TPFJL7Py31FxvlqB+pPq6Ya3ehpg2XP1JA24qUzCnXkOudEgU7AB2eeGT0w8c7gQPIP3IOi
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
  hw/display/blizzard.c:940:9: warning: Value stored to 'data' is never read
        data >>= 5;
        ^        ~
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200325025919.21316-3-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/blizzard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 359e399c2a0b..105241577de1 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "ui/console.h"
 #include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
@@ -932,12 +933,9 @@ static void blizzard_draw_line16_32(uint32_t *dest,
     const uint16_t *end = (const void *) src + width;
     while (src < end) {
         data = *src ++;
-        b = (data & 0x1f) << 3;
-        data >>= 5;
-        g = (data & 0x3f) << 2;
-        data >>= 6;
-        r = (data & 0x1f) << 3;
-        data >>= 5;
+        b = extract16(data, 0, 5) << 3;
+        g = extract16(data, 5, 6) << 2;
+        r = extract16(data, 11, 5) << 3;
         *dest++ = rgb_to_pixel32(r, g, b);
     }
 }
-- 
2.26.2


