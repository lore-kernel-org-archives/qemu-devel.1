Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWO-00047Q-61
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWL-0005jt-6N
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWL-0005jG-0d
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7478AC03BD7A
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:43 +0100
Message-Id: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Hi

This are the current migration pull:
- fix long id's for migration (David)
- several postcopy fixes (David)
- create the incomming state in a single place for Migraition (me)

Please, apply.

The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0ff4:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' into staging (2017-02-06 11:44:08 +0000)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170206

for you to fetch changes up to ef8d6488d2767fe81bb4bb9bcdc52af5ff718b56:

  postcopy: Recover block devices on early failure (2017-02-06 13:36:49 +0100)

----------------------------------------------------------------
migration/next for 20170206

----------------------------------------------------------------
Dr. David Alan Gilbert (5):
      vmstate_register_with_alias_id: Take an Error **
      migration: Check for ID length
      vmstate registration: check return values
      Postcopy: Reset state to avoid cleanup assert
      postcopy: Recover block devices on early failure

Juan Quintela (1):
      migration: create Migration Incoming State at init time

 hw/core/qdev.c                |  9 ++++---
 hw/intc/apic_common.c         |  2 +-
 include/migration/migration.h |  1 -
 include/migration/vmstate.h   |  7 +++--
 migration/migration.c         | 63 ++++++++++++++++++++++++++++---------------
 migration/savevm.c            | 29 ++++++++++++++------
 stubs/vmstate.c               |  3 ++-
 7 files changed, 77 insertions(+), 37 deletions(-)
