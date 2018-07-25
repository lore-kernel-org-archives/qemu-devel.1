Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbR-0000aH-Fr
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbO-0006kC-FK
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fiKbO-0006im-Aq
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:18 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Wed, 25 Jul 2018 16:16:08 +0200
Message-Id: <20180725141610.12075-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] seccomp branch queue
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

The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4=
cc:

  Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180725

for you to fetch changes up to 5b2f59307372bae13a2ff95706646674eccb65e0:

  RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available (2018-07-25 16:=
07:31 +0200)

----------------------------------------------------------------
pull-seccomp-20180725

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      seccomp: use SIGSYS signal instead of killing the thread
      RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available

 qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--=20
2.17.1
