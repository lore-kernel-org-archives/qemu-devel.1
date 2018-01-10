Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMx5-0001Uz-Nu
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMx2-0001cc-0Y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZMx1-0001aN-Rn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 10 Jan 2018 20:25:52 +0000
Message-Id: <20180110202553.31889-3-stefanha@redhat.com>
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
References: <20180110202553.31889-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] tracetool: clarify that "formats" means
 "format strings"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The terminology used by tracetool is not consistent with C sprintf or
docs/devel/tracing.txt.  The word "formats" is sometimes used to mean
"format strings".

This patch clarifies comments and error messages that contain this word.

Note that the error message lines are longer than 80 characters but I
have not wrapped them to aid grepping.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index fbccaaa0cf..5db1f5c395 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -173,7 +173,7 @@ class Event(object):
         props : list of str
             Property names.
         fmt : str, list of str
-            Event printing format (or formats).
+            Event printing format string(s).
         args : Arguments
             Event arguments.
         orig : Event or None
@@ -237,9 +237,9 @@ class Event(object):
         if "tcg-exec" in props:
             raise ValueError("Invalid property 'tcg-exec'")
         if "tcg" not in props and not isinstance(fmt, str):
-            raise ValueError("Only events with 'tcg' property can have two formats")
+            raise ValueError("Only events with 'tcg' property can have two format strings")
         if "tcg" in props and isinstance(fmt, str):
-            raise ValueError("Events with 'tcg' property must have two formats")
+            raise ValueError("Events with 'tcg' property must have two format strings")
 
         event = Event(name, props, fmt, args)
 
@@ -263,7 +263,7 @@ class Event(object):
     _FMT = re.compile("(%[\d\.]*\w+|%.*PRI\S+)")
 
     def formats(self):
-        """List of argument print formats."""
+        """List conversion specifiers in the argument print format string."""
         assert not isinstance(self.fmt, list)
         return self._FMT.findall(self.fmt)
 
-- 
2.14.3
