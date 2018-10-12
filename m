Received: from eggs.gnu.org ([2001:4830:134:3::10]:48565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb8-00085c-Fr
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb5-0004bu-4k
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gAmb2-0004a5-KG
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Oct 2018 09:50:24 +0800
Message-Id: <20181012015026.17441-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block patches
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

The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a=
5b:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10'=
 into staging (2018-10-11 10:43:37 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/block-pull-request

for you to fetch changes up to 6388147296cd4c841a7d4409ba622c200332a8c7:

  nvme: correct locking around completion (2018-10-12 09:46:14 +0800)

----------------------------------------------------------------
Block patches

One fix from Marc-Andr=C3=A9 for iothread.
One fix from Paolo on nvme:// driver.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  iothread: fix crash with invalid properties

Paolo Bonzini (1):
  nvme: correct locking around completion

 block/nvme.c | 2 --
 iothread.c   | 9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

--=20
2.17.1
