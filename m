Received: from eggs.gnu.org ([2001:4830:134:3::10]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7j-0003lA-Oy
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7g-00083r-MC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpP7g-00083G-GL
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA168C058EA9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 01:27:18 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed,  6 Sep 2017 09:27:12 +0800
Message-Id: <20170906012715.31761-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] buildsys: Move crypto libraries to per
 object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2: Add gcrypt as well. [Daniel]

Not all targets need the flags and libs of gcrypt/nettle/gnutls, so move them
out from global variables, as done with other libraries.

There are still other libraries in ./configure that can be converted this way,
which will be sent separatedly.

Fam Zheng (3):
  buildsys: Move nettle cflags/libs to per object
  buildsys: Move gnutls cflags/libs to per object
  buildsys: Move gcrypt cflags/libs to per object

 configure              | 14 ++++++--------
 crypto/Makefile.objs   | 20 ++++++++++++++++++++
 tests/Makefile.include | 10 +++++-----
 3 files changed, 31 insertions(+), 13 deletions(-)

-- 
2.13.5
