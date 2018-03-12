Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFv-0007Lg-JA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFr-0005VN-ME
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFr-0005Uj-IR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:13 +0100
Message-Id: <1520860275-101576-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/9] qmp: permit query-hotpluggable-cpus in
 preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

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
index 1f48d35..691c980 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3196,7 +3196,8 @@
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
