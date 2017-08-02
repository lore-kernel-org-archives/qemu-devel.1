Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckHu-0003KT-GH
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckHr-0000dm-65
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dckHr-0000dS-0t
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6D5216BB16
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 03:25:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 Aug 2017 11:25:19 +0800
Message-Id: <1501644321-17721-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migration: fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Two patches isolated from the postcopy recovery series, which may be
good for 2.10.

Peter Xu (2):
  migration: fix comment disorder in RAMState
  io: fix qio_channel_socket_accept err handling

 io/channel-socket.c | 3 ++-
 migration/ram.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.4
