Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykC-0005qg-NQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWT-0005OC-Qv
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:52 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:30 +0100
Message-Id: <20181106102335.20027-2-kraxel@redhat.com>
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] move ObjectClass to typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/typedefs.h | 1 +
 include/qom/object.h    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3ec0e13a96..fed53f6de2 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -62,6 +62,7 @@ typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
 typedef struct NumaNodeMem NumaNodeMem;
+typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
 typedef struct PCIDevice PCIDevice;
diff --git a/include/qom/object.h b/include/qom/object.h
index f0b0bf39cc..499e1fd8b7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -20,7 +20,6 @@
 struct TypeImpl;
 typedef struct TypeImpl *Type;
 
-typedef struct ObjectClass ObjectClass;
 typedef struct Object Object;
 
 typedef struct TypeInfo TypeInfo;
-- 
2.9.3
