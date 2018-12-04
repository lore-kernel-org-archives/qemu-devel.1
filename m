Received: from eggs.gnu.org ([2001:4830:134:3::10]:54285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAaf-00047g-4j
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAac-00014C-2B
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUAab-00010B-TU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 958B785A04
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:18:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 17:17:56 +0400
Message-Id: <20181204131802.16885-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/6] monitor: misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,

Here is a small series of fixes for the monitor, mostly related to
threading issues.

v3:
 - replaced an error_report() with an assert()
 - simplify a mon->use_io_thread condition, removing needless QMP check
 - modify/add some code comments
 - update commit messages

v2 bis:
 - update comments/commit messages
 - add Peter r-b

v2: after Peter review
 - patch 2: fix resuming with oob=3Doff
 - patch 4: keep MUX case explicit, improve commit message

Marc-Andr=C3=A9 Lureau (6):
  monitor: inline ambiguous helper functions
  monitor: accept chardev input from iothread
  char: add a QEMU_CHAR_FEATURE_GCONTEXT flag
  monitor: check if chardev can switch gcontext for OOB
  monitor: prevent inserting new monitors after cleanup
  monitor: avoid potential dead-lock when cleaning up

 include/chardev/char.h |  3 ++
 chardev/char.c         | 11 +++++++
 monitor.c              | 71 ++++++++++++++++++++++++++----------------
 3 files changed, 59 insertions(+), 26 deletions(-)

--=20
2.20.0.rc1
