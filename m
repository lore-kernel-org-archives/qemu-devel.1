Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAy4b-0007UP-Ii
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAy4X-0007Ny-G9
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAy4X-0007Mc-3o
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FD3E37E85
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 14:05:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 16:05:36 +0200
Message-Id: <20181012140538.28504-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ui2 20181012 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 69ac8c4cb93f2685839ff7b857cef306b388ff=
3c:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181012' into =
staging (2018-10-12 12:40:04 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui2-20181012-pull-request

for you to fetch changes up to 58296cb61866195297510e946a51acc5f0b9639e:

  ui: increase min required GTK3 version to 3.14.0 (2018-10-12 15:22:18 +=
0200)

----------------------------------------------------------------
ui: drop gtk2 support.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (2):
  ui: remove support for GTK2 in favour of GTK3
  ui: increase min required GTK3 version to 3.14.0

 configure            |  51 ++-----------
 include/ui/gtk.h     |   9 ---
 ui/gtk-egl.c         |  10 +--
 ui/gtk.c             | 202 ++++-----------------------------------------=
------
 qemu-deprecated.texi |   7 --
 5 files changed, 26 insertions(+), 253 deletions(-)

--=20
2.9.3
