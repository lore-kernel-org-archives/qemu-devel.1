Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1BAC004C9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CB22081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CB22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWLG-00073u-Ep
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:27:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEt-0000Ty-K9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEs-0002HJ-6E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEp-0002Bt-RB; Fri, 03 May 2019 07:20:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MVe9i-1hCeqR1kiC-00RWMA; Fri, 03 May 2019 13:20:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:47 +0200
Message-Id: <20190503111958.30825-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qpa8yx0JkaEtHqArsVLvP6OIZR1vdefw/Mlo2DZ7y9ukZm1QMXD
	vWv8cXmO4N0jqrMrPwgdEgMKHbm4zrvZFEKoO+VtiJpE2hyf93QtGkPLiCJCpxdAtyExUBp
	cxobzyNyMvofRcEHqt9OGrdECjnqpV6XeeIeSE9fYSXQvIU9EpwzlKMiub+LzeeGZluhNDF
	wDmI3MLFjekxUsgCHySPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aUJGjar5Cbo=:7Z1T9/bt/CJfrWGVZlgn8a
	rinF9f0Ue6yxi8kERTvRdPIGGmeWo/QfJIHTCjA73fKiAgE49RA6TxKANIpfB7bGPG5iZiRCw
	gk9Z7e8syCQcgSq9STFE5zblpMN9EjI06Q/w/usftbOESYy6TQ9zMiaCVwXhHVNdSECQ3Nm2/
	QVeW+846GE1bF5YRCtWN3yHrj0rw2NtdiEE7UGvKxKLeFggH2hjS8y//uTaRUu0fl53O8MnOK
	a12HFFVXVC1F9DmglCFgDyf630dS3WJ0itjq/5FsPViKGYty02ycXGltOBefaYzn1h9OzIQZz
	Nj8i32AKO/ATCUB+ILjRuGDXlvzmcfPZhvFP5GyHvXVgZdF0FulJ5iHoGCDcrKzWUe/jZrwxJ
	Y7y8azzXf5dj3JM/EncASxDsbQKupJ0qkLww9oEZ/0GPmT5845GsGQx0SXGrDJpW2cxOVmWev
	F80wdofyA/GbtuW95nW6yPXDbo6C64e9uWBfQ1jhC/T5yJEhoWxdGbiZzb+tTn2QpC0zfCrJ6
	Or9DfkZ72gdyIFGLcQ0OM1G3oxPCU9fOtwVz0OHsfwZvRghPfOaQGhPR/yBp0iCyykbblpadJ
	KHB+/5EczM1FH4dJdj+qWYe98IMHR40QHJgdIqvvCIJr8BY0wE0y4UiEOQ5xvq8IpDDlk6IWq
	nsydj26PGSyLbSVMEmIBsZraw32/gFZOlGh2OPhtAOdAb1nfM7BqR0JgFX14h95Hm63kYKKh1
	Z1xkX5QNE63k7eE9gJfjcphGQpNGpxfaTqe7zbMbbXEoSzj2NHOm0/0qU5E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL v2 01/12] hw/net/pcnet: Use
 qemu_log_mask(GUEST_ERROR) instead of printf
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111947.hAa34Gtr4GmbHwqTPkKYevCtM-P0ZdWHjuhgtQjNAdM@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid to clutter stdout until explicitly requested
(with -d guest_errors):

  $ qemu-system-mips -M malta -m 512 -kernel vmlinux-3.2.0-4-4kc-malta
  Bad SWSTYLE=0x04

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190311102712.8572-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/pcnet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index d9ba04bdfc62..16683091c939 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -36,6 +36,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/qdev.h"
 #include "net/net.h"
 #include "net/eth.h"
@@ -1501,7 +1502,8 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
             val |= 0x0300;
             break;
         default:
-            printf("Bad SWSTYLE=0x%02x\n", val & 0xff);
+            qemu_log_mask(LOG_GUEST_ERROR, "pcnet: Bad SWSTYLE=0x%02x\n",
+                          val & 0xff);
             val = 0x0200;
             break;
         }
-- 
2.20.1


