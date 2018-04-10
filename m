Received: from eggs.gnu.org ([2001:4830:134:3::10]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWD-0004jY-U6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWC-0006V8-S9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5pWC-0006Tl-MW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC317818AAE8
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 09:24:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Apr 2018 11:24:42 +0200
Message-Id: <20180410092446.26903-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Ui 20180410 patches
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

The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b=
32:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-04-09 17:29:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180410-pull-request

for you to fetch changes up to c6093a05d6a84d2144bb6462cf20e907eddf8aeb:

  configure: don't warn SDL abi if disabled (2018-04-10 11:22:03 +0200)

----------------------------------------------------------------
configure: don't warn on old sdl/gtk versions if disabled.
keymap + gtk fixes.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  ui: fix keymap detection under Xwayland

Gerd Hoffmann (1):
  gtk: drop pointless code from gd_window_close

Peter Xu (2):
  configure: don't warn GTK if disabled
  configure: don't warn SDL abi if disabled

 configure     | 110 +++++++++++++++++++++++++++++++---------------------=
------
 ui/gtk.c      |   8 -----
 ui/x_keymap.c |   7 ++--
 3 files changed, 63 insertions(+), 62 deletions(-)

--=20
2.9.3
