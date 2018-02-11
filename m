Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3a-00070h-S7
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006KW-Tm
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006JW-JR
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:36:04 +0100
Message-Id: <20180211093607.27351-27-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 26/29] docs: Correct outdated information on
 QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

* Fix guidance on error classes

* Point to generated documentation

* Drop plea for documentation, because the QAPI code generator
  enforces it since commit 3313b6124b

* Minor tweaks here and there

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 25 +++++++++----------------
 docs/interop/qmp-intro.txt          |  3 ++-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 776b3b41ca..50385eff27 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -36,9 +36,9 @@ very simple and get more complex as we progress.
 For all the examples in the next sections, the test setup is the same and is
 shown here.
 
-First, QEMU should be started as:
+First, QEMU should be started like this:
 
-# /path/to/your/source/qemu [...] \
+# qemu-system-TARGET [...] \
     -chardev socket,id=qmp,port=4444,host=localhost,server \
     -mon chardev=qmp,mode=control,pretty=on
 
@@ -179,7 +179,7 @@ described in the "Testing" section and then send two commands:
     }
 }
 
-You should see "Hello, world" and "we love qemu" in the terminal running qemu,
+You should see "Hello, world" and "We love qemu" in the terminal running qemu,
 if you don't see these strings, then something went wrong.
 
 === Errors ===
@@ -221,30 +221,23 @@ The QMP server's response should be:
     }
 }
 
-As a general rule, all QMP errors should use ERROR_CLASS_GENERIC_ERROR
-(done by default when using error_setg()). There are two exceptions to
-this rule:
+Note that error_setg() produces a "GenericError" class.  In general,
+all QMP errors should have that error class.  There are two exceptions
+to this rule:
 
- 1. A non-generic ErrorClass value exists* for the failure you want to report
-    (eg. DeviceNotFound)
+ 1. To support a management application's need to recognize a specific
+    error for special handling
 
- 2. Management applications have to take special action on the failure you
-    want to report, hence you have to add a new ErrorClass value so that they
-    can check for it
+ 2. Backward compatibility
 
 If the failure you want to report falls into one of the two cases above,
 use error_set() with a second argument of an ErrorClass value.
 
- * All existing ErrorClass values are defined in the qapi-schema.json file
-
 === Command Documentation ===
 
 There's only one step missing to make "hello-world"'s implementation complete,
 and that's its documentation in the schema file.
 
-This is very important. No QMP command will be accepted in QEMU without proper
-documentation.
-
 There are many examples of such documentation in the schema file already, but
 here goes "hello-world"'s new entry for qapi/misc.json:
 
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index adbc94abb1..430fe1b747 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -78,7 +78,8 @@ Escape character is '^]'.
     }
 }
 
-Please, refer to the qapi-schema.json file for a complete command reference.
+Please refer to docs/interop/qemu-qmp-ref.* for a complete command
+reference, generated from qapi-schema.json.
 
 QMP wiki page
 -------------
-- 
2.13.6
