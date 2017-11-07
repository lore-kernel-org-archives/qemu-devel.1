Received: from eggs.gnu.org ([2001:4830:134:3::10]:53000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wK-0001kw-DO
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wE-0000E3-Ch
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wE-0000DE-6O
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:16:58 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:36 +0000
Message-Id: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/6] Merge build 2017/11/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc=
6c:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-11-06 10:04:16 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-build-2017-11-07-1

for you to fetch changes up to c4b01c7c5171e9f77ed4ed6d9b4f63845410f641:

  build: remove use of MAKELEVEL optimization in submodule handling (2017=
-11-06 12:49:20 +0000)

----------------------------------------------------------------
Merge build 2017/11/07 v1

----------------------------------------------------------------

Daniel P. Berrange (6):
  build: allow setting a custom GIT binary for transparent proxying
  build: don't create temporary files in source dir
  build: allow automatic git submodule updates to be disabled
  build: don't fail if given a git submodule which does not exist
  build: delay check for empty git submodule list
  build: remove use of MAKELEVEL optimization in submodule handling

 Makefile                 | 23 +++++++++++-----
 configure                | 12 ++++++++
 scripts/git-submodule.sh | 72 ++++++++++++++++++++++++++++++++++++++----=
------
 3 files changed, 86 insertions(+), 21 deletions(-)

--=20
2.13.6
