Received: from eggs.gnu.org ([2001:4830:134:3::10]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmM8-0005Q8-E0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmM7-0004po-AX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmM7-0004pJ-4j
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:03 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:14 -0200
Message-Id: <20181211180129.7661-10-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/24] move ObjectClass to typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20181106102335.20027-2-kraxel@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
=20
-typedef struct ObjectClass ObjectClass;
 typedef struct Object Object;
=20
 typedef struct TypeInfo TypeInfo;
--=20
2.18.0.rc1.1.g3f1ff2140
