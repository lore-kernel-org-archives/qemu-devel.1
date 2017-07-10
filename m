Received: from eggs.gnu.org ([2001:4830:134:3::10]:46736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUaF3-0000bR-TY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUaF0-00086C-OI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUaF0-00085p-FO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A78A769E0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 15:04:49 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-60.rdu2.redhat.com [10.10.121.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E458E7D50C
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 15:04:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 10:04:29 -0500
Message-Id: <20170710150440.11303-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/11] NBD patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 94c56652b9079cfb9d560a6dde7ecb15eb9ef9c7:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-07-10 14:06:49 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-10-v2

for you to fetch changes up to 9588463e747706ffbaf6f4600b5efea2779bc26f:

  nbd: use generic trace subsystem instead of TRACE macro (2017-07-10 09:57:24 -0500)

----------------------------------------------------------------
nbd patches for 2017-07-10

- Eric Blake: MAINTAINERS: Promote NBD to supported, with new maintainer
- Vladimir Sementsov-Ogievskiy: [00/10] nbd refactoring part 2

----------------------------------------------------------------

v2: fixed cover letter, drop Paolo's unused T: in MAINTAINERS
[only sending the modified patch]

Eric Blake (1):
      MAINTAINERS: Promote NBD to supported, with new maintainer

Vladimir Sementsov-Ogievskiy (10):
      nbd/server: nbd_negotiate: return 1 on NBD_OPT_ABORT
      nbd/server: refactor nbd_negotiate
      nbd/server: use errp instead of LOG
      nbd/server: add errp to nbd_send_reply()
      nbd/common: nbd_tls_handshake: remove extra TRACE
      nbd/client: refactor TRACE of NBD_MAGIC
      nbd/server: fix TRACE in nbd_negotiate_send_rep_len
      nbd/server: rename clientflags var in nbd_negotiate_options
      nbd: refactor tracing
      nbd: use generic trace subsystem instead of TRACE macro

 nbd/nbd-internal.h |  19 ---
 nbd/client.c       |  81 +++++------
 nbd/common.c       |   4 +-
 nbd/server.c       | 401 +++++++++++++++++++++++++++++------------------------
 MAINTAINERS        |  21 +--
 Makefile.objs      |   1 +
 nbd/trace-events   |  56 ++++++++
 7 files changed, 323 insertions(+), 260 deletions(-)
 create mode 100644 nbd/trace-events

Eric Blake (1):
  MAINTAINERS: Promote NBD to supported, with new maintainer

Vladimir Sementsov-Ogievskiy (10):
  nbd/server: nbd_negotiate: return 1 on NBD_OPT_ABORT
  nbd/server: refactor nbd_negotiate
  nbd/server: use errp instead of LOG
  nbd/server: add errp to nbd_send_reply()
  nbd/common: nbd_tls_handshake: remove extra TRACE
  nbd/client: refactor TRACE of NBD_MAGIC
  nbd/server: fix TRACE in nbd_negotiate_send_rep_len
  nbd/server: rename clientflags var in nbd_negotiate_options
  nbd: refactor tracing
  nbd: use generic trace subsystem instead of TRACE macro

 nbd/nbd-internal.h |  19 ---
 nbd/client.c       |  81 +++++------
 nbd/common.c       |   4 +-
 nbd/server.c       | 401 +++++++++++++++++++++++++++++------------------------
 MAINTAINERS        |  21 +--
 Makefile.objs      |   1 +
 nbd/trace-events   |  56 ++++++++
 7 files changed, 323 insertions(+), 260 deletions(-)
 create mode 100644 nbd/trace-events

-- 
2.9.4
