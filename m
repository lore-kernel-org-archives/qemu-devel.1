Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27687206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27687206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0Yv-0005tG-9q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uq-0007kG-Dh; Wed, 10 Jun 2020 09:10:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56225)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Up-0003cP-3r; Wed, 10 Jun 2020 09:10:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEmAV-1jhdZJ3B8t-00GFv7; Wed, 10 Jun 2020 15:10:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/16] hw/arm/aspeed: Correct DRAM container region size
Date: Wed, 10 Jun 2020 15:10:03 +0200
Message-Id: <20200610131011.1941209-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aoyblYvsxNs/VaIf9aNl95oG04olgSvD6l6khwnqzdMTlTYHqgl
 UEjXCX7l3XJ8HnTryfuiHK4bEvKYLzVnym1o4R3pnSYwxikSQ1ZcsLub42RkWfNCbPVzjw5
 WuzMReXW+1b3qZVeCQAIemzMZDJsrNWVfV6TznKkdYh41E+3Fw92dFf/AtewYlXtDqBriCr
 3Iha14j7AFGtkpaePrgnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ga1Vdo8ob8c=:yfGYd7nSifPd9m5FG0rh8R
 ZvbTK/rLHlBMX6QP+IvJ6BInveyYoGgz2IFmBjkghgXu6sL0dUa5jpSLpVT1c4Nedf74goC6C
 u6WSnY9ia2KDStyJrGX8N7bMa8vJjQJqgKxlLlPji8PgrmCESYrqk9Sk7El4KMX+1vCDaz7lE
 VrHTFS/u6ROjH0MTmR7+ixIaJZmKhSaQiojBpTf1to9CQuKC0CfvPTnrhZf8QWcERtVuRl6UN
 9kwg7mt3W50uiEcrdm+unUtcnsqXFdYgGTDawul7kaRrbr50BzDcWAUUw63rWBzBXL3MGZRp5
 5CM5xdhggoMtRacCcOQOsxAnR6i/oE1dfiZD31yXbjTpSfvvoNGflaWME4N+EZQ+yjop78gZ7
 FB/SFVFT6fsjddZyYNMmB84cU9N7JQCblbWjNPR1xp58pwegXdwCSsHXF3rtLGnowlis5dyzS
 wGvlOFrdLCvn/s6cTc9c/d9RV/VNCUt/f6Wn8NOiAGn9yg0uns8moHZj6bUto/8bSMPhzuAh4
 le8UeDZEt1vKnrNYHvXNgmpeO2zS3VYOC+AOCnv9RA0hrnQHDkezVfJgfWfJqMIeaDnbBtXoO
 58xxAOytoNK6WAyncz0wB/QQ/Ba0w4z1Nmk93/ma9DnzWCTMYvR/hoWbF9NGGCsvzoFN/sDwf
 7T/c/vU3k1avy9tMBBfXZBv42QQZVQHOhoPQAqENHFr7T+TBdMqKpb+RzxeVMk0gU4D9LzqbH
 PdME4exr7IFscO78Ywit/QdbPo24BVfXsxJLyPuHGWKmGaG7uo9353h6UmRvagZrhqeJnHwte
 VNdzCODUyXRGfXFpgnEihUgdEyI9u7zBe+/wDMggHVkLmucYYjWVsyIcQoNZS+0+EyS2rZ6
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value. This is not a problem
for the 32-bit maximum, 4 GiB.
By using the UINT32_MAX value, the aspeed-ram-container
MemoryRegion ends up missing 1 byte:

 $ qemu-system-arm -M ast2600-evb -S -monitor stdio
 (qemu) info mtree

  address-space: aspeed.fmc-ast2600-dma-dram
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-00000000bfffffff (prio 0, ram): ram
      00000000c0000000-ffffffffffffffff (prio 0, i/o): max_ram

Fix by using the correct value. We now have:

  address-space: aspeed.fmc-ast2600-dma-dram
    0000000080000000-000000017fffffff (prio 0, i/o): aspeed-ram-container
      0000000080000000-00000000bfffffff (prio 0, ram): ram
      00000000c0000000-ffffffffffffffff (prio 0, i/o): max_ram

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601142930.29408-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/arm/aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2c23297edf07..62344ac6a3a2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -262,7 +262,7 @@ static void aspeed_machine_init(MachineState *machine)
     bmc = g_new0(AspeedBoardState, 1);
 
     memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
-                       UINT32_MAX);
+                       4 * GiB);
     memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
 
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
-- 
2.26.2


