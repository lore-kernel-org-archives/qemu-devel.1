Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA3CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36D120650
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36D120650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUX8Z-0005m2-KC
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUX7a-0004ya-NQ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUX7Z-0005rX-JX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:26:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUX7Z-0005qn-Am
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:26:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF3U0-1ifamv0DfM-00FU05; Tue, 12 Nov 2019 15:26:01 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: remove host stime() syscall
Date: Tue, 12 Nov 2019 15:25:56 +0100
Message-Id: <20191112142556.6335-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lMLzvhVRBqGcDpm64aMbuyq5VZyhb5rLM7ZHuxL8H4MsqHQVP6/
 9lQORUGrb6RztknEFHoyPnqmW941UiRdRphuJQXA8xHGPWVHnuIjl9IYRI8Sy82KAQ6PsXK
 IO0PP89uZ+b3KUmJglmi6FAyUtldY8ntBrclmyz2pGIuscitPdlppCY4W5RkKB1ylpbiT6n
 6FSJmRs40lLWYRyUtCBlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ckg1wGnTGRY=:zYnsRXjaG/zhSd3Xg6l4jX
 Elv4y1i1C5jhVJW4724xjnMslpRhYYEsJcKs+uUOa9jUo3AdODVW3BH9LWOlWUQ1QujnJwoNy
 ia/CB0QQ78ScRjrA3GxkuLrCkS1mLvA1LHjKR2GicI6GyM25JBb90TUIDcmI1tdSCI7fwLS82
 lrdI7kne1t+gB4m9pl8phFzQkQ8eN8AnphdhbK14DCp2kW+cZAdqUGJKWN8EQNxi3K9bVM6sk
 svy5RKNdqd9VZN3i+TZc1VTuQcd7Ih3l9FBIwKdrEZxSKyDYb5ar3poT2khnN+uWlWncOS+KJ
 YAqL5sO3TcLHmZqsYoGkoOwL5cQEHYkqoh630RA8Rm6mzG8EJgC7WuFh+g8/qdtrUTrx/mzYU
 52e+DKVN+vaZYSpXm2emta0VCdzSIEbO7ltZCtjYEXX5zAnwCQHFM4INkMFHtg+rgcJOPN/zo
 l93H9+Dv8HMymImVGRw/Wf+e0ierjkX8pAg9B147Pe1hB9It/yAgAxL4iMYU26Nj1GM1sElU6
 YMNBmrUjG6n0sX4iskp3oNX2LWnH8DqzV6lRPGN7qcrHDQvTzropDcORXlmZs0PbfCP5KRon1
 j3O1qeg/epAVDbiZraAbng4wtR2tMSZbrSyYtPI38ZZZ6jGS0E9vBEtQmkOl9J7SEgpUlEDe0
 STS9uCaPpsIVR4lAp10V4K173kCJPWJkUFWTVVwESlpkLa67texGL/J2fnUH/2iM+DLVwkw5m
 0i3G6am7vEuGMlR/WVI4qZg9oG+OT5+Hhkw0fGKSzEJZO0aFaE+IXV7c4JkQ4aSlpx3iQaWR4
 TLwlVk4aMjprapsyTZFbhTns33B7KLK5HHx2mXhHzZCe+cFMghQH1PYcbmRixUykSZrR1Os+v
 /cwdelEv2fx1QReL49ew==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: "Daniel P . Berrange" <dan@berrange.com>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
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
---
 linux-user/syscall.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ab9d933e53af..c4dcdc94b10c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7763,10 +7763,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


