Received: from eggs.gnu.org ([2001:4830:134:3::10]:49977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LJ-00042V-Am
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LF-0006PU-AU
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44631 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LF-0006E4-2y
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:37 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:09 +0200
Message-Id: <1494586944-7253-2-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/16] linux-user: add strace for getuid(),
 gettid(), getppid(), geteuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Milos.Stojanovic@rt-rk.com

Improve strace support for syscalls getuid(), gettid(), getppid()
and geteuid(). Since these system calls don't have arguments, "%s()"
is added in the corresponding strace.list entry so that no arguments
are printed.

getuid:
Prior to this commit, typical strace output used to look like this:
4894 getuid(4894,0,0,274886293296,-3689348814741910323,4832615904) =3D 10=
00
After this commit, it looks like this:
4894 getuid() =3D 1000

gettid:
Prior to this commit, typical strace output used to look like this:
8307 gettid(0,0,64,0,4832630528,4832615840) =3D 8307
After this commit, it looks like this:
8307 gettid() =3D 8307

getppid:
Prior to this commit, typical strace output used to look like this:
20588 getppid(20588,64,0,4832630528,4832615888,0) =3D 20625
After this commit, it looks like this:
20588 getppid() =3D 20625

geteuid:
Prior to this commit, typical strace output used to look like this:
20588 geteuid(64,0,0,4832615888,0,-9151031864016699136) =3D 1000
After this commit, it looks like this:
20588 geteuid() =3D 1000

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/strace.list | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3b1282e..6e33788 100644
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
--=20
1.9.1
