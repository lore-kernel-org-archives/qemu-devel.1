Received: from eggs.gnu.org ([2001:4830:134:3::10]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8fE-0000XA-Fd
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8fD-0002Id-J4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db8fD-0002Hb-DO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:02:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 545EFA962A
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 17:02:58 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC30F6F44B
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 17:02:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 28 Jul 2017 12:02:53 -0500
Message-Id: <20170728170255.13270-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.10 0/1] NBD changes for 2.10-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3aabfec2c83da500ae52fc87ff3a0a60718022=
db:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170728' into =
staging (2017-07-28 15:32:44 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-28

for you to fetch changes up to 158b9aa568eabe614d37882dddc2eea534edc7ae:

  nbd: fix memory leak in nbd_opt_go() (2017-07-28 11:58:20 -0500)

----------------------------------------------------------------
nbd patches for 2017-07-28

- Philippe Mathieu-Daud=C3=A9 - nbd: fix memory leak in nbd_opt_go()

----------------------------------------------------------------
Philippe Mathieu-Daud=C3=A9 (1):
      nbd: fix memory leak in nbd_opt_go()

 nbd/client.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--=20
2.13.3
