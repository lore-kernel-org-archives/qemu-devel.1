Received: from eggs.gnu.org ([2001:4830:134:3::10]:35308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAach-0007pM-Ez
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAacc-00067U-MK
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAacc-00065k-GE
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F90E356D2
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 11:58:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 Nov 2017 12:58:39 +0100
Message-Id: <20171103115842.1534-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] sdl: hotkey updates and cleanups
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



Gerd Hoffmann (3):
  sdl: remove -no-frame support
  sdl: remove -alt-grab and -ctrl-grab support
  sdl: use ctrl-alt-g as grab hotkey

 include/ui/console.h |  5 ++---
 ui/sdl.c             | 54 ++++++++++++++--------------------------------------
 ui/sdl2.c            | 50 ++++++++++++------------------------------------
 vl.c                 | 39 +++++++------------------------------
 4 files changed, 35 insertions(+), 113 deletions(-)

-- 
2.9.3
