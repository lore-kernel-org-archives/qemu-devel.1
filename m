Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01832C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE82220714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE82220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMsm-0006D8-Tt
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHMs7-0005LZ-A6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHMs6-0007tK-9Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHMs6-0007sv-1D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:10 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHXSD-1j4SiM1ZFB-00DYn9; Thu, 26 Mar 2020 08:23:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] linux-user: Add x86_64 vsyscall page to /proc/self/maps
Date: Thu, 26 Mar 2020 08:23:51 +0100
Message-Id: <20200326072352.2056553-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326072352.2056553-1-laurent@vivier.eu>
References: <20200326072352.2056553-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N9BloZddGoEI8aaMOWZioelpXj+OrVHQl9zigrnZcP/MsKXmp2Q
 bfT24knouSbYlvmSXFeyzQ4IdT2X9DEIAmFSwwAAjYSUV4N12AGO1d2yo/IxzaK4mBTwgt8
 I4cMOT6+rrHZex8D6hZypm72a8zfey21qHguss0uuZVSqXu6Khc7yP2dYtpMohlt2RRrlMI
 +5FLf2955LFmL5mpfLLcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZYP8560LjSM=:msR9P5Q/I1q2yMQwfo8mtW
 Z+DydHO9oCRc2UOW9O/G8VTjHxN4mHq7c8I86RKuP8NfdV3IwNbtY46eiwways+Vj24M7o54H
 WNDKzJKfRuzdxZIdvtOGCXEu1P57zLbcBhsaEtZUOWnxTYpirEAlHT1BLxHC7/W6yrcdlOOIw
 F+4+KM4k1CTfVXB6Wkud11fdcewTrWc2qBo7I/CJTIYqHbkXKa70FHMqbZs0LrXDNzeC3fH4x
 eWi4A5P8L3hGgiOtfvTIJUvwzduxtNqQZOjZ6Vpy1VFqxe4udBTzhNonHaRPVgDQPGjY0hXfI
 4AodIDG0N4u0j85Vy8+V0vHN3UkMWdTfZt1tPf5ceHoMoA2Tp6Zk7VvDT1846hPhQFnHo9839
 oCgKEAFTua+RlULRH4iUey9EqPPTcc7spFLiCxsM2M3JRLeUjvYlrtLU/YLW3PB8aJ8iZIvHb
 yDAfmD0TRSJtAwa20/rxkOnsj/WOq+9sEwO+QEJC4xMYTjYOVqlEMNJYnXO+wYVWV7z+1R5kx
 ws6uDQk3ZVGcsjxmeQ/EaJievGBptens6B7c+qx9pyE2gFKEyb/E+2h0WKoNJLg2WOmgiPzJY
 dYb2QYgFWDpANeWEq4GRaQoG+BREia+FikLHDaYfVT/lTUAAhlrEX4VzHTKwF1fu19vJhLEzk
 QfOj/BLs0MdHU7nsYvvXiKyFEdK2YhsEi0Lh0tYYhNonVbxWKIeotW+gr8zmbYf1QUzS9AaJy
 ygEXiOicbUTdAVf4z4VcnYqjFNAjx+oODq3o58L42VpZPF1aIOoJIQkIIYfNnMb3NOFDIEufN
 C3pPUZNJDdf0jhzsMaW/UL070+0FnFlI70P9hn00DJuwZPbHg+cbftEV3TzCVYK826JBvCy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The page isn't (necessarily) present in the host /proc/self/maps,
and even if it might be it isn't present in page_flags, and even
if it was it might not have the same set of page permissions.

The easiest thing to do, particularly when it comes to the
"[vsyscall]" note at the end of line, is to special case it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-5-richard.henderson@linaro.org>
[lv: remove trailing space]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 35f414666243..dbdd56e42077 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7144,6 +7144,16 @@ static int open_self_maps(void *cpu_env, int fd)
         }
     }
 
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * We only support execution from the vsyscall page.
+     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
+     */
+    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
+            " --xp 00000000 00:00 0 [vsyscall]\n",
+            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+#endif
+
     free(line);
     fclose(fp);
 
-- 
2.25.1


