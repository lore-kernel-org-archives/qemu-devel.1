Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMtN-0003wu-6n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMtJ-0003oG-DO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daMtJ-0003nz-71
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31B77267D7
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:02:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Jul 2017 09:02:15 -0500
Message-Id: <20170726140218.15904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/3] Improved --version/--help tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Consistently letting --help point users back to the full resources
of the project is a good idea.  Also enhance some --version outputs.

Eric Blake (3):
  qemu-io: Give more --version information
  qga: Give more --version information
  maint: Include bug-reporting info in --help output.

 include/qemu-common.h | 5 +++++
 vl.c                  | 4 +++-
 bsd-user/main.c       | 2 ++
 linux-user/main.c     | 4 +++-
 qemu-img.c            | 2 +-
 qemu-io.c             | 9 ++++++---
 qemu-nbd.c            | 2 +-
 qga/main.c            | 8 +++++---
 8 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.13.3
