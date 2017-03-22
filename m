Received: from eggs.gnu.org ([2001:4830:134:3::10]:37152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilp-0006Xa-DZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqill-0001jl-1a
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqilk-0001iN-H5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B47E63336
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 542E0800CC
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:36 +0100
Message-Id: <1490198748-4753-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 05/17] MAINTAINERS: Add myself for files
 I touched recently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490014548-15083-6-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 779c429..c60235e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,15 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: backends/baum.c
 
+Command line option argument parsing
+M: Markus Armbruster <armbru@redhat.com>
+S: Supported
+F: include/qemu/option.h
+F: tests/test-keyval.c
+F: tests/test-qemu-opts.c
+F: util/keyval.c
+F: util/qemu-option.c
+
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
@@ -1365,7 +1374,9 @@ X: include/qapi/qmp/
 F: include/qapi/qmp/dispatch.h
 F: tests/qapi-schema/
 F: tests/test-*-visitor.c
+F: tests/test-qapi-*.c
 F: tests/test-qmp-*.c
+F: tests/test-visitor-serialization.c
 F: scripts/qapi*
 F: docs/qapi*
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
-- 
2.7.4
