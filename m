Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpV0d-0004nE-1R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpV0Z-0004Mv-5T
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpV0Y-0004Mc-WD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5BDD81138
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 07:44:21 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed,  6 Sep 2017 15:44:15 +0800
Message-Id: <20170906074418.10903-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] buildsys: Move crypto libraries to per
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

v3: Remove one more line that was missed in v2.

Not all targets need the flags and libs of gcrypt/nettle/gnutls, so move them
out from global variables, as done with other libraries.

There are still other libraries in ./configure that can be converted this way,
which will be sent separatedly.

Fam Zheng (3):
  buildsys: Move nettle cflags/libs to per object
  buildsys: Move gnutls cflags/libs to per object
  buildsys: Move gcrypt cflags/libs to per object

 configure              | 15 ++++++---------
 crypto/Makefile.objs   | 20 ++++++++++++++++++++
 tests/Makefile.include | 10 +++++-----
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.13.5
