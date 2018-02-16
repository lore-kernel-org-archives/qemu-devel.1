Received: from eggs.gnu.org ([2001:4830:134:3::10]:36351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dK-My
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003fY-Ja
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eF-D4
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99350407244E
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:01 +0100
Message-Id: <20180216115410.27287-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Ui 20180216 patches
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

The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58e9=
2a:

  Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +0000=
)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180216-pull-request

for you to fetch changes up to d50f09ff23f5509c05e3883440849b27af051f08:

  ui: extend VNC trottling tracing to SASL codepaths (2018-02-16 12:33:02=
 +0100)

----------------------------------------------------------------
bugfixes for vnc and sdl2

----------------------------------------------------------------

Anatoly Trosinenko (1):
  sdl: restore optimized redraw

Daniel P. Berrang=C3=A9 (5):
  vnc: remove bogus object_unref on client socket
  ui: avoid risk of 32-bit int overflow in VNC buffer check
  ui: avoid 'local_err' variable shadowing in VNC SASL auth
  ui: check VNC audio frequency limit at time of reading from client
  ui: extend VNC trottling tracing to SASL codepaths

Gerd Hoffmann (2):
  vnc: add qapi/error.h include to stubs
  sdl2: fix mouse grab

Klim Kireev (1):
  vnc: fix segfault in closed connection handling

 ui/sdl2-2d.c       | 21 ++++++---------------
 ui/sdl2.c          |  1 +
 ui/vnc-auth-sasl.c | 13 +++++++++++--
 ui/vnc-jobs.c      |  6 ++++--
 ui/vnc-stubs.c     |  1 +
 ui/vnc.c           | 42 +++++++++++++++++++++++++++++-------------
 6 files changed, 52 insertions(+), 32 deletions(-)

--=20
2.9.3
