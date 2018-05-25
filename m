Received: from eggs.gnu.org ([2001:4830:134:3::10]:32857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCq0-0001Qi-MI
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCpx-0003FE-Kd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fMCpx-0003Ex-GO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFCC4401EF25
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:32:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 25 May 2018 15:32:44 +0200
Message-Id: <20180525133246.7839-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

this pull:
- fix iotests problems
- add a fix for coverity.

Apply, please.

The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-pull-request' into staging (2018-05-25 10:04:36 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180525

for you to fetch changes up to bf269906f5b225a04825b2bce4364bfe1d509999:

  migration: use g_free for ram load bitmap (2018-05-25 15:29:48 +0200)

----------------------------------------------------------------
migration/next for 20180525

----------------------------------------------------------------
Juan Quintela (1):
      migration: fix exec/fd migrations

Peter Xu (1):
      migration: use g_free for ram load bitmap

 migration/exec.c | 4 ++++
 migration/fd.c   | 4 ++++
 migration/ram.c  | 4 ++--
 3 files changed, 10 insertions(+), 2 deletions(-)
