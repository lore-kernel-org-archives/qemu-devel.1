Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8q-000464-21
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8m-0006sU-83
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpc8m-0006sA-1H
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E5D0DF22
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:21:19 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-228.rdu2.redhat.com [10.10.120.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C84DD87800
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:21:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Sep 2017 10:21:06 -0500
Message-Id: <20170906152111.16958-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] NBD patches for 2017-09-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:

  Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-09-06

for you to fetch changes up to 030fa7f6f950f5c8963f1dee8e6bb7387ed86a99:

  nbd: Use new qio_channel_*_all() functions (2017-09-06 10:11:54 -0500)

----------------------------------------------------------------
nbd patches for 2017-09-06

- Daniel P. Berrange: [0/2] Fix / skip recent iotests with LUKS driver
- Eric Blake: [0/3] nbd: Use common read/write-all qio functions

----------------------------------------------------------------
Daniel P. Berrange (2):
      iotests: rewrite 192 to use _launch_qemu to fix LUKS support
      iotests: blacklist 194 with the luks driver

Eric Blake (3):
      io: Yield rather than wait when already in coroutine
      io: Add new qio_channel_read{, v}_all_eof functions
      nbd: Use new qio_channel_*_all() functions

 include/block/nbd.h           |  2 --
 include/io/channel.h          | 53 ++++++++++++++++++++++++++++++++++++++
 nbd/nbd-internal.h            | 41 +++++------------------------
 block/nbd-client.c            | 15 +++++------
 io/channel.c                  | 60 +++++++++++++++++++++++++++++++++++--------
 nbd/common.c                  | 45 --------------------------------
 tests/qemu-iotests/083.out    |  8 +++---
 tests/qemu-iotests/192        | 23 ++++++++++++-----
 tests/qemu-iotests/194        |  1 +
 tests/qemu-iotests/iotests.py |  4 ++-
 10 files changed, 141 insertions(+), 111 deletions(-)

-- 
2.13.5
