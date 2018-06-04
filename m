Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlAs-0006lg-Li
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlAo-0007XN-MZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fPlAo-0007V9-Hm
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1DD6738E0
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 08:49:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  4 Jun 2018 10:49:01 +0200
Message-Id: <20180604084903.8163-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Vga 20180604 patches
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

The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce014=
7a:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
010618-1' into staging (2018-06-01 17:32:30 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180604-pull-request

for you to fetch changes up to 6bc2fd57e1fc2d1957d1ff952793c53764130218:

  vga: cleanup surface handling (2018-06-04 09:44:10 +0200)

----------------------------------------------------------------
Two little vga fixes.

----------------------------------------------------------------

Gerd Hoffmann (2):
  bochs-display: add missing break
  vga: cleanup surface handling

 hw/display/bochs-display.c |  1 +
 hw/display/vga.c           | 36 +++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

--=20
2.9.3
