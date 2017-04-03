Received: from eggs.gnu.org ([2001:4830:134:3::10]:49160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDa-0004sM-Lp
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDZ-0004A4-Od
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cuzDZ-000490-Ij
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94E6F7E9D6
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 10:28:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Apr 2017 12:28:00 +0200
Message-Id: <20170403102803.31820-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/3] bugfixes: xhci, input-linux and vnc
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

Bugfix collection for the next 2.9-rc.

please pull,
  Gerd

The following changes since commit 95b31d709ba343ad237c3630047ee7438bac40=
65:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201703=
31.0' into staging (2017-03-31 18:06:13 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-fixes-20170403-1

for you to fetch changes up to fa03cb7fd212bc07f0253db9ea436383ddc6c08f:

  vnc: allow to connect with add_client when -vnc none (2017-04-03 11:48:=
55 +0200)

----------------------------------------------------------------
bugfixes: xhci, input-linux and vnc

----------------------------------------------------------------
Gerd Hoffmann (1):
      xhci: flush dequeue pointer to endpoint context

Javier Celaya (1):
      Fix input-linux reading from device

Marc-Andr=C3=A9 Lureau (1):
      vnc: allow to connect with add_client when -vnc none

 hw/usb/hcd-xhci.c |  4 +++-
 ui/input-linux.c  | 17 ++++++++++++-----
 ui/vnc.c          |  8 ++++----
 3 files changed, 19 insertions(+), 10 deletions(-)
