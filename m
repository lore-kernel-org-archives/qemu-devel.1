Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmhoR-0004Jo-Gu
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmhoN-0000w0-LI
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dmhoN-0000vL-FL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B646480C1F
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 14:48:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Aug 2017 16:48:03 +0200
Message-Id: <20170829144805.28872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] vhost-user-bridge reconnect regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: victork@redhat.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

libvhost-user doesn't support resuming with the same trick vubr had
since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
two patches fix that regression.

Thanks

Marc-Andr=C3=A9 Lureau (2):
  libvhost-user: support resuming vq->last_avail_idx based on used_idx
  vhost-user-bridge: fix resume regression (since 2.9)

 contrib/libvhost-user/libvhost-user.h |  5 +++++
 contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
 tests/vhost-user-bridge.c             |  7 +++++++
 3 files changed, 25 insertions(+)

--=20
2.14.1.146.gd35faa819
