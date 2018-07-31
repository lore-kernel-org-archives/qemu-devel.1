Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkWwJ-000475-4y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkWwI-00055B-9C
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:51:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkWwI-000550-3S
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:51:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 964DD7D84D
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:51:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-135.ams2.redhat.com
	[10.36.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F311C640
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:51:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 31 Jul 2018 17:51:55 +0200
Message-Id: <20180731155156.25994-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Monitor patches for 2018-07-31 (3.0.0-rc3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 42e76456cf68dc828b8dbd3c7e255197e9b5e5=
7d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-p=
ull-request' into staging (2018-07-31 13:52:03 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-07-31

for you to fetch changes up to 9a1054061c62311f6efcd88e4df0aa5203c7b39a:

  monitor: temporary fix for dead-lock on event recursion (2018-07-31 17:=
42:57 +0200)

----------------------------------------------------------------
Monitor patches for 2018-07-31 (3.0.0-rc3)

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      monitor: temporary fix for dead-lock on event recursion

 monitor.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

--=20
2.17.1
