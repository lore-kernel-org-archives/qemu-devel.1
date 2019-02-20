Received: from eggs.gnu.org ([209.51.188.92]:43200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwTm0-0001ju-PK
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwTly-0008QY-Gp
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:27:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwTly-0007N4-94
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 886468B108
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:58:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 13:57:52 +0100
Message-Id: <20190220125755.3906-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] WIP: Multifd compression support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This series create compression code on top of multifd.  It is still
WIP, but it is already:
- faster that current compression code
- it does the minimum amount of copies possible
- we allow support for other compression codes
- it pass the multifd test sent in my previous series

Test for existing code didn't work because code is too slow, I need to
make downtime 10 times bigger to make it to converge on my test
machine.  This code works with same limits that multifd no-

ToDo:
- move printf's  to traces
- move code to a struct instead of if (zlib) inside the main threads.
- improve error handling.

Please, review and coment.

Juan Quintela (3):
  migration: Add multifd-compress parameter
  multifd: compression support variables
  multifd: Start of zlib compression code

 hmp.c                        |  23 +++++-
 hw/core/qdev-properties.c    |  11 +++
 include/hw/qdev-properties.h |   1 +
 migration/migration.c        |  25 ++++++
 migration/migration.h        |   1 +
 migration/ram.c              | 142 ++++++++++++++++++++++++++++++++++-
 migration/trace-events       |   2 +-
 qapi/common.json             |  15 ++++
 qapi/migration.json          |  20 ++++-
 9 files changed, 229 insertions(+), 11 deletions(-)

--=20
2.20.1
