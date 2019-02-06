Received: from eggs.gnu.org ([209.51.188.92]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBB-0006Qg-G7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBA-0007cw-Ku
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1grNBA-0007bX-FF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 910BF3C2CD0
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 13:23:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Feb 2019 14:23:27 +0100
Message-Id: <20190206132331.1694-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] migration: Make multifd not experimental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This series:

- Change page_count default to 128.

  16 was really small, and it makes much less contention on mutexes to
  just have bigger packets.

- Drop multifd-page_count parameter

  This parameter was useful for testing, but in all my testing 128 is
  good enough, no need to have an extra knob.  Libvirt don't want to
  expose this parameter because it is difficult to explain.

- Drop experimental "x-" from multifd

  Code is stable, nothing big is happening here.

- Multifd test

  And a test for multifd, this test has already been on other patch
  series.  But now it uses the names without "-x".

Please review.

Juan Quintela (4):
  multifd: Change page count default to 128
  multifd: Drop x-multifd-page-count parameter
  multifd: Drop x-
  tests: Add migration multifd test

 hmp.c                  | 17 ++++---------
 migration/migration.c  | 56 ++++++++++--------------------------------
 migration/migration.h  |  1 -
 migration/ram.c        | 13 ++++++----
 qapi/migration.json    | 45 +++++++++++++--------------------
 tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 89 deletions(-)

--=20
2.20.1
