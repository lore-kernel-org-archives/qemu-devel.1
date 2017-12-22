Received: from eggs.gnu.org ([2001:4830:134:3::10]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtJ-000824-Oc
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtH-000181-2k
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCtG-00017Y-SF
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:50 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:36 +0800
Message-Id: <1513908937-16034-18-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 17/18] qemu-doc: The "-net nic" option can be
 used with "netdev=...", too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Looks like we missed to document that it is also possible to specify
a netdev with "-net nic" - which is very useful if you want to
configure your on-board NIC to use a backend that has been specified
with "-netdev".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e2..9f4dd3a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2035,9 +2035,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev hubport,id=str,hubid=n\n"
     "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
-    "-net nic[,vlan=n][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
-    "                old way to create a new NIC and connect it to VLAN 'n'\n"
-    "                (use the '-device devtype,netdev=str' option if possible instead)\n"
+    "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
+    "                configure or create an on-board (or machine default) NIC and\n"
+    "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
+    "                NICs please use '-device devtype,netdev=nd' instead)\n"
     "-net dump[,vlan=n][,file=f][,len=n]\n"
     "                dump traffic on vlan 'n' to file 'f' (max n bytes per packet)\n"
     "-net none       use it alone to have zero network devices. If no -net option\n"
@@ -2058,10 +2059,11 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 STEXI
-@item -net nic[,vlan=@var{n}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
+@item -net nic[,vlan=@var{n}][,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
 @findex -net
-Create a new Network Interface Card and connect it to VLAN @var{n} (@var{n}
-= 0 is the default). The NIC is an e1000 by default on the PC
+Configure or create an on-board (or machine default) Network Interface Card
+(NIC) and connect it either to VLAN @var{n} (@var{n} = 0 is the default), or
+to the netdev @var{nd}. The NIC is an e1000 by default on the PC
 target. Optionally, the MAC address can be changed to @var{mac}, the
 device address set to @var{addr} (PCI cards only),
 and a @var{name} can be assigned for use in monitor commands.
-- 
2.7.4
