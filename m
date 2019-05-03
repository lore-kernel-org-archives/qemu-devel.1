Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D519C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024762075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024762075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWUu-0007SM-6S
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:37:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLg-0007l9-I0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLe-0003La-M3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLe-0003JV-DL; Fri, 03 May 2019 07:27:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MWhxY-1hFyvU3tqS-00X13A; Fri, 03 May 2019 13:27:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:50 +0200
Message-Id: <20190503112654.4393-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G2yBrV7EeKrN/+ppX66Q4YSPLjd/pin9EJ9LPnkhhk4KBEsXU0S
	18qNg1leysXag1GayfOmJqH5Yu6CwlUZvOo+2WAl5aC52MbuY3KqpDcbGUnCbmwmO2+iyRU
	7cMaCBrq14EQNjFnR+L0w/Eo0dcP/QBOTMrF7B4UJrnFY+ANXYlRnmM2syN7sRb5xrfjDoZ
	m+haxnDDdOydQMjaiapLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iuZKCtrbyDY=:7B1a4EN08eXbwEmHWnhbga
	J3tOIhdeKPujwgVl6T1TxJtCaw/g8aiujYZYi0kCal9zXJpI/JbdA9aHBGIPspW7uu6Y+uZSb
	kLraZ40mD+Cd9CqDL39ipPOFhg9hOI2T5z0o8vs6MqwP+LRDFox5jKCo7aaKfZuDOuGQB0lHt
	I5kLXX/ANZ8auYPeIzpx/0JCjjcCb8FrLXc+e4S1q5/ldNnK1RCRH+aNaw0PDOI8sQHCWgcUg
	EQpr0Tcy+YqyeIwaUEN0I3YCoNQFFoHx98cCZ2FtjkMi0ssDhE+Rs9kNIAHfK3oTSfIZuWSfD
	wD5nLQTgYYk4nCkn7Mbl0YtUobIvto0/9qh2evss2ySQf/1bxMmYUHTRCoEOYtlnQz5/yOoZ8
	wlIBe++/u+ox1Pz0S9KwT1UkUPCFFq7kiBXspPfnFStzb0kbiu/ls16CuLpd1MY6o6tKHrBOE
	pce4GLsFj0AJxoH03aDKKtKuZUDNb4qwkUIoyGgEUQBszsDc1qNF7d3bqTXwsfHnMCHnQvFeN
	2hbe/+AdXecPbu4kBGfw2i0Q5eJ56op2CUdmuGamTVaa8WUyUx4/k0d1Rr5vG1l9N4bsMAndF
	pKCHvbT5lPylBtkOE4ERaQ9v2+1eiWyy3rYk6oJKlqqRaO04uz4cWJ1bZfWx8p1Kextd53msP
	PlJ1/5VKkT92vS9N7C6NGd2DMraImBqKHrn91QEThtMiWAc0/iO/AZvB7KXtl1LIIH6pAKPkD
	wVqx0vDbS3V0LHvHm+LdrtxrBm7KY4pFOWDD4g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL v2 08/12] Header cleanups
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503112650.fjyk27Z1XvWmmilnljpiLn2D8jObb3xiBKj_p5ark68@z>

From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

Removed unwanted includes from cpu-common.h
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
[lv: fix conflict on rebase]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/cpu-common.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 848a4b94ab73..f7dbe75fbc38 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,9 +7,6 @@
 #include "exec/hwaddr.h"
 #endif
 
-#include "qemu/bswap.h"
-#include "qemu/queue.h"
-
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
 void qemu_init_cpu_list(void);
 void cpu_list_lock(void);
-- 
2.20.1


