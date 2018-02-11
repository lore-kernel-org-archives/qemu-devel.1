Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3a-00070c-J5
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006KI-Ov
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006JL-J2
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:36:03 +0100
Message-Id: <20180211093607.27351-26-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 25/29] docs/devel/writing-qmp-commands:
 Update for modular QAPI
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

With modular code generation, putting stuff right into
qapi-schema.json is a bad idea.  Update writing-qmp-commands.txt
accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 4f5b24c0c4..776b3b41ca 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -15,8 +15,8 @@ start with docs/interop/qmp-intro.txt.
 Generally speaking, the following steps should be taken in order to write a
 new QMP command.
 
-1. Write the command's and type(s) specification in the QAPI schema file
-   (qapi-schema.json in the root source directory)
+1. Define the command and any types it needs in the appropriate QAPI
+   schema module.
 
 2. Write the QMP command itself, which is a regular C function. Preferably,
    the command should be exported by some QEMU subsystem. But it can also be
@@ -88,8 +88,9 @@ command carries some meaningful action in QEMU but here it will just print
 Our command will be called "hello-world". It takes no arguments, nor does it
 return any data.
 
-The first step is to add the following line to the bottom of the
-qapi-schema.json file:
+The first step is defining the command in the appropriate QAPI schema
+module.  We pick module qapi/misc.json, and add the following line at
+the bottom:
 
 { 'command': 'hello-world' }
 
@@ -245,7 +246,7 @@ This is very important. No QMP command will be accepted in QEMU without proper
 documentation.
 
 There are many examples of such documentation in the schema file already, but
-here goes "hello-world"'s new entry for the qapi-schema.json file:
+here goes "hello-world"'s new entry for qapi/misc.json:
 
 ##
 # @hello-world
@@ -425,8 +426,7 @@ There are a number of things to be noticed:
    allocated by the implementation. This is so because the QAPI also generates
    a function to free its types and it cannot distinguish between dynamically
    or statically allocated strings
-6. You have to include the "qmp-commands.h" header file in qemu-timer.c,
-   otherwise qemu won't build
+6. You have to include "qapi/qmp-commands-misc.h" in qemu-timer.c
 
 Time to test the new command. Build qemu, run it as described in the "Testing"
 section and try this:
-- 
2.13.6
