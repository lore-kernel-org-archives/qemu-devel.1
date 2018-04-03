Received: from eggs.gnu.org ([2001:4830:134:3::10]:39579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3RhO-0006qr-Qx
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3RhL-0002ZD-Ok
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3RhL-0002Z2-Jj
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5096F8151D46
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 19:34:25 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-104.rdu2.redhat.com [10.10.123.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0761C10FFE73
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 19:34:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Apr 2018 14:34:17 -0500
Message-Id: <20180403193420.2065215-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] QAPI and misc patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 13b65ec54dbf524cb62331281a98b432f78d4e=
3a:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-04-02' i=
nto staging (2018-04-03 15:59:50 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-03

for you to fetch changes up to 1ecaef92a1d158bd875bf66091325d4721eb2762:

  dump: Fix build with newer gcc (2018-04-03 13:47:08 -0500)

----------------------------------------------------------------
qapi and misc patches for 2018-04-03

- Peter Xu: monitor: bind dispatch bh to iohandler context
- Eric Blake: maint: Add .mailmap entries for patches claiming list autho=
rship
- Eric Blake: dump: Fix build with newer gcc

----------------------------------------------------------------
Eric Blake (2):
      maint: Add .mailmap entries for patches claiming list authorship
      dump: Fix build with newer gcc

Peter Xu (1):
      monitor: bind dispatch bh to iohandler context

 dump.c    |  4 ++--
 monitor.c |  2 +-
 .mailmap  | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 7 deletions(-)

--=20
2.14.3
