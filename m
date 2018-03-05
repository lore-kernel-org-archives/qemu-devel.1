Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgY5-0006r5-7y
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgY4-0005Ps-7u
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1esgY4-0005Pb-3i
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:24 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  5 Mar 2018 11:11:58 +0800
Message-Id: <1520219524-17160-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] net: Only show vhost-user in the help text
 if CONFIG_POSIX is defined
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

According to net/Makefile.objs we only link in the vhost-user code
if CONFIG_POSIX has been set. So the help screen should also only
show this information if CONFIG_POSIX has been defined.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index fea949d..5781599 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1998,8 +1998,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                VALE port (created on the fly) called 'name' ('nmname' is name of the \n"
     "                netmap device, defaults to '/dev/netmap')\n"
 #endif
+#ifdef CONFIG_POSIX
     "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
+#endif
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
     "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
-- 
2.7.4
