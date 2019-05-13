Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADBAC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B1A20578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B1A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ59Y-0006nF-IN
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:13:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ54G-0002II-3X
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ4pt-0002Il-2j
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQ4pr-0002H9-31
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4639308FBA0
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:53:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF2368D87;
	Mon, 13 May 2019 06:53:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3491B11AA3; Mon, 13 May 2019 08:53:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 08:53:03 +0200
Message-Id: <20190513065310.10263-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 06:53:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/7] Input 20190513 v2 patches
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

  git://git.kraxel.org/qemu tags/input-20190513-v2-pull-request

for you to fetch changes up to 503591cb6c28c3ddbe38ea50cab2f0dd3d6cd929:

  virtio-input: fix Kconfig dependency and Makefile (2019-05-13 08:49:30 =
+0200)

----------------------------------------------------------------
input: add vhost-user-input, virtio-input fixes.

----------------------------------------------------------------

Gerd Hoffmann (2):
  virtio-input-host-pci: cleanup types
  virtio-input: fix Kconfig dependency and Makefile

Marc-Andr=C3=A9 Lureau (5):
  libvhost-user: fix -Waddress-of-packed-member
  libvhost-user: add PROTOCOL_F_CONFIG if {set, get}_config
  Add vhost-user-backend
  Add vhost-user-input-pci
  util: simplify unix_listen()

 include/hw/virtio/virtio-input.h      |  14 ++
 include/sysemu/vhost-user-backend.h   |  57 +++++++
 backends/vhost-user.c                 | 209 ++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.c |  10 +-
 hw/input/vhost-user-input.c           | 129 ++++++++++++++++
 hw/virtio/vhost-user-input-pci.c      |  50 ++++++
 hw/virtio/virtio-input-host-pci.c     |   7 +-
 util/qemu-sockets.c                   |  18 +--
 MAINTAINERS                           |   3 +
 backends/Makefile.objs                |   2 +
 hw/input/Kconfig                      |   7 +-
 hw/input/Makefile.objs                |   5 +-
 hw/virtio/Makefile.objs               |   1 +
 13 files changed, 484 insertions(+), 28 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c

--=20
2.18.1


