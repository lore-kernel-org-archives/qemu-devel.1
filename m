Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1D2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ACC20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ACC20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYsU-000656-VC
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUYr3-0004oX-1w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUYr1-0007oF-Tf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUYqy-0007iq-07
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfZ9C-1hxOol22yO-00fy48; Tue, 12 Nov 2019 17:16:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] linux-user: remove host stime() syscall
Date: Tue, 12 Nov 2019 17:16:54 +0100
Message-Id: <20191112161654.2253-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112161654.2253-1-laurent@vivier.eu>
References: <20191112161654.2253-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zAlir39psUJGY/PKb1Os7sQIO9usNnJ82WbHPpVdxmU4zixrPL5
 uB0hsRgoYLSaGaLyZMRXqN1Z/HrL1QVENlXEcqQ10Od+I78K+bzN8GkzH/H6uTJaRuhWK8P
 oOIBJgWg5XpBBEvm1HFRAQC3sXx53Oso9Y7mRNRjSZd9W4yiUWm8K3LSuhu2rjbz2QfUcwk
 Ss2P06f3ZpJXnuvFxHidA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AgWAZBIztvs=:Iq/eRFx5pl7QZxrFRIPOEN
 TkdeKaaGcWXwuDw6eABnpaON/tb+eSJJ2VJD+DoMWx8ykxwGbFnMF3nsS34IPJXLjlIpgWTBx
 0c2EfDvTsi+hgUDy7hBKRLVN5K4dic+RwcY9CFki9I9IAdiNBvXOBjMeWjkruZvzRtEPYCa4z
 JpveDM6oCTTsHUPpyDdUHE1BUClBg9AYZOx1bTHdoAF2Wdqdlle0IL8LijASxW5jAtXjBAuPD
 2L1aZhRiLFZb9Q42BmZfPh18iDNXslI/CaChDhB2dFyKXPN9+acqnomXqcL/yqKL9PDNaHNMu
 5suWD0/Z2nwu1oEHtMk5llMx0TXXF6JfTFmrGVIWFJXGqra0us+wPT4TzRd73sIWCfts86XN7
 JXlzW0HECPsJanJd5oUJ5gwdciUGr6JgO6lVjjszyYuCvxehAVanxfK7wyzkRoSW6eiIiJjxf
 US1u3cr6tg+DGYqSuhTq2D7JojfQZ+SCU+WkCbwvINm06mBrmdEGj/BRm8QZagMWxqjZ6m3f6
 IdYyqMo3GG3SqsB+Cny4j6R4vkO90Wds7MclZdoETnGlRWWVWtfY/eiaumuLmDEtOlFqE0L27
 bYjCYb6R9cXGXAiPxw339LGAVistev6MryYkF/C3BO0xk2erejileUOYFuJvkL5Lm+DZ6hb+I
 NPqD4xG1SMrXsQXmesABwJQX+3WV9oBTkdUJZ0HL5tAoGGGLWijki1P9JvpMLn2/TDimbXnlH
 lBz+GH3fDzMhNL9ckCsanImTlBVuoXkOlxA2xnXYEK+10BpTJtAGMwzJ3aBxRKM9zGkUCZdJZ
 LE5cwX9rmdicpclMfyz/ajCEJAygVRo/6WdYXzf8XbfHe6BKHFOwxG76E5cLCeEK7ats+HdTu
 9gvpDnMW0unka0ZZoGow==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

stime() has been withdrawn from glibc
(12cbde1dae6f "Use clock_settime to implement stime; withdraw stime.")

Implement the target stime() syscall using host
clock_settime(CLOCK_REALTIME, ...) as it is done internally in glibc.

Tested qemu-ppc/x86_64 with:

	#include <time.h>
	#include <stdio.h>

	int main(void)
	{
		time_t t;
		int ret;

		/* date -u -d"2019-11-12T15:11:00" "+%s" */
		t = 1573571460;
		ret = stime(&t);
		printf("ret %d\n", ret);
		return 0;
	}

        # date; ./stime; date
        Tue Nov 12 14:18:32 UTC 2019
        ret 0
        Tue Nov 12 15:11:00 UTC 2019

Buglink: https://bugs.launchpad.net/qemu/+bug/1852115
Reported-by: Cole Robinson <crobinso@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191112142556.6335-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4e97bcf1e5a9..ce399a55f0db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7764,10 +7764,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
-            time_t host_time;
-            if (get_user_sal(host_time, arg1))
+            struct timespec ts;
+            ts.tv_nsec = 0;
+            if (get_user_sal(ts.tv_sec, arg1)) {
                 return -TARGET_EFAULT;
-            return get_errno(stime(&host_time));
+            }
+            return get_errno(clock_settime(CLOCK_REALTIME, &ts));
         }
 #endif
 #ifdef TARGET_NR_alarm /* not on alpha */
-- 
2.21.0


