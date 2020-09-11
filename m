Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD48BC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A292220D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A292220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGop7-0004U4-LV
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGono-0002bg-5J; Fri, 11 Sep 2020 15:33:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonl-0000nl-2p; Fri, 11 Sep 2020 15:33:43 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mtxxk-1kX7nh13eO-00uHew; Fri, 11 Sep 2020 21:33:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] hw/acpi/tco: Remove unused definitions
Date: Fri, 11 Sep 2020 21:33:15 +0200
Message-Id: <20200911193330.1148942-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lytElenqQ/jkApA2KD0dlZ7WvY0XwOzKahOEJvBCS+/K7IWbE9Y
 RFxC4CfKUOPWsG8jnExJi6ggrOq+4/2IjrmLwU3Il3jhGma+rQn7zT3ssFEbFN39eu6wigJ
 ktQk778rI+lC7sN0Ams0T8eMajWia/cKJ7smUe5VlGmcGWq4YQ5stbNd+wJksSIYMZiS529
 5qSW5mA8I1fS5sSDz+DKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KE7inTOMhi0=:ZndHDxmf0MC5OOHoHLZb3e
 GHNqOWqiu/FGC1CJ+3RKUUfUtFv7BoAQNptDDe6g8deSWvQGY+bSDOcmf9j2YbH4X7VaCZANl
 HTQMQK1Weaaa28mQCaiFzLckB6L96cujMwy/yjt1R0gEx6elsml3MFr5/w4NVES0P5L1wFkwt
 fpyj9H6DrJUFTYCySIBB7yU3gcsqfhsiF+ZQUtFOnaMnyIm/D9TItJ3obx4rr9ldeGMzXoC5H
 T7TLvFhvhXncHx4UIbSiIliQyiIPiba8XYKTUTtq1fuCkeAQoGu3Dxhub0duB1O9jT6pY9598
 ghyv0gL4Gfui6ZDib0j8nhU2M8kfYEOlxRNRKobfJoblbLFpGkd80QOyXGaOBS/9S/wGR0Zxz
 5D4yA3gmjobqc9/EN6eadWcyOEYLNZg49Han/b+3vO0/9NUCeRIqU+o7YVJ6lWdgW8YOhHa/F
 tE/51+DwxGRx+Q0505odW2xpRcx2g5xGUyQghEgjzOmq52nv3bhHStVa382+s0u6XuNJwkDwJ
 ZTcSIyAW9x0Lxb5qPnZXvmNmWLyCwhrkP6assldyNqnn5yp52PL6mZ5bKY/9Jpiu+p2cRDv+j
 y/GHKFLh/0cJYVBq9cuXCckHinjBOzvrit/UAACD0rt/EXYvAkd4EK8qMjPCJ8+0JITXYWH9E
 8+Ie58mHC4CNC74x9wQtCgtIhp1ixrNGbhsdPf5I1fbyzx1MKvMMwA28XWogpSzVfJ5euk5wf
 ZueY4XUBfhPzMMfbmrvVcsPwrR/SP89xNd1dvZZIszYnlEp497g6ge/V7PrjsrdHOG/CC65ch
 F1YkjUlJy0akbQDqXz9c53gmPrMaGaiFR5k6oyOp8mwhUrH8s9fwbcipGCVs+6CTV0nzpWi
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

TCO_DEBUG() and DEBUG definitions are not used, remove them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200901101951.85892-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/acpi/tco.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index fb9052dbca2a..cf1e68a5393b 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -15,17 +15,6 @@
 #include "hw/acpi/tco.h"
 #include "trace.h"
 
-//#define DEBUG
-
-#ifdef DEBUG
-#define TCO_DEBUG(fmt, ...)                                     \
-    do {                                                        \
-        fprintf(stderr, "%s "fmt, __func__, ## __VA_ARGS__);    \
-    } while (0)
-#else
-#define TCO_DEBUG(fmt, ...) do { } while (0)
-#endif
-
 enum {
     TCO_RLD_DEFAULT         = 0x0000,
     TCO_DAT_IN_DEFAULT      = 0x00,
-- 
2.26.2


