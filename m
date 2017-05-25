Received: from eggs.gnu.org ([2001:4830:134:3::10]:55252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwc-0005ev-Td
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwb-0001Nb-PZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwb-0001Mk-Ho
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:05:08 +0200
Message-Id: <20170525210508.4910-27-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 26/26] target/s390x: update maximum TCG model
 to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Now that the extended-translation facility 2 has been fully implemented,
it's possible to emulated a most a z800 CPU with TCG.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363b07..9c4227d2dd 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -670,8 +670,8 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 */
-        max_model.def = &s390_cpu_defs[0];
+        /* TCG emulates at most a z800 */
+        max_model.def = &s390_cpu_defs[3];
         bitmap_copy(max_model.features, max_model.def->default_feat,
                     S390_FEAT_MAX);
     }
-- 
2.11.0
