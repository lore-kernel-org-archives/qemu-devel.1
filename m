Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4279920880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="XttQbDvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4279920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJv6-0007mk-Gp
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 22:22:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJtq-00071c-II
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJiP-0007GN-V2
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:08:55 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:48845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hDJiP-0007GG-KG
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1554689332; bh=ArZirZ/SF4WVURkjIPI0YNRGE8nclaJXXRV1EOJLhqU=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=XttQbDvclfphq3UWzdSFyP1KpMTiGKVajnv5Ju+v5ChA0OB8rseuobkO5LOFPvVjF
	7AowGq4lEGECyLhtNzbkv0onQLBvaDdNfb19/yAyYhbmQPbAnEJcSRVEiTYm++AmSM
	Twnqyc71/YMciXa2TBMcZAVuj98kyDZb1SHYwPtxFdo3ooQVW7UlZRZBA3iSFUDPIk
	ZmtxPX8lofKxCWyzNN9aJpTgMu5Ckgv5Hs+7nq5hMzxZ9LXpTZmphUyQeUb+aWqZiX
	c3779YQ3fsA4Jhb8kbYCIJHlbEOUCl/qUg+pE0vHc6kwct4spJi5Ka4StRxGfNmpCr
	+Y1a76v4iVe4g==
Received: from [172.18.2.102] (unknown [36.106.167.87])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 0AC506400FF; 
	Mon,  8 Apr 2019 02:08:50 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Date: Mon, 8 Apr 2019 10:08:42 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C11CC168-C5E7-4537-BC0B-03D2B1058057@me.com>
References: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-08_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904080018
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.40
Subject: [Qemu-devel] [PATCH 1/2] ui/cocoa: Fix absolute input device
 grabbing issue on
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408020842.vtPanQfUdfOJN_90PurU_vHpUNx3A7NyEo2CiLLTvpE@z>

This patches fixed boundary check methods for cursor in normal and
fullscreen modes with/without Zoom-to-Fit on Mojave.

On Mojave, absolute input device, i.e. tablet, had trouble re-grabbing
the cursor in re-entry into the virtual screen area. In some cases,
the `window` property of NSEvent object was nil after exit of cursor,
meaning that the `-locationInWindow` method would return value in screen
coordinates. The current implementation used raw locations frrom NSEvent
without considering whether the value was for the window coordinates or
the macOS screen coordinates, nor the zooming factor for Zoom-to-Fit in
fullscreen mode.

In fullscreen mode, the fullscreen cocoa window might not be the key
window, therefore the location of event in virtual coordinates should
suffice.

Note: CGRect, -convertRectToScreen: and -convertRectFromScreen: were
used in coordinates conversion for compatibility reason.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 ui/cocoa.m | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 420b2411c1..474d44cb9f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -405,6 +405,41 @@ QemuCocoaView *cocoaView;
     return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < =
screen.height);
 }
=20
+/* Get location of event and convert to virtual screen coordinate */
+- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
+{
+    NSWindow *eventWindow =3D [ev window];
+    // XXX: Use CGRect and -convertRectFromScreen: to support macOS =
10.10
+    CGRect r =3D CGRectZero;
+    r.origin =3D [ev locationInWindow];
+    if (!eventWindow) {
+        if (!isFullscreen) {
+            return [[self window] convertRectFromScreen:r].origin;
+        } else {
+            CGPoint locationInSelfWindow =3D [[self window] =
convertRectFromScreen:r].origin;
+            CGPoint loc =3D [self convertPoint:locationInSelfWindow =
fromView:nil];
+            if (stretch_video) {
+                loc.x /=3D cdx;
+                loc.y /=3D cdy;
+            }
+            return loc;
+        }
+    } else if ([[self window] isEqual:eventWindow]) {
+        if (!isFullscreen) {
+            return r.origin;
+        } else {
+            CGPoint loc =3D [self convertPoint:r.origin fromView:nil];
+            if (stretch_video) {
+                loc.x /=3D cdx;
+                loc.y /=3D cdy;
+            }
+            return loc;
+        }
+    } else {
+        return [[self window] convertRectFromScreen:[eventWindow =
convertRectToScreen:r]].origin;
+    }
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -704,7 +739,8 @@ QemuCocoaView *cocoaView;
     int keycode =3D 0;
     bool mouse_event =3D false;
     static bool switched_to_fullscreen =3D false;
-    NSPoint p =3D [event locationInWindow];
+    // Location of event in virtual screen coordinates
+    NSPoint p =3D [self screenLocationOfEvent:event];
=20
     switch ([event type]) {
         case NSEventTypeFlagsChanged:
@@ -815,7 +851,10 @@ QemuCocoaView *cocoaView;
             break;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
-                if (![self screenContainsPoint:p] || ![[self window] =
isKeyWindow]) {
+                // Cursor re-entered into a window might generate =
events bound to screen coordinates
+                // and `nil` window property, and in full screen mode, =
current window might not be
+                // key window, where event location alone should =
suffice.
+                if (![self screenContainsPoint:p] || !([[self window] =
isKeyWindow] || isFullscreen)) {
                     if (isMouseGrabbed) {
                         [self ungrabMouse];
                     }
--=20
2.19.2


