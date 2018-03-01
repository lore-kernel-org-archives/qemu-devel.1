Received: from eggs.gnu.org ([2001:4830:134:3::10]:40987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7f-0001b1-R4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7d-0000IX-U4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7d-0000Hr-OW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F416049026
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:44:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:41 -0600
Message-Id: <20180301194245.29854-27-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/30] docs/devel/writing-qmp-commands: Update
 for modular QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

With modular code generation, putting stuff right into
qapi-schema.json is a bad idea.  Update writing-qmp-commands.txt
accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-26-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 4f5b24c0c4c..776b3b41ca0 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -15,8 +15,8 @@ start with docs/interop/qmp-intro.txt.
 Generally speaking, the following steps should be taken in order to writ=
e a
 new QMP command.

-1. Write the command's and type(s) specification in the QAPI schema file
-   (qapi-schema.json in the root source directory)
+1. Define the command and any types it needs in the appropriate QAPI
+   schema module.

 2. Write the QMP command itself, which is a regular C function. Preferab=
ly,
    the command should be exported by some QEMU subsystem. But it can als=
o be
@@ -88,8 +88,9 @@ command carries some meaningful action in QEMU but here=
 it will just print
 Our command will be called "hello-world". It takes no arguments, nor doe=
s it
 return any data.

-The first step is to add the following line to the bottom of the
-qapi-schema.json file:
+The first step is defining the command in the appropriate QAPI schema
+module.  We pick module qapi/misc.json, and add the following line at
+the bottom:

 { 'command': 'hello-world' }

@@ -245,7 +246,7 @@ This is very important. No QMP command will be accept=
ed in QEMU without proper
 documentation.

 There are many examples of such documentation in the schema file already=
, but
-here goes "hello-world"'s new entry for the qapi-schema.json file:
+here goes "hello-world"'s new entry for qapi/misc.json:

 ##
 # @hello-world
@@ -425,8 +426,7 @@ There are a number of things to be noticed:
    allocated by the implementation. This is so because the QAPI also gen=
erates
    a function to free its types and it cannot distinguish between dynami=
cally
    or statically allocated strings
-6. You have to include the "qmp-commands.h" header file in qemu-timer.c,
-   otherwise qemu won't build
+6. You have to include "qapi/qmp-commands-misc.h" in qemu-timer.c

 Time to test the new command. Build qemu, run it as described in the "Te=
sting"
 section and try this:
--=20
2.14.3
