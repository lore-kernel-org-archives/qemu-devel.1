Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEAC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BBA2081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BBA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWIT-0003Jy-KC
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:24:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDw-00087B-M2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDv-0001CA-Qs
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWDt-00018e-LB; Fri, 03 May 2019 07:19:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1My6xz-1gXsbu3vP5-00zWCY; Fri, 03 May 2019 13:18:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:18:21 +0200
Message-Id: <20190503111832.30316-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
References: <20190503111832.30316-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0QU5eNHOBHQ37BR4B1E92mAHxrTiY4zvXiPU0hADaB4iQHXA5Sq
	h5sMHrvos8z0p1koLJgZvY2tWviBHmb5SW/oHK0UhoaXD2jGKfGG9jjfgsZ3XK/UqFPZpXI
	Cd+hK8P0WOxNt3dMABVm1W4lmURetT0gupaxVN7SF56eOEXu8Os9g3lY4IVhzMgXGAcGwEk
	DYMEj1G77xshBWiWOe5zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ncdUtw6OE8=:uj5jldxlgdU53qEM3jkdLO
	rzTpLd0dmXC50Nku4aEYxYsSS5fRWu48VNFKC0XRPqMYfzw5kJegh8LA7j6iQdbGAhtcmN+Zn
	kJwSDvWze0miT1GQ/dRn7RrxZW+k3cc0ygOBOzOesJM7rbLQM9XsIi38eX3iO2GAKq2EmzuJo
	IG8U68jBtmNiFygjGtVCs57AuvdyHp99+bjv/j4zaCnkel2CE3jlOj5yS08RVZ4iu+4B1+iXS
	ZbQqVxkxc297DjBReYpPDbSE/eJxHtpK3Q5RvNHpNg2S6NcrfqAidFuc0mL+AuvOzq5ZQYogV
	5ESI+Wg1HdfEINdb7uUn5M7GVortHobiwdbvXlIKnFV5cUGaC+gDBb/lPfkpby8W6YaV5wkn+
	lKVdpid5/H8JaK+W8cTYxxzPtCvuiibKlfrDSk4tNhTwAwmw43xYY0vmtT4zT95RaYNQD+wl2
	89whLqbZZIpYA+7DUXvdx9JME/eYjdEZ3CGgzqu4RvPZ7AG3lFCZ3uecNzjGB/7gKhbCfzk3Z
	TZheb+t4FRT4xlAeEYOkrzRDsL5wsdyru5c4/qrhPSzAUczNuhcXNV/xR7ycYSPsDO2FkcE2m
	Iu5Mx3n9MFgVXOnZy9cpjNSxr1I1yDOThPAxautNo6viqhvwTi2WM9/wFxi3T3d+34eI9wKXC
	zd8l6lWAvvk8wPh3C61eJ0/saUIvy0p3BpWW7WfX5nBtj64U+/4t+s3xIko0P8+mWY/ES5zpG
	fwbeatyzhu7jKRvLxlU3gCDTbPd26c4j+h+CwdRMk0O5+ieOH1InDOy2T+4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Message-ID: <20190503111821.NDEZeLoz8IC1NyR6Lu8V0PbHPrYw8VgN_7gmfi_FkQw@z>

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


