Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTpM1-0001Ja-Gb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTpLy-0003mi-8k
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:05:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 16:04:46 +0200
Message-Id: <20180615140448.32234-12-david@redhat.com>
In-Reply-To: <20180615140448.32234-1-david@redhat.com>
References: <20180615140448.32234-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/13] nvdimm: allow setting the label-size
 to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

It is inititally 0, so setting it to 0 should be allowed, too.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db7d8c3050..df7646488b 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -52,9 +52,9 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     if (local_err) {
         goto out;
     }
-    if (value < MIN_NAMESPACE_LABEL_SIZE) {
+    if (value && value < MIN_NAMESPACE_LABEL_SIZE) {
         error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
-                   " at least 0x%lx", object_get_typename(obj),
+                   " either 0 or at least 0x%lx", object_get_typename(obj),
                    name, value, MIN_NAMESPACE_LABEL_SIZE);
         goto out;
     }
-- 
2.17.1
