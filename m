Received: from eggsout.gnu.org ([209.51.188.92]:56416 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVg-0003h0-AC
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVc-0007YC-A8
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfmVc-0007Wl-53
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41A37C057F36
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 14:01:03 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-216.phx2.redhat.com [10.3.116.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0383B5C22E
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 14:01:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 08:00:52 -0600
Message-Id: <20190105140100.26913-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] NBD patches through 2019-01-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fd=
ea:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-12-22 11:25:31 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-05

for you to fetch changes up to ef2e35fcc8e14bcc9366df5fdf53f65d679f8dca:

  nbd/client: Drop pointless buf variable (2019-01-05 07:53:22 -0600)

----------------------------------------------------------------
nbd patches for 2019-01-05

Error and trace improvements in NBD code, such as less noise for
common disconnect scenarios.

- Vladimir Sementsov-Ogievskiy: 0/3 nbd-client: drop extra error noise
- Eric Blake: portions of 0/22 nbd: add qemu-nbd --list

----------------------------------------------------------------
Eric Blake (6):
      nbd/client: Trace all server option error messages
      qemu-nbd: Use program name in error messages
      nbd: Document timeline of various features
      nbd/client: More consistent error messages
      qemu-nbd: Fail earlier for -c/-d on non-linux
      nbd/client: Drop pointless buf variable

Vladimir Sementsov-Ogievskiy (2):
      nbd: publish _lookup functions
      block/nbd-client: use traces instead of noisy error_report_err

 docs/interop/nbd.txt       | 19 +++++++++++++-
 include/block/nbd.h        |  5 ++++
 nbd/nbd-internal.h         |  8 ++----
 block/nbd-client.c         | 23 ++++++++++++++---
 nbd/client.c               | 63 ++++++++++++++++------------------------=
------
 qemu-nbd.c                 | 22 ++++++++++++++--
 block/trace-events         |  4 +++
 nbd/trace-events           |  1 +
 tests/qemu-iotests/083.out | 28 ---------------------
 tests/qemu-iotests/233.out |  2 +-
 10 files changed, 92 insertions(+), 83 deletions(-)

--=20
2.20.1
