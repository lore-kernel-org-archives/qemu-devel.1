Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F5C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753C32186A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C32186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrwW-0007ks-OX
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:55:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTrvk-0007DA-SA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTrvj-000455-EP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:55:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTrvj-00044S-59
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:55:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MORN0-1hH7OV01YU-00PwkK; Thu, 23 May 2019 19:54:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 19:54:13 +0200
Message-Id: <20190523175413.14448-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SLwN8cRc5Nl8DSKyHNnXjJHJSabtIj4F3VwCbnhOE3/uZmfVLWY
	isucfvQefJPt8jerEzgXTXdTvf8kZ/pbC7miQyutJPy6MStiYFs4P2tNaLZXYc/0DzmPorW
	S5DVKZANJpsAT4pUwFmFH8/QYdO6pTmohYgguEtvtITBWCKeA8w+ZuMSbs0GAPg5x9tRRm9
	shfJagnWZeqE2MkVVznRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nI17I7pbAWg=:btWKmcssONsqhBjqZxjAe0
	gTjFseiCVcXfRu1fzfI1JQUMXT/tCKbQ4WlTs8TWxvHpwOipn3SI40TM1ul3J6IL4y4Tj/XJG
	7GYUHedChAAHTz7nNs4ynU9XpULvPkJRtqFuL0mkJv854s7okD+Vbd/CKqhUKzlzAK846brB7
	/UR5DkSnUhmrqnjfy5ku4nYb9Pp+GaZJRlFNJMlk+aZRjsn1jBnrgsclbEh5FOaKf0gxNbRPf
	11D2X+IetwbfuWMOhb4F29qI7JOR07SgiMDOxb9n1bIeQ+XPnlJi3mmV0/Mi/GqlNwrNdWmXg
	RNmjSS9jdKF+Lh0obEmtbM5cbmv05NpVx7iEmmCb2/xIJjM0AYEfkTW9Ua0CXY442HX2q1vqg
	PW+CzzXXVPyeWqCN3JW6pVkNhurmIlryKcKyyKtuynz2JtdzQG9Yb2TXhaJgzMhkD8WTTZ0+3
	QuIcj0JLAqPG31Ytqg9PR3YxUw4ph4kmnaiPHQ904nYyMQiACSO3TFA//d4Kl5XD3IiaS8e+d
	XcJlqq1AZvk+Y4geDaH/wNLOFSOvKOB0QfAYC50GKqjwaee5wltU+RsKTfPk6pF00l+gCqreb
	Pb2tiIEWFEZ3f5eq7WPJ1b51tIgOEDKACb/6YuOkQE21l2oAnWBEv+8EkqO7njggSBelQzJ5Y
	/Za8Mu0M4UDLQ/R93fVM69U0w3CtCTtGVvOdPxZd2xRcy0eTTG0JZvrNwgXF2FdC6MlBqBXEi
	w9mvhZUKl1eTBAY7nnG2kKUARwpNftBvy4i9D7Rna4N/6teoru0Z6UNmdco=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
defined if __NR_msgsnd is defined.

But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
__NR_semtimedop and it breaks the QEMU build.

__NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n32.h
but not in asm-mips/unistd_o32.h.

Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimedop.
It introduces __NR_semtimedop_time64 instead.

This patch fixes the problem by checking for each __NR_XXX symbol
before defining the corresponding syscall.

Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e311fcda0517..d316de25c9f2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -761,14 +761,7 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
-#ifdef __NR_msgsnd
-safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
-              int, flags)
-safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
-              long, msgtype, int, flags)
-safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
-              unsigned, nsops, const struct timespec *, timeout)
-#else
+#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semtimedop)
 /* This host kernel architecture uses a single ipc syscall; fake up
  * wrappers for the sub-operations to hide this implementation detail.
  * Annoyingly we can't include linux/ipc.h to get the constant definitions
@@ -783,14 +776,29 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
 
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
               void *, ptr, long, fifth)
+#endif
+#ifdef __NR_msgsnd
+safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
+              int, flags)
+#else
 static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
 {
     return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
 }
+#endif
+#ifdef __NR_msgrcv
+safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
+              long, msgtype, int, flags)
+#else
 static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
 {
     return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
 }
+#endif
+#ifdef __NR_semtimedop
+safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
+              unsigned, nsops, const struct timespec *, timeout)
+#else
 static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
                            const struct timespec *timeout)
 {
-- 
2.20.1


