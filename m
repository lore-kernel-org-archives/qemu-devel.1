Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErE-0008TI-1q
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErA-0005Y2-K4
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cmErA-0005Xg-Ep
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:20:56 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 10 Mar 2017 15:20:49 +0800
Message-Id: <20170310072051.15704-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Docker patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit eba44e9339fc13c36e24c8c59e2b73ea231b46=
a1:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' i=
nto staging (2017-03-06 15:13:23 +0000)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to 8ba1e5f72b17584f23e17c54494bb4beeb05174e:

  docker/dockerfiles/debian-s390-cross: include clang (2017-03-10 15:05:2=
2 +0800)

----------------------------------------------------------------

Hi Peter, here are two more docker patches:

- Fix for shippable.
- Improvement on proxy env var. Technically it's not a fix but since it's=
 under
  tests/, it doesn't have to wait for the 2.10 window.

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  docker/dockerfiles/debian-s390-cross: include clang

Philippe Mathieu-Daud=C3=A9 (1):
  tests/docker: support proxy / corporate firewall

 tests/docker/docker.py                             | 6 ++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--=20
2.9.3
