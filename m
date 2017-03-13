Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0007YP-V3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0003b4-DQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJl-0003Za-34
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:18 +0100
Message-Id: <1489385927-6735-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 18/47] qapi: Use raw strings for
 regular expressions consistently
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index c580e76..6d39ec9 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -550,7 +550,7 @@ def discriminator_find_enum_define(expr):
 # Names must be letters, numbers, -, and _.  They must start with letter,
 # except for downstream extensions which must start with __RFQDN_.
 # Dots are only valid in the downstream extension prefix.
-valid_name = re.compile('^(__[a-zA-Z0-9.-]+_)?'
+valid_name = re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
                         '[a-zA-Z][a-zA-Z0-9_-]*$')
 
 
@@ -1827,10 +1827,10 @@ def cgen(code, **kwds):
     if indent_level:
         indent = genindent(indent_level)
         # re.subn() lacks flags support before Python 2.7, use re.compile()
-        raw = re.subn(re.compile("^.", re.MULTILINE),
+        raw = re.subn(re.compile(r'^.', re.MULTILINE),
                       indent + r'\g<0>', raw)
         raw = raw[0]
-    return re.sub(re.escape(eatspace) + ' *', '', raw)
+    return re.sub(re.escape(eatspace) + r' *', '', raw)
 
 
 def mcgen(code, **kwds):
@@ -1964,7 +1964,7 @@ def parse_command_line(extra_options="", extra_long_options=[]):
     for oa in opts:
         o, a = oa
         if o in ("-p", "--prefix"):
-            match = re.match('([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
+            match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
             if match.end() != len(a):
                 print >>sys.stderr, \
                     "%s: 'funny character '%s' in argument of --prefix" \
-- 
2.7.4
