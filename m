Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWUa-0002x1-TK
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWUZ-0004wM-HG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIWUZ-0004w7-Bb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E323C7D843
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:43:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:43:30 +0200
Message-Id: <20180515094332.4907-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Input 20180515 patches
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

The following changes since commit fbd3a489df9953e2a5d017c922f3c103b2426952:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180514' into staging (2018-05-14 18:53:42 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/input-20180515-pull-request

for you to fetch changes up to 7abe7eb29494b4e4a11ec99ae5623083409a2f1e:

  ps2: Fix mouse stream corruption due to lost data (2018-05-15 11:31:33 +0200)

----------------------------------------------------------------
input: ps2 fixes.

----------------------------------------------------------------

Geoffrey McRae (2):
  ps2: Clear the PS/2 queue and obey disable
  ps2: Fix mouse stream corruption due to lost data

 include/hw/input/ps2.h |   5 ++
 hw/input/ps2.c         | 135 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 111 insertions(+), 29 deletions(-)

-- 
2.9.3
