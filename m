Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB1C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B4C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU0otcbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B4C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyhuD-0003c5-H1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 15:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1iyhsy-000329-7r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1iyhsw-00017H-Ag
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:59:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1iyhsw-0000xW-21
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:59:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id t14so747857wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 11:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Q0Qpsc4ajx70nsjo8Y7n5ggESfY1EYrPKrkiBnSMMoQ=;
 b=EU0otcbj59jTHXzoezptrJg+qqjXm/KB0HObpccEmfVuFDVn1T1QAUb5JOzRvIxd+2
 5nnveDkaLo8p5fw0DA86ajjZxMuH3pU2ratyW/E/o7kZNSpo7RV6yC+HsuErJ0BodnXF
 F/mBT+FznRiZag2gRUxURcY16akRgBR6FEsb+C9wCQ7qarvTqZIrVSwC5qRTTetQZ+OL
 MuSW0Ovum4ccII6rPsm+laaPWDgWvLNx/sY+T73E+VbiU42HdiFwr8UT3Lw0w2ea/KGw
 kYnMJ4FH8m4/f5lxjFdaYXwoEwcFMHG/2d3QUZH5bouvomIo33IZ3ebBW4q/39UKbJoo
 hX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Q0Qpsc4ajx70nsjo8Y7n5ggESfY1EYrPKrkiBnSMMoQ=;
 b=qrtO+X4ju8XLvMUHl00NBD+tlzzUBzOHEu5/oQZVgCRSVIp4y8Lq99j8wrN6cmm70s
 yhqB+V9eiuW3UKZvlHrsJn7wkmPwG7/x+3okQYLVILcaYbDYNZikeApmfpW4bQ1uMbTN
 B0j4Mr7lc7tSW/8ANHHPERXsi9WBQZT6lplJoX5fHPaQkJagnOrtdsKL7EiWqe6bsbG1
 HX6NnoWIZhkH1DNiZ/SE4jLErw6xQwCxaN6GebsuxuNPjy8xKr+oS5suP+Cmd5f1pznA
 OAUuSBo8eoIwwCreGDrVknSFIkiIoWNMb1sPCKrA4/fPqxSKOd3gxp6FZs/YJNy9BJtY
 auTw==
X-Gm-Message-State: APjAAAUnoYBfpxxUgEC/f9g5BsnmDWYuOelz20jZ8XWw9eH7PK1k9MS2
 6uKqRdYwob/dEHMgdGAEMpjrWOkl3sEDRYWyWHV0pg==
X-Google-Smtp-Source: APXvYqwapkXMkVXp1eF/W2IVDJL2CdVGbaNoU5WdP52eCsKbzuvrMlhW9iSeHlQcywm0XEUfcI/4OE40PQV1fGWulE8=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr643198wmi.146.1580759991808; 
 Mon, 03 Feb 2020 11:59:51 -0800 (PST)
MIME-Version: 1.0
References: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
In-Reply-To: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 3 Feb 2020 14:59:40 -0500
Message-ID: <CAKyx-3NZ9Tne+WKkA7wAtyFqZ6roN_gS7rF59ZRjECCkx0qKaQ@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c97679059db15d9a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c97679059db15d9a
Content-Type: text/plain; charset="UTF-8"

> Date: Sat,  1 Feb 2020 17:05:34 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> To: qemu-devel@nongnu.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Subject: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
> Message-ID: <20200201170534.22123-1-peter.maydell@linaro.org>
>
> Our official OSX support policy covers the last two released versions.
> Currently that is 10.14 and 10.15.  We also may work on older versions, but
> don't guarantee it.
>
> In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
> CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
> versions (see LP:1861551). We don't intend to fix that, so we might
> as well drop the code in ui/cocoa.m which caters for pre-10.12
> versions as well. (For reference, 10.11 fell out of Apple extended
> security support in September 2018.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The bug report is recent, but this was also pointed out on
> the mailing list back in June 2019. Since nobody has cared
> to try to fix it, we clearly don't care about 10.11 in
> practice as well as in theory.]
> ---
>  ui/cocoa.m | 59 ------------------------------------------------------
>  1 file changed, 59 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index fbb5b1b45f..f9945bc712 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -42,60 +42,10 @@
>  #include <Carbon/Carbon.h>
>  #include "hw/core/cpu.h"
>
> -#ifndef MAC_OS_X_VERSION_10_5
> -#define MAC_OS_X_VERSION_10_5 1050
> -#endif
> -#ifndef MAC_OS_X_VERSION_10_6
> -#define MAC_OS_X_VERSION_10_6 1060
> -#endif
> -#ifndef MAC_OS_X_VERSION_10_9
> -#define MAC_OS_X_VERSION_10_9 1090
> -#endif
> -#ifndef MAC_OS_X_VERSION_10_10
> -#define MAC_OS_X_VERSION_10_10 101000
> -#endif
> -#ifndef MAC_OS_X_VERSION_10_12
> -#define MAC_OS_X_VERSION_10_12 101200
> -#endif
>  #ifndef MAC_OS_X_VERSION_10_13
>  #define MAC_OS_X_VERSION_10_13 101300
>  #endif
>
> -/* macOS 10.12 deprecated many constants, #define the new names for older
> SDKs */
> -#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
> -#define NSEventMaskAny                  NSAnyEventMask
> -#define NSEventModifierFlagCapsLock     NSAlphaShiftKeyMask
> -#define NSEventModifierFlagShift        NSShiftKeyMask
> -#define NSEventModifierFlagCommand      NSCommandKeyMask
> -#define NSEventModifierFlagControl      NSControlKeyMask
> -#define NSEventModifierFlagOption       NSAlternateKeyMask
> -#define NSEventTypeFlagsChanged         NSFlagsChanged
> -#define NSEventTypeKeyUp                NSKeyUp
> -#define NSEventTypeKeyDown              NSKeyDown
> -#define NSEventTypeMouseMoved           NSMouseMoved
> -#define NSEventTypeLeftMouseDown        NSLeftMouseDown
> -#define NSEventTypeRightMouseDown       NSRightMouseDown
> -#define NSEventTypeOtherMouseDown       NSOtherMouseDown
> -#define NSEventTypeLeftMouseDragged     NSLeftMouseDragged
> -#define NSEventTypeRightMouseDragged    NSRightMouseDragged
> -#define NSEventTypeOtherMouseDragged    NSOtherMouseDragged
> -#define NSEventTypeLeftMouseUp          NSLeftMouseUp
> -#define NSEventTypeRightMouseUp         NSRightMouseUp
> -#define NSEventTypeOtherMouseUp         NSOtherMouseUp
> -#define NSEventTypeScrollWheel          NSScrollWheel
> -#define NSTextAlignmentCenter           NSCenterTextAlignment
> -#define NSWindowStyleMaskBorderless     NSBorderlessWindowMask
> -#define NSWindowStyleMaskClosable       NSClosableWindowMask
> -#define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
> -#define NSWindowStyleMaskTitled         NSTitledWindowMask
> -#endif
> -/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
> - * NSModalResponseOK, which was introduced in 10.9. Define
> - * it for older versions.
> - */
> -#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
> -#define NSModalResponseOK NSFileHandlingPanelOKButton
> -#endif
>  /* 10.14 deprecates NSOnState and NSOffState in favor of
>   * NSControlStateValueOn/Off, which were introduced in 10.13.
>   * Define for older versions
> @@ -465,11 +415,7 @@ - (void) drawRect:(NSRect) rect
>      COCOA_DEBUG("QemuCocoaView: drawRect\n");
>
>      // get CoreGraphic context
> -#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10
> -    CGContextRef viewContextRef = [[NSGraphicsContext currentContext]
> graphicsPort];
> -#else
>      CGContextRef viewContextRef = [[NSGraphicsContext currentContext]
> CGContext];
> -#endif
>
>      CGContextSetInterpolationQuality (viewContextRef,
> kCGInterpolationNone);
>      CGContextSetShouldAntialias (viewContextRef, NO);
> @@ -1075,9 +1021,7 @@ - (void) raiseAllKeys
>   ------------------------------------------------------
>  */
>  @interface QemuCocoaAppController : NSObject
> -#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6)
>                                         <NSWindowDelegate,
> NSApplicationDelegate>
> -#endif
>  {
>  }
>  - (void)doToggleFullScreen:(id)sender;
> @@ -1126,9 +1070,6 @@ - (id) init
>          [normalWindow setAcceptsMouseMovedEvents:YES];
>          [normalWindow setTitle:@"QEMU"];
>          [normalWindow setContentView:cocoaView];
> -#if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10)
> -        [normalWindow useOptimizedDrawing:YES];
> -#endif
>          [normalWindow makeKeyAndOrderFront:self];
>          [normalWindow center];
>          [normalWindow setDelegate: self];
> --
> 2.17.2 (Apple Git-113)
>
>
> Why would you want to inconvenience the Mac users? This is unacceptable. I
and many other Mac users would not be able to use the newer versions of
QEMU anymore. Keeping Mac OS 10.10 and up support doesn't seem like a
burden. This patch should not be applied.

--000000000000c97679059db15d9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
Date: Sat,=C2=A0 1 Feb 2020 17:05:34 +0000<br>
From: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=
=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Subject: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX<br>
Message-ID: &lt;<a href=3D"mailto:20200201170534.22123-1-peter.maydell@lina=
ro.org" target=3D"_blank">20200201170534.22123-1-peter.maydell@linaro.org</=
a>&gt;<br>
<br>
Our official OSX support policy covers the last two released versions.<br>
Currently that is 10.14 and 10.15.=C2=A0 We also may work on older versions=
, but<br>
don&#39;t guarantee it.<br>
<br>
In commit 50290c002c045280f8d in mid-2019 we introduced some uses of<br>
CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX<br>
versions (see LP:1861551). We don&#39;t intend to fix that, so we might<br>
as well drop the code in ui/cocoa.m which caters for pre-10.12<br>
versions as well. (For reference, 10.11 fell out of Apple extended<br>
security support in September 2018.)<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
The bug report is recent, but this was also pointed out on<br>
the mailing list back in June 2019. Since nobody has cared<br>
to try to fix it, we clearly don&#39;t care about 10.11 in<br>
practice as well as in theory.]<br>
---<br>
=C2=A0ui/cocoa.m | 59 -----------------------------------------------------=
-<br>
=C2=A01 file changed, 59 deletions(-)<br>
<br>
diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
index fbb5b1b45f..f9945bc712 100644<br>
--- a/ui/cocoa.m<br>
+++ b/ui/cocoa.m<br>
@@ -42,60 +42,10 @@<br>
=C2=A0#include &lt;Carbon/Carbon.h&gt;<br>
=C2=A0#include &quot;hw/core/cpu.h&quot;<br>
<br>
-#ifndef MAC_OS_X_VERSION_10_5<br>
-#define MAC_OS_X_VERSION_10_5 1050<br>
-#endif<br>
-#ifndef MAC_OS_X_VERSION_10_6<br>
-#define MAC_OS_X_VERSION_10_6 1060<br>
-#endif<br>
-#ifndef MAC_OS_X_VERSION_10_9<br>
-#define MAC_OS_X_VERSION_10_9 1090<br>
-#endif<br>
-#ifndef MAC_OS_X_VERSION_10_10<br>
-#define MAC_OS_X_VERSION_10_10 101000<br>
-#endif<br>
-#ifndef MAC_OS_X_VERSION_10_12<br>
-#define MAC_OS_X_VERSION_10_12 101200<br>
-#endif<br>
=C2=A0#ifndef MAC_OS_X_VERSION_10_13<br>
=C2=A0#define MAC_OS_X_VERSION_10_13 101300<br>
=C2=A0#endif<br>
<br>
-/* macOS 10.12 deprecated many constants, #define the new names for older =
SDKs */<br>
-#if MAC_OS_X_VERSION_MAX_ALLOWED &lt; MAC_OS_X_VERSION_10_12<br>
-#define NSEventMaskAny=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NSAnyEventMask<br>
-#define NSEventModifierFlagCapsLock=C2=A0 =C2=A0 =C2=A0NSAlphaShiftKeyMask=
<br>
-#define NSEventModifierFlagShift=C2=A0 =C2=A0 =C2=A0 =C2=A0 NSShiftKeyMask=
<br>
-#define NSEventModifierFlagCommand=C2=A0 =C2=A0 =C2=A0 NSCommandKeyMask<br=
>
-#define NSEventModifierFlagControl=C2=A0 =C2=A0 =C2=A0 NSControlKeyMask<br=
>
-#define NSEventModifierFlagOption=C2=A0 =C2=A0 =C2=A0 =C2=A0NSAlternateKey=
Mask<br>
-#define NSEventTypeFlagsChanged=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSFlagsCh=
anged<br>
-#define NSEventTypeKeyUp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 NSKeyUp<br>
-#define NSEventTypeKeyDown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 NSKeyDown<br>
-#define NSEventTypeMouseMoved=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSMo=
useMoved<br>
-#define NSEventTypeLeftMouseDown=C2=A0 =C2=A0 =C2=A0 =C2=A0 NSLeftMouseDow=
n<br>
-#define NSEventTypeRightMouseDown=C2=A0 =C2=A0 =C2=A0 =C2=A0NSRightMouseDo=
wn<br>
-#define NSEventTypeOtherMouseDown=C2=A0 =C2=A0 =C2=A0 =C2=A0NSOtherMouseDo=
wn<br>
-#define NSEventTypeLeftMouseDragged=C2=A0 =C2=A0 =C2=A0NSLeftMouseDragged<=
br>
-#define NSEventTypeRightMouseDragged=C2=A0 =C2=A0 NSRightMouseDragged<br>
-#define NSEventTypeOtherMouseDragged=C2=A0 =C2=A0 NSOtherMouseDragged<br>
-#define NSEventTypeLeftMouseUp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NSLeftMou=
seUp<br>
-#define NSEventTypeRightMouseUp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSRightMo=
useUp<br>
-#define NSEventTypeOtherMouseUp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSOtherMo=
useUp<br>
-#define NSEventTypeScrollWheel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NSScrollW=
heel<br>
-#define NSTextAlignmentCenter=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSCe=
nterTextAlignment<br>
-#define NSWindowStyleMaskBorderless=C2=A0 =C2=A0 =C2=A0NSBorderlessWindowM=
ask<br>
-#define NSWindowStyleMaskClosable=C2=A0 =C2=A0 =C2=A0 =C2=A0NSClosableWind=
owMask<br>
-#define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask<br>
-#define NSWindowStyleMaskTitled=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSTitledW=
indowMask<br>
-#endif<br>
-/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of<br>
- * NSModalResponseOK, which was introduced in 10.9. Define<br>
- * it for older versions.<br>
- */<br>
-#if MAC_OS_X_VERSION_MAX_ALLOWED &lt; MAC_OS_X_VERSION_10_9<br>
-#define NSModalResponseOK NSFileHandlingPanelOKButton<br>
-#endif<br>
=C2=A0/* 10.14 deprecates NSOnState and NSOffState in favor of<br>
=C2=A0 * NSControlStateValueOn/Off, which were introduced in 10.13.<br>
=C2=A0 * Define for older versions<br>
@@ -465,11 +415,7 @@ - (void) drawRect:(NSRect) rect<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaView: drawRect\n&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0// get CoreGraphic context<br>
-#if MAC_OS_X_VERSION_MAX_ALLOWED &lt; MAC_OS_X_VERSION_10_10<br>
-=C2=A0 =C2=A0 CGContextRef viewContextRef =3D [[NSGraphicsContext currentC=
ontext] graphicsPort];<br>
-#else<br>
=C2=A0 =C2=A0 =C2=A0CGContextRef viewContextRef =3D [[NSGraphicsContext cur=
rentContext] CGContext];<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0CGContextSetInterpolationQuality (viewContextRef, kCGIn=
terpolationNone);<br>
=C2=A0 =C2=A0 =C2=A0CGContextSetShouldAntialias (viewContextRef, NO);<br>
@@ -1075,9 +1021,7 @@ - (void) raiseAllKeys<br>
=C2=A0 ------------------------------------------------------<br>
=C2=A0*/<br>
=C2=A0@interface QemuCocoaAppController : NSObject<br>
-#if (MAC_OS_X_VERSION_MAX_ALLOWED &gt;=3D MAC_OS_X_VERSION_10_6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;NSWi=
ndowDelegate, NSApplicationDelegate&gt;<br>
-#endif<br>
=C2=A0{<br>
=C2=A0}<br>
=C2=A0- (void)doToggleFullScreen:(id)sender;<br>
@@ -1126,9 +1070,6 @@ - (id) init<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setAcceptsMouseMovedEvents:=
YES];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setTitle:@&quot;QEMU&quot;]=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setContentView:cocoaView];<=
br>
-#if (MAC_OS_X_VERSION_MAX_ALLOWED &lt; MAC_OS_X_VERSION_10_10)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow useOptimizedDrawing:YES];<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow makeKeyAndOrderFront:self];=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow center];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setDelegate: self];<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
<br></blockquote><div>Why would you want to inconvenience the Mac users? Th=
is is unacceptable. I and many other Mac users would not be able to use the=
 newer versions of QEMU anymore. Keeping Mac OS 10.10 and up support doesn&=
#39;t seem like a burden. This patch should not be applied.<br></div></div>=
</div>

--000000000000c97679059db15d9a--

