Received: from eggs.gnu.org ([2001:4830:134:3::10]:49395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH779-0007sK-5t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH775-0000RU-3U
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gH774-0000O9-Tt
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83AE2C04B2D8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:57:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Oct 2018 16:57:27 +0400
Message-Id: <20181029125733.14597-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] monitor: misc fixes
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

 include/chardev/char.h |  3 +++
 chardev/char.c         | 11 +++++++++
 monitor.c              | 51 +++++++++++++++++++++++++++---------------
 3 files changed, 47 insertions(+), 18 deletions(-)

--=20
2.19.0.271.gfe8321ec05
