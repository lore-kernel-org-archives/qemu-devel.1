Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5620BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A06B206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A06B206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVddf-0006az-5f
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW3-0001WZ-8J; Mon, 04 May 2020 12:00:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW1-0005uk-R5; Mon, 04 May 2020 12:00:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRTAj-1jkG7J29ob-00NR8k; Mon, 04 May 2020 18:00:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/19] hw/gpio/aspeed_gpio: Remove dead assignment
Date: Mon,  4 May 2020 17:59:54 +0200
Message-Id: <20200504155956.380695-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hBrsijXPJ2Ho2iRXx3sz00wduvdEf20MNyVGGEbhdMg0T31HWrF
 BF5475bsyyioCHPf1bOgcCPdzjyfsrbwqg6YyTSiV6m3i0LKmwZOLRp1J07PlFVhHLAoNHl
 zWyVEwZmYxxcFGzEs1Y5Lg3Xn+EtEBWuFgmJ/erRm9Gxhf0Xv6YeExvyXbvhPz4OP2MwTfQ
 H1dcbBh9+pWwUf+v8ZgJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMt7dqAidCo=:fbuwDLr0XNpjrCpzvu35Yc
 Q0b4YtHPORcIIvGfcQE5zmzdppzrzIhyb7fjMzEfDcWC26RvtYWJy9yH7f9UhTvLSNuPVdeYh
 pV2uTNd9CvZi1qimzGVaSOcu/EwgGZxcI1C4c6SXiIfLZeZjc4l4GvLZqRLYPbmTzgR5iED3s
 X25YMEfEHymiOHaiNQ5TpnMjpsglmcvMefU6F2/56/2sHej4wFpVaNX+yKO9lyVyS+ok27fwC
 9xAAKR6q8Of3g2uEwR/QTNYTB44/+hJr5ppDiH0iF1hNcUUeiWUA2RWVTfypWJioDjTF1Wx3U
 o1fVIZk5jBeMeTg9TldLD2WB3O8ZN02+7m1K4Cxw+WAa6ojwnUV1B8aJnTCpZvRmjAf622GIi
 RK/U/2BLCoLvobYPAEBfMfvYSS1OI2OKWrJFduG4SjNs9Y2VAN9Ey1z8gyOvlZkYBBsR7kIlv
 eS9rT2nUBt5df5cGdxleJCEu0tXvXyKKcc/IWX+x62kv201y3TAYVwTCcBbf5IFanHxnjtet1
 EFf+rse16VcelbzImkcUZtt5xj7AcBhQQUu8H4YHIMfsN2duBkyZpL1RCgjVILVKoOjU6r2ss
 +PxjqwlpFsfeAOkjCS7Q3z68CyD6LTOAy6swYqX3LXqxyA2xLZH+LSyxaks/xO+rsVzDfr94h
 RgWf6kqeO7ZsYpXReW4K54LSd6fD994iqKa6jEBNNoup5m9LpJWzVX+yHP3bQFrVFZgSwRtak
 XFRWiSlZeEexAPsZU//Ym3Sn+KHSFmvNyw7UDtou8y13bhcVszYS82jM8pRABTWOifazklu4x
 rlptXC2kBcbBK/ipZDpJCKn5JEwhQmQtn2QTC+wM0gZyGcPkEXdpscHvQrE7rq8JT4xc+sJ
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:20
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

  hw/gpio/aspeed_gpio.c:717:18: warning: Value stored to 'g_idx' during its initialization is never read
      int set_idx, g_idx = *group_idx;
                   ^~~~~   ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/gpio/aspeed_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index e52fcfd9a030..4c75b5c80cc9 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -712,7 +712,7 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
 static int get_set_idx(AspeedGPIOState *s, const char *group, int *group_idx)
 {
     AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
-    int set_idx, g_idx = *group_idx;
+    int set_idx, g_idx;
 
     for (set_idx = 0; set_idx < agc->nr_gpio_sets; set_idx++) {
         const GPIOSetProperties *set_props = &agc->props[set_idx];
-- 
2.26.2


