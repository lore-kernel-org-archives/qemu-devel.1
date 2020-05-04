Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ED6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED6206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZxI-0005CA-SI
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjt-0003AL-Hx; Mon, 04 May 2020 07:58:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjs-0002JF-0h; Mon, 04 May 2020 07:58:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXpM2-1jdPLr2KgG-00YAEA; Mon, 04 May 2020 13:58:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] hw/gpio/aspeed_gpio: Remove dead assignment
Date: Mon,  4 May 2020 13:57:56 +0200
Message-Id: <20200504115758.283914-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Epmdrbj84mM4+CNaeDulwlmvqtjjjQC/X1eHvYAmsWRk8j3Fn2h
 QijUH4N79c1Jg6lWt19bDhVMvk/Fj3FTs9poJ1QXh3aMQ5r0b8lJIHp3QSTozpdbUciXm25
 VVPTRMxVD1zVS5dEB+qkxiSoTk1022LNoMuTcce8wtvCp2lK6lglv/R0gGm/hwnzHlhWFh3
 CtfAXsijfUc58kuHBdKAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jrJy+udALk0=:xw/Jpa4PCL6qHBVS5+PejC
 ndl36lGw0tPEOdos0jaqJC5FVvwaZXiPbauA+5GOOdTK4DP2DPF4aCcuLhP+SrEiJsQorTTru
 BPCODmZharzbKU/M39ybMnqXQYKDHdOpUNUGhSVV6YROR2pd/Br96I7i3mmCapAfZfVjiaqdQ
 JRqLLUKZhXdyxVnfebn5TiowuUqNmLs45YZJbUt1b6v/JTnsqhhR0dJWx8VGkfpvBeUch8CiL
 w7Ngjt4qKnqN+qIpxhqdftoMSwjOhNf5NaPKoGFSinHY4HcT7yJpH5QuCDMZW1q8VcYhHmzbq
 IIwwMYI081LcnoQUa01yJJusRXpKLnz1H0ng5Azof/+VFXDVckc7zq5G8nC/FaYJRWjjMAAS6
 UN+GLv/k8Oc+rhgH/nk4FxR1SobQXkfhxTTfHKHaChYpW2tCL4OtXnwi4dnzS6oBvOVRUmfp7
 EnYietJzuUPxV/MAyx18YE5DQ/FfNdmvpl8rCZl5ZlOKKe/v92xAzW+F8m+bQ8MXIY4pFV1b/
 t4ooIu4UNCJRq9O/bYS3tC/PbffaJnZELZ1/HsGIPS4Uj/OLl1Bf8reX3O6RS7UUtxjjD5bni
 MBo2Zc8EqACo7VESU3mnfNMUHedisofGZ4JlKjQAgQyAn5zU1VlWGBY2W8JRradDZWde2rnIY
 Ly/qsgQBJpnd/+wn7xHh6gtXgziCmuDlUtcBUocEbZ9ZXFqqYCjJWFfLl5ZY9L/D/Yt5P0pcH
 EjavFRteaS5LJNW/anMoSIvBJMXm2vaLa4MIWAZaP3CV2BtyexkpmWqUZsfiNihemWN5RF089
 n9EzzrTncQwheMoOLr2sDrQnxsDPgWFXev6IolOoSwbTdU+WOa5rewlYNjiNzhkVAPigFR+
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:13
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


