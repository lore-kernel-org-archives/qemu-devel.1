Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C91C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF73A20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73A20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i5g-0003cD-S5
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1X-00049k-QW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1W-00089H-Ql
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:35 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1W-00088h-Ho
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:34 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7KKA-1j5oTF2Oqq-007o8U; Thu, 20 Feb 2020 10:20:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] linux-user: implement getsockopt SO_RCVTIMEO and
 SO_SNDTIMEO
Date: Thu, 20 Feb 2020 10:20:42 +0100
Message-Id: <20200220092053.1510215-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:piuR98raXOCQseHB9gJlYbGRMo6LpwDMndEJ/p23L8vng4uA3Cs
 iXwZaTtEQFdAH3WMFENYmv5hkQBMFtI867KilwQYwURNkvaHI1NSmwqOk3rC4GdFMKgbubI
 ixGllbIHsNhxY1cfqb6N0NLf4JIG5ke++lHnx7LBE+btLnkw0NzqGYsbZ4tRlYiSrm3Lug/
 1W8r1BB3EysUwSeRGE6zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cAtAgkIHimU=:GAHb8SLqGq8CA8ucX02zTy
 H0wDVa7W9CbB24XnNRjzWHJIE2SgYXS2Ps9jFuYuQVjF2Z728do5TOojywz1glbu62YpYkepi
 f3XNNPeqlvFfn/bkBT9IBkdNeJFEcIVg54VNTGbIhqtltCr2bbxLa2FSswOMFP9j8CMUNQOCi
 3eRNu2QC20qyRcm0MaO5McNZ4hBnQU1Ri1zbIxGYr514CE4S+gf1TECvgR6Xku0c9xZG2MKt9
 3l3zT3o/+HpcE7Qo7vFEwU+UOSSVNmER5DqxjNoF0sU30zT9aL2yKXdMkawD9UCT5vsHa3c9w
 9mDIFRYBBUBHGDsHH5jsS4Mbaebm2Ll3UjLaKz3oQwlUYedyD1uNMpkBblm+EdgXliPlPag29
 MEGMuCM44uS0TylO2ZHadTY54cZk90s5QEoYI2NrEcjimNVoXuxLBAdssmjdIJwQZUTnZ/AdG
 Jsebd4ukpym+EB1hlkuAlsIxtVxP1ZcSZd38avnxd9Hu4f6ILj3NdwzqO+PyXL4xCBgo4sczA
 rTMqP/sRlEEU+DCcaS1PTGRXGsTpupk7NqswtheHKXRrlejTamXIB4ES4ldexv1cGojZ8iLJk
 9oe/VS7BtvSUSUaSIF0DN6B98tVQUeZRZuOdY8RyNLiItAtkxmopkzpHsAzEwqoGvUzMP7ntG
 NM1+E1OtUHqrl6OsiaLpc08eUQcbexiDXhaX4XIwKiVJ6VmmK3y1QHKEJIyYscD2ApZVS0stz
 /LAVYAzobkqoYykSA11yoPJtGdx+9E8YB9mnI5kGRc0iC/dr+/SMydN3OkMQxFRWJLYtHNAaz
 zjd8yAospFudzlZNpQ9bddoj5fMvq32kTyVve3MpQYZS7BIhI24Um6iIZ0LR/nMpMxXBOdr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Andreas Schwab <schwab@suse.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvmlfzaoh9p.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7aaa9d96397c..9fa722f2388d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2310,10 +2310,42 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         level = SOL_SOCKET;
         switch (optname) {
         /* These don't just return a single integer */
-        case TARGET_SO_RCVTIMEO:
-        case TARGET_SO_SNDTIMEO:
         case TARGET_SO_PEERNAME:
             goto unimplemented;
+        case TARGET_SO_RCVTIMEO: {
+            struct timeval tv;
+            socklen_t tvlen;
+
+            optname = SO_RCVTIMEO;
+
+get_timeout:
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+
+            tvlen = sizeof(tv);
+            ret = get_errno(getsockopt(sockfd, level, optname,
+                                       &tv, &tvlen));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len > sizeof(struct target_timeval)) {
+                len = sizeof(struct target_timeval);
+            }
+            if (copy_to_user_timeval(optval_addr, &tv)) {
+                return -TARGET_EFAULT;
+            }
+            if (put_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+        }
+        case TARGET_SO_SNDTIMEO:
+            optname = SO_SNDTIMEO;
+            goto get_timeout;
         case TARGET_SO_PEERCRED: {
             struct ucred cr;
             socklen_t crlen;
-- 
2.24.1


