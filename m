Received: from eggs.gnu.org ([2001:4830:134:3::10]:42803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3l-0002ul-3m
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008N6-OU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008Mr-Jh
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B57984072CF7
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 13:57:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Mar 2018 14:57:28 +0100
Message-Id: <20180329135730.95774-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c9678112=
5a:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-import=
ant-fixes' into staging (2018-03-28 22:13:38 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180329a

for you to fetch changes up to 0746a92612276aee69e66dfe6782b0f882d221d5:

  migration: Don't activate block devices if using -S (2018-03-29 14:53:1=
6 +0100)

----------------------------------------------------------------
Migration pull (small fixes)

A pair of two small fixes for 2.12.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      migration: Don't activate block devices if using -S

Marc-Andr=C3=A9 Lureau (1):
      migration: fix pfd leak

 migration/migration.c    | 22 +++++++++++++++-------
 migration/postcopy-ram.c |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)
