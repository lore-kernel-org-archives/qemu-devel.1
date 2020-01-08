Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DA12073A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DA12073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDpq-0000VW-FT
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipDnW-0005xa-RX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipDnV-00023v-KP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:03:06 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:37357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ipDnJ-0001sl-TQ; Wed, 08 Jan 2020 11:02:54 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSswA-1jH9k041Ms-00ULNl; Wed, 08 Jan 2020 17:02:39 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] nbd: fix uninitialized variable warning
Date: Wed,  8 Jan 2020 17:02:31 +0100
Message-Id: <20200108160233.991134-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108160233.991134-1-laurent@vivier.eu>
References: <20200108160233.991134-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/EYbbloMlE/mMInqy/wdNfBC3RP04ti36AzGOyWwDHvqGvzbFHS
 v208escUAmxXixQMpRzprBjxVZjUoGNrRCODviDRVNYwEugYcBQieTDNwHOOD/6ZIIlIaYw
 KA+Be91bIDGmuZ0G/UBFArstWuyyb2NLijwwhX6UPa+txMmfD9lRrMyQY5cjXKCQW9iu26V
 iF8KcNVXo2nNpXAzErDhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOjUjdSmKnQ=:6tycorvo7+rtQ6XdOUOAUt
 H+pbOWqu7gT3UNfWGYuxNfdl6c2ZUoBAoErARBoEQU72X49+mIsnESZ0U7/bB4nvctT/LOOuv
 B3t5mpG7hmAxMXWw4vTM3y9S+kAToNaKwHRW3Az8rnEX7iDQy9ONUCHT5YJVDAC6waMnsoJiG
 NgEqnYDMfGq9IKDtd1Tr3Ga0FVO8FnoSEvb9RYjg2j1WeKHSfLWCCovmONA8pImZB4q0uU7rG
 x5LfCWSBIPmAkAA78x+7NUPWkIgrlE0Vy+PCJIbWNGZuZmzdUsKKa2xUmKFAY0Rj2/EwC7MUZ
 Evb1vtFiJspXYnYPmiXIlcwKT0OlvgS6mVPJyTQKA8FoGjZqDC05AG9xp/TBn24DtgnNx94oZ
 TSHXX8xuZNBrmKP7tqhEz3xc4LLQN5IMHB55125TZZQ+FPCDZfCRhzLZBOVaZgtoAsT5s+VV5
 cE5DSjvWk0sMLo8FtfS79ZVMQaSmRX56H+/YiHN7mgl1mV3RGkuglaPmGr+zq+Y+PTPKbQ8oB
 Usdkw70/6UqQqARMiLbrZMp17tVyuWlA9anI/HDiJUGmvw3Tfg09GpYWANiUsiA7/KYgjDMsd
 mboQq8U4UzTSXSjBtm8ByH8I/WSJjDIjFkGpUsSjhCJnlm386Xg7sq0DIxZt8vgmfa6Xy9cob
 TQV+lDvuhgwu1ntcEmoBcpl7yhzVyjYHM9xc4YQt6SEJHjsxKfHrswa7GPOOejC3egv4pRIR+
 sxnylE6ZOMNmqZFaKxx/yuLmAxZOef///mCsX36rK35jvrZSirGgkh46ckbqXKnF05ACGgGZd
 TLLWSonKCtqnm7JaZ+gBsY2Nse5odRhUAa/ZHlQ9Y7CVjd8/r3b94O9ithaZrZdTBUYqOKy0d
 ZHuvl/3lstAYoyDKpsjA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Fixes:
/mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
/mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
     int ret;

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200108025132.46956-1-pannengyuan@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 nbd/server.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 24ebc1a80571..87fcd2e7bfac 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2384,20 +2384,12 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                                !client->export_meta.bitmap,
                                                NBD_META_ID_BASE_ALLOCATION,
                                                errp);
-                if (ret < 0) {
-                    return ret;
-                }
-            }
-
-            if (client->export_meta.bitmap) {
+            } else {              /* client->export_meta.bitmap */
                 ret = nbd_co_send_bitmap(client, request->handle,
                                          client->exp->export_bitmap,
                                          request->from, request->len,
                                          dont_fragment,
                                          true, NBD_META_ID_DIRTY_BITMAP, errp);
-                if (ret < 0) {
-                    return ret;
-                }
             }
 
             return ret;
-- 
2.24.1


