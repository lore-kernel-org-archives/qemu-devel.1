Received: from eggs.gnu.org ([2001:4830:134:3::10]:38785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007yT-Pr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xn-UV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wc-Kz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:27 +0200
Message-Id: <20171002152552.27999-8-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 07/32] qapi: Drop superfluous
 allow_optional=True
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

check_command() passes allow_optional=True to check_type().  Useless
unless you also pass allow_dict=True, which check_command() doesn't.
Drop the superfluous argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..248af89b0b 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -695,7 +695,7 @@ def check_command(expr, info):
         returns_meta += ['built-in', 'alternate', 'enum']
     check_type(info, "'returns' for command '%s'" % name,
                expr.get('returns'), allow_array=True,
-               allow_optional=True, allow_metas=returns_meta)
+               allow_metas=returns_meta)
 
 
 def check_event(expr, info):
-- 
2.13.6
