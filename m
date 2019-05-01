Received: from eggs.gnu.org ([209.51.188.92]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmxE-0000UW-ML
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmxA-0002eO-SJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hLmxA-0002c0-KQ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86687E1EF7
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 10:59:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  1 May 2019 11:59:02 +0100
Message-Id: <20190501105904.29907-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, crobinso@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a607=
31:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-30 17:06:57 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20190501

for you to fetch changes up to 574d96933ceff60b2d13fe97602572fc7e95f7c6:

  hmp: gva2gpa debug command (2019-05-01 10:46:59 +0100)

----------------------------------------------------------------
HMP pull

New gva2gpa command
delvm now uses hmp_handle_error so gets Error: prefix in messages

----------------------------------------------------------------
Cole Robinson (1):
      hmp: delvm: use hmp_handle_error

Dr. David Alan Gilbert (1):
      hmp: gva2gpa debug command

 hmp-commands.hx  | 15 +++++++++++++++
 hmp.c            |  7 ++++---
 monitor.c        | 22 ++++++++++++++++++++++
 tests/test-hmp.c |  1 +
 4 files changed, 42 insertions(+), 3 deletions(-)
