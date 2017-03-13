Received: from eggs.gnu.org ([2001:4830:134:3::10]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJr-0007bp-Mk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0003fj-9h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJn-0003de-0m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:39 +0100
Message-Id: <1489385927-6735-40-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 39/47] qapi: Drop unused variable events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Missed in commit e98859a

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 0da426a..12b1bda 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -49,7 +49,6 @@ name_case_whitelist = []
 enum_types = []
 struct_types = []
 union_types = []
-events = []
 all_names = {}
 
 #
@@ -751,14 +750,12 @@ def check_command(expr, info):
 
 
 def check_event(expr, info):
-    global events
     name = expr['event']
     boxed = expr.get('boxed', False)
 
     meta = ['struct']
     if boxed:
         meta += ['union', 'alternate']
-    events.append(name)
     check_type(info, "'data' for event '%s'" % name,
                expr.get('data'), allow_dict=not boxed, allow_optional=True,
                allow_metas=meta)
-- 
2.7.4
