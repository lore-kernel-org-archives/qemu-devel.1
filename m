Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds3EF-0006Cc-BQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds3E6-0000ss-Ay
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:40:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds3E6-0000rz-4T
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 021137F755
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:40:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 10:40:47 +0200
Message-Id: <20170913084051.21378-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Ui 20170913 patches
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

The following changes since commit 619c200f6ce2f44fbc8a5732174530c3b4782a=
ab:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-signe=
d' into staging (2017-09-11 11:44:30 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20170913-pull-request

for you to fetch changes up to 7c336f9fe53b1a500f21241841c7bf4267c7ee14:

  console: add question-mark escape operator (2017-09-13 10:17:26 +0200)

----------------------------------------------------------------
ui: console fixes
drop pixman submodule

----------------------------------------------------------------

Alexander Graf (1):
  console: add question-mark escape operator

Gerd Hoffmann (3):
  pixman: drop submodule
  pixman: drop configure switches
  console: fix dpy_gfx_replace_surface assert

 configure        | 44 ++++----------------------------------------
 Makefile         | 10 ----------
 ui/console.c     |  5 +++--
 ui/qemu-pixman.c |  4 ----
 .gitmodules      |  3 ---
 pixman           |  1 -
 6 files changed, 7 insertions(+), 60 deletions(-)
 delete mode 160000 pixman

--=20
2.9.3
