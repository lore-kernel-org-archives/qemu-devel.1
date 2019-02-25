Received: from eggs.gnu.org ([209.51.188.92]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3X-0007cW-Ot
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3R-0008Tc-T2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gyI3H-0008JU-CI
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9E1030832C4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:20:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-222.phx2.redhat.com [10.3.116.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81253600C8
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:20:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Feb 2019 09:20:12 -0600
Message-Id: <20190225152015.26089-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] NBD patches for 2019-02-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 59a568b57848b10e8a44518a889323f12ccdd8=
f4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190222-pull-req=
uest' into staging (2019-02-25 12:49:07 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-25

for you to fetch changes up to f62b3c953fae63e627cfe86333efb6294bb48a14:

  iotests: avoid broken pipe with certtool (2019-02-25 08:20:17 -0600)

----------------------------------------------------------------
nbd patches for 2019-02-25

- iotest failure fixes for tests related to NBD

----------------------------------------------------------------
Andrey Shinkevich (1):
      iotests: handle TypeError for Python3 in test 242

Daniel P. Berrang=C3=A9 (2):
      iotests: ensure we print nbd server log on error
      iotests: avoid broken pipe with certtool

 tests/qemu-iotests/common.tls | 48 ++++++++++++++++++++++++++++---------=
------
 tests/qemu-iotests/233        |  3 +++
 tests/qemu-iotests/242        |  8 ++++++--
 3 files changed, 41 insertions(+), 18 deletions(-)

--=20
2.20.1
