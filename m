Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75715C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA482075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA482075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWaQ-0005Pv-H0
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:42:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLQ-0007Tx-Qk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLP-0002yR-W9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLP-0002vf-O2; Fri, 03 May 2019 07:27:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MsJXG-1gUI620Kd8-00tilO; Fri, 03 May 2019 13:27:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:43 +0200
Message-Id: <20190503112654.4393-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FwDBsksgwr3Ro8wFHhTMgwol3cUCD/ilGRHQs4MAiGl1UtjiqFF
	P3XBYBVYtRXQrlY3wlVNFlUDSIMYOOKFgvqUKJWDLifVc28d1pkpgAFd2+Xx5CrOPa4zIrp
	jXbbP+8W/L58IVc1241l8sHMGugi/MplAaGDDgmSkSRPj4GFQHsjc0IPodDWXAd55FmJSZG
	n/gkGbWdbtuhMZlgq8xVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Uc4m6XBooE=:C8mQ6489mMY17Dd/pk5DSV
	M/kpYAVR1WSwAQLdvhNEvtsVQuIsiquUQ8GAP6NjcY7bo08kn4S9G3MmbSlITXv+g4gFLyW8R
	ac5LxyOxXRsNzZ9RU1Wl0hEeZAHYHW9smt8DeI45IvzmhVm0LGMOQLskuqVmsKIOBcY2Grcc0
	GTGQ8QO2kuvUV2ED/wnMVcvfdrDnhXjAr4fyTfZ2pu/387vZU0mts2h8Tv4KMBaAKKJMQ+7VL
	tZpBgmw/6EUr+2+tEMV5C93gyo3pzCv5jNHkMYgDFrqBVaqQj2RiMVH8zGF2JDuvIfTCYJQia
	D18o3NI7dl8rlj5bOTyL2RkmY9lcC5azv1blG1l2XcwPMhRSF0XHFJsavPDpIsyzk2eKpckR/
	XlFJmdy2MSp6m2tOWuz9q8yjbsxy0jBolrrAkeaK1Iqy2Ln5fSa0NO4WDiu6G4Mao1m38lXg4
	3HEdjzRkD55tvY0+GVzQbTiBEMLLoyZcx1owxDs0e0WOrnBRj5OcZDGR+9PrVOhuBoUnuvDgV
	O0mqxvPbr070Vti/LGZYrct5Jyxi1/hon2Z785dzldqIlq1uvTQaDAZ4GJWZGtXVbLSt84Bzt
	CBU/jSCxD87/ONr2jajbstjUVQARFZ+PbLpAml3nWpaaSNCeKhdb/S25qGr/bzbw5akYiFujj
	rgy0OgZkDxmSop6j/+gAxaNAK3VQcGa6ZGl5xxceB58d1v3o+TqaZubIosV/nh8OHAr8f8ayO
	92qD6/APoUXk+6fqXGHD5qKRWWhZP85mHbuxlkhe9TQ6hSIsk0JBDUno2LE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Message-ID: <20190503112643.OPVdSHlnyJHqCOGfbXXCJmc7Zx8RqTeentuLhWOf7ew@z>

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


