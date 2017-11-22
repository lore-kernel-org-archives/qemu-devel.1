Received: from eggs.gnu.org ([2001:4830:134:3::10]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUMH-0004g4-Af
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUME-00077b-5b
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHUMD-00076v-Ux
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5D80C0587C5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 12:42:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Nov 2017 13:42:13 +0100
Message-Id: <20171122124219.12954-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Improve info migrate output on
 destination
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

For v2:
- dropped the qio patch, get the address later with qio_socket_get_local_address
 (danp)
- set the uri with all the options (danp found it)
- rebase on top of latest rc

Please review.

Later, Juan.

[v1]
This series (on top of my last pull requset) do:

- Make update port for address work for port 0.
  Right now we only update the _port_ that we ask for, not the one that we receive.
- Print global options as everything else (i.e. one by line, and on/off)
- Move addr cleanup to the place where we created it
- Create an uri migration parameter
- Fill the migrate parameter and set it.
- make the uri parameter optional for migrate

Please review.

Later, Juan.

Juan Quintela (6):
  migration: print features as on off
  migration: free addr in the same function that we created it
  migration: Create uri parameter
  migration: Now set the migration uri
  migration: make migrate uri parameter optional
  migration: Set the new port/address in the uri parameter

 hmp-commands.hx       |  4 ++--
 hmp.c                 | 12 +++++++++--
 migration/migration.c | 59 ++++++++++++++++++++++++++++++++++++++++-----------
 migration/migration.h |  2 ++
 migration/socket.c    | 41 +++++++++++++++++++++++++++++------
 qapi/migration.json   | 20 +++++++++++++----
 6 files changed, 111 insertions(+), 27 deletions(-)

-- 
2.13.6
