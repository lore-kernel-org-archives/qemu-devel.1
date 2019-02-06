Received: from eggs.gnu.org ([209.51.188.92]:46153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlb-0004hH-VV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlZ-0001xD-WD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlX-0001qH-Sk
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D233DA048A
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:09 +0100
Message-Id: <20190206181725.14337-2-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/17] qapi: Belatedly document modular code
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

We generate code for built-ins and sub-modules into separate files
since commit cdb6610ae42 and 252dc3105fc (v2.12.0).  Both commits
neglected to update documentation.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 87183d3a09..b91bde647c 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1113,6 +1113,19 @@ Example:
 
 [Uninteresting stuff omitted...]
 
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-types-SUBMODULE.h
+SUBDIR/$(prefix)qapi-types-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+qapi-builtin-types.h - C types corresponding to built-in types
+
+qapi-builtin-types.c - Cleanup functions for the above C types
+
 === Code generated for visiting QAPI types ===
 
 These are the visitor functions used to walk through and convert
@@ -1244,6 +1257,19 @@ Example:
 
 [Uninteresting stuff omitted...]
 
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-visit-SUBMODULE.h
+SUBDIR/$(prefix)qapi-visit-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+qapi-builtin-visit.h - Visitor functions for built-in types
+
+qapi-builtin-visit.c - Declarations for these visitor functions
+
 === Code generated for commands ===
 
 These are the marshaling/dispatch functions for the commands defined
@@ -1342,6 +1368,12 @@ Example:
 
 [Uninteresting stuff omitted...]
 
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-commands-SUBMODULE.h
+SUBDIR/$(prefix)qapi-commands-SUBMODULE.c
+
 === Code generated for events ===
 
 This is the code related to events defined in the schema, providing
@@ -1402,6 +1434,12 @@ Example:
 
 [Uninteresting stuff omitted...]
 
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-events-SUBMODULE.h
+SUBDIR/$(prefix)qapi-events-SUBMODULE.c
+
 === Code generated for introspection ===
 
 The following files are created:
-- 
2.17.2
