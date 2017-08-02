Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq9r-0006RB-C0
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq9i-0004XE-5l
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcq9h-0004WB-Ux
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2C53C0587C1
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 09:41:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 Aug 2017 17:41:18 +0800
Message-Id: <1501666880-10159-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] migration: fixes for 2.10
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

v2:
- patch 2: move trace_*() after error_setg_errno(). [Dan]

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
