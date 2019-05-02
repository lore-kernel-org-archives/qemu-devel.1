Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D9BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBB20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGxC-0004eI-Pv
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:01:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvM-0003UE-Ua
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvM-0002vv-1f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvL-0002u6-Ou; Thu, 02 May 2019 14:59:15 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mrggc-1h1SDp3B6i-00njoP; Thu, 02 May 2019 20:58:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:23 +0200
Message-Id: <20190502185835.15185-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oR1ObyDzheuCsJYSoWaCS0YXv/NblZRyYkeYRMY0/IHirEPRzri
	GQXfKFKKG9YdybfH3SpL6eYzYkK9mFXumKxJQTv0q1cQBaqrQMhyktlVL0s6VwPUDSU4MhJ
	1Jd9SZjuV/y7XvD0yCzxIjxCyvxmFjN//Pt+pbNlYTaUwO8tz5J6hIjOk6/p+wo80kXInYu
	WfDwKuUR287HlzGOE9AWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4IYYtPfPiw=:Px5YNL/p0EsP4zXvcDDciV
	AoULs0Vh4aeJ/26Qj0VVpEfiUngffXUGM23tfJS5Oe1ft7K4zfiLCGtZrypNwA2JcT5n4faXC
	ve3+TZUl9vtbpg3Yb/bekle9nDMRqgMVsh6UwHl4K5TQsI42JalrI/E0OHej/KO9Akkkvl/rE
	h7EkKsXZiFPmNIgmo4HBmr20/PlLHfKcAsQoUNJnYafwZDiyzNPucyQ49udPFwtBo+qE4cNoa
	uvaEAcYzrWiTB3U9sgMkTzranaE0yUagJeiYa4g50l83PmK4hxy8X2R75UNzY0EbTGNOWvnM7
	8lDn3s1OyuOtwpqKsltat+tExVkRnLsL346jgPfShShezryWKzoNff2leq/2rrRyaiIVlSRPF
	UvldwMAXcqIRFnmB4u5hkTE1oGhUNs7o6WFYRV1SJMGk5iGDPBmD3lLr+WAaV/BHjhGoTqwjZ
	ASDk9U5HLB19xv5WfKdItVb5CbW4zsGQl9YxGUB42T3Sai0jm996RS4ODAlIJa57fHmMdoP8Z
	B6wNfZas+mKD7PB072oGRmM1gMe5kf0xqNBCkmUnREIKmtbWNEbbXewinlNq9j2bo5b9kajVN
	1S2OBtEmvcMXHfZASvyeCavoznqkVfHUQAA9mCngja0w5aof6gslv/oZQtiO4kWhwe5Kz+s3B
	5drosIK3ErzNOaMcMMiUNqPV3wbca1MS/BPLgUWr5KKIu/1Le/ha22sx1cw7IvlUTvVG6wn6v
	v2DctFfxZkzhU4JhaSJi3wrqENTBawkKN2J/LTqft6+t2uR9b62wIoff9wo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 01/13] hw/net/pcnet: Use
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185823.6BLJEy1721b-3TE-rxuSYak-6UkMfYyZz-vajcUz_Nk@z>

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


