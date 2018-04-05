Received: from eggs.gnu.org ([2001:4830:134:3::10]:59091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qn-0000oD-H1
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qm-0006XW-DG
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f40qm-0006XL-8P
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7A384023150
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 09:06:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Apr 2018 11:05:11 +0200
Message-Id: <1522919113-158775-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
References: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v5 09/11] qmp: permit
 query-hotpluggable-cpus in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

it will allow mgmt to query possible CPUs, which depends on
used machine(version)/-smp options, without restarting
QEMU and use results to configure numa mapping or adding
CPUs with device_add* later.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>

PS:
*) device_add is not allowed to run at preconfig in this series
   but later it could be dealt with by injecting -device
   in preconfig state and letting existing -device handling
   to actually plug devices
---
 qapi/misc.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 579900f..65cb56b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3228,7 +3228,8 @@
 #    ]}
 #
 ##
-{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
+             'allowed-in-preconfig': true }
 
 ##
 # @GuidInfo:
-- 
2.7.4
