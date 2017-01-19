Received: from eggs.gnu.org ([2001:4830:134:3::10]:57676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6H-0004Tg-1M
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6E-00020H-35
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUE6D-0001yw-U3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2F6781239
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:54:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-93.ams2.redhat.com
	[10.36.117.93])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0JErx6C006684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:54:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 19 Jan 2017 15:53:55 +0100
Message-Id: <1484837637-16896-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Error reporting patches for 2017-01-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ab4b92760498e097ff668f0e9c83aa87a2ec11=
28:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-01-17 16:54:09 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-01-19

for you to fetch changes up to 0d6b50d474090b9085c595e2475c40cfdc092411:

  error: Report certain hints on stderr when no monitor (2017-01-19 15:42=
:36 +0100)

----------------------------------------------------------------
Error reporting patches for 2017-01-19

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      error: Report certain hints on stderr when no monitor

Sascha Silbe (1):
      error: error_setg_errno(): errno gets preserved

 include/qapi/error.h | 3 +++
 monitor.c            | 2 ++
 2 files changed, 5 insertions(+)

--=20
2.7.4
