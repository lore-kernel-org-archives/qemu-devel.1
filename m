Received: from eggs.gnu.org ([2001:4830:134:3::10]:55600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqII-0006yg-SD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIF-0001RL-QX
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIF-0001Qz-L8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD77291FE6
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:03:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:12 -0500
Message-Id: <20170901180340.30009-2-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 01/29] tests: Improve .gitignore for
 tests/multiboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

Right now, tests/multiboot is not run by default during 'make check';
but when it is run in-tree, it was leaving some junk behind that could
accidentally get checked in with a careless 'git add tests'.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index fed0189a5a..64ecd6683b 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -10,6 +10,8 @@ check-qnull
 check-qstring
 check-qom-interface
 check-qom-proplist
+multiboot/test.out
+multiboot/*.elf
 qht-bench
 rcutorture
 test-aio
-- 
2.13.5
