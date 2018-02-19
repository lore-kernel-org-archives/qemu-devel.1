Received: from eggs.gnu.org ([2001:4830:134:3::10]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhXx-0000oq-8P
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhXw-0002wQ-8V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1enhXw-0002wI-3y
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9221EAE83
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:15:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 10:15:23 +0100
Message-Id: <1519031728-9850-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1519031728-9850-1-git-send-email-thuth@redhat.com>
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/8] net: Only show vhost-user in the help
 text if CONFIG_POSIX is defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

According to net/Makefile.objs we only link in the vhost-user code
if CONFIG_POSIX has been set. So the help screen should also only
show this information if CONFIG_POSIX has been defined.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5050a49..b81b53b 100644
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
1.8.3.1
