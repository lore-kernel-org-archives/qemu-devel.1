Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE71C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E0520724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E0520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEkd-00071J-Hi
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVK-0004lo-4l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVI-0007CP-Rl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVI-00074f-IW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfYHW-1jl5Gw1Xjs-00g3GW; Tue, 17 Mar 2020 16:51:26 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/37] linux-user: Add x86_64 vsyscall page to
 /proc/self/maps
Date: Tue, 17 Mar 2020 16:50:43 +0100
Message-Id: <20200317155116.1227513-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:obArXG41tvjaxxflB7jXPHCdM0J/9xxp6czqD9oDJq1UMtUan+v
 asnZX+TAJAOVCAl1ZqGGg5gCgxkRoGhTsMY3mal05Gkfsh7SXZkx4CAA1BGrfjH6FBeBc/t
 a/5dAoM1MK2Z0YuC6CvdTVnDzp64Iv0gR7pibiHX8eqrwMbDPubEGcUQnTqQsF4hC6dFE0H
 drRtmsLYY5GhPQ4u1hYsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6QCS2Xc3Ck=:FYEG4lEN3r35VJclh/mPh1
 j+9HTb4dWE8BIiDv74oiMxSgMad09TNNbWZ5RVziG8wTXQdgOkXKPyxBCZUDVzPX4nCiQb91E
 qgE22cm+pTSW36O97m+kUavAPKQuzIaTXGHrLT7E75tP59bo/UknXNkwkgpMz+7YD1BPkeAaN
 IuNnRjvoluNdWEcXFJdYS4IIWqZG5aKUKDH8JKQfb3hrCz+CVbGoHhMURjzupq9ffgQ+v/kpT
 UJTkQA6xeIFaLYY42rjajAcbDF3Hvj0SLnCHr52hZEvhTTe/Jg5S34CVriM3HEOWJ5wNyl1yY
 whGVrM0BOjq1lM7bHxmMmxWLnpJCpzopuG7FwTDQSMA5cqbX9l7wQ4t7Ehp/2URVoqE7rC9IV
 QfDugDsZwzoZ4/8eRC4yAnaI1XB8rkpGKAewKgGWLOU7MWv2PAMlBXq1p0G6YvBIlhYkIZb+P
 jg/Lh50sv5nQAB7hBnRixccZ10sj4KIk/M8bBlmgdEP/V2tCw1tZ7oASwhf+DvLo61dENKz6c
 bia+l91Wvc2k9MAzBxpyFDrQgR8bAQ0aYw3uAsizQ5KiY3c+wH6lzVv3YOsPaFMMw2feMc9OU
 ugsdvBWii26l/hn07pnFwiUx3rqJVZz5+MjBUi8Oxi3UKp4XQm1BY0FyLFnTpaWfa7GWnt/ol
 zE9wtqC3Z0NhT7TfMAeMzmapi2kDeUNAmFvplTAxcTNm6N68LwoQW71VhTvFb4qpe1AeV5N0h
 w167rruVzt3csP0fwVqtYSiTPy7SEJqo3dR1wY99wOzbF8/xY4Y5Fkn4Drv78dPs4ncnBYr8T
 GU5waJ0Q1Te1HBlsK01H+bkxfH+incVoXHDlueSDlN9IOW6VANtJS//3ORbWkeKySb2HpD6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
[lv: remove trailing whitespace]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d1080752..5479d67a10be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7079,6 +7079,16 @@ static int open_self_maps(void *cpu_env, int fd)
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
2.24.1


