Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxed-0001bN-BE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxeZ-0005MD-74
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dIxeZ-0005L8-1A
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6618537E66
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:39:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  8 Jun 2017 10:39:01 -0300
Message-Id: <20170608133906.12737-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Error handling cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This series fixes and simplifies some of the existing code that
assigns to *errp directly.

Eduardo Habkost (5):
  xilinx: Fix error handling
  block: Don't try to set *errp directly
  websock: Don't try to set *errp directly
  migration: Don't try to set *errp directly
  vnc: No need for Error** parameter at vnc_client_io_error()

 ui/vnc.h                |  2 +-
 block.c                 |  8 +++-----
 hw/dma/xilinx_axidma.c  |  4 +---
 hw/net/xilinx_axienet.c |  4 +---
 io/channel-websock.c    |  4 ++--
 migration/migration.c   |  2 +-
 ui/vnc.c                | 13 +++++--------
 7 files changed, 14 insertions(+), 23 deletions(-)

-- 
2.11.0.259.g40922b1
