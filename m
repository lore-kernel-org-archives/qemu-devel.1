Received: from eggs.gnu.org ([2001:4830:134:3::10]:55817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiHz-0004sv-RT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiHv-0002uW-Ou
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKiHv-0002nQ-75
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Nov 2018 11:15:23 +0000
Message-Id: <20181108111531.30671-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/8] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v4:
 * Once more, with feeling!  Fix 'https//' in get_maintainer.pl [Philippe=
]
v3:
 * Fix broken openhackware URL [Eric]
 * Convert a few remaining URLs [Eric]
v2:
 * Use HTTPS for repo.or.cz [Eric]

Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HT=
TPS is
the preferred protocol because it adds some protection against
man-in-the-middle when cloning a repo.

This patch series updates git:// URLs and changes them to https://.  The =
https:// URL format is:

  https://git.qemu.org/git/<project>.git

The old git:// URL format was:

  git://git.qemu.org/<project>.git

I have also updated git://github.com/ and repo.or.cz URLs because they of=
fer HTTPS.

I have tested that submodules continue to work after the change to .gitmo=
dules.

Stefan Hajnoczi (8):
  README: use 'https://' instead of 'git://'
  get_maintainer: use 'https://' instead of 'git://'
  MAINTAINERS: use 'https://' instead of 'git://' for GitHub
  gitmodules: use 'https://' instead of 'git://'
  git: use HTTPS git URLs for repo.or.cz
  pc-testdev: use HTTPS git URL
  target-alpha: use HTTPS git URL for palcode
  docker: use HTTPS git URL for virglrenderer

 MAINTAINERS                                  | 88 ++++++++++----------
 hw/misc/pc-testdev.c                         |  2 +-
 .gitmodules                                  | 34 ++++----
 README                                       |  4 +-
 pc-bios/README                               |  8 +-
 scripts/get_maintainer.pl                    |  2 +-
 tests/docker/dockerfiles/debian-amd64.docker |  2 +-
 7 files changed, 70 insertions(+), 70 deletions(-)

--=20
2.19.1
