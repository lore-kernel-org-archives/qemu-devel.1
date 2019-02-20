Received: from eggs.gnu.org ([209.51.188.92]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU7w-0004CX-04
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU7v-0005Y9-5a
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwU7u-0005WB-Hf
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 16:42:51 +0100
Message-Id: <20190220154253.26982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Misc QGA/monitor QMP improvements (resend)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

I have those 2 simplification patches left which were part of previous
series. They are still worthwhile imho.

Thanks

Marc-Andr=C3=A9 Lureau (2):
  qga: process_event() simplification
  qmp: common 'id' handling & make QGA conform to QMP spec

 monitor.c           | 33 ++++++++++++-------------------
 qapi/qmp-dispatch.c | 10 ++++++++--
 qga/main.c          | 47 +++++++++------------------------------------
 tests/test-qga.c    | 13 +++++--------
 4 files changed, 34 insertions(+), 69 deletions(-)

--=20
2.21.0.rc1
