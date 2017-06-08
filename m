Received: from eggs.gnu.org ([2001:4830:134:3::10]:58288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIrXS-0002uu-He
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIrXP-0008Qo-D7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIrXP-0008QQ-6v
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8103580478
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 07:07:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Jun 2017 09:07:09 +0200
Message-Id: <20170608070716.2954-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] ui patch queue
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

Here is the ui patch queue.  Switches the default
to gtk3 and sdl2 and fixes some bugs.

please pull,
  Gerd

The following changes since commit a0d4aac7467dd02e5657b79e867f067330266a=
24:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170605' into =
staging (2017-06-05 18:03:43 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-ui-20170608-1

for you to fetch changes up to 468949958fdfa4347a66e3cf5c8240a428532602:

  spice: don't enter opengl mode in case another UI provides opengl suppo=
rt (2017-06-08 08:13:46 +0200)

----------------------------------------------------------------
ui: prefer gtk3 and sdl2, various fixes.

----------------------------------------------------------------
Gerd Hoffmann (5):
      gtk: prefer gtk3 over gtk2
      sdl: prefer sdl2 over sdl1
      gtk: add deprecation warning for gtk2
      sdl: add deprecation warning for sdl1
      spice: don't enter opengl mode in case another UI provides opengl s=
upport

Ian McKellar via Qemu-devel (1):
      Improve Cocoa modifier key handling

Jonathon Jongsma (1):
      spice: Use proper enum type for kbd led state

 configure                  | 36 ++++++++++++++++++----------
 include/ui/spice-display.h |  2 ++
 ui/spice-core.c            |  1 +
 ui/spice-display.c         |  3 ++-
 ui/spice-input.c           |  2 +-
 ui/cocoa.m                 | 60 ++++++++++++++++++++++++++++++++++++----=
------
 6 files changed, 78 insertions(+), 26 deletions(-)
