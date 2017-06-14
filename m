Received: from eggs.gnu.org ([2001:4830:134:3::10]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005SW-6q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002Ig-24
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Ai-0002IC-Sy
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D52FB80463
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:56:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:48 +0200
Message-Id: <20170614075653.26420-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/5] ui patch queue
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

This version drops the two patches adding deprecation
warnings to configure.

please pull,
  Gerd

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae=
91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-ui-20170614-1

for you to fetch changes up to fe5c44f9c95be3f74fb58902077ac587998d1392:

  spice: don't enter opengl mode in case another UI provides opengl suppo=
rt (2017-06-14 09:52:35 +0200)

----------------------------------------------------------------
ui: prefer gtk3 and sdl2, various fixes.

----------------------------------------------------------------
Gerd Hoffmann (3):
      gtk: prefer gtk3 over gtk2
      sdl: prefer sdl2 over sdl1
      spice: don't enter opengl mode in case another UI provides opengl s=
upport

Ian McKellar via Qemu-devel (1):
      Improve Cocoa modifier key handling

Jonathon Jongsma (1):
      spice: Use proper enum type for kbd led state

 configure                  | 24 +++++++++----------
 include/ui/spice-display.h |  2 ++
 ui/spice-core.c            |  1 +
 ui/spice-display.c         |  3 ++-
 ui/spice-input.c           |  2 +-
 ui/cocoa.m                 | 60 ++++++++++++++++++++++++++++++++++++----=
------
 6 files changed, 66 insertions(+), 26 deletions(-)
