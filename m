Received: from eggs.gnu.org ([2001:4830:134:3::10]:38500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsI5-00035Y-Iw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsI2-0004Fk-Ci
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsI2-0004FO-6O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 225B4C04B941
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:35:57 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:35:50 +0800
Message-Id: <20170907083552.17725-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] buildsys: Move vde cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Hi Jason,

this is the net/ part of the conversion of library cflags/libs from global
QEMU_CFLAGS and libs_softmmu to per object variables. Please review.

Fam Zheng (2):
  vl: Don't include vde header
  buildsys: Move vde libs to per object

 configure         | 3 +--
 net/Makefile.objs | 2 ++
 vl.c              | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.13.5
