Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1e-00036i-Kb
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1a-0003pJ-Fi
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8O1a-0003oT-9g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9095F86674
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 11:12:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 13:11:53 +0200
Message-Id: <20181005111157.12801-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Vga 20181005 patches
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

The following changes since commit dafd95053611aa14dda40266857608d12ddce6=
58:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-02 18:27:18 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20181005-pull-request

for you to fetch changes up to edbc4b24bbb179fa9562d4e5313470f10569433c:

  edid: fix vendor default (2018-10-05 11:26:56 +0200)

----------------------------------------------------------------
vga: edid fixes, qxl clang workaround, vga mmio subregion fix.

----------------------------------------------------------------

Eric Blake (1):
  edid: Ignore built binary

Gerd Hoffmann (1):
  edid: fix vendor default

Peter Maydell (1):
  hw/display/qxl: Suppress clang-7 warning about misaligned atomic
    operation

remy.noel (1):
  secondary-vga: delete mmio subregions upon exit

 include/hw/display/edid.h  |  2 +-
 include/qemu/compiler.h    |  9 +++++++++
 hw/display/edid-generate.c |  2 +-
 hw/display/qxl.c           | 26 +++++++++++++++++++++++++-
 hw/display/vga-pci.c       |  8 ++++++++
 .gitignore                 |  1 +
 6 files changed, 45 insertions(+), 3 deletions(-)

--=20
2.9.3
