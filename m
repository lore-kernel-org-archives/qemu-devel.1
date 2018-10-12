Received: from eggs.gnu.org ([2001:4830:134:3::10]:34231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNw-0006qK-OC
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNr-0002Xj-TZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAxNr-0002WV-KG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1555307D98F
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 13:21:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 15:21:32 +0200
Message-Id: <20181012132135.12313-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Ui 20181012 patches
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

The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a=
5b:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10'=
 into staging (2018-10-11 10:43:37 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20181012-pull-request

for you to fetch changes up to 1d454c3fee00d9d1e46e1ec6788d49da5a0bfdb0:

  gtk: fix uninitialized variable (2018-10-12 14:49:03 +0200)

----------------------------------------------------------------
ui: gtk fixes, support more formats in sdl2.

----------------------------------------------------------------

Kevin Wolf (1):
  gtk: Don't vte_terminal_set_encoding() on new VTE versions

Max Reitz (1):
  sdl2: Support all virtio-gpu formats

Paolo Bonzini (1):
  gtk: fix uninitialized variable

 ui/gtk.c     |  8 +++++---
 ui/sdl2-2d.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

--=20
2.9.3
