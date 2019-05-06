Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890BC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1912053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1912053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfHc-0003gQ-H0
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:12:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNfGT-000398-Op
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNfGS-000557-KD
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:10:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:54458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hNfGS-00054b-Eu
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:10:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hNfGQ-0003tW-Fj
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 15:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 715872E8042
	for <qemu-devel@nongnu.org>; Mon,  6 May 2019 15:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2019 14:58:18 -0000
From: Chen Zhang <1827772@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: gvt mdev rfc vfio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cuser2
X-Launchpad-Bug-Reporter: Chen Zhang (cuser2)
X-Launchpad-Bug-Modifier: Chen Zhang (cuser2)
References: <155705134117.31768.14250772954769525827.malonedeb@wampee.canonical.com>
Message-Id: <155715469842.19580.12684671006065863230.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 57879f8d3201b900438b87962de6d9b58814427c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1827772] Re: [RFC] dma buf: support sprite plane
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1827772 <1827772@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  QEMU does not support sprite/overlay in DMA-buf mode for Intel gvt
  vGPUs. Some use cases relies on sprite plane support, e.g. hw
  accelerated video playback in Windows 10 guest.
  =

  To support this feature, functions in both kernel and QEMU should be
  implemented:
  =

- - query support for plane info in kernel: =

-   in vgpu_get_plane_info() of drm/i915/gvt/dmabuf.c, calls to intel_vgpu_=
decode_sprite_plane() shall be made;
+ - query support for plane info in kernel:
+ =C2=A0=C2=A0in vgpu_get_plane_info() of drm/i915/gvt/dmabuf.c, calls to i=
ntel_vgpu_decode_sprite_plane() shall be made;
  =

  - struct to hold VFIODMABuf object in QEMU:
-   in struct VFIODisplay of include/hw/vfio/vfio-common.h;
+ =C2=A0=C2=A0in struct VFIODisplay of include/hw/vfio/vfio-common.h;
  - copying of data in QEMU:
-   in vfio_display_get_dmabuf() of hw/vfio/display.c;
+ =C2=A0=C2=A0in vfio_display_get_dmabuf() of hw/vfio/display.c;
  - drawing of sprite plane in QEMU:
-   in vfio_display_dmabuf_update() of hw/vfio/display.c;
+ =C2=A0=C2=A0in vfio_display_dmabuf_update() of hw/vfio/display.c;
+   defining more DisplayChangeListenerOps for overlay;
+   adding position info in struct QemuDmaBuf of include/ui/console.h;
+   adding overlay_fb in struct VirtualGfxConsole of include/ui/gtk.h;
+   implement gd_egl_overlay_dmabuf for overlay update;

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1827772

Title:
  [RFC] dma buf: support sprite plane

Status in QEMU:
  New

Bug description:
  QEMU does not support sprite/overlay in DMA-buf mode for Intel gvt
  vGPUs. Some use cases relies on sprite plane support, e.g. hw
  accelerated video playback in Windows 10 guest.

  To support this feature, functions in both kernel and QEMU should be
  implemented:

  - query support for plane info in kernel:
  =C2=A0=C2=A0in vgpu_get_plane_info() of drm/i915/gvt/dmabuf.c, calls to i=
ntel_vgpu_decode_sprite_plane() shall be made;

  - struct to hold VFIODMABuf object in QEMU:
  =C2=A0=C2=A0in struct VFIODisplay of include/hw/vfio/vfio-common.h;
  - copying of data in QEMU:
  =C2=A0=C2=A0in vfio_display_get_dmabuf() of hw/vfio/display.c;
  - drawing of sprite plane in QEMU:
  =C2=A0=C2=A0in vfio_display_dmabuf_update() of hw/vfio/display.c;
    defining more DisplayChangeListenerOps for overlay;
    adding position info in struct QemuDmaBuf of include/ui/console.h;
    adding overlay_fb in struct VirtualGfxConsole of include/ui/gtk.h;
    implement gd_egl_overlay_dmabuf for overlay update;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1827772/+subscriptions

