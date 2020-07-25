Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FDAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 21:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C88F206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 21:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzRvH-0007Vq-IU
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 17:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzRuZ-00076c-4u
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 17:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:59648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzRuW-0001Gb-BI
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 17:40:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jzRuT-00062a-Pi
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 21:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BB85C2E80D2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 21:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2020 21:32:24 -0000
From: Tobias Markus <1888964@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: dmabuf egl gtk gvt mdev ui vfio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hesiod
X-Launchpad-Bug-Reporter: Tobias Markus (hesiod)
X-Launchpad-Bug-Modifier: Tobias Markus (hesiod)
Message-Id: <159571274485.17992.4520030985362542383.malonedeb@soybean.canonical.com>
Subject: [Bug 1888964] [NEW] Segfault using GTK display with dmabuf (iGVT-g)
 on Wayland
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d4548be6b8fac2e788365fedfcb340ba27582467
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 14:40:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1888964 <1888964@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When using...
 a) Intel virtualized graphics (iGVT-g) with dmabuf output
 b) QEMU's GTK display with GL output enabled (-display gtk,gl=3Don)
 c) A Wayland compositor (Sway in my case)
a segfault occurs at some point on boot (I guess as soon as the guest start=
s using the virtual graphics card?)

The origin is the function dpy_gl_scanout_dmabuf in ui/console.c, where it =
calls
    con->gl->ops->dpy_gl_scanout_dmabuf(con->gl, dmabuf);
However, the ops field (struct DisplayChangeListenerOps) does not have dpy_=
gl_scanout_dmabuf set because it is set to dcl_gl_area_ops which does not h=
ave dpy_gl_scanout_dmabuf set.
Only dcl_egl_ops has dpy_gl_scanout_dmabuf set.
Currently, the GTK display uses EGL on X11 displays, but GtkGLArea on Wayla=
nd. This can be observed in early_gtk_display_init() in ui/gtk.c, where it =
says (simplified code):

if (opts->has_gl && opts->gl !=3D DISPLAYGL_MODE_OFF) {
        if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
            gtk_use_gl_area =3D true;
            gtk_gl_area_init();
        } else {
            DisplayGLMode mode =3D opts->has_gl ? opts->gl : DISPLAYGL_MODE=
_ON;
            gtk_egl_init(mode);
        }
}

To reproduce the findings above, add this assertion to dpy_gl_scanout_dmabu=
f:
    assert(con->gl->ops->dpy_gl_scanout_dmabuf);
This will make the segfault turn into an assertion failure.

A workaround is to force QEMU to use GDK's X11 backend (using
GDK_BACKEND=3Dx11).

Note: This might be a duplicate of 1775011, however the information
provided in that bug report is not sufficient to make the assertion.

QEMU version: b0ce3f021e0157e9a5ab836cb162c48caac132e1 (from Git master bra=
nch)
OS: Arch Linux, Kernel Version 5.17.0-1

Relevant flags of the QEMU invocation:
qemu-system-x86_64 \
  -vga none \
  -device vfio-pci-nohotplug,sysfsdev=3D"$GVT_DEV",romfile=3D"${ROMFILE}",d=
isplay=3Don,x-igd-opregion=3Don,ramfb=3Don \
  -display gtk,gl=3Don

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: dmabuf egl gtk gvt mdev ui vfio

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888964

Title:
  Segfault using GTK display with dmabuf (iGVT-g) on Wayland

Status in QEMU:
  New

Bug description:
  When using...
   a) Intel virtualized graphics (iGVT-g) with dmabuf output
   b) QEMU's GTK display with GL output enabled (-display gtk,gl=3Don)
   c) A Wayland compositor (Sway in my case)
  a segfault occurs at some point on boot (I guess as soon as the guest sta=
rts using the virtual graphics card?)

  The origin is the function dpy_gl_scanout_dmabuf in ui/console.c, where i=
t calls
      con->gl->ops->dpy_gl_scanout_dmabuf(con->gl, dmabuf);
  However, the ops field (struct DisplayChangeListenerOps) does not have dp=
y_gl_scanout_dmabuf set because it is set to dcl_gl_area_ops which does not=
 have dpy_gl_scanout_dmabuf set.
  Only dcl_egl_ops has dpy_gl_scanout_dmabuf set.
  Currently, the GTK display uses EGL on X11 displays, but GtkGLArea on Way=
land. This can be observed in early_gtk_display_init() in ui/gtk.c, where i=
t says (simplified code):

  if (opts->has_gl && opts->gl !=3D DISPLAYGL_MODE_OFF) {
          if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
              gtk_use_gl_area =3D true;
              gtk_gl_area_init();
          } else {
              DisplayGLMode mode =3D opts->has_gl ? opts->gl : DISPLAYGL_MO=
DE_ON;
              gtk_egl_init(mode);
          }
  }

  To reproduce the findings above, add this assertion to dpy_gl_scanout_dma=
buf:
      assert(con->gl->ops->dpy_gl_scanout_dmabuf);
  This will make the segfault turn into an assertion failure.

  A workaround is to force QEMU to use GDK's X11 backend (using
  GDK_BACKEND=3Dx11).

  Note: This might be a duplicate of 1775011, however the information
  provided in that bug report is not sufficient to make the assertion.

  QEMU version: b0ce3f021e0157e9a5ab836cb162c48caac132e1 (from Git master b=
ranch)
  OS: Arch Linux, Kernel Version 5.17.0-1

  Relevant flags of the QEMU invocation:
  qemu-system-x86_64 \
    -vga none \
    -device vfio-pci-nohotplug,sysfsdev=3D"$GVT_DEV",romfile=3D"${ROMFILE}"=
,display=3Don,x-igd-opregion=3Don,ramfb=3Don \
    -display gtk,gl=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888964/+subscriptions

