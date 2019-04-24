Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CEC282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D716B21900
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiANODJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D716B21900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIQY-00042b-Oy
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:59:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJILu-0008ST-NI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJII9-0003aj-Hr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:50:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJII9-0003ZE-2n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:50:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so7687872wrp.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=YyKAsYf50TUGclcq2xvGIOFoGQ0hdh8P58U1HqiutXo=;
	b=YiANODJB0fp519XHaHmxVL+fFtU6WN7hmD7JE0FQnpah4oMa4HVSf9PeIKWxJ+ZTuK
	KQNNxiE9GAE0yC7YTcw7ua2/doT5ITdeL1LgK8MU9UAjiL9s38C1ppTRINp0O73GMpbM
	P4DQLhQh9SIcqdOMU54XW0+fo7FRMge0NnMKrMQHC8MJhAOoFnvvRJP/7ID9tEpQFz0e
	uHfOs+VKcPlfp18xwX9Lfs9XsvmITELfJWbO18ed2dFEUT05hE2JQ81yUjJvhQkbNgXZ
	sMNPN7vdfN+83Cnafop9ipwK4XIwaoeI0xpOnvznjCwx0qLLKHa47lddhjvjOCLsu1TN
	JXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=YyKAsYf50TUGclcq2xvGIOFoGQ0hdh8P58U1HqiutXo=;
	b=RiFPptVmuYDVje5wL43h0E319td5b0G+Cw3E9SB+4TMuD8h95fqqOYMcxAIVW1R9BZ
	+OV4+CioD3JkxSxqbdLKmCKyHbuuhyB7m2cy7o4lmhu4dNdEC8vThputLAAX+bwmy/ca
	Sy4YyChu0OcLfcsX8HPX5BYBZ4L9zVgRT+HoIjMtuNreUe39ESUA6Vxk+cmU1sz/c0bG
	XjPOy+2+P1bsChdtDPBlkwf2OAZEYDK/zqVsvacazPwc9yP3eM7f/vADCMfUH30HlM2j
	NRIoUHJMokqgwfACSH9nML6x97k0rwTI2CkBoxYjRgfDGfohKggUFfLsSyArzSni1G3n
	pQ/g==
X-Gm-Message-State: APjAAAXE4oxFdgiXAweIcASZaNUi39ibQ9G6eHQAzXPmpEaUhHyakVDH
	fjmNGezFg63cW3ZFGhM3izNuts3ofMlbshwtz48=
X-Google-Smtp-Source: APXvYqzJceGiXIicIRnl+OLsrvTCjGfh/oKNsh539/7I6fhEXK6Hz3xIHpEAeXH+AkC9wEpShAL591R1HTbg+iqL1hA=
X-Received: by 2002:adf:b641:: with SMTP id i1mr21513470wre.288.1556113827344; 
	Wed, 24 Apr 2019 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190424092028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190424092028-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Apr 2019 15:50:15 +0200
Message-ID:
 <CAJ+F1CLPjEwwrXwEYTGE-zsmK4cAn0Dg=dv8h6CnXt537mofCA@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v6 00/11] vhost-user for input & GPU
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424135015.xtjBcZrnjK0MJmtmjZfhnzGo1gA2RAHKYHMXW3n1wKs@z>

Hi

On Wed, Apr 24, 2019 at 3:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:53PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > vhost-user allows to drive a virtio device in a seperate
> > process. After vhost-user-net, we have seen
> > vhost-user-{scsi,blk,crypto} added more recently.
> >
> > This series, initially proposed ~3 years ago, time flies
> > (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> > contributes with vhost-user-input and vhost-user-gpu.
>
>
> Pls note asan errors reported by patchew.

Those are pre-existing, and I thought we had patches on the list for
them, but I can't find them.

A quick fix could be:

diff --git a/contrib/libvhost-user/libvhost-user.c
b/contrib/libvhost-user/libvhost-user.c
index c9823a1354..944d5c9c4f 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -543,7 +543,7 @@ static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
     dev->nregions =3D memory->nregions;

     DPRINT("Nregions: %d\n", memory->nregions);
@@ -685,7 +685,7 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;

     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *r =3D &dev->regions[i];
@@ -814,7 +814,7 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
+    struct vhost_vring_addr addr =3D vmsg->payload.addr, *vra =3D &addr;
     unsigned int index =3D vra->index;
     VuVirtq *vq =3D &dev->vq[index];


>
>
> > You may start a vhost-user-gpu with virgl rendering in a separate
> > process like this:
> >
> > $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > $ qemu...
> >   -chardev socket,id=3Dchr,path=3Dvgpu.sock
> >   -device vhost-user-vga,chardev=3Dchr
> >
> > v6:
> >  - do not install vhost-user-input
> >  - install vhost-user-gpu and json file following the spec
> >  - fix the build when drm-intel-devel missing
> >  - rebase (& resend without already applied patches)
> >
> > v5:
> >  - remove user-creatable version of vhost-user-backend
> >  - remove optinal management of sub-process in vhost-user-backend
> >  - removed daemonize/pid code
> >  - drop introduction of new input & gpu messages for PCI config space
> >    handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
> >  - plain mem & udmabuf fallback for 2d rendering
> >  - rebased, kconfig-ify, rst-ify
> >
> > Marc-Andr=C3=A9 Lureau (11):
> >   Add vhost-user-backend
> >   Add vhost-user-input-pci
> >   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
> >   contrib: add vhost-user-input
> >   vhost-user: add vhost_user_gpu_set_socket()
> >   virtio: add virtio-gpu bswap helpers header
> >   util: compile drm.o on Linux
> >   contrib: add vhost-user-gpu
> >   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
> >   virtio-gpu: split virtio-gpu-pci & virtio-vga
> >   hw/display: add vhost-user-vga & gpu-pci
> >
> >  contrib/libvhost-user/libvhost-user.h      |    1 +
> >  contrib/vhost-user-gpu/drm.h               |   72 ++
> >  contrib/vhost-user-gpu/virgl.h             |   25 +
> >  contrib/vhost-user-gpu/vugpu.h             |  170 +++
> >  hw/display/virtio-vga.h                    |   32 +
> >  include/hw/virtio/vhost-backend.h          |    2 +
> >  include/hw/virtio/virtio-gpu-bswap.h       |   61 +
> >  include/hw/virtio/virtio-gpu-pci.h         |   40 +
> >  include/hw/virtio/virtio-gpu.h             |   92 +-
> >  include/hw/virtio/virtio-input.h           |   14 +
> >  include/sysemu/vhost-user-backend.h        |   57 +
> >  backends/vhost-user.c                      |  209 ++++
> >  contrib/libvhost-user/libvhost-user.c      |    5 +
> >  contrib/vhost-user-gpu/drm.c               |  341 ++++++
> >  contrib/vhost-user-gpu/main.c              | 1236 ++++++++++++++++++++
> >  contrib/vhost-user-gpu/virgl.c             |  579 +++++++++
> >  contrib/vhost-user-input/main.c            |  427 +++++++
> >  hw/display/vhost-user-gpu-pci.c            |   51 +
> >  hw/display/vhost-user-gpu.c                |  572 +++++++++
> >  hw/display/vhost-user-vga.c                |   52 +
> >  hw/display/virtio-gpu-3d.c                 |   49 +-
> >  hw/display/virtio-gpu-base.c               |  268 +++++
> >  hw/display/virtio-gpu-pci.c                |   55 +-
> >  hw/display/virtio-gpu.c                    |  415 ++-----
> >  hw/display/virtio-vga.c                    |  138 +--
> >  hw/input/vhost-user-input.c                |  129 ++
> >  hw/virtio/vhost-user-input-pci.c           |   53 +
> >  hw/virtio/vhost-user.c                     |   11 +
> >  vl.c                                       |    1 +
> >  MAINTAINERS                                |   14 +-
> >  Makefile                                   |   27 +-
> >  Makefile.objs                              |    2 +
> >  backends/Makefile.objs                     |    2 +
> >  configure                                  |   29 +
> >  contrib/vhost-user-gpu/50-qemu-gpu.json.in |    5 +
> >  contrib/vhost-user-gpu/Makefile.objs       |   10 +
> >  contrib/vhost-user-input/Makefile.objs     |    1 +
> >  docs/interop/index.rst                     |    2 +-
> >  docs/interop/vhost-user-gpu.rst            |  238 ++++
> >  docs/interop/vhost-user.txt                |    9 +
> >  hw/display/Kconfig                         |   10 +
> >  hw/display/Makefile.objs                   |    5 +-
> >  hw/input/Kconfig                           |    5 +
> >  hw/input/Makefile.objs                     |    1 +
> >  hw/virtio/Makefile.objs                    |    1 +
> >  rules.mak                                  |    9 +-
> >  util/Makefile.objs                         |    2 +-
> >  47 files changed, 5070 insertions(+), 459 deletions(-)
> >  create mode 100644 contrib/vhost-user-gpu/drm.h
> >  create mode 100644 contrib/vhost-user-gpu/virgl.h
> >  create mode 100644 contrib/vhost-user-gpu/vugpu.h
> >  create mode 100644 hw/display/virtio-vga.h
> >  create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
> >  create mode 100644 include/hw/virtio/virtio-gpu-pci.h
> >  create mode 100644 include/sysemu/vhost-user-backend.h
> >  create mode 100644 backends/vhost-user.c
> >  create mode 100644 contrib/vhost-user-gpu/drm.c
> >  create mode 100644 contrib/vhost-user-gpu/main.c
> >  create mode 100644 contrib/vhost-user-gpu/virgl.c
> >  create mode 100644 contrib/vhost-user-input/main.c
> >  create mode 100644 hw/display/vhost-user-gpu-pci.c
> >  create mode 100644 hw/display/vhost-user-gpu.c
> >  create mode 100644 hw/display/vhost-user-vga.c
> >  create mode 100644 hw/display/virtio-gpu-base.c
> >  create mode 100644 hw/input/vhost-user-input.c
> >  create mode 100644 hw/virtio/vhost-user-input-pci.c
> >  create mode 100644 contrib/vhost-user-gpu/50-qemu-gpu.json.in
> >  create mode 100644 contrib/vhost-user-gpu/Makefile.objs
> >  create mode 100644 contrib/vhost-user-input/Makefile.objs
> >  create mode 100644 docs/interop/vhost-user-gpu.rst
> >
> > --
> > 2.21.0.313.ge35b8cb8e2
>


--=20
Marc-Andr=C3=A9 Lureau

