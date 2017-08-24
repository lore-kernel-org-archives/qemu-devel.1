Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqr0-0003yS-QD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqqw-0001yM-OH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkqqw-0001y2-IT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87F74552EB
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:03:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 14:02:57 +0200
Message-Id: <1503576178-23966-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1503576178-23966-1-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qapi-schema: Introspection doc is in the
 wrong section, fix
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

Bug: introspection documentation is in section "Tracing commands".

Cause: sub-schema qapi/introspect.json lacks a section header, and
therefore goes into whatever section precedes its include.

Fix: add a section header.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/introspect.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index cf77ff0..5b3e6e9 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,7 +1,5 @@
 # -*- Mode: Python -*-
 #
-# QAPI/QMP introspection
-#
 # Copyright (C) 2015 Red Hat, Inc.
 #
 # Authors:
@@ -11,6 +9,10 @@
 # See the COPYING file in the top-level directory.
 
 ##
+# = QMP introspection
+##
+
+##
 # @query-qmp-schema:
 #
 # Command query-qmp-schema exposes the QMP wire ABI as an array of
-- 
2.7.5
