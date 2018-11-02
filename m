Received: from eggs.gnu.org ([2001:4830:134:3::10]:43423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYw0-0005NH-Ub
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYmZ-0000FJ-RT
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gIYmW-0000AL-LA
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:42:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  2 Nov 2018 12:42:15 +0000
Message-Id: <20181102124220.26558-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Daniel Berrange <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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

Stefan Hajnoczi (5):
  README: use 'https://' instead of 'git://'
  get_maintainer: use 'https://' instead of 'git://'
  MAINTAINERS: use 'https://' instead of 'git://' for GitHub
  gitmodules: use 'https://' instead of 'git://'
  git: use HTTPS git URLs for repo.or.cz

 MAINTAINERS               | 88 +++++++++++++++++++--------------------
 .gitmodules               | 34 +++++++--------
 README                    |  4 +-
 pc-bios/README            |  6 +--
 scripts/get_maintainer.pl |  2 +-
 5 files changed, 67 insertions(+), 67 deletions(-)

--=20
2.17.2
