Received: from eggs.gnu.org ([209.51.188.92]:55444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIsS-0000RJ-Q5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIsP-00045m-SO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guIsK-0003p3-5L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:24:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4606B89AD1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:24:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
Date: Thu, 14 Feb 2019 16:24:19 +0100
In-Reply-To: <20190214152251.2073-1-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 14 Feb 2019 16:22:33 +0100")
Message-ID: <87h8d65r6k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 00/18] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Diff from v4:

diff --git a/Makefile.objs b/Makefile.objs
index 95150d7173..5fb022d7ad 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,8 +79,8 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-commands-%.o)
 common-obj-y += qmp.o hmp.o
+common-obj-y += qapi/
 endif
 
 #######################################################################
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 654321de94..87e4df1660 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -18,8 +18,9 @@ util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-visit-%.o)
 util-obj-y += qapi-emit-events.o
 util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-events-%.o)
 
-common-obj-y += $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
+common-obj-y = $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
 
+obj-y = qapi-introspect.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
 obj-y += qapi-types.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-visit-%.o)
@@ -28,4 +29,3 @@ obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
 obj-y += qapi-events.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
 obj-y += qapi-commands.o
-obj-y += qapi-introspect.o
