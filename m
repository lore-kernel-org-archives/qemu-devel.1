Received: from eggs.gnu.org ([2001:4830:134:3::10]:51136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dFwrW-0006nE-9V
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dFwrT-0005RR-5t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:06 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1dFwrS-0005Qg-Uz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:03 -0400
Received: by mail-pf0-x241.google.com with SMTP id w69so1314003pfk.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 23:12:01 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 31 May 2017 16:11:50 +1000
Message-Id: <20170531061150.15755-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] help: Add newline to end of thread option help
 text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sjitindarsingh@gmail.com

The help text for the thread sub option of the accel option is missing
a newline at the end. This is annoying as it makes it hard to see the
help text for the next option.

Add the new line so that the following option help text (-smp) is
displayed on a new line rather on the same line and directly after
the thread help.

Before patch:

-accel [accel=]accelerator[,thread=single|multi]
                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)
                thread=single|multi (enable multi-threaded TCG)-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
                set the number of CPUs to 'n' [default=1]
                maxcpus= maximum number of total cpus, including
                offline CPUs for hotplug, etc
                cores= number of CPU cores on one socket
                threads= number of threads on one CPU core
                sockets= number of discrete sockets in the system

After patch:

-accel [accel=]accelerator[,thread=single|multi]
                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)
                thread=single|multi (enable multi-threaded TCG)
-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
                set the number of CPUs to 'n' [default=1]
                maxcpus= maximum number of total cpus, including
                offline CPUs for hotplug, etc
                cores= number of CPU cores on one socket
                threads= number of threads on one CPU core
                sockets= number of discrete sockets in the system

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index a6c9b9e..8515db8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -102,7 +102,7 @@ ETEXI
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
     "                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)\n"
-    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
+    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
-- 
2.9.4
