Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E6BC28CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8EB21734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8EB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqPu-0006T0-I5
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:42:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqOA-0005DE-Q4
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqO9-00068Q-Jm
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVqO9-00064w-Ax
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3EF83087926
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:40:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D798798A9;
	Wed, 29 May 2019 04:40:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8F0EF16E36; Wed, 29 May 2019 06:40:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 06:40:11 +0200
Message-Id: <20190529044020.27003-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 04:40:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/9] Vga 20190529 patches
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit da35f7f1eeff9f249a9597400fc514c83fd3a0=
f8:

  virtio-gpu: add sanity check (2019-05-28 08:14:44 +0200)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190529-pull-request

for you to fetch changes up to 267f664658fee4138f80013fa25354191e8091cb:

  hw/display: add vhost-user-vga & gpu-pci (2019-05-29 06:30:45 +0200)

----------------------------------------------------------------
vga: add vhost-user-gpu.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (9):
  vhost-user: add vhost_user_gpu_set_socket()
  virtio-gpu: add bswap helpers header
  virtio-gpu: add a pixman helper header
  util: compile drm.o on posix
  contrib: add vhost-user-gpu
  spice-app: fix running when !CONFIG_OPENGL
  virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
  virtio-gpu: split virtio-gpu-pci & virtio-vga
  hw/display: add vhost-user-vga & gpu-pci

 configure                                  |   17 +
 Makefile                                   |   24 +-
 Makefile.objs                              |    1 +
 contrib/libvhost-user/libvhost-user.h      |    1 +
 contrib/vhost-user-gpu/virgl.h             |   25 +
 contrib/vhost-user-gpu/vugbm.h             |   67 ++
 contrib/vhost-user-gpu/vugpu.h             |  177 +++
 hw/display/virtio-vga.h                    |   32 +
 include/hw/virtio/vhost-backend.h          |    2 +
 include/hw/virtio/virtio-gpu-bswap.h       |   61 +
 include/hw/virtio/virtio-gpu-pci.h         |   40 +
 include/hw/virtio/virtio-gpu-pixman.h      |   45 +
 include/hw/virtio/virtio-gpu.h             |   92 +-
 contrib/libvhost-user/libvhost-user.c      |    1 +
 contrib/vhost-user-gpu/main.c              | 1185 ++++++++++++++++++++
 contrib/vhost-user-gpu/virgl.c             |  579 ++++++++++
 contrib/vhost-user-gpu/vugbm.c             |  328 ++++++
 hw/display/vhost-user-gpu-pci.c            |   51 +
 hw/display/vhost-user-gpu.c                |  607 ++++++++++
 hw/display/vhost-user-vga.c                |   52 +
 hw/display/virtio-gpu-3d.c                 |   49 +-
 hw/display/virtio-gpu-base.c               |  268 +++++
 hw/display/virtio-gpu-pci.c                |   55 +-
 hw/display/virtio-gpu.c                    |  448 ++------
 hw/display/virtio-vga.c                    |  138 +--
 hw/virtio/vhost-user.c                     |   11 +
 ui/spice-app.c                             |    3 +-
 vl.c                                       |    1 +
 MAINTAINERS                                |   10 +-
 contrib/vhost-user-gpu/50-qemu-gpu.json.in |    5 +
 contrib/vhost-user-gpu/Makefile.objs       |   10 +
 docs/interop/index.rst                     |    1 +
 docs/interop/vhost-user-gpu.rst            |  242 ++++
 docs/interop/vhost-user.rst                |    9 +
 hw/display/Kconfig                         |   10 +
 hw/display/Makefile.objs                   |    5 +-
 rules.mak                                  |    9 +-
 util/Makefile.objs                         |    2 +-
 38 files changed, 4176 insertions(+), 487 deletions(-)
 create mode 100644 contrib/vhost-user-gpu/virgl.h
 create mode 100644 contrib/vhost-user-gpu/vugbm.h
 create mode 100644 contrib/vhost-user-gpu/vugpu.h
 create mode 100644 hw/display/virtio-vga.h
 create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
 create mode 100644 include/hw/virtio/virtio-gpu-pci.h
 create mode 100644 include/hw/virtio/virtio-gpu-pixman.h
 create mode 100644 contrib/vhost-user-gpu/main.c
 create mode 100644 contrib/vhost-user-gpu/virgl.c
 create mode 100644 contrib/vhost-user-gpu/vugbm.c
 create mode 100644 hw/display/vhost-user-gpu-pci.c
 create mode 100644 hw/display/vhost-user-gpu.c
 create mode 100644 hw/display/vhost-user-vga.c
 create mode 100644 hw/display/virtio-gpu-base.c
 create mode 100644 contrib/vhost-user-gpu/50-qemu-gpu.json.in
 create mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 docs/interop/vhost-user-gpu.rst

--=20
2.18.1


