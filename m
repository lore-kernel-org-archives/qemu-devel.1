Received: from eggs.gnu.org ([2001:4830:134:3::10]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvquI-0002Zg-WA
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvquI-0007xi-07
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvquH-0007x6-Qh
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:47:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Apr 2017 14:47:31 -0500
Message-Id: <20170405194741.18956-4-eblake@redhat.com>
In-Reply-To: <20170405194741.18956-1-eblake@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/13] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

An upcoming Coccinelle cleanup script wanted to reformat the casts
present in this file - but on closer look, we don't need the casts
at all because C automatically converts void* to any other pointer.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1434d15..ce461cc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,

 static void qdict_add_disabled_feat(const char *name, void *opaque)
 {
-    qdict_put((QDict *) opaque, name, qbool_from_bool(false));
+    qdict_put(opaque, name, qbool_from_bool(false));
 }

 static void qdict_add_enabled_feat(const char *name, void *opaque)
 {
-    qdict_put((QDict *) opaque, name, qbool_from_bool(true));
+    qdict_put(opaque, name, qbool_from_bool(true));
 }

 /* convert S390CPUDef into a static CpuModelInfo */
-- 
2.9.3
