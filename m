Received: from eggs.gnu.org ([2001:4830:134:3::10]:38210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3ia1-0002P0-MR
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3iZy-0000YI-Hs
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3iZy-0000Y0-De
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88994406E8C3
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 13:35:57 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-104.rdu2.redhat.com [10.10.123.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 294C210B2B3D
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 13:35:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed,  4 Apr 2018 08:35:46 -0500
Message-Id: <20180404133550.2143237-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/4] QAPI and misc patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e5efa1f5f2d32cbfbf18ba84300736503985b5=
93:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-04-04 12:33:23 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-03-v2

for you to fetch changes up to 908cc9be8811c15abc70e1a5e1c396d9c3414d2e:

  iothread: workaround glib bug which hangs qmp-test (2018-04-04 08:22:37=
 -0500)

In v2: add one more patch (just sending the new patch in this thread)

----------------------------------------------------------------
qapi and misc patches for 2018-04-03

- Peter Xu: monitor: bind dispatch bh to iohandler context
- Eric Blake: maint: Add .mailmap entries for patches claiming list autho=
rship
- Eric Blake: dump: Fix build with newer gcc
- Peter Xu: iothread: workaround glib bug which hangs qmp-test

----------------------------------------------------------------
Eric Blake (2):
      maint: Add .mailmap entries for patches claiming list authorship
      dump: Fix build with newer gcc

Peter Xu (2):
      monitor: bind dispatch bh to iohandler context
      iothread: workaround glib bug which hangs qmp-test

 dump.c     |  4 ++--
 iothread.c | 18 ++++++++++++++----
 monitor.c  |  2 +-
 .mailmap   | 18 ++++++++++++++----
 4 files changed, 31 insertions(+), 11 deletions(-)

--=20
2.14.3
