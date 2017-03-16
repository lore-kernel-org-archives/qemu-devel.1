Received: from eggs.gnu.org ([2001:4830:134:3::10]:54865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtW-000690-Jv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00079V-84
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-00077a-RC
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B29AF81247
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ECCC5C541
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:57 +0100
Message-Id: <1489645685-4750-42-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 41/49] qapi: Drop unused variable events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Missed in commit e98859a

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-40-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1aaae8e..d5a113c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -49,7 +49,6 @@ name_case_whitelist = []
 enum_types = []
 struct_types = []
 union_types = []
-events = []
 all_names = {}
 
 #
@@ -756,14 +755,12 @@ def check_command(expr, info):
 
 
 def check_event(expr, info):
-    global events
     name = expr['event']
     boxed = expr.get('boxed', False)
 
     meta = ['struct']
     if boxed:
         meta += ['union', 'alternate']
-    events.append(name)
     check_type(info, "'data' for event '%s'" % name,
                expr.get('data'), allow_dict=not boxed, allow_optional=True,
                allow_metas=meta)
-- 
2.7.4
