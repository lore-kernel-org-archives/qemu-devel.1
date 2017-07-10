Received: from eggs.gnu.org ([2001:4830:134:3::10]:54608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaW-0001dn-9R
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaR-0002XT-BR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUXaR-0002Wd-4q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4868C624B3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 12:14:45 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-60.rdu2.redhat.com [10.10.121.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE29578DE1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 12:14:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:23 -0500
Message-Id: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] NBD patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 77d472291812cf04f97974dadbda767e59e31fde:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170707-tag' into staging (2017-07-10 10:29:11 +0100)

are available in the git repository at:

  ericb@repo.or.cz:/srv/git/qemu/ericb.git tags/pull-nbd-2017-07-10

for you to fetch changes up to 167e16f91e706fde23fee3e1aaf58a97163357be:

  nbd: use generic trace subsystem instead of TRACE macro (2017-07-10 06:52:38 -0500)

----------------------------------------------------------------
nbd patches for 2017-07-10

- Eric Blake: MAINTAINERS: Promote NBD to supported, with new maintainer
- Vladimir Sementsov-Ogievskiy: [00/10] nbd refactoring part 2

----------------------------------------------------------------
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
 MAINTAINERS        |  22 +--
 Makefile.objs      |   1 +
 nbd/trace-events   |  56 ++++++++
 7 files changed, 324 insertions(+), 260 deletions(-)
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
 MAINTAINERS        |  22 +--
 Makefile.objs      |   1 +
 nbd/trace-events   |  56 ++++++++
 7 files changed, 324 insertions(+), 260 deletions(-)
 create mode 100644 nbd/trace-events

-- 
2.9.4
