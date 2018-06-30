Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiz-0008Tj-N0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiw-0007X8-HS
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZIiw-0007WP-Bx
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFF5A407049A
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-16.ams2.redhat.com
	[10.36.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C990A10FFE6B
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 Jun 2018 18:27:39 +0200
Message-Id: <20180630162744.15920-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Monitor patches for 2018-06-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 6f4fa0998fd13bd8a533f38ee69774ecad6911=
b6:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2018-06-30 13:59:53 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-06-30

for you to fetch changes up to 4bfa7974d90a0cbad29c0a27334d02cbd37bb23d:

  docs: mention shared state protect for OOB (2018-06-30 17:50:48 +0200)

----------------------------------------------------------------
Monitor patches for 2018-06-30

----------------------------------------------------------------
Peter Xu (5):
      chardev: comment details for CLOSED event
      monitor: rename *_pop_one to *_pop_any
      monitor: flush qmp responses when CLOSED
      tests: iotests: drop some stderr line
      docs: mention shared state protect for OOB

 docs/devel/qapi-code-gen.txt | 17 ++++++++++-----
 include/chardev/char.h       | 11 +++++++++-
 monitor.c                    | 52 ++++++++++++++++++++++++++++++++------=
------
 tests/qemu-iotests/060       | 10 ++++++++-
 tests/qemu-iotests/060.out   |  1 -
 5 files changed, 68 insertions(+), 23 deletions(-)
