Received: from eggs.gnu.org ([2001:4830:134:3::10]:36157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmpT-0001DN-Lw
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmpQ-0004ro-IP
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvmpQ-0004rT-CF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C9AE19D24E
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 15:26:35 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.118.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C73D42D653
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 15:26:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Apr 2017 17:26:32 +0200
Message-Id: <20170405152633.6824-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] PC fix for 2.9.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 8c9f42f3cf3598e8bb612b3f81cd12632efd3ca4:

  tco: do not generate an NMI (2017-04-05 17:23:52 +0200)

----------------------------------------------------------------
* TCO watchdog fix

----------------------------------------------------------------
Paolo Bonzini (1):
      tco: do not generate an NMI

 hw/acpi/tco.c          | 2 --
 hw/isa/lpc_ich9.c      | 5 -----
 include/hw/i386/ich9.h | 1 -
 3 files changed, 8 deletions(-)
-- 
2.9.3
