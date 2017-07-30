Received: from eggs.gnu.org ([2001:4830:134:3::10]:35348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuqY-0004x0-Ib
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuqT-000651-HL
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:54 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dbuqT-00064D-DJ
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:49 -0400
Received: by mail-it0-x242.google.com with SMTP id t78so16526610ita.1
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 13:29:49 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <BAB68128-33C3-4160-87D1-116ABE087536@gmail.com>
Date: Sun, 30 Jul 2017 16:29:47 -0400
Subject: [Qemu-devel] [PATCH v2 2/2] Add more function keys to cocoa.m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Enable the Cocoa front-end to be able to use function keys F16 to F20.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0..edc7a65 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -225,6 +225,11 @@ const int mac_to_qkeycode_map[] =3D {
     [kVK_F13] =3D Q_KEY_CODE_PRINT,
     [kVK_F14] =3D Q_KEY_CODE_SCROLL_LOCK,
     [kVK_F15] =3D Q_KEY_CODE_PAUSE,
+    [kVK_F16] =3D Q_KEY_CODE_F16,
+    [kVK_F17] =3D Q_KEY_CODE_F17,
+    [kVK_F18] =3D Q_KEY_CODE_F18,
+    [kVK_F19] =3D Q_KEY_CODE_F19,
+    [kVK_F20] =3D Q_KEY_CODE_F20

     /*
      * The eject and volume keys can't be used here because they are =
handled at
--=20
2.7.2
