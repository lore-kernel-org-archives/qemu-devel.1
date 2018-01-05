Received: from eggs.gnu.org ([2001:4830:134:3::10]:38591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxU-0002GC-ST
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxR-0005jx-LO
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXYxR-0005iT-9u
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1929C7E424
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 20:51:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 21:51:07 +0100
Message-Id: <20180105205109.683-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Improve info migrate output on
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

In v4:

Based-on: 20180103093834.20879-1-quintela@redhat.com

- update and rebase
- tcp-port is not a property that can be set anymore (peter xu)
- improve comments (eric)

Please, review.

[v3]
On top of my previous migration-for-2.11 patches.
- We don't create an uri parameter, just too complicated and not
  needed.
- So we cerate a tcp_port parameter, easier, and everybody knows what
  it means.
- Several patches reviewed integrated in for-2.11.

Please, review.

Later, Juan.

[v2]
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


*** BLURB HERE ***

Juan Quintela (2):
  migration: Create tcp_port parameter
  migration: Set the migration tcp port

 hmp.c                 |  7 +++++++
 migration/migration.c | 20 ++++++++++++++++++++
 migration/migration.h |  2 ++
 migration/socket.c    | 35 ++++++++++++++++++++++++++++++-----
 qapi/migration.json   | 19 ++++++++++++++++---
 5 files changed, 75 insertions(+), 8 deletions(-)

-- 
2.14.3
