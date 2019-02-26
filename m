Received: from eggs.gnu.org ([209.51.188.92]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfvu-0007qt-Hh
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfvs-0001RY-E9
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gyfvs-0001Q3-7z
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78A5530BCCF7
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 16:50:15 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-222.phx2.redhat.com [10.3.116.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42A0329341
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 16:50:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 26 Feb 2019 10:50:10 -0600
Message-Id: <20190226165013.24867-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/3] NBD patches for 2019-02-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d88d85f1f0625d57e9f354aa0874c4c8b5d1fb=
47:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-25 17:28:04 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-25-v2

for you to fetch changes up to 3e6f45446b11ccc20b4b751f70331f03d70369b8:

  iotests: avoid broken pipe with certtool (2019-02-26 10:45:37 -0600)

(v2: pull in Andrey's v3 python patch per last-minute list emails)

----------------------------------------------------------------
nbd patches for 2019-02-25

- iotest failure fixes for tests related to NBD

----------------------------------------------------------------
Andrey Shinkevich (1):
      iotests: handle TypeError for Python 3 in test 242

Daniel P. Berrang=C3=A9 (2):
      iotests: ensure we print nbd server log on error
      iotests: avoid broken pipe with certtool

 tests/qemu-iotests/common.tls | 48 ++++++++++++++++++++++++++++---------=
------
 tests/qemu-iotests/233        |  3 +++
 tests/qemu-iotests/242        |  8 +++++---
 3 files changed, 40 insertions(+), 19 deletions(-)

--=20
2.20.1
