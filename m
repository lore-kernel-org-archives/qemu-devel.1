Received: from eggs.gnu.org ([2001:4830:134:3::10]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH6wq-0007wD-4v
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH6wj-0005MA-RL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH6wj-0005Im-IP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72C5A31A5451
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:47:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 13:47:01 +0100
Message-Id: <20181029124703.11123-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Vga 20181029 patches
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

The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487=
b8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-19 19:01:07 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20181029-pull-request

for you to fetch changes up to e69a10f468d8f6aa6c00a4308f5a8e1f2fd6b3a1:

  vga_int: remove unused function protype (2018-10-29 10:43:48 +0100)

----------------------------------------------------------------
vga: two fixes.

----------------------------------------------------------------

Gerd Hoffmann (1):
  qxl: store channel id in qxl->id

yuchenlin (1):
  vga_int: remove unused function protype

 hw/display/qxl.h     |  1 +
 hw/display/vga_int.h |  1 -
 hw/display/qxl.c     | 19 ++++++++++++-------
 3 files changed, 13 insertions(+), 8 deletions(-)

--=20
2.9.3
