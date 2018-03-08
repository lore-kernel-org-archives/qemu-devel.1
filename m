Received: from eggs.gnu.org ([2001:4830:134:3::10]:44828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVI-0008GI-7V
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVD-0005gr-A5
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrVD-0005ge-6L
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF6DB4023BB3
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 09:06:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 10:06:14 +0100
Message-Id: <20180308090618.30147-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] spice: add support for dmabufs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

v3: rebase, handle surface =3D=3D NULL in tracepoint (Marc-Andr=C3=A9).
v2: rebase, fix codestyle issues.

Gerd Hoffmann (3):
  spice: drop dprint() debug logging
  spice: add scanout_dmabuf support
  spice: add cursor_dmabuf support

 include/ui/spice-display.h |   9 +++
 ui/spice-display.c         | 194 ++++++++++++++++++++++++++++++++-------=
------
 ui/trace-events            |  12 +++
 3 files changed, 162 insertions(+), 53 deletions(-)

--=20
2.9.3
