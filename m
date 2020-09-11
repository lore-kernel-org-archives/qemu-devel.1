Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240CCC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF892214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF892214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGotk-0004fy-Lx
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo2-00031w-Tq; Fri, 11 Sep 2020 15:33:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo0-0000qZ-TW; Fri, 11 Sep 2020 15:33:58 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMY9X-1jzQoC2fFH-00JYvd; Fri, 11 Sep 2020 21:33:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] hw/arm/pxa2xx: Add missing fallthrough comment
Date: Fri, 11 Sep 2020 21:33:27 +0200
Message-Id: <20200911193330.1148942-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MFlSvULitaydFXZ1z6AuKK+Pklr0g/yjNEpPSc4suR87LECVFeI
 atTidlOQpKNbzZMiqsOsO5tFr1sFUQczA4QS7xKwGwYId64+JP3Ch0QfBdYXpVrNA+Ri3gp
 xXOs3Sx8Z8p3o/PzGcGfXnqazut3fQzJ4zYB0JT8Hl9gYjT3y/v3KOi4TglaUeLxRSGZtmP
 NEH/35ysKQgk52O/KnCkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NmYKcVDTjTA=:PpYvzJSdhmoF2gdezkJ8bD
 Ao9ZYhxovp4/4D3VW868TC+3L24gnsdwQ9pgHfiVDL5+fu77wouifgRkYUAVMscXHtxkC4oZy
 MmPP/ut4cEOWa5tQSIj9z1Ntxda9X75R1Gt2J1POznyG/C/LVLE7+8G5Os/pBxuoGlBRZifKM
 cYy0NUK0710tf+tGUR5t5FkYIIEr2AL0KhSvSYNlJeGv/yiq4o4aMWKdBalHbdmSmqzagFVFm
 sNKav4oQsilAkBtwX4gDOirv6HzHTIUCcOZhzCqpR716tAFrduVkyR6fDqlh1an14TzmjCkGM
 gp0deSCPYyv8EyToSF5GkofcBufUx3p2OTDcCEsAA3nq49NvofL8p5svwp6M9O/t5Vk+Hxip8
 FNzYfUrmjnTqQw9P6kyBfDitFMK0PB4QyP0oGhfKANdYFWYcNJVZp3/r1kxGa53fPNFg89BOt
 KyuKuJMxuziuXaKJB+97X8Wgzo/mVMHkeyKNlHDiQUFYpxc2aN5hg8oUpWmPFaKnjq69rzrN5
 kA0eZ7SZ+knX3nIo5g3RhNfZIrj5hGaDcCX4Yym6VGRSe7GD06z7LDPcVxdCB8rUQW0kok5yM
 w/JnTpWy/tEggdupV+arbY3rR6JqIiO122br2SiBO2lotQAUzBqGigozUi8eE4i+3gbdNP6Yu
 f070XiHEKePdoW4bNf7erMUBrsrfJUQnDkMoZ2zPoy2wWazOfNZOumf/Cy+trC+CrD4iYPzLi
 +o7I3pFi+9XmRjihiBun0vqKXf4N6TfV3nsekw7l8ZZvdgyvew2+xMmaCT5N642fgLakUdQPC
 rCQu1L9+f04vNpYNgC4ZzvxQJGiETctKoKsgTWo9A9IWtpO42bHIXCn88z/+p+9I7u5Gu9J
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Let's make this file compilable with -Werror=implicit-fallthrough :
Looking at the code, it seems like the fallthrough is intended here,
so we should add the corresponding "/* fallthrough */" comment here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200911121844.404434-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/arm/pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 76975d17a461..c1f45b2adfa0 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -443,7 +443,7 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
             s->mm_regs[addr >> 2] = value;
             break;
         }
-
+        /* fallthrough */
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
-- 
2.26.2


