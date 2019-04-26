Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E535C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EE9206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EE9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJy3V-0008WA-S0
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 06:26:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy2D-0007TW-Jp
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy2C-0003On-Kc
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hJy2C-0003N3-ET
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68D1A30B4758
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:46 +0000 (UTC)
Received: from localhost (ovpn-112-33.ams2.redhat.com [10.36.112.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F11A0272D6;
	Fri, 26 Apr 2019 10:24:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 12:24:31 +0200
Message-Id: <20190426102437.16189-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 26 Apr 2019 10:24:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] Add vhost-user-input
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
	kraxel@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426102431.OvlruHKkJIYOsrynjgX3llwIru4QlRFkCraTeDQYASI@z>

Hi,

This is the vhost-user-input part of "[PATCH v6 00/11] vhost-user for inp=
ut & GPU".

v1: (changes since original v6 series)
- add "libvhost-user: fix -Waddress-of-packed-member" & "util: simplify u=
nix_listen()"
- use unix_listen()
- build vhost-user-input by default (when applicable)

Marc-Andr=C3=A9 Lureau (6):
  libvhost-user: fix -Waddress-of-packed-member
  libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
  Add vhost-user-backend
  Add vhost-user-input-pci
  util: simplify unix_listen()
  contrib: add vhost-user-input

 include/hw/virtio/virtio-input.h       |  14 +
 include/sysemu/vhost-user-backend.h    |  57 ++++
 backends/vhost-user.c                  | 209 +++++++++++++
 contrib/libvhost-user/libvhost-user.c  |  10 +-
 contrib/vhost-user-input/main.c        | 393 +++++++++++++++++++++++++
 hw/input/vhost-user-input.c            | 129 ++++++++
 hw/virtio/vhost-user-input-pci.c       |  53 ++++
 util/qemu-sockets.c                    |  18 +-
 MAINTAINERS                            |   4 +
 Makefile                               |   9 +
 Makefile.objs                          |   1 +
 backends/Makefile.objs                 |   2 +
 contrib/vhost-user-input/Makefile.objs |   1 +
 hw/input/Kconfig                       |   5 +
 hw/input/Makefile.objs                 |   1 +
 hw/virtio/Makefile.objs                |   1 +
 16 files changed, 888 insertions(+), 19 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs

--=20
2.21.0.313.ge35b8cb8e2


