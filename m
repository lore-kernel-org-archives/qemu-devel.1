Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2R-0007G1-Jx
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2Q-0006ub-QE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst2Q-0006uP-LH
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6524C0921A2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:39 +0100
Message-Id: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6 for 2.10] Parameterise self-announce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The RARP/ARP announce mechanisms have a bunch of fixed timings/counts
and on a system with a sluggish network the whole announce process
can be a bit short, ending before the networking is ready.
Make all these fixed values parameterised, document it and add a
basic test.

The default behaviour is unchanged, that is we have:
   <p> 50ms <p> 150ms <p> 250ms <p> 350ms <p>

Dave


Dr. David Alan Gilbert (6):
  migration/announce: Add parameters for self-announce
  migration/announce: Accessor functions for parameters
  migration/announce: Use the new parameters
  migration/announce: Update hmp migrate parameter info/set
  migration/announce: Document self-announce mechanism
  migration/announce: Add test

 docs/migration.txt            |  40 ++++++++++
 hmp.c                         |  36 +++++++++
 hw/net/virtio-net.c           |   3 +-
 include/migration/migration.h |   6 ++
 include/migration/vmstate.h   |  10 ---
 migration/migration.c         |  72 ++++++++++++++++++
 migration/savevm.c            |  32 +++++++-
 qapi-schema.json              |  34 ++++++++-
 tests/Makefile.include        |   2 +
 tests/announce-test.c         | 165 ++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 385 insertions(+), 15 deletions(-)
 create mode 100644 tests/announce-test.c

-- 
2.9.3
