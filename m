Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B202175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B202175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6EW-0006Si-6T
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:10:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65G-00075f-K0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65F-00020F-Gq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP65F-0001zs-Bh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B44303084029
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:01:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E59AD1001E65;
	Fri, 10 May 2019 14:01:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2AB6EA1E0; Fri, 10 May 2019 16:01:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 16:00:55 +0200
Message-Id: <20190510140103.3834-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 14:01:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Input 20190510 patches
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 812b835fb4d23dd108b2f9802158472d50b735=
79:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-05-=
07' into staging (2019-05-09 16:31:12 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/input-20190510-pull-request

for you to fetch changes up to 7fb6e5a839bc625fd64c32d167f231ecd6f2b3e2:

  virtio-input: fix Kconfig dependency and Makefile (2019-05-10 14:54:11 =
+0200)

----------------------------------------------------------------
input: add vhost-user-input, virtio-input fixes.

----------------------------------------------------------------

Gerd Hoffmann (2):
  virtio-input-host-pci: cleanup types
  virtio-input: fix Kconfig dependency and Makefile

Marc-Andr=C3=A9 Lureau (6):
  libvhost-user: fix -Waddress-of-packed-member
  libvhost-user: add PROTOCOL_F_CONFIG if {set, get}_config
  Add vhost-user-backend
  Add vhost-user-input-pci
  util: simplify unix_listen()
  contrib: add vhost-user-input

 Makefile                               |  11 +
 Makefile.objs                          |   1 +
 include/hw/virtio/virtio-input.h       |  14 +
 include/sysemu/vhost-user-backend.h    |  57 ++++
 backends/vhost-user.c                  | 209 +++++++++++++
 contrib/libvhost-user/libvhost-user.c  |  10 +-
 contrib/vhost-user-input/main.c        | 393 +++++++++++++++++++++++++
 hw/input/vhost-user-input.c            | 129 ++++++++
 hw/virtio/vhost-user-input-pci.c       |  50 ++++
 hw/virtio/virtio-input-host-pci.c      |   7 +-
 util/qemu-sockets.c                    |  18 +-
 MAINTAINERS                            |   4 +
 backends/Makefile.objs                 |   2 +
 contrib/vhost-user-input/Makefile.objs |   1 +
 hw/input/Kconfig                       |   7 +-
 hw/input/Makefile.objs                 |   5 +-
 hw/virtio/Makefile.objs                |   1 +
 17 files changed, 891 insertions(+), 28 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs

--=20
2.18.1


