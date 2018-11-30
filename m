Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSXLT-0000CC-C4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSXLQ-0004Jv-84
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:11:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSXLP-0004Gx-VS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:11:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3999CC05000A
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 01:11:47 +0000 (UTC)
Received: from red.redhat.com (ovpn-117-105.phx2.redhat.com [10.3.117.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 010E26A6AB
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 01:11:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 29 Nov 2018 19:11:44 -0600
Message-Id: <20181130011146.3065277-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1? 0/2] NBD dirty bitmap cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm working on a bigger series to add 'qemu-nbd --list' that shows
all details about all exports of a given server. In the process,
it turned up a couple of bugs. By themselves, these are not enough
to cause -rc4 (the bugs already existed in 3.0; this is not a
regression fix), but if we have -rc4 for any other reason, both
of these would be nice to have as it makes incremental backups
easier to manage.

Eric Blake (2):
  nbd/server: Advertise all contexts in response to bare LIST
  nbd/client: Make x-dirty-bitmap more reliable

 nbd/client.c | 21 +++++++++++++++++++++
 nbd/server.c |  1 +
 2 files changed, 22 insertions(+)

-- 
2.17.2
