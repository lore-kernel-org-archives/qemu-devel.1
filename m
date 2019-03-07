Received: from eggs.gnu.org ([209.51.188.92]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1wGu-0007cl-3l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1wGp-0005jl-Po
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:53:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  7 Mar 2019 17:53:03 +0100
Message-Id: <20190307165303.15382-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qcow2 spec: Describe string header extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Be more specific about the string representation in header extensions.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/interop/qcow2.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index bfb97cfde3..8c3098d8d9 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -170,11 +170,11 @@ be stored. Each extension has a structure like the =
following:
=20
     Byte  0 -  3:   Header extension type:
                         0x00000000 - End of the header extension area
-                        0xE2792ACA - Backing file format name
+                        0xE2792ACA - Backing file format name string
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
-                        0x44415441 - External data file name
+                        0x44415441 - External data file name string
                         other      - Unknown header extension, can be sa=
fely
                                      ignored
=20
@@ -196,6 +196,16 @@ data of compatible features that it doesn't support.=
 Compatible features that
 need space for additional data can use a header extension.
=20
=20
+=3D=3D String header extensions =3D=3D
+
+Some header extensions (such as the backing file format name and the ext=
ernal
+data file name) are just a single string. In this case, the header exten=
sion
+length is the string length and the string is not '\0' terminated. (The =
header
+extension padding can make it look like a string is '\0' terminated, but
+neither is padding always necessary nor is there a guarantee that zero b=
ytes
+are used for padding.)
+
+
 =3D=3D Feature name table =3D=3D
=20
 The feature name table is an optional header extension that contains the=
 name
--=20
2.20.1
