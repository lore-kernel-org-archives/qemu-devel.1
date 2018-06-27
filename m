Received: from eggs.gnu.org ([2001:4830:134:3::10]:48883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zf-000145-I4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zb-0001Uy-Kw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY9zb-0001TE-G1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 977335BCBE
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:56:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Jun 2018 14:55:48 +0200
Message-Id: <20180627125604.15275-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/16] Migration
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

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1=
f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180627

for you to fetch changes up to ca273df3014930f4ecb6d3ba24aa778354634b56:

  migration: fix crash in when incoming client channel setup fails (2018-=
06-27 13:29:35 +0200)

----------------------------------------------------------------
migration/next for 20180627

This series contains:
- fix tls crash (danp)
- drop unused parameter from postcopy (david)
- multifd series (me)

Please, apply.

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (1):
      migration: fix crash in when incoming client channel setup fails

David Hildenbrand (1):
      postcopy: drop ram_pages parameter from postcopy_ram_incoming_init(=
)

Juan Quintela (14):
      migration: Create multipage support
      migration: Create multifd packet
      migration: Calculate mbps only during transfer time
      migration: Abstract the number of bytes sent
      migration: Add multifd traces for start/end thread
      migration: Multifd channels always wait on the sem
      migration: Add block where to send/receive packets
      migration: Synchronize multifd threads with main thread
      migration: Create multifd_bytes ram_counter
      migration: Create ram_save_multifd_page
      migration: Start sending messages
      migration: Wait for blocking IO
      migration: Remove not needed semaphore and quit
      migration: Stop sending whole pages through main channel

 exec.c                   |   2 +-
 hmp.c                    |   2 +
 include/exec/ram_addr.h  |   1 -
 migration/migration.c    |  24 ++-
 migration/postcopy-ram.c |   4 +-
 migration/postcopy-ram.h |   2 +-
 migration/ram.c          | 491 +++++++++++++++++++++++++++++++++++++++++=
++++--
 migration/trace-events   |  12 ++
 qapi/migration.json      |   5 +-
 9 files changed, 514 insertions(+), 29 deletions(-)
