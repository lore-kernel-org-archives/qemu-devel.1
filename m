Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823EDC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF11206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEhqFaMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF11206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkCT-000343-BT
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ckmichael8@gmail.com>) id 1jLeLt-00069B-SC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 22:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ckmichael8@gmail.com>) id 1jLeLr-0005Lg-ST
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 22:52:37 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:37211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ckmichael8@gmail.com>)
 id 1jLeLr-0005LQ-My
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 22:52:35 -0400
Received: by mail-vk1-xa43.google.com with SMTP id f195so461564vka.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 19:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pzOgG9xaygDrkVoaN5g5dyF2HXxOXbwiOJGa/DNX8iI=;
 b=nEhqFaMemCGJJ73AZO9DjmCO54r5kmapzuplCrWGnX9KLe5fFJ5d7M3begR6TM/6ej
 guFbC1NQMor65mdEgomDRajSP/kX1ip8E92FGprLSd8SYpydVdFjh2N6zxa2KvyDO03L
 mSIXvGrIw4AvfaA7voxkX8iRgaPNgMIyo91KL1gOb/9PtOFcR6chUyVxmtkpd8lmza2a
 FShGI8AplYDeMgMT+9pNpwQgg66dqpcqlWFTQ/XjQ2agPtynTAemY7/085CjKlh897US
 APHxqojA1bEW9GuljRYIc2k+NoT+W6ZmOSurGipnfZd4z08ebjnGrS4saPW5Lp/o/u44
 btyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pzOgG9xaygDrkVoaN5g5dyF2HXxOXbwiOJGa/DNX8iI=;
 b=bWY7+R660n6opQAdfyzRT0mPGJX6yKaP7/gCqbUpI5KyixHoT0LO09xnNoL+thYp/W
 jqVMzbWkJ5lJ1X/a69xrydo8I9ZKLAYaMosJv6JvLf0ONCgSvgcOcPIW5kaigHoaBKZM
 4Jjv6S8/eXQvLIm1fICznulkukiywuXq2EgcEkU1FlPe1TqZtFS9ApZnoy8QJRkJmKn5
 q1Yb9vuhxAntLzMWsiunQAK6WsolZ5GHEM2j8sGVJ4eAvIMUyYtteV1oLcj+IAPABsVK
 nrRFbuGjMZ0WYVpBxHc8rj+01Pz/+VIBfw1XqLvlzLxGfK1kkfqERQwG/olC8BksgbCn
 Ns3A==
X-Gm-Message-State: AGi0PuadvQnYw8l7EW8fH+3VXM3GK2nV8mxjT6Wy7dOyweYs+C2KKlMM
 7NdyatfxUt7QPybkpClP4l6p+hw6e7k/PGeVuZw=
X-Google-Smtp-Source: APiQypJwGaOxdH1hKUd/oKTAPVoRpGf6dgSYrP/CUSX+njanip+xhptF8WQiIyfMVoRt3Q3qCKtibaYoOlswLXdlR40=
X-Received: by 2002:a1f:e182:: with SMTP id y124mr20088vkg.0.1586227954836;
 Mon, 06 Apr 2020 19:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNnKHAd21Z6L0LR6xj0cLVZ6WS7uNTYZDTvE2-BUhU+GvNiFA@mail.gmail.com>
In-Reply-To: <CAGNnKHAd21Z6L0LR6xj0cLVZ6WS7uNTYZDTvE2-BUhU+GvNiFA@mail.gmail.com>
From: Michael Lee <ckmichael8@gmail.com>
Date: Tue, 7 Apr 2020 10:52:23 +0800
Message-ID: <CAGNnKHBOKs70iJopwuFdb0M=dK3FDy+jMyJPg8K12vtKwfsaAA@mail.gmail.com>
Subject: Re: RFE: add usbredir device reset blacklist options support to allow
 macOS guest to iOS device usbredir
To: kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c7eb5305a2aa79cf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
X-Mailman-Approved-At: Tue, 07 Apr 2020 04:58:30 -0400
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c7eb5305a2aa79cf
Content-Type: text/plain; charset="UTF-8"

From ec02df3bb9027691957218e5ea07c4febb007cec Mon Sep 17 00:00:00 2001
From: michaellee8 <ckmichael8@gmail.com>
Date: Tue, 7 Apr 2020 10:19:27 +0800
Subject: [PATCH] usbredir: introduce new parameters to configure guest reset
 behavior for usbredir device

This patch solves the same problem of usb device reset loop as mentioned in
ba4c735b4fc7,
but for usbredir device instead. This allows my iPad device to be
redirected to my
Mac OS X Catalina guest via SPICE.

However, this patch does not solve everything, it will require further work
on the
client-side spice viewers to be useful. I have already opened issues in
different
components that will require changes in order to make this patch useful.

Cross-references:
- https://bugzilla.redhat.com/show_bug.cgi?id=1821518
- https://bugzilla.redhat.com/show_bug.cgi?id=1821517
- https://gitlab.freedesktop.org/spice/usbredir/-/issues/10
- https://bugs.launchpad.net/bugs/1871270

Signed-off-by: michaellee8 <ckmichael8@gmail.com>
---
 hw/usb/redirect.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 45d8b76218..1cb04cebf6 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -115,6 +115,8 @@ struct USBRedirDevice {
     bool enable_streams;
     bool suppress_remote_wake;
     bool in_write;
+    bool allow_one_guest_reset;
+    bool allow_all_guest_resets;
     uint8_t debug;
     int32_t bootindex;
     char *filter_str;
@@ -516,6 +518,13 @@ static void usbredir_handle_reset(USBDevice *udev)
 {
     USBRedirDevice *dev = USB_REDIRECT(udev);

+    if (!dev->allow_one_guest_reset && !dev->allow_all_guest_resets) {
+        return;
+    }
+    if (!dev->allow_all_guest_resets && udev->addr == 0) {
+        return;
+    }
+
     DPRINTF("reset device\n");
     usbredirparser_send_reset(dev->parser);
     usbredirparser_do_write(dev->parser);
@@ -2564,6 +2573,10 @@ static Property usbredir_properties[] = {
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
     DEFINE_PROP_BOOL("suppress-remote-wake", USBRedirDevice,
                      suppress_remote_wake, true),
+    DEFINE_PROP_BOOL("guest-reset", USBRedirDevice,
+                     allow_one_guest_reset, true),
+    DEFINE_PROP_BOOL("guest-resets-all", USBRedirDevice,
+                     allow_all_guest_resets, false),
     DEFINE_PROP_END_OF_LIST(),
 };

-- 
2.17.1

On Tue, 7 Apr 2020 at 09:35, Michael Lee <ckmichael8@gmail.com> wrote:

> Description of problem:
> Currently, when a iOS device is redirected to a macOS VM, it falls into a
> reset-not-found loop.
> Version-Release number of selected component (if applicable):
> latest
> How reproducible:
> 100%
> Steps to Reproduce:
>
>    1. Connect an iOS device to Ubuntu 18.04.2 LTS (I believe it is the
>    same for any distro.)
>    2. Connect virt-manager/virt-viewer to a macOS VM through SPICE (I am
>    using OSX 10.15 Catalina)
>    3. Attempt to redirect the iOS device (iPad in my case) to the VM
>    through usb redirection.
>
>
>
> Actual results:
> For any odd number of attempt, the guest macOS will send a reset to the
> iOS device which causes the host to reset the USB connection in the host
> side. In the UI, it will be displayed as a successful connection for a few
> seconds before it disconnects. After this, the iOS device will reconnect
> itself, but via a different device name /dev/bus/usb/x/y+1.
> For any even number of attempt, when I select the iOS device in the
> virt-manager/virt-viewer UI, the connection will not success and instead a
> LIBUSB_ERROR_NOT_FOUND error will be provided. Then the UI will reload and
> get the new device name of the iOS device, falling into the behavior of the
> aforementioned odd number of attempt.
> Expected results:
> The macOS detects the iOS device and connects to it happily.
> Additional info:
> It seems that this bug has been first identified as in
> https://bugs.freedesktop.org/show_bug.cgi?id=100149, for a Samsung
> Android device, which the developers of SPICE applied a hotfix in
> https://gitlab.freedesktop.org/spice/usbredir/-/blob/master/usbredirhost/usbredirhost.c#L147.
> However, there were no settings available for users to fix it.
> A similar bug that also consists of a macOS guest/iOS device pair, but
> instead of being usbredir, is usb-host, has been identified and patched in
> https://github.com/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5,
> which is further modified into
> https://github.com/qemu/qemu/blame/146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486.
> Following such patch, I have attempted to apply such patch at host-side in
> https://github.com/michaellee8/qemu/blob/master/hw/usb/redirect.c (not
> correctly formatted currently, pls ignore it atm), however I discovered
> that this is not enough since it is also a SPICE issue, which resolves to
> virt-manager/virt-viewer.
> This is probably a cross-project issue between qemu, spice (usbredir) and
> virt-manager/virt-viewer, which would some effort to coordinate a solution.
> However a working solution for this problem would probably benefits a lot
> of users whom relies on connecting a mobile device into a VM, for purposes
> like easier mobile development. Considering the report for the Samsung
> Android Device on a PC use case, such issue is probably
> cross-OS/cross-device.
>
> cross-references:
> - https://bugzilla.redhat.com/show_bug.cgi?id=1821518
> - https://bugzilla.redhat.com/show_bug.cgi?id=1821517
> - https://gitlab.freedesktop.org/spice/usbredir/-/issues/10
>

--000000000000c7eb5305a2aa79cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">From ec02df3bb9027691957218e5ea07c4febb00=
7cec Mon Sep 17 00:00:00 2001<br>From: michaellee8 &lt;<a href=3D"mailto:ck=
michael8@gmail.com">ckmichael8@gmail.com</a>&gt;<br>Date: Tue, 7 Apr 2020 1=
0:19:27 +0800<br>Subject: [PATCH] usbredir: introduce new parameters to con=
figure guest reset<br>=C2=A0behavior for usbredir device<br><br>This patch =
solves the same problem of usb device reset loop as mentioned in ba4c735b4f=
c7,<br>but for usbredir device instead. This allows my iPad device to be re=
directed to my<br>Mac OS X Catalina guest via SPICE.<br><br>However, this p=
atch does not solve everything, it will require further work on the<br>clie=
nt-side spice viewers to be useful. I have already opened issues in differe=
nt<br>components that will require changes in order to make this patch usef=
ul.<br><br>Cross-references:<br>- <a href=3D"https://bugzilla.redhat.com/sh=
ow_bug.cgi?id=3D1821518">https://bugzilla.redhat.com/show_bug.cgi?id=3D1821=
518</a><br>- <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D18215=
17">https://bugzilla.redhat.com/show_bug.cgi?id=3D1821517</a><br>- <a href=
=3D"https://gitlab.freedesktop.org/spice/usbredir/-/issues/10">https://gitl=
ab.freedesktop.org/spice/usbredir/-/issues/10</a><br>- <a href=3D"https://b=
ugs.launchpad.net/bugs/1871270">https://bugs.launchpad.net/bugs/1871270</a>=
<br><br>Signed-off-by: michaellee8 &lt;<a href=3D"mailto:ckmichael8@gmail.c=
om">ckmichael8@gmail.com</a>&gt;<br>---<br>=C2=A0hw/usb/redirect.c | 13 +++=
++++++++++<br>=C2=A01 file changed, 13 insertions(+)<br><br>diff --git a/hw=
/usb/redirect.c b/hw/usb/redirect.c<br>index 45d8b76218..1cb04cebf6 100644<=
br>--- a/hw/usb/redirect.c<br>+++ b/hw/usb/redirect.c<br>@@ -115,6 +115,8 @=
@ struct USBRedirDevice {<br>=C2=A0 =C2=A0 =C2=A0bool enable_streams;<br>=
=C2=A0 =C2=A0 =C2=A0bool suppress_remote_wake;<br>=C2=A0 =C2=A0 =C2=A0bool =
in_write;<br>+ =C2=A0 =C2=A0bool allow_one_guest_reset;<br>+ =C2=A0 =C2=A0b=
ool allow_all_guest_resets;<br>=C2=A0 =C2=A0 =C2=A0uint8_t debug;<br>=C2=A0=
 =C2=A0 =C2=A0int32_t bootindex;<br>=C2=A0 =C2=A0 =C2=A0char *filter_str;<b=
r>@@ -516,6 +518,13 @@ static void usbredir_handle_reset(USBDevice *udev)<b=
r>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0USBRedirDevice *dev =3D USB_REDIRECT(udev)=
;<br>=C2=A0<br>+ =C2=A0 =C2=A0if (!dev-&gt;allow_one_guest_reset &amp;&amp;=
 !dev-&gt;allow_all_guest_resets) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;=
<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (!dev-&gt;allow_all_guest_resets =
&amp;&amp; udev-&gt;addr =3D=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
;<br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0DPRINTF(&quot;reset devic=
e\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0usbredirparser_send_reset(dev-&gt;parser=
);<br>=C2=A0 =C2=A0 =C2=A0usbredirparser_do_write(dev-&gt;parser);<br>@@ -2=
564,6 +2573,10 @@ static Property usbredir_properties[] =3D {<br>=C2=A0 =C2=
=A0 =C2=A0DEFINE_PROP_BOOL(&quot;streams&quot;, USBRedirDevice, enable_stre=
ams, true),<br>=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;suppress-remote-w=
ake&quot;, USBRedirDevice,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suppress_remote_wake, true),<br>+ =C2=A0 =
=C2=A0DEFINE_PROP_BOOL(&quot;guest-reset&quot;, USBRedirDevice,<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allow_one_g=
uest_reset, true),<br>+ =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;guest-resets-al=
l&quot;, USBRedirDevice,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 allow_all_guest_resets, false),<br>=C2=A0 =C2=A0 =
=C2=A0DEFINE_PROP_END_OF_LIST(),<br>=C2=A0};<br>=C2=A0<br>-- <br>2.17.1<br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, 7 Apr 2020 at 09:35, Michael Lee &lt;<a href=3D"mailto:ckmichael8@g=
mail.com">ckmichael8@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr">Description of problem:<br>C=
urrently, when a iOS device is redirected to a macOS VM, it falls into a re=
set-not-found loop.<br>Version-Release number of selected component (if app=
licable):<br>latest<br>How reproducible:<br>100%<br>Steps to Reproduce:<br>=
<ol><li>Connect an iOS device to Ubuntu 18.04.2 LTS (I believe it is the sa=
me for any distro.)</li><li>Connect virt-manager/virt-viewer to a macOS VM =
through SPICE (I am using OSX 10.15 Catalina)</li><li>Attempt to redirect t=
he iOS device (iPad in my case) to the VM through usb redirection.</li></ol=
><br><br>Actual results:<br>For any odd number of attempt, the guest macOS =
will send a reset to the iOS device which causes the host to reset the USB =
connection in the host side. In the UI, it will be displayed as a successfu=
l connection for a few seconds before it disconnects. After this, the iOS d=
evice will reconnect itself, but via a different device name /dev/bus/usb/x=
/y+1.<br>For any even number of attempt, when I select the iOS device in th=
e virt-manager/virt-viewer UI, the connection will not success and instead =
a LIBUSB_ERROR_NOT_FOUND error will be provided. Then the UI will reload an=
d get the new device name of the iOS device, falling into the behavior of t=
he aforementioned odd number of attempt.<br>Expected results:<br>The macOS =
detects the iOS device and connects to it happily.<br>Additional info:<br>I=
t seems that this bug has been first identified as in <a href=3D"https://bu=
gs.freedesktop.org/show_bug.cgi?id=3D100149" target=3D"_blank">https://bugs=
.freedesktop.org/show_bug.cgi?id=3D100149</a>, for a Samsung Android device=
, which the developers of SPICE applied a hotfix in <a href=3D"https://gitl=
ab.freedesktop.org/spice/usbredir/-/blob/master/usbredirhost/usbredirhost.c=
#L147" target=3D"_blank">https://gitlab.freedesktop.org/spice/usbredir/-/bl=
ob/master/usbredirhost/usbredirhost.c#L147</a>. However, there were no sett=
ings available for users to fix it.<br>A similar bug that also consists of =
a macOS guest/iOS device pair, but instead of being usbredir, is usb-host, =
has been identified and patched in <a href=3D"https://github.com/qemu/qemu/=
commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5" target=3D"_blank">https://=
github.com/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5</a>, w=
hich is further modified into <a href=3D"https://github.com/qemu/qemu/blame=
/146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486" targe=
t=3D"_blank">https://github.com/qemu/qemu/blame/146aa0f104bb3bf88e43c4082a0=
bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486</a>. Following such patch, I have =
attempted to apply such patch at host-side in <a href=3D"https://github.com=
/michaellee8/qemu/blob/master/hw/usb/redirect.c" target=3D"_blank">https://=
github.com/michaellee8/qemu/blob/master/hw/usb/redirect.c</a> (not correctl=
y formatted currently, pls ignore it atm), however I discovered that this i=
s not enough since it is also a SPICE issue, which resolves to virt-manager=
/virt-viewer.<br>This is probably a cross-project issue between qemu, spice=
 (usbredir) and virt-manager/virt-viewer, which would some effort to coordi=
nate a solution. However a working solution for this problem would probably=
 benefits a lot of users whom relies on connecting a mobile device into a V=
M, for purposes like easier mobile development. Considering the report for =
the Samsung Android Device on a PC use case, such issue is probably cross-O=
S/cross-device.<br><br>cross-references:<br>- <a href=3D"https://bugzilla.r=
edhat.com/show_bug.cgi?id=3D1821518" target=3D"_blank">https://bugzilla.red=
hat.com/show_bug.cgi?id=3D1821518</a><br>- <a href=3D"https://bugzilla.redh=
at.com/show_bug.cgi?id=3D1821517" target=3D"_blank">https://bugzilla.redhat=
.com/show_bug.cgi?id=3D1821517</a><br>- <a href=3D"https://gitlab.freedeskt=
op.org/spice/usbredir/-/issues/10" target=3D"_blank">https://gitlab.freedes=
ktop.org/spice/usbredir/-/issues/10</a><br></div>
</blockquote></div></div>

--000000000000c7eb5305a2aa79cf--

