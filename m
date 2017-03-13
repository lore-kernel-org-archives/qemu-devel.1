Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJu-0007d2-8u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0003g1-CP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJn-0003e0-21
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:46 +0100
Message-Id: <1489385927-6735-47-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 46/47] qapi: Make pylint a bit happier
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
 scripts/qapi-commands.py | 6 +++---
 scripts/qapi-visit.py    | 1 -
 scripts/qapi.py          | 8 ++++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 0c05449..1943de4 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -13,7 +13,6 @@
 # See the COPYING file in the top-level directory.
 
 from qapi import *
-import re
 
 
 def gen_command_decl(name, arg_type, boxed, ret_type):
@@ -84,7 +83,8 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
 
 
 def gen_marshal_proto(name):
-    return 'void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp)' % c_name(name)
+    return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp)'
+            % c_name(name))
 
 
 def gen_marshal_decl(name):
@@ -198,7 +198,7 @@ def gen_register_command(name, success_response):
         options = 'QCO_NO_SUCCESS_RESP'
 
     ret = mcgen('''
-    qmp_register_command(cmds, "%(name)s", 
+    qmp_register_command(cmds, "%(name)s",
                          qmp_marshal_%(c_name)s, %(opts)s);
 ''',
                 name=name, c_name=c_name(name),
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 3d3936e..5737aef 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -13,7 +13,6 @@
 # See the COPYING file in the top-level directory.
 
 from qapi import *
-import re
 
 
 def gen_visit_decl(name, scalar=False):
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 4102011..a4bf1ea 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -11,13 +11,13 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-import re
-from ordereddict import OrderedDict
 import errno
 import getopt
 import os
-import sys
+import re
 import string
+import sys
+from ordereddict import OrderedDict
 
 builtin_types = {
     'str':      'QTYPE_QSTRING',
@@ -1582,7 +1582,7 @@ class QAPISchema(object):
         tag_member = None
         if isinstance(base, dict):
             base = (self._make_implicit_object_type(
-                    name, info, doc, 'base', self._make_members(base, info)))
+                name, info, doc, 'base', self._make_members(base, info)))
         if tag_name:
             variants = [self._make_variant(key, value)
                         for (key, value) in data.iteritems()]
-- 
2.7.4
