Received: from eggs.gnu.org ([2001:4830:134:3::10]:41020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpFXf-0005S6-8J
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpFXa-0000Sk-C3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpFXa-0000Rm-5Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30C1FC024AF0
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 15:13:25 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 23:13:17 +0800
Message-Id: <20170905151319.10756-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] buildsys: Move -lnettle and -lgnutls to
 per object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not all targets need the flags and libs of nettle/gnutls, so move them out from
global variables, as done with other libraries.

Fam Zheng (2):
  buildsys: Move nettle cflags/libs to per object
  buildsys: Move gnutls cflags/libs to per object

 configure              |  9 ++++-----
 crypto/Makefile.objs   | 13 +++++++++++++
 tests/Makefile.include | 10 +++++-----
 3 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.13.5
