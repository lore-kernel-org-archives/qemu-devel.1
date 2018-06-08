Received: from eggs.gnu.org ([2001:4830:134:3::10]:56708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRH8Q-0005Uf-Ac
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRH8O-0006hJ-8S
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fRH8O-0006h2-3x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAFBE818BAED
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 13:08:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Jun 2018 14:08:43 +0100
Message-Id: <20180608130846.22234-5-dgilbert@redhat.com>
In-Reply-To: <20180608130846.22234-1-dgilbert@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] qmp: enable
 query-[chardev|version|name|uuid|iothreads|memdev] commands in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: Igor Mammedov <imammedo@redhat.com>

subj commands, are informational and do not depend on machine being
initialized. Make them available early in preconfig runstate to make
the later a little bit more useful.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qapi/char.json |  3 ++-
 qapi/misc.json | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index ae19dcd1ed..60f31d83fc 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -62,7 +62,8 @@
 #    }
 #
 ##
-{ 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
+{ 'command': 'query-chardev', 'returns': ['ChardevInfo'],
+  'allow-preconfig': true }
 
 ##
 # @ChardevBackendInfo:
diff --git a/qapi/misc.json b/qapi/misc.json
index f83a63a0ab..1be1728c0e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,7 +117,8 @@
 #    }
 #
 ##
-{ 'command': 'query-version', 'returns': 'VersionInfo' }
+{ 'command': 'query-version', 'returns': 'VersionInfo',
+  'allow-preconfig': true }
 
 ##
 # @CommandInfo:
@@ -241,7 +242,7 @@
 # <- { "return": { "name": "qemu-name" } }
 #
 ##
-{ 'command': 'query-name', 'returns': 'NameInfo' }
+{ 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
 ##
 # @KvmInfo:
@@ -301,7 +302,7 @@
 # <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
 #
 ##
-{ 'command': 'query-uuid', 'returns': 'UuidInfo' }
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
 
 ##
 # @EventInfo:
@@ -710,7 +711,8 @@
 #    }
 #
 ##
-{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
+{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
+  'allow-preconfig': true }
 
 ##
 # @BalloonInfo:
@@ -2902,7 +2904,7 @@
 #    }
 #
 ##
-{ 'command': 'query-memdev', 'returns': ['Memdev'] }
+{ 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
 
 ##
 # @PCDIMMDeviceInfo:
-- 
2.17.0
