Received: from eggs.gnu.org ([2001:4830:134:3::10]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cw6AJ-0008DP-BJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cw6AF-0002IZ-DK
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cw6AF-0002Gm-7l
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82BEAC04B93E
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 12:05:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Apr 2017 14:05:10 +0200
Message-Id: <20170406120513.638-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Fix incoming migration regression of QXL
 in VGA mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, dgilbert@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Commit cd958edb1fae85d introduced a migration regression in QXL VGA
mode. The last patch fixes it. The first two patches helped me reason
about the related console code.

Marc-Andr=C3=A9 Lureau (3):
  console: add same surface replace pre-condition
  console: add same displaychangelistener registration pre-condition
  qxl: switch display on entering VGA

 hw/display/qxl.c | 1 +
 ui/console.c     | 4 ++++
 2 files changed, 5 insertions(+)

--=20
2.12.0.191.gc5d8de91d
