Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWF0-0006yg-SW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEx-0002Zl-Po
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fEWEx-0002Yz-Lm
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F49F427095C
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:38:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  4 May 2018 10:37:47 +0200
Message-Id: <1525423069-61903-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/11] qmp: permit query-hotpluggable-cpus
 in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

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
v7:
  * s/allowed-in-preconfig/allow-preconfig/
---
 qapi/misc.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index eb7bc4c..12ae310 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3251,7 +3251,8 @@
 #    ]}
 #
 ##
-{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
+             'allow-preconfig': true }
 
 ##
 # @GuidInfo:
-- 
2.7.4
