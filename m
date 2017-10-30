Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H74-0008JI-8T
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H6z-0000uE-EW
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e9H6z-0000tm-83
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F14EC85A04
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 20:56:43 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-123.rdu2.redhat.com [10.10.123.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5705C3FF
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 20:56:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:24 +0100
Message-Id: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] NBD patches prior to 2.11 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit abf6e752e55b2f5afb48303429dea2db7c3a62de:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20171030' into staging (2017-10-30 13:02:45 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-10-30

for you to fetch changes up to f140e3000371e67ff4e00df3213e2d576d9c91be:

  nbd: Minimal structured read for client (2017-10-30 21:48:41 +0100)

----------------------------------------------------------------
nbd patches for 2017-10-30

Vladimir Sementsov-Ogievskiy (some patches co-authored by Eric Blake):
00/12 nbd minimal structured read

----------------------------------------------------------------
Eric Blake (8):
      nbd: Include error names in trace messages
      nbd: Move nbd_errno_to_system_errno() to public header
      nbd: Expose constants and structs for structured read
      nbd/server: Report error for write to read-only export
      nbd/server: Simplify nbd_negotiate_options loop
      nbd/server: Refactor zero-length option check
      nbd/server: Include human-readable message in structured errors
      nbd: Move nbd_read() to common header

Vladimir Sementsov-Ogievskiy (4):
      nbd: Minimal structured read for server
      nbd/client: refactor nbd_receive_starttls
      nbd/client: prepare nbd_receive_reply for structured reply
      nbd: Minimal structured read for client

 block/nbd-client.h         |   1 +
 include/block/nbd.h        | 106 +++++++++-
 nbd/nbd-internal.h         |  23 +--
 block/nbd-client.c         | 492 ++++++++++++++++++++++++++++++++++++++++++---
 nbd/client.c               | 217 +++++++++++++-------
 nbd/common.c               |  84 ++++++++
 nbd/server.c               | 210 ++++++++++++++-----
 nbd/trace-events           |  15 +-
 tests/qemu-iotests/083.out |  15 ++
 9 files changed, 969 insertions(+), 194 deletions(-)

-- 
2.13.6
