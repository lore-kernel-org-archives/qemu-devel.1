Received: from eggs.gnu.org ([2001:4830:134:3::10]:49185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuAt-0001tJ-PG
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuAq-0005OF-N6
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcuAq-0005NW-GH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69528155B9
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 13:58:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  2 Aug 2017 14:58:31 +0100
Message-Id: <20170802135834.1455-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit d3d183a638d6a3ead515618a6547b3f80d39fc=
b9:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-08-02 09:49:02 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170802a

for you to fetch changes up to 8bd9c4e6c565c566a6cba3470cb2d4ea63994143:

  io: fix qio_channel_socket_accept err handling (2017-08-02 11:27:44 +01=
00)

----------------------------------------------------------------
Migration pull 2017-08-02

Just minor fixes for 2.10

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      migration: fix small leaks

Peter Xu (2):
      migration: fix comment disorder in RAMState
      io: fix qio_channel_socket_accept err handling

 io/channel-socket.c   |  3 ++-
 migration/migration.c | 10 ++++++++++
 migration/ram.c       |  4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)
