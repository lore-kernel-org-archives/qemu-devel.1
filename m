Received: from eggs.gnu.org ([2001:4830:134:3::10]:56466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwO-00074n-QV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwN-0007jd-LK
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1foAwN-0007io-Ea
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:07 -0400
Received: by mail-wm0-x244.google.com with SMTP id o18-v6so2651756wmc.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Aug 2018 18:11:00 +0100
Message-Id: <20180810171102.16451-3-alex.bennee@linaro.org>
In-Reply-To: <20180810171102.16451-1-alex.bennee@linaro.org>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/3] qemu-seccomp: manually expand SCMP_A1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Otubo <otubo@redhat.com>

The expansion of ((struct scmp_arg_cmp){1, SCMP_CMP_NE, 5}) doesn't
work with -std=gnu99.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qemu-seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 9cd8eb9499..4dc1c22924 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -39,7 +39,7 @@ struct QemuSeccompSyscall {
 };
 
 const struct scmp_arg_cmp sched_setscheduler_arg[] = {
-    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
+    {1, SCMP_CMP_NE, SCHED_IDLE}
 };
 
 static const struct QemuSeccompSyscall blacklist[] = {
-- 
2.17.1
