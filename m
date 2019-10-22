Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369DAC47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF3C21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF3C21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpP2-0003fW-UM
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGP-0002y8-O7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGO-0005AT-KD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGO-00059Y-AX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mtfa5-1i1a142DB1-00v9j3; Tue, 22 Oct 2019 10:11:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] linux-user/strace: Display invalid pointer in
 print_timeval()
Date: Tue, 22 Oct 2019 10:10:56 +0200
Message-Id: <20191022081104.11814-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hCOy3gVybWU6TYPsuvud3YzUqA4Ytz+yHtzWQrt54XaYdteppXq
 9xx9V/RI1sTN2tMjOsKXQfnV+/crOL3GF9IxLzkMM/HbEtXwiMSfCmSaKUxX+DXzGDPS4E2
 1NnVhpNXUGeY5srrB6dHLmTxtPvdwk67SZZp7EMvuCzWyjWEpYGGUC3To7RMOtMqKjCpr7K
 yhgDPHl//R07GQqOO6U4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6MCORydexKE=:lE/nrl3vGZrjsjebIVGAdb
 /9bwsm8PQX5KjkpCJwEKIot5c4raIjsfLm48CQMDgKJMfIjywhpV7vY3JnCK8sZs5YW+/57A9
 O37NK4jhOiwODyU0THn/PuDYGJVvyRX32mvxMDHxatWTDKlldsbL1eOIYqbEsLlmoVLegAVod
 Gc7a6BKYjY4Zo2wFFubf6Jg2zIOe+LSF6ohwZkaelo2SrLjFqzbUGE+B5ERiUxzSJEoxfJjWw
 Mhhhip+//JL+Q8qMSv6mfIHnCdoLgHDoh7wE/ETtRAxrcWTpd9joD3G1hjhLOvW56U8/jf2Tg
 KVFG6qhUHezFoEu8/Ky1056zbwGWJKUwsA70jCqKclUzen3fuP8keBcQLgoTWeZ747t962YvC
 KgDa8kq64fTCEYc7PfGcOG35GECBexJ2AyMKn44baq/XoC6/c3DPNCkI8RowT9Kw+3emYbx+d
 HZldae0fAFSJ3OIcCcfYkLoTQGZ85IxbwTSaM/L39iA+MFGrhDc8gXpClsRp5or6CQSGHwB7q
 n1xN7hqIvKJr1fy6+NynkhXntkg7Bmcdw+s3qPG2CMVABtOeNZk0IK4fcDKVN8HwwwE/Vbj0a
 8dLze+xko1IyTIG8KG0i+v5xGBzUqfS1Re8DjOlXZ7Mr8DsrB120+7UdN7u0MvrjngtTQpBHz
 BgG++bnSS8g6HWrC4AwNjW4JpfiYvqO87ogLavHvLsCgNBP+PFs7KhvUjofINnvgQ7qxmmI0e
 lxaZyz5Gyf2NQnkbmZpemMlDDXZBA6prxWV6DMo9Y9VkckhxleN2zlku9IGlmOmOxWMUVN32x
 2nrbmm6u74k5APQgOXalC1oLZqU/VppYTEXEXCUo/QNDX33iI2Zasrq1GVWfzgDF8IZYrUkEK
 H/lRD4eNTOQAqFyC/Io3UerXr+Z7Oya0TtG5o9QE0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20191021114857.20538-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c80e93b5db8a..f326c357a26d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1243,8 +1243,10 @@ print_timeval(abi_ulong tv_addr, int last)
         struct target_timeval *tv;
 
         tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
-        if (!tv)
+        if (!tv) {
+            print_pointer(tv_addr, last);
             return;
+        }
         gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
             tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
-- 
2.21.0


