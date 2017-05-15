Received: from eggs.gnu.org ([2001:4830:134:3::10]:37387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHWV-00011s-E5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHWQ-00052g-GK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:02:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45938 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHWQ-00050r-9T
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:02:54 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:45 +0200
Message-Id: <1494860396-24930-6-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/16] linux-user: fix argument type
 declaration of rt_sigqueinfo() syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

Change the type of the first argument of rt_sigqueinfo() from int to pid_=
t
in the syscall declaration to match specifications of the system call.

Proper spacing is added to satisfy checkpatch.pl.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff03e1a..9ec7ccd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -274,7 +274,7 @@ _syscall3(int, sys_getdents64, uint, fd, struct linux=
_dirent64 *, dirp, uint, co
 _syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
           loff_t *, res, uint, wh);
 #endif
-_syscall3(int,sys_rt_sigqueueinfo,int,pid,int,sig,siginfo_t *,uinfo)
+_syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, u=
info)
 _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
--=20
1.9.1
