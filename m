Received: from eggs.gnu.org ([2001:4830:134:3::10]:59516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbX-0006Rc-PP
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbU-0007a9-N3
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26017 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmbU-0007VB-CN
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:12 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:12:04 +0300
Message-Id: <1491405126-30591-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 0/2] parallels: some truncate fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

Stefan, here some obvious fixes for parallels image format. I am not quite
sure that they should go into 2.9, but it will be good if they will reach
2.9.1

Your opinion is very welcome here.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>

Denis V. Lunev (2):
  parallels: create parallels_inactivate() callback of block driver
    state
  parallels: relax check for auto switch of prealloc_mode

 block/parallels.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

-- 
2.7.4
