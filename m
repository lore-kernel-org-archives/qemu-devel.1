Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dQImD-0003IX-Mj
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dQIm8-0000Bu-Po
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:37:25 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dQIm8-0000BP-Kl
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:37:20 -0400
Received: by mail-it0-x244.google.com with SMTP id v193so5547920itc.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 12:37:18 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Jun 2017 15:37:16 -0400
Message-Id: <F6C36C1A-4661-48F4-BEA6-3994889927D0@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: Fix compatibility issue with Mac
 OS 10.9 and under
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

The [NSEvent modifierFlags] method returns an NSEventModifierFlags type =
value in Mac OS 10.10. It use to be of type NSUInteger. Replacing =
NSEventModifierFlags with NSUInteger allows for the cooca.m file to be =
compiled on older versions of Mac OS. This patch was been tested on Mac =
OS 10.6 and Mac OS 10.12 without problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 9e81285..93e56d0 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -571,7 +571,7 @@ QemuCocoaView *cocoaView;
                 // bitmask.
=20
                 if (qemu_console_is_graphic(NULL)) {
-                    NSEventModifierFlags modifiers =3D [event =
modifierFlags];
+                    NSUInteger modifiers =3D [event modifierFlags];
=20
                     if (!!(modifiers & NSEventModifierFlagCapsLock) !=3D =
!!modifiers_state[Q_KEY_CODE_CAPS_LOCK]) {
                         [self =
toggleStatefulModifier:Q_KEY_CODE_CAPS_LOCK];
--=20
2.7.2
