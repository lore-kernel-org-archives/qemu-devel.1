Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAB-0004gK-7l
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAA-0000Ao-9Z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAAA-00009U-3t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:26 -0300
Message-Id: <20180530230528.30166-11-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] qmp: permit query-hotpluggable-cpus in
 preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it will allow mgmt to query possible CPUs, which depends on
used machine(version)/-smp options, without restarting
QEMU and use results to configure numa mapping or adding
CPUs with device_add* later.

PS:
*) device_add is not allowed to run at preconfig in this series
   but later it could be dealt with by injecting -device
   in preconfig state and letting existing -device handling
   to actually plug devices

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1525423069-61903-10-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index bd6d1805ab..b155db2642 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3285,7 +3285,8 @@
 #    ]}
 #
 ##
-{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
+             'allow-preconfig': true }
 
 ##
 # @GuidInfo:
-- 
2.17.1
