Received: from eggs.gnu.org ([2001:4830:134:3::10]:56277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cXOTQ-0004Z7-8o
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 03:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cXOTN-0004SA-0K
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 03:35:04 -0500
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <af0a08ab-0d3d-3bc3-2f2f-6f5a25fa07df@weilnetz.de>
Date: Sat, 28 Jan 2017 09:34:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] target/s390x: Fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Stefan Weil <sw@weilnetz.de>
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
