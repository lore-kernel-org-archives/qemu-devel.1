Received: from eggs.gnu.org ([2001:4830:134:3::10]:41269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aE-0000L7-3g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aA-00056R-Rk
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d99aA-000562-LQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95E41C05678D
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:22:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 14:21:52 +0200
Message-Id: <20170512122158.32032-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] usb patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Here comes the usb patch queue, with a bugfix collection and a
documentation update.

please pull,
  Gerd

The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:

  Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-usb-20170512-1

for you to fetch changes up to aa612b364ecbe1dc034efcabb04526f24e56c145:

  hw/usb/dev-serial: Do not try to set vendorid or productid properties (=
2017-05-12 12:30:23 +0200)

----------------------------------------------------------------
usb: bugfixes, doc update

----------------------------------------------------------------
Gerd Hoffmann (1):
      usb-redir: fix stack overflow in usbredir_log_data

Ladi Prosek (3):
      xhci: fix logging
      usb-hub: clear PORT_STAT_SUSPEND on wakeup
      xhci: relax link check

Thomas Huth (2):
      qemu-doc: Update to use the new way of attaching USB devices
      hw/usb/dev-serial: Do not try to set vendorid or productid properti=
es

 docs/qdev-device-use.txt |  6 ++--
 hw/usb/dev-hub.c         |  1 +
 hw/usb/dev-serial.c      | 24 ++++---------
 hw/usb/hcd-xhci.c        |  9 ++---
 hw/usb/redirect.c        | 13 +------
 qemu-doc.texi            | 91 +++++++++++++++++++++++++++---------------=
------
 6 files changed, 64 insertions(+), 80 deletions(-)
