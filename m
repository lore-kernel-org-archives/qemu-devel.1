Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFBC3B188
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A1420724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf2kTTVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A1420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1unL-0001x2-L4
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uiz-0001jI-Ic
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004bj-8M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004bK-4B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsaMdrjcS7LqXtKeEfDdHdZ8jJXJz/XwFMk+kk69oL8=;
 b=Bf2kTTVaZZd1SoQL4C4H9v/Yy89g+/EPqD9Qc8+nde3Jocqz+6Sef/6fjD7vkyroOTWSax
 v7WEnRZHK2WNo3tWW2uCTUQAuasgFlpz+zufzc8rWrMi+WfRMnV1MRHdF5w+9HtJXVzH0N
 vTrklbDnEyYu2fu/6bNcXEBzlO8/mCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-FpTATBr4MIiseDS8E5HboQ-1; Wed, 12 Feb 2020 11:18:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09139101FC73;
 Wed, 12 Feb 2020 16:18:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9E65C3F8;
 Wed, 12 Feb 2020 16:18:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2CE7A31EEA; Wed, 12 Feb 2020 17:18:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] ui/cocoa: Drop workarounds for pre-10.12 OSX
Date: Wed, 12 Feb 2020 17:18:35 +0100
Message-Id: <20200212161835.28576-11-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FpTATBr4MIiseDS8E5HboQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Our official OSX support policy covers the last two released versions.
Currently that is 10.14 and 10.15.  We also may work on older versions, but
don't guarantee it.

In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
versions (see LP:1861551). We don't intend to fix that, so we might
as well drop the code in ui/cocoa.m which caters for pre-10.12
versions as well. (For reference, 10.11 fell out of Apple extended
security support in September 2018.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200201170534.22123-1-peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/cocoa.m | 59 ------------------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index f7b323044582..747a70839af8 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -42,60 +42,10 @@
 #include <Carbon/Carbon.h>
 #include "hw/core/cpu.h"
=20
-#ifndef MAC_OS_X_VERSION_10_5
-#define MAC_OS_X_VERSION_10_5 1050
-#endif
-#ifndef MAC_OS_X_VERSION_10_6
-#define MAC_OS_X_VERSION_10_6 1060
-#endif
-#ifndef MAC_OS_X_VERSION_10_9
-#define MAC_OS_X_VERSION_10_9 1090
-#endif
-#ifndef MAC_OS_X_VERSION_10_10
-#define MAC_OS_X_VERSION_10_10 101000
-#endif
-#ifndef MAC_OS_X_VERSION_10_12
-#define MAC_OS_X_VERSION_10_12 101200
-#endif
 #ifndef MAC_OS_X_VERSION_10_13
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
=20
-/* macOS 10.12 deprecated many constants, #define the new names for older =
SDKs */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
-#define NSEventMaskAny                  NSAnyEventMask
-#define NSEventModifierFlagCapsLock     NSAlphaShiftKeyMask
-#define NSEventModifierFlagShift        NSShiftKeyMask
-#define NSEventModifierFlagCommand      NSCommandKeyMask
-#define NSEventModifierFlagControl      NSControlKeyMask
-#define NSEventModifierFlagOption       NSAlternateKeyMask
-#define NSEventTypeFlagsChanged         NSFlagsChanged
-#define NSEventTypeKeyUp                NSKeyUp
-#define NSEventTypeKeyDown              NSKeyDown
-#define NSEventTypeMouseMoved           NSMouseMoved
-#define NSEventTypeLeftMouseDown        NSLeftMouseDown
-#define NSEventTypeRightMouseDown       NSRightMouseDown
-#define NSEventTypeOtherMouseDown       NSOtherMouseDown
-#define NSEventTypeLeftMouseDragged     NSLeftMouseDragged
-#define NSEventTypeRightMouseDragged    NSRightMouseDragged
-#define NSEventTypeOtherMouseDragged    NSOtherMouseDragged
-#define NSEventTypeLeftMouseUp          NSLeftMouseUp
-#define NSEventTypeRightMouseUp         NSRightMouseUp
-#define NSEventTypeOtherMouseUp         NSOtherMouseUp
-#define NSEventTypeScrollWheel          NSScrollWheel
-#define NSTextAlignmentCenter           NSCenterTextAlignment
-#define NSWindowStyleMaskBorderless     NSBorderlessWindowMask
-#define NSWindowStyleMaskClosable       NSClosableWindowMask
-#define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
-#define NSWindowStyleMaskTitled         NSTitledWindowMask
-#endif
-/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
- * NSModalResponseOK, which was introduced in 10.9. Define
- * it for older versions.
- */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
-#define NSModalResponseOK NSFileHandlingPanelOKButton
-#endif
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -466,11 +416,7 @@ QemuCocoaView *cocoaView;
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
=20
     // get CoreGraphic context
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10
-    CGContextRef viewContextRef =3D [[NSGraphicsContext currentContext] gr=
aphicsPort];
-#else
     CGContextRef viewContextRef =3D [[NSGraphicsContext currentContext] CG=
Context];
-#endif
=20
     CGContextSetInterpolationQuality (viewContextRef, kCGInterpolationNone=
);
     CGContextSetShouldAntialias (viewContextRef, NO);
@@ -1076,9 +1022,7 @@ QemuCocoaView *cocoaView;
  ------------------------------------------------------
 */
 @interface QemuCocoaAppController : NSObject
-#if (MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_X_VERSION_10_6)
                                        <NSWindowDelegate, NSApplicationDel=
egate>
-#endif
 {
 }
 - (void)doToggleFullScreen:(id)sender;
@@ -1127,9 +1071,6 @@ QemuCocoaView *cocoaView;
         [normalWindow setAcceptsMouseMovedEvents:YES];
         [normalWindow setTitle:@"QEMU"];
         [normalWindow setContentView:cocoaView];
-#if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10)
-        [normalWindow useOptimizedDrawing:YES];
-#endif
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
         [normalWindow setDelegate: self];
--=20
2.18.2


