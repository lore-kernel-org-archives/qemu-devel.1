Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988A-0005Pb-Tg
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e9886-0007iJ-0S
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e9885-0007hk-RD
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D377FFED0
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:21:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 30 Oct 2017 12:21:06 +0100
Message-Id: <20171030112112.6952-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Improve info migrate output on destination
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
  qio: Make port 0 work for qio
  migration: print features as on off
  migration: free addr in the same function that we created it
  migration: Create uri parameter
  migration: Now set the migration uri
  migration: make migrate uri parameter optional

 hmp-commands.hx       |  4 ++--
 hmp.c                 | 12 +++++++++--
 migration/migration.c | 59 ++++++++++++++++++++++++++++++++++++++++-----------
 migration/migration.h |  2 ++
 migration/socket.c    | 11 ++++++++--
 qapi/migration.json   | 20 +++++++++++++----
 util/qemu-sockets.c   | 11 ++++++----
 7 files changed, 93 insertions(+), 26 deletions(-)

-- 
2.13.6
