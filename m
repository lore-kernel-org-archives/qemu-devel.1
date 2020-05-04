Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BB0206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB0206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdkJ-00020X-NE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWA-0001Z8-89; Mon, 04 May 2020 12:00:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW2-0005uo-4r; Mon, 04 May 2020 12:00:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzydy-1jBTXE2WIA-00x2jx; Mon, 04 May 2020 18:00:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/19] hw/input/adb-kbd: Remove dead assignment
Date: Mon,  4 May 2020 17:59:51 +0200
Message-Id: <20200504155956.380695-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pP2iFbrOwoCpjoZYcWB3oBDpYLt6NWP4+aZCPwxjbAxZq1NP7vT
 cP4L6qVJLBhsmINheshkGRXS+F4MzzZBKKZc18YI+4Oq5i8AzUeDs7Pg0cQRcpHOmQ4V7A2
 Gy6KcE+H144TPF1CPuFhbGGvBm2je2fzRBYYjNE08VCFC5rvCmUbCbWryfBLbEukjFUkcXK
 BK13xnR7ESjMXkVwH0rEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uu7VC6fA5c4=:Kx4jAe/Bslcq3RWJoegR7A
 pkq1FlvFj1fMWyRFZJwvH1KCfybx+H6yA/Sf5sD6Uldoe8o0nv9AuNHqvYNox97PSaOvN3Ldm
 TXPO1ZY2yq9Ej2mcegb1y3nlJkxwZurSQF2+v8mgmvMam2o90mDPIdGinVkQQwP0WNb9J2Hp3
 TkzC1nf+JPOX0GyxSvTVQGyRKZoXlsGUH7Aj28dv0IX2CBr0AqHk7JFMoVqx9BJNcS+6RowGv
 bSDHerG2BVm2emdaAUZEQr2mVbteTzqqcTNd/39tRyHdjDn/II89366QW/bDl1IIrbuXhcZfi
 u1DNI1TJAgbZ7z5N898AUIgLsA6INqphZGkYMlX0nxo+MZ0SPO484gG/yvd+3YkAk8eRtnPvP
 CyeMyKDXsxE8taBRvpQcAcW04L9W8XsjkdaYtyawfWXqvYZxuhQZmHZp+00FpUDRI7viKMt/0
 AnWtXoOAMwHoUnjLClGBhXeo1ltBo5wfmJizxKpO0my4Oibsqh0fo4+AW1CmkhTpbrHxI2iM8
 +vWa3o0BQwrc1mqPJqIHDNN0UhiAk3OYMU5kUoYbmDMmDazAVvURmUZA9HTh1Pj5OnQftToOm
 R0NeUs4m2aI6kf6jivUhAyuUHG5HQf+nbRJ4wZOoKFQRe7qHA0Nan2YkDSQ5jTwtn9BnZnyis
 fwYmZmDlLNH71dwN+XC33vQMeQgUE0PqMRKRKTiEm+qelTvJdKSSRnYmjKIvH6JG9RmBzJW4o
 6WY5wdYuezClJzeyBhGb/1D/Tho4rZx317ixn/4TUuMGsBkfwXTnFqMp5Dqb3ELpJ6ks8Fy28
 NiPaji83ueETH6nGulc5IC26XLmvIVLsZwRIv2in7tmKNQT9tZqTLE8UaCBOP4O5X93RFWw
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5a1f49718 the 'olen' variable is not really
used. Remove it to fix a warning reported by Clang static
code analyzer:

    CC      hw/input/adb-kbd.o
  hw/input/adb-kbd.c:200:5: warning: Value stored to 'olen' is never read
      olen = 0;
      ^      ~

Fixes: 5a1f49718 (adb: add support for QKeyCode)
Reported-by: Clang Static Analyzer
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-5-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/input/adb-kbd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 0ba82075897f..a6d5c9b7c9ac 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -195,9 +195,7 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
 {
     KBDState *s = ADB_KEYBOARD(d);
     int keycode;
-    int olen;
 
-    olen = 0;
     if (s->count == 0) {
         return 0;
     }
@@ -216,7 +214,6 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
     if (keycode == 0x7f) {
         obuf[0] = 0x7f;
         obuf[1] = 0x7f;
-        olen = 2;
     } else {
         obuf[0] = keycode;
         /* NOTE: the power key key-up is the two byte sequence 0xff 0xff;
@@ -224,10 +221,9 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
          * byte, but choose not to bother.
          */
         obuf[1] = 0xff;
-        olen = 2;
     }
 
-    return olen;
+    return 2;
 }
 
 static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
-- 
2.26.2


