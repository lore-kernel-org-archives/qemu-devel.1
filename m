Received: from eggs.gnu.org ([2001:4830:134:3::10]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mo-0007dX-FY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mm-0003fV-KO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:50 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:33196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mm-0003fH-CC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:48 -0400
Received: by mail-lf0-x234.google.com with SMTP id m18so8647865lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:48 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:23 +0300
Message-Id: <c1a402a7ae9ba9c41b4ac7e7ca3e48e4d60eb35a.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/15] linux-user: fix argument type declaration
 of rt_sigqueinfo() syscall
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

Change the type of the first argument of rt_sigqueinfo() from int to pid_t
in the syscall declaration to match specifications of the system call.

Proper spacing is added to satisfy checkpatch.pl.

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index de85bce167..3373853bb9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -274,7 +274,7 @@ _syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, co
 _syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
           loff_t *, res, uint, wh);
 #endif
-_syscall3(int,sys_rt_sigqueueinfo,int,pid,int,sig,siginfo_t *,uinfo)
+_syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
 _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
-- 
2.11.0
