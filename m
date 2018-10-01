Received: from eggs.gnu.org ([2001:4830:134:3::10]:44234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vew-00069a-Sn
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vet-0000hF-KJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6vet-0000gs-EI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD7BF307C719
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 10:42:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 12:42:27 +0200
Message-Id: <20181001104230.17779-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Ui 20181001 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit 07f426c35eddd79388a23d11cb278600d7e383=
1d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180926' into =
staging (2018-09-28 18:56:09 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20181001-pull-request

for you to fetch changes up to e8b1386ea1719525a1a92df03377764703fe8c64:

  gtk: add zoom-to-fit to gtk options. (2018-10-01 11:29:03 +0200)

----------------------------------------------------------------
ui: some small fixes/improvements.

----------------------------------------------------------------

Gerd Hoffmann (2):
  sdl2: show console #0 unconditionally
  gtk: add zoom-to-fit to gtk options.

Marc-Andr=C3=A9 Lureau (1):
  vnc: call sasl_server_init() only when required

 ui/gtk.c     |  8 ++++++++
 ui/sdl2.c    |  3 ++-
 ui/vnc.c     | 15 ++++++++-------
 qapi/ui.json | 10 +++++++++-
 4 files changed, 27 insertions(+), 9 deletions(-)

--=20
2.9.3
