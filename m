Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FBA206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FBA206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa7F-0008BY-9s
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZk3-0003Lt-Kr; Mon, 04 May 2020 07:58:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZk2-0002Lm-EZ; Mon, 04 May 2020 07:58:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNtjq-1jl4JV2sAa-00OE4o; Mon, 04 May 2020 13:58:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] hw/input/adb-kbd: Remove dead assignment
Date: Mon,  4 May 2020 13:57:53 +0200
Message-Id: <20200504115758.283914-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hsInISMjZejKFc62NlpU9zM5vQXucwUAa8UscLt3PndFE9WJkyK
 ordHkV3voxT9Q7M4Bn28UJTjwBxcLVM6lDP+5eqNoJCwuQvMRwfsuHoBysHciRoajIy3uOn
 x5kTEp4/ESd1daJvO3kX1Lps5whX741dgFhpmprWTQ4TM6P7sFR+SrGI3JeeyjzdLtMz5tm
 Sw4ni9SIoLb1Br2JlMYEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pr5xlVTbTMc=:+GCZhwc2vN6rcl3tyWabAy
 pLi2IWhCnUji0x2fGqrV6I+R0j/5IfmJafRtG9J/Syg5R0b7CfzD/sXYOS2/l1vUCtvmUX8dT
 7se5Nl7cdZNIOmswjwIgOa2Jwv3TD4P/qD2vzbY4vrnh6gvCvP37wQPKmYWee6Z/787pdSaKs
 TXVZg8dbgwyhDjd+koNvXcGK3Pv8gRqjBvyuxQfwuLZfrwldveV3xzjnWgosQOgdZ77cQW7Tr
 ZVFC1KYNIiYU/EAlnneIVrb7yzrl15M/V2UUVyc+TDp3MHc79dssgIEm6w28pxVfYFTifR22q
 Fe5qeQpjeeUOLEMVLrhy2KnzwF/tselF36hnSNqXe0UzbqEQe+MH6v3r9ABwx1BjcJOnWbdqK
 LA8ABb0XMjScPkPqz9thAT1kFAE55i2JB7QPQSOGbdYOb/QVlr9y9uBrBO6hlX/Qwf3eY4dmW
 Ly6aZVMm2Qh9yVATYm97dpxPypDhSE3Z92mkDIk96DQJwoYK3CA5xOxI/NlOlNVjAAnkjfmC2
 uUSzl7U7TJLHZ7hgz6yeMPT1iNCK35BJjfKR0v6FhUSpe/08GsycYdwNVKmyNfIkj4/Rqav84
 zOtmikx/C2cLxiHIue9dsTinIIuNobqUOLitKctsf9akcJ6m6E/oxTgDGbAGA72u1ZkaqGlBX
 3jkNBDfd0R6/DcqmY0D5aaWzPkgNTBsxlsckycdeukVaYdxv8ITFGcEaEGzUaKgY+GPNFEMQ0
 nndhS7swfRirLnLP9bN9CE+DhgufgjZpqvAGpIT5EsGFzxl9sLJbQUfefryyN0nRp0WF1OOqs
 2Ab2AGm+PTwBJ0xf5BiJnszZHoZhut8LKch/KaZS+VmsQ0vlYglFW44b1KSoEl+xEGXYKvt
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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


