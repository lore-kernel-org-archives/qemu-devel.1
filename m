Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B0C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CC120801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CC120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48641 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MbY-0001IQ-NQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MQ2-0003sz-K3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MQ1-0005jH-JH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:26 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPp-0005N6-QG; Wed, 19 Feb 2020 05:17:14 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6LMN-1jWvt50T6H-016gGs; Wed, 19 Feb 2020 11:16:50 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] hw/nios2:fix leak of fdevice tree blob
Date: Wed, 19 Feb 2020 11:16:11 +0100
Message-Id: <20200219101612.1033925-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V4NW0Cfty6gcVkThdoEhaGL1nZCXMiXRMOUudoULVW+euwTxQSJ
 70VGnLGFEyow/yWgzGydQoK4mih2hDHqrxAVPDO5/Et85fzhS9p317woqhGdjIu9hpJij/d
 roY8bpX11SuJ+zVFK0MXuNwkMk7A74iF1zZfJpGqInesuu1yF0+QrptL8FD5cZ89D+123LT
 U7v1SaAMYxD6auoNpuz9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qo6RIilQvSI=:MR/4+Kac0ZOkyA9zF0wV3N
 JtCAMYarL6x7pbPFkge74S9pezob3grjmKKLq5Oab59NErOnrDVC9ybRI8K2MBDT4qNECzTGS
 NGHiigfzKACRBWzzGnH0Lq9UG2Q8bRvUi/RrbxHYD7/Kfidu2Y5EPmy1p8UCOcNsceDz64Ytu
 LXbNoDSGyS9o7K0WdZfFIyNCBung3TYObfjszEkDmTS46bkU//YY78YCSEJjE84fbZw9lb7jI
 Zv8oUtDC052XioqJ0MvvtW5g0NL7YuKk9tdI+VyT426UG6r/Gb0fvqQH5/j5pp8gIXpwiOs03
 QVsGNLc7x8PJJSflv/z8DXNMgIosVRKHQhHbe+uhRE8JQ5TzKHN7DE8sq/8E67XSeLM9VyZ/g
 JfaXsRY4UiUwBN3y1RHOkQsPmL5xAwWEnJHOikl/Ns/1WX5PwiqZ3y+////uob3U1Q/BrasjM
 x7hfD6OiK+g5HEGEBGpgl6fu9CSZvtdRsIv7NKNfkPEyHI5oLvrcgyR92WweK67TfH41189i7
 fTIJGF8srSzi05o0Fl/XMaQThZ6ILFD7DxbQRSjK7CZA0/vwAUkhAeZV/dPmDsDELcqPwNrB9
 Hij57OdqbUlcIBoLKfXIVD20PBAtgbXDWqxsrvqnA+Xi7SbxugzL6/lDQ50VazYvTuQzcBZMg
 JTzGQKMLI+2kZQra+tFQz8JVDPJ+EQD16Gtlo1/+Gi7QC2dSCp6ZgV9pVWLgjjR4FReOAd/T4
 7LEvW5AeFYfYC/6De/OdJOpaa3Xra15hOfL1niubUG+qqtUhyl1usxecLls7237KCp+KpQSrF
 lhC1kwqKcGkLLjPU1Mgu/yLsm5PwpfOWFsJ895pLUMJxcheNTVWIrVi6a2oEn7dnyU35XEO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Chen Qun <kuhn.chenqun@huawei.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

The device tree blob returned by load_device_tree is malloced.
We should free it after cpu_physical_memory_write().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200218091154.21696-2-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/nios2/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 46b834987691..88224aa84c8b 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -109,6 +109,7 @@ static int nios2_load_dtb(struct nios2_boot_info bi, const uint32_t ramsize,
     }
 
     cpu_physical_memory_write(bi.fdt, fdt, fdt_size);
+    g_free(fdt);
     return fdt_size;
 }
 
-- 
2.24.1


