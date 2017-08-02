Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03K-0000IG-Mb
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03H-00069q-Ui
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd03H-000695-OL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87DF4356C0
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:29 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
	[10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46043413C
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  2 Aug 2017 16:15:06 -0400
Message-Id: <20170802201512.29142-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Enable building and running tcg tests on
 i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The primary motivation of this patch series is to get "make -C
tests/tcg", on i386, to run.  Having all of the individual i386 tcg
tests passing is beyond the scope of this patch series, though.

The secondary motivation is to gather feedback on the status of the
tcg tests.  If you have strong opinions about it, be that they need to
be nourished and cared for, that they should be eliminated completely,
or anything in between, I'd love to hear about it.

Cleber Rosa(6):
   tests/tcg/test_path.c: include utils/bufferiszero.c
   tests/tcg/linux-test.c: remove unused include of "qemu/cutils.h"
   tests/tcg/linux-test.c: include definitions for getrusage()
   tests/tcg/test-i386-fprem: build with $(QEMU_CFLAGS)
   tests/tcg/test-i386-fprem.c: compilation fix for -Werror=strict-prototype
   tests/tcg/test-i386-fprem.c: compilation fix for -Werror=unused-const-variable=

 tests/tcg/Makefile          |  2 +-
 tests/tcg/linux-test.c      |  2 +-
 tests/tcg/test-i386-fprem.c | 17 +----------------
 tests/tcg/test_path.c       |  1 +
4 files changed, 4 insertions(+), 18 deletions(-)
