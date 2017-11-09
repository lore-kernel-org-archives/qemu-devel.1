Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCowv-0000Yj-2D
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCowq-0006ya-5m
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:41:01 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:6261 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eCowp-0006wk-QB
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:40:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  9 Nov 2017 18:40:47 +0300
Message-Id: <20171109154049.42386-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] add qmp nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add command to remove nbd export, pair to nbd-server-add.
The whole thing and description are in patch 02.

Vladimir Sementsov-Ogievskiy (2):
  nbd/server: add additional assert to nbd_export_put
  qmp: add nbd-server-remove

 qapi/block.json | 20 ++++++++++++++++++++
 blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
 nbd/server.c    |  1 +
 3 files changed, 48 insertions(+)

-- 
2.11.1
