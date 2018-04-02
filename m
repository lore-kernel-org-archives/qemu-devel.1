Received: from eggs.gnu.org ([2001:4830:134:3::10]:51585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30G1-0000KW-Ms
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30Fy-0004Ki-Bh
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f30Fy-0004KE-7o
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63645401CC41
	for <qemu-devel@nongnu.org>; Mon,  2 Apr 2018 14:16:19 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-146.rdu2.redhat.com [10.10.122.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD51D7DFE
	for <qemu-devel@nongnu.org>; Mon,  2 Apr 2018 14:16:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Apr 2018 09:16:11 -0500
Message-Id: <20180402141614.2008263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] NBD patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-04-02

for you to fetch changes up to 2b53af2523f6a3387f71372f59d3717f1f7d5fd9:

  nbd: trace meta context negotiation (2018-04-02 09:10:49 -0500)

----------------------------------------------------------------
nbd patches for 2018-04-02

- Eric Blake: nbd: Fix 32-bit compilation on BLOCK_STATUS
- Eric Blake: nbd/client: Correctly handle bad server REP_META_CONTEXT
- Eric Blake: nbd: trace meta context negotiation

----------------------------------------------------------------
Eric Blake (3):
      nbd: Fix 32-bit compilation on BLOCK_STATUS
      nbd/client: Correctly handle bad server REP_META_CONTEXT
      nbd: trace meta context negotiation

 block/nbd-client.c |  2 +-
 nbd/client.c       | 30 +++++++++++++++++++++++-------
 nbd/server.c       |  8 ++++++++
 nbd/trace-events   |  6 ++++++
 4 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.14.3
