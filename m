Received: from eggs.gnu.org ([2001:4830:134:3::10]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIC7S-00086A-Ck
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIC7P-0006Kh-An
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIC7P-0006JJ-65
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA87785376
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:53:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 12:53:35 +0200
Message-Id: <20170606105339.3613-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] gtk/sdl: use newer versions by default,
 deprecate the old ones.
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

  Hi,

High time to use new versions (gtk3 and SDL2) by default.  This patch
series switches over qemu to prefer the newer versions and adds a
deprecation warning for the old versions.

Note that qemu uses the new versions automatically for quite a while
already in case the older isn't installed.

cheers,
  Gerd

Gerd Hoffmann (4):
  gtk: prefer gtk3 over gtk2
  sdl: prefer sdl2 over sdl1
  gtk: add deprecation warning for gtk2
  sdl: add deprecation warning for sdl1

 configure | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.9.3
