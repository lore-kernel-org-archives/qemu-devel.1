Received: from eggs.gnu.org ([2001:4830:134:3::10]:47462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsVRp-0001ft-5f
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsVFR-0005bm-Ez
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:40:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fsVFR-0005bQ-AS
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:40:41 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Wed, 22 Aug 2018 17:40:27 +0200
Message-Id: <20180822154030.14911-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7=
d4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-req=
uest' into staging (2018-08-21 15:57:56 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180822

for you to fetch changes up to 2131f3e6e98195b4ce43a87c78cd9d8cb9f4da2c:

  seccomp: set the seccomp filter to all threads (2018-08-22 17:35:34 +02=
00)

----------------------------------------------------------------
pull-seccomp-20180822

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (3):
      seccomp: use SIGSYS signal instead of killing the thread
      seccomp: prefer SCMP_ACT_KILL_PROCESS if available
      seccomp: set the seccomp filter to all threads

 qemu-options.hx |  2 ++
 qemu-seccomp.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 2 files changed, 95 insertions(+), 3 deletions(-)

--=20
2.17.1
