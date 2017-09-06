Received: from eggs.gnu.org ([2001:4830:134:3::10]:57832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYla-0004AB-1p
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYlX-000507-0L
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYlW-0004zy-QN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6A2CC04B92C
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:45:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:44:54 +0200
Message-Id: <20170906114456.27339-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Fix tests with new gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

TNhis has already been reviewed on list.

Please, apply.

The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac06=
5e:

  Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/tests/20170906

for you to fetch changes up to c18aaeb69072b74cb0a66e6638fcb14837c7cd3a:

  tests: Make vmgenid test compile (2017-09-05 22:34:40 +0200)

----------------------------------------------------------------
tests/next for 20170906

----------------------------------------------------------------
Juan Quintela (2):
      tests: Use real size for iov tests
      tests: Make vmgenid test compile

 include/qemu/iov.h   |  6 ------
 tests/test-iov.c     | 10 +++++-----
 tests/vmgenid-test.c |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)
