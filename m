Received: from eggs.gnu.org ([2001:4830:134:3::10]:35100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXzC-00071U-QV
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXz9-0003w6-Mc
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:22 +0300
Message-Id: <f603164ae409d23e1fba012ded3b5dda33f9df5a.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 18/22] help: Add newline to end of thread option
 help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 10995dc932..30c4f9850f 100644
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
2.11.0
