Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C19C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95416206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95416206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Bh-0007sQ-LX
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zR-0005jW-9W; Tue, 01 Sep 2020 10:10:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zO-0003ut-3A; Tue, 01 Sep 2020 10:10:24 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuluN-1kUVHQ4BVr-00rsoo; Tue, 01 Sep 2020 16:10:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 28/44] hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
Date: Tue,  1 Sep 2020 16:09:38 +0200
Message-Id: <20200901140954.889743-29-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bTgl6P/Ee+6znIidnx6ahoDV8qX8jOCR51ZVN3cq8jLGLm1bL/4
 2Q6GsgZd1K+bSzlc1wt0bdU0Ek8ieKjHBRyxkwu9YvLE2HyyzOvyo12c0hRQnFdr0GBEqLL
 IDxikjRmln9enzwX2Yi7yhuDvEmZefmv7nsRBkiR2grkNFkMUHekX7sXZRgSKL87y19j3E/
 VOPkDffIJIlHnp72Iln+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tg9Os5e/Y28=:hkidTrcs+hBv1EBwiT3E8G
 0Ncaz796ymjoBOrgk5r/H2B77OBq40wdquxm0a7QGA15t+ZJyR2qVpHR9PAzq8EJ4ZtOJYiuq
 +Nyb/7uHyj9htE7o7t3/eU8r74/C9dNTw11hVohkSNUndih00cvbJ64Go+XoQBr30/vdaFm48
 xjsR94QgVTEtBwHrqy/E+4uRWfr3qQ7MvEq1rMlpDFG0P8oPBjlZVd92sUX/JgClfzihUu2zP
 I06fEHO3KJixOI9KDoDZcIQlZCwOrOFsIjXAkbsMUL0RtKb4f9oIVRtlvCApVGhoSSQwjH+33
 wQbCriH9bKA2v9WBMeP8WEjpU03yeT0ORTEL6vJXsflLGh2DFKMXXrOozg1OaZZDCCyD83oEB
 8Qjtp+cvfTxz5VsicEOxFn1v/z3bKAW+0fRmZpNaSMBo4PUdfiAsHf2xJBR/YiW3EjOusrpO7
 Leb5PxUwQTCRo+KAfwtlLlVfFftsdpuLyu/5sVuDh3hRlEXcWgE4Yb2Id/D9o1ndhYtjP+BlE
 zOpMwQeFeg7RbsuTZonDLPsJdtuReVxq4N2h9b8hm4PZLX89dhlU/oMJJycvCIE74AHESXEtq
 JsEPQqZQoh4mgUNgsByNW7rBfWsKOz5cjr1tYoOt+D0m185Vcs8qD+g5FLEnuOdf08yOYZo8o
 WfBmRaEZy0+iZV+SaHup4344TR2F4/vzZ7OBcyH+Ox3wp/rhNWWOP6ZeOhPb/qcsVGesaZxjA
 K6zgD/GfR26ounsHeHx9uDJyGioDnGgRmCdAlFEFXV6qKOs1VvSofN0rwO+eXaxuSVoTzZb9Q
 niizjZdMwWgIl/WCnJa+IU1OufAf2vnXA1BkIbdLZPlDhh2oeYMQLCOLBB38tbqa8TNCJDt
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:03
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200814082841.27000-7-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ide/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 5e85c4ad17e0..b50091b615cb 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -138,7 +138,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
     int l, len;
 
     pci_dma_sglist_init(&s->sg, pci_dev,
-                        s->nsector / (BMDMA_PAGE_SIZE / 512) + 1);
+                        s->nsector / (BMDMA_PAGE_SIZE / BDRV_SECTOR_SIZE) + 1);
     s->io_buffer_size = 0;
     for(;;) {
         if (bm->cur_prd_len == 0) {
-- 
2.26.2


