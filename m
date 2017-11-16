Received: from eggs.gnu.org ([2001:4830:134:3::10]:38733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtS-0000B3-8s
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtN-0007Wm-JH
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJtN-0007WU-DZ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:41 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:56 +0800
Message-Id: <20171116130610.23582-14-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 13/27] qmp: introduce some capability helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Introduce qmp_cap_enabled() and qmp_oob_enabled() helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor.c b/monitor.c
index da03d1370f..655c25041c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1038,6 +1038,16 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
 }
 
+static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
+{
+    return mon->qmp.qmp_caps[cap];
+}
+
+static bool qmp_oob_enabled(Monitor *mon)
+{
+    return qmp_cap_enabled(mon, QMP_CAPABILITY_OOB);
+}
+
 static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
                            Error **errp)
 {
-- 
2.13.6
