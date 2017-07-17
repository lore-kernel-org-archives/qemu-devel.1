Received: from eggs.gnu.org ([2001:4830:134:3::10]:57254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Ny-0002mA-Q3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Nv-0007Vi-O1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX8Nv-0007VU-Hy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09EB37DCC9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 15:56:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:27 -0500
Message-Id: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Easier conversion from qapi to qobject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

I'm not sure if I'm posted this before, or if it is a cleanup I've
just been sitting on locally.  In all likelihood, it will miss
tomorrow's freeze due to lack of review time, and thus be 2.11
material, but we'll see...

Eric Blake (5):
  qapi: Add QAPI_TO_QOBJECT() convenience macro
  nbd: Use simpler QAPI_TO_QOBJECT()
  nfs: Use simpler QAPI_TO_QOBJECT()
  qapi: Use simpler QAPI_TO_QOBJECT()
  blockdev: Use simpler QAPI_TO_QOBJECT()

 include/qapi/qobject-output-visitor.h | 19 +++++++++++++++++++
 block/nbd.c                           |  8 +++-----
 block/nfs.c                           |  8 +++-----
 block/qapi.c                          |  7 +++----
 blockdev.c                            | 13 ++++---------
 qapi/qobject-output-visitor.c         | 16 ++++++++++++++++
 6 files changed, 48 insertions(+), 23 deletions(-)

-- 
2.13.3
