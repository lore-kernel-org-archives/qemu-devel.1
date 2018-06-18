Received: from eggs.gnu.org ([2001:4830:134:3::10]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUrFJ-0007ZB-9i
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUrFF-0002z3-Bu
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUrFF-0002xj-82
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 801DF401DEAF
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 10:18:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 12:18:40 +0200
Message-Id: <20180618101841.21609-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Input 20180618 patches
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

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/input-20180618-pull-request

for you to fetch changes up to b55a06df4f03f21e8a32e9d067a8a5782ac3ce0d:

  ps2: check PS2Queue wptr pointer in post_load routine (2018-06-18 12:06:45 +0200)

----------------------------------------------------------------
input: ps2 post_load fix.

----------------------------------------------------------------

liujunjie (1):
  ps2: check PS2Queue wptr pointer in post_load routine

 hw/input/ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
