Received: from eggs.gnu.org ([2001:4830:134:3::10]:38986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cN40S-0004cD-2B
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 15:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cN40P-00018J-0E
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 15:42:28 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cN40O-000189-RU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 15:42:24 -0500
Received: by mail-it0-x242.google.com with SMTP id b123so42614420itb.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 12:42:24 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Dec 2016 15:42:21 -0500
Message-Id: <0C9DA454-E3DC-4291-806E-9A96557DE833@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: add toast file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Add the ability for the user to use .toast files with QEMU. This format =
works
just like ISO files.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 26d4a1c..c81f7b6 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -879,7 +879,7 @@ QemuCocoaView *cocoaView;
         // set the supported image file types that can be opened
         supportedImageFileTypes =3D [NSArray arrayWithObjects: @"img", =
@"iso", @"dmg",
                                  @"qcow", @"qcow2", @"cloop", @"vmdk", =
@"cdr",
-                                  nil];
+                                  @"toast", nil];
         [self make_about_window];
     }
     return self;
--=20
2.7.2
