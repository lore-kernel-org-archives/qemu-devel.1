Received: from eggs.gnu.org ([2001:4830:134:3::10]:54799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtU-00067r-9S
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00075Q-G9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-00072B-57
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D0ABC054916
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9D91627D9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:38 +0100
Message-Id: <1489645685-4750-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 22/49] qapi2texi: Plainer enum value and
 member name formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use @code{%s} instead of @code{'%s'}.  Impact, using @id as example:

* Texinfo
  -@item @code{'id'}
  +@item @code{id}

* HTML
  -<dt><code>'id'</code></dt>
  +<dt><code>id</code></dt>

* POD (for manual pages):
  -=item C<'id'>
  +=item C<id>

* Formatted manual pages:
  -'id'
  +"id"

* Plain text:
  -     ''id''
  +     'id'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-21-git-send-email-armbru@redhat.com>
---
 scripts/qapi2texi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 91cd593..ecfaeda 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -130,12 +130,12 @@ def texi_body(doc):
 
 def texi_enum_value(value):
     """Format a table of members item for an enumeration value"""
-    return "@item @code{'%s'}\n" % value.name
+    return '@item @code{%s}\n' % value.name
 
 
 def texi_member(member):
     """Format a table of members item for an object type member"""
-    return "@item @code{'%s'}%s\n" % (
+    return '@item @code{%s}%s\n' % (
         member.name, ' (optional)' if member.optional else '')
 
 
-- 
2.7.4
