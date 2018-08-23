Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyV-0003xe-MH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyS-0008BV-Ul
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fsqyS-0008B3-Q6
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:36 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 23 Aug 2018 16:52:26 +0200
Message-Id: <20180823145230.13183-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com

The following changes since commit 3392fbee4e435658733bbe9aab23392660558b=
59:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-08-23 12:28:17 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180823

for you to fetch changes up to 70dfabeaa79ba4d7a3b699abe1a047c8012db114:

  seccomp: set the seccomp filter to all threads (2018-08-23 16:45:44 +02=
00)

----------------------------------------------------------------
pull-seccomp-20180823

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (4):
      seccomp: use SIGSYS signal instead of killing the thread
      seccomp: prefer SCMP_ACT_KILL_PROCESS if available
      configure: require libseccomp 2.2.0
      seccomp: set the seccomp filter to all threads

 configure      |  7 ++-----
 qemu-seccomp.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 6 deletions(-)

--=20
2.17.1
