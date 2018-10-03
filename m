Received: from eggs.gnu.org ([2001:4830:134:3::10]:41420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g7eqt-0007LD-2g
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g7efU-0001oW-67
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1g7efT-0001nn-PJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:46:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04D525F78E
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 10:46:10 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Wed,  3 Oct 2018 12:46:05 +0200
Message-Id: <20181003104605.8477-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words in
 CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

While at it, s/QMU/QEMU in @CpuDefinitionInfo.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 qapi/misc.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index ada9af5add..f98de3a58c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2017,7 +2017,7 @@
 #
 # @migration-safe: whether a CPU definition can be safely used for
 #                  migration in combination with a QEMU compatibility machine
-#                  when migrating between different QMU versions and between
+#                  when migrating between different QEMU versions and between
 #                  hosts with different sets of (hardware or software)
 #                  capabilities. If not provided, information is not available
 #                  and callers should not assume the CPU definition to be
@@ -2126,11 +2126,11 @@
 # @static: Expand to a static CPU model, a combination of a static base
 #          model name and property delta changes. As the static base model will
 #          never change, the expanded CPU model will be the same, independent of
-#          independent of QEMU version, machine type, machine options, and
-#          accelerator options. Therefore, the resulting model can be used by
-#          tooling without having to specify a compatibility machine - e.g. when
-#          displaying the "host" model. static CPU models are migration-safe.
-#
+#          QEMU version, machine type, machine options, and accelerator options.
+#          Therefore, the resulting model can be used by tooling without having
+#          to specify a compatibility machine - e.g. when displaying the "host"
+#          model. The @static CPU models are migration-safe.
+
 # @full: Expand all properties. The produced model is not guaranteed to be
 #        migration-safe, but allows tooling to get an insight and work with
 #        model details.
-- 
2.17.1
