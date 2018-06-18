Received: from eggs.gnu.org ([2001:4830:134:3::10]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqLz-00075j-Up
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqLw-0000UO-Oj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUqLw-0000Tg-Kg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 421937DAC2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:21:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:21:29 +0200
Message-Id: <20180618092132.7253-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Usb 20180618 patches
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

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180618-pull-request

for you to fetch changes up to 0d1e8d6f4a2ced75f673edfe4d6cb78f3b361144:

  Revert "bus: do not unref the added child bus on realize" (2018-06-18 0=
9:15:51 +0200)

----------------------------------------------------------------
usb: revert ccid / qom patches.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (3):
  Revert "usb-ccid: fix bus leak"
  Revert "usb: release the created buses"
  Revert "bus: do not unref the added child bus on realize"

 hw/core/bus.c                 |  1 +
 hw/usb/dev-smartcard-reader.c |  1 -
 hw/usb/dev-storage.c          | 16 ----------------
 hw/usb/dev-uas.c              |  2 --
 4 files changed, 1 insertion(+), 19 deletions(-)

--=20
2.9.3
