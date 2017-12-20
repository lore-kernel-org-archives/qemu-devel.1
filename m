Received: from eggs.gnu.org ([2001:4830:134:3::10]:35803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbB-0001N8-IR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZb8-0002Yu-R0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRZb8-0002Y0-KH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C721E80F79
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 09:19:19 +0100
Message-Id: <20171220081927.8761-3-armbru@redhat.com>
In-Reply-To: <20171220081927.8761-1-armbru@redhat.com>
References: <20171220081927.8761-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 02/10] qemu-options: Fix markup of -netdev
 l2tpv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The table of option parameters lacks @table and @end table.  The
parameters become items in the enclosing table of options.  Screwed up
when l2tpv3 was added in commit 3fb69aa.  Fix the obvious way.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7ac8ade9f9..66ec232879 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2377,6 +2377,7 @@ two systems. It is present in routers, firewalls an=
d the Linux kernel
=20
 This transport allows a VM to communicate to another VM, router or firew=
all directly.
=20
+@table @option
 @item src=3D@var{srcaddr}
     source address (mandatory)
 @item dst=3D@var{dstaddr}
@@ -2404,6 +2405,7 @@ draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
 networks which have packet reorder.
 @item offset=3D@var{offset}
     Add an extra offset between header and data
+@end table
=20
 For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to the br=
idge br-lan
 on the remote Linux host 1.2.3.4:
--=20
2.13.6
