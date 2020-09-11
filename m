Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0290C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927D822227
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927D822227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGor7-0007yE-JL
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGono-0002bx-9w; Fri, 11 Sep 2020 15:33:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonl-0000nt-Jm; Fri, 11 Sep 2020 15:33:43 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7v18-1kBqz20Pi6-0054S0; Fri, 11 Sep 2020 21:33:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] hw/gpio/omap_gpio: Replace fprintf() by
 qemu_log_mask(GUEST_ERROR)
Date: Fri, 11 Sep 2020 21:33:16 +0200
Message-Id: <20200911193330.1148942-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+7pCVak8FRWtEZ4bdydUkPxwzLeyVjymMOBult1BSAyGuSu3QYq
 05aB4SX+0n2hyqigg1td9JQvZAOC+0MW1PF4G/Fss5A6fT1hrN4sEkV9pUW7Z6QPxnWqoij
 j42AaAWyGpy6ksxuyoJq62B6P9hWiqs++BvtLd0i8ZF+zxiXvNjUJfwK7HffNT1imA/scmS
 ja4KAnOVYLYCECMpvXojA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ewk3hdxN/P4=:DBFEnQnuGS28A4KV3Pw5Tv
 3G14hrvtbFw0lh9PHyDetbrSKGM0g4Bit3R8KyDY3yGlpCqR89KmgVjAeGeL8cq5Rh1R5qBV4
 RZ5elIBdswZBKr6diBIs3vtDtcddQChzHJ8KbWbn+h3z5okHm6rzSpih0bCc7jNBctY278HKL
 orTM16dQ1HbbTQoDSbYfoSNGADAYn11NCIT4w11TGqQfz4AEsT3vtOAAzYzTOkwQvrVlpgnls
 VqoXSaWIkme35qF0Sc3oD75BGUyVQbb3GkZy2hFiTZ/cQro+f/Rm0W15nNVQHK7HAGEJlQSaY
 8OTBHE+kllGe3wcYKZa55TzQ7Y/1Pyw4n0KRBojcwxE3o1J7Ww7BEhGmUqIHWjFyOZ/Xl5fI1
 RTQrhPX69cepVqdnjYvpJq6bFdBm6ysWW2O/9qtBuLcoetbcvBC8rh4mRpUeW42XaucnTg8K5
 tY1mUWds7CEA4Yn842F3cglgb30yIqVPZbdMg3lOKnw29LgSgC2tezIsYcJy+ZBPaIfjomaqw
 uSm+eBTuSocVBH0KVhN4yZHtvtbzhB6mml1yWrpGvtVFZECxaKyfiLH53CrOWjjCxJt1yBNsn
 UNTTBL2fPyfloP6axpaAONjN0n4E/A/1dIjVWjk8NTeoRtFKpDUplU21oKQadLDtSDL2dBV7z
 NMjSWttxwZv9BguIRHOnoO/WBVovWCJEKqTn0J+zYONOnZScyiEf41ugzbSdFGUnHaai7OmVs
 rCJdg87RxmDH8QzDR9Dk51hNQUC+05e7cXSDFHrIJ0ODBVd2VdnrYWwFKxMF7Iho2iqri2ChN
 3GR4HFIxsA64Ypwr76pqL+2hVgUV/UGpLHGYrYH+SgH1vsSlOw3tzFjhMhXeN7/wqR3hsW6
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:34
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace fprintf() by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200901104234.92159-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/gpio/omap_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index f662c4cb9588..e25084b40c95 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -392,8 +392,10 @@ static void omap2_gpio_module_write(void *opaque, hwaddr addr,
         break;
 
     case 0x10:	/* GPIO_SYSCONFIG */
-        if (((value >> 3) & 3) == 3)
-            fprintf(stderr, "%s: bad IDLEMODE value\n", __func__);
+        if (((value >> 3) & 3) == 3) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Illegal IDLEMODE value: 3\n", __func__);
+        }
         if (value & 2)
             omap2_gpio_module_reset(s);
         s->config[0] = value & 0x1d;
-- 
2.26.2


