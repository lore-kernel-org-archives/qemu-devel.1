Received: from eggs.gnu.org ([2001:4830:134:3::10]:40368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JV-0005go-VA
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JO-0004iW-9C
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1JO-0004hs-3Q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19D53C0587C6
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:01 +0200
Message-Id: <20171002140307.5292-3-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] qemu-options: Fix markup of -netdev l2tpv3
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
List-ID: <qemu-devel.nongnu.org>

The table of option parameters lacks @table and @end table.  The
parameters become items in the enclosing table of options.  Screwed up
when l2tpv3 was added in commit 3fb69aa.  Fix the obvious way.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 0fed2fc009..39f0e1b990 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2367,6 +2367,7 @@ two systems. It is present in routers, firewalls and the Linux kernel
 
 This transport allows a VM to communicate to another VM, router or firewall directly.
 
+@table @option
 @item src=@var{srcaddr}
     source address (mandatory)
 @item dst=@var{dstaddr}
@@ -2394,6 +2395,7 @@ draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
 networks which have packet reorder.
 @item offset=@var{offset}
     Add an extra offset between header and data
+@end table
 
 For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to the bridge br-lan
 on the remote Linux host 1.2.3.4:
-- 
2.13.6
