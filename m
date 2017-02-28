Received: from eggs.gnu.org ([2001:4830:134:3::10]:42957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibX1-0001o9-Lc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibWy-0003EA-Ka
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:44 +0300
Message-Id: <8dc52350f97ec7e2ce5d16c65021b5283f71b184.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/14] target/s390x: Fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/s390x/cpu_models.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 5b66d33..2a894ee 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -671,7 +671,7 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG enulates a z900 */
+        /* TCG emulates a z900 */
         max_model.def = &s390_cpu_defs[0];
         bitmap_copy(max_model.features, max_model.def->default_feat,
                     S390_FEAT_MAX);
-- 
2.1.4
