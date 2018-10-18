Received: from eggs.gnu.org ([2001:4830:134:3::10]:47909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXn-0004ce-OU
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXj-000114-Ml
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDDXj-00010P-DS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 18 Oct 2018 21:00:24 +0200
Message-Id: <20181018190026.9494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [2 0/2] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request

for you to fetch changes up to 6d5bb0b896f9954c98d85c8835a75bb3a041de41:

  linux-user/sparc/signal.c: Remove unnecessary comment (2018-10-18 20:17:49 +0200)

----------------------------------------------------------------
Add a workaround for clang bug and remove misleading comment (sparc)

----------------------------------------------------------------

Peter Maydell (2):
  linux-user: Suppress address-of-packed-member warnings in
    __get/put_user_e
  linux-user/sparc/signal.c: Remove unnecessary comment

 linux-user/qemu.h         | 74 ++++++++++++++++++++++++++++-----------
 linux-user/sparc/signal.c |  4 ---
 2 files changed, 53 insertions(+), 25 deletions(-)

-- 
2.17.2
