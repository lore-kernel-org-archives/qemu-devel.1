Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841CEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58083206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58083206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdYb-0004WT-AP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVt-0001JK-QA; Mon, 04 May 2020 12:00:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVr-0005kl-9y; Mon, 04 May 2020 12:00:13 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MT9zD-1jiaRc24h5-00UWYS; Mon, 04 May 2020 17:59:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/19] scsi/esp-pci: add g_assert() for fix clang analyzer
 warning in esp_pci_io_write()
Date: Mon,  4 May 2020 17:59:38 +0200
Message-Id: <20200504155956.380695-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hlY/jz48hSKyGJeykHcVLtxPX1ei8qGh18vdGZtCqwgAEJ2Pi/m
 LHSYGUh+QXbyIWCt1lmMWS16QL2SaDyCyh3gllwlndkJct+A7Wxc8jgdrlXoqp5k2iGRAzB
 jNm39927q9U/u/EGg/p/VKm0PlMmFuLHflkhnnWaXSPaSRizkO2bmDcM/T1aL9pMXSd8g0U
 FpMytWLT/anA8Js5niAMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DToFnN6RxIs=:V6FXeoRq2XH7OH/k9Pg3Mu
 zNvT1XFJGyp7YtVDbGhzFx+FnJFGCFwAF6EG6APfhbcZnvNqfVfLbk0OPTXaEuzBvb14wrrRx
 F+XAjNwZQtvgJN2sPURooMFLwvsL9DNaB+fDVVLfrYLu1RlEENP1Gx/exhFBJyCCaxM6Udz76
 F3AzU1xGHnjmwgmrO/yJzS2dHz93wEDFXl6uAB0HmPpR18EUZ6Hkv+9DGUG/DznVbbMjaA6Qw
 aDEr/9fXQS1oxVzy7JbaqKVWFBDJCd5JWMRvUKeEL/eGCy0jbWEkhuryNXdyMvvGftsP1vy4Q
 O9814yQPbd2t3ZZsP19iX3PxYhyZzJFMfsPcwS2caq3HdHDJF9LwEoPqrzNRDbN/dEtHJeD4F
 lFaTihFCzldivtGstN8bJyE/0DiFRTbvnwAOqW/aD1eUpdk8v41vJqUW/+QZ/+J3jadp84/Ri
 osglQAd+KoAI9J8hZHuZV8w9VNXMnhXNevFlrDj/76Ce/QnYSKV8h2UEhSKZokF/NCMp/f8S2
 /AwGrFrp+A1Cyp1oU73cfcEHSqJ4l3mP1aF3GM6skadRAHrMmC1IVxXRFXSUjjT68TcoRAhtb
 LRu6L+3oobHR+M35N9fDnmTAC+Z6ZLP/yEWsdUDb808CIVIER4PB42TOEb4uRvN+il2YZ/11q
 B0gPc32aTuCT/k1kdlAEea3YU+6mf9QBlfLMopEiu5klZx5brRfC9mngoep4FOnWVTejwQVOO
 6Vgwg24JEOj1Bxdiw63n2oBaUdTn8IfC45IIIx0bjjSS9W++dDGNU6nE76caDRFZGzNyJ79xF
 HpodzSlMRzYYUZqLEsKbB1qKGeR2ibMgBNdSzzKkkpofEf29m+2wSX0uFzcv8NO/N2vvRms
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:07
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
  hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
        size = 4;
        ^      ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200325025919.21316-2-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/esp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e01748..497a8d590190 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -197,6 +197,7 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         addr &= ~3;
         size = 4;
     }
+    g_assert(size >= 4);
 
     if (addr < 0x40) {
         /* SCSI core reg */
-- 
2.26.2


