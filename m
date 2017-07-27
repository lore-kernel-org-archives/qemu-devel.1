Received: from eggs.gnu.org ([2001:4830:134:3::10]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak9T-0003ET-VC
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak9Q-0004Ck-4Q
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:52:36 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dak9Q-0004CS-0F
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:52:32 -0400
Received: by mail-io0-x244.google.com with SMTP id f1so13286305ioj.2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:52:31 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <3893640A-C6CF-4B34-BC2D-FBBDE67B38C5@gmail.com>
Date: Thu, 27 Jul 2017 10:52:30 -0400
Subject: [Qemu-devel] [PATCH 2/2] Add more function keys to cocoa.m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Enable the Cocoa front-end to be able to use function keys F16 to F19.=20=


Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0..efbb6e6 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -225,6 +225,10 @@ const int mac_to_qkeycode_map[] =3D {
     [kVK_F13] =3D Q_KEY_CODE_PRINT,
     [kVK_F14] =3D Q_KEY_CODE_SCROLL_LOCK,
     [kVK_F15] =3D Q_KEY_CODE_PAUSE,
+    [kVK_F16] =3D Q_KEY_CODE_F16,
+    [kVK_F17] =3D Q_KEY_CODE_F17,
+    [kVK_F18] =3D Q_KEY_CODE_F18,
+    [kVK_F19] =3D Q_KEY_CODE_F19
=20
     /*
      * The eject and volume keys can't be used here because they are =
handled at
--=20
2.7.2
