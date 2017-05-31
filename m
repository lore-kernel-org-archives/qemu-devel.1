Received: from eggs.gnu.org ([2001:4830:134:3::10]:36780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mj-0007Yh-Ep
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mh-0003eE-2D
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:45 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mg-0003e2-Rb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:43 -0400
Received: by mail-lf0-x235.google.com with SMTP id m18so8645909lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:42 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:19 +0300
Message-Id: <65424cc45696768442c684c1202d21b7f73f1156.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/15] linux-user: add strace for getuid(),
 gettid(), getppid(), geteuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Improve strace support for syscalls getuid(), gettid(), getppid()
and geteuid(). Since these system calls don't have arguments, "%s()"
is added in the corresponding strace.list entry so that no arguments
are printed.

getuid:
Prior to this commit, typical strace output used to look like this:
4894 getuid(4894,0,0,274886293296,-3689348814741910323,4832615904) = 1000
After this commit, it looks like this:
4894 getuid() = 1000

gettid:
Prior to this commit, typical strace output used to look like this:
8307 gettid(0,0,64,0,4832630528,4832615840) = 8307
After this commit, it looks like this:
8307 gettid() = 8307

getppid:
Prior to this commit, typical strace output used to look like this:
20588 getppid(20588,64,0,4832630528,4832615888,0) = 20625
After this commit, it looks like this:
20588 getppid() = 20625

geteuid:
Prior to this commit, typical strace output used to look like this:
20588 geteuid(64,0,0,4832615888,0,-9151031864016699136) = 1000
After this commit, it looks like this:
20588 geteuid() = 1000

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.list | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3b1282ec1a..6e33788a17 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -290,7 +290,7 @@
 { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_geteuid
-{ TARGET_NR_geteuid, "geteuid" , NULL, NULL, NULL },
+{ TARGET_NR_geteuid, "geteuid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_geteuid32
 { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
@@ -338,7 +338,7 @@
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getppid
-{ TARGET_NR_getppid, "getppid" , NULL, NULL, NULL },
+{ TARGET_NR_getppid, "getppid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getpriority
 { TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
@@ -381,13 +381,13 @@
   NULL, NULL },
 #endif
 #ifdef TARGET_NR_gettid
-{ TARGET_NR_gettid, "gettid" , NULL, NULL, NULL },
+{ TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_gettimeofday
 { TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getuid
-{ TARGET_NR_getuid, "getuid" , NULL, NULL, NULL },
+{ TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getuid32
 { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
-- 
2.11.0
