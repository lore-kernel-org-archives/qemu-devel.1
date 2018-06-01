Received: from eggs.gnu.org ([2001:4830:134:3::10]:60019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fOirQ-0004na-Ab
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fOirM-0004uT-8A
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:08:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fOirM-0004tc-3V
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:08:44 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Jun 2018 14:08:31 +0200
Message-Id: <20180601120832.17299-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/01] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, zyimin@linux.ibm.com

The following changes since commit 14fc618461c2756a3f0b16bf6af198c5d77311=
37:

  Merge remote-tracking branch 'remotes/sstabellini-http/tags/xen-2018053=
1-tag' into staging (2018-06-01 10:16:49 +0100)

are available in the Git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20180601

for you to fetch changes up to 4e488581de463218be39cff97530294534c9e85b

  seccomp: disable -sandbox if CONFIG_SECCOMP undefined (2018-06-01 13:44=
:15 +0200)

----------------------------------------------------------------
pull-seccomp-20180601

----------------------------------------------------------------
Yi Min Zhao (1):
      seccomp: disable -sandbox if CONFIG_SECCOMP undefined

 include/sysemu/seccomp.h |   3 +-
 qemu-seccomp.c           | 121 +++++++++++++++++++++++++++++++++++++++++=
+++-
 vl.c                     | 124 +++--------------------------------------=
------
 3 files changed, 130 insertions(+), 118 deletions(-)

--=20
2.17.0
