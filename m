Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiz5-0003Up-Oy
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiz4-0007tf-VH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:05:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 26 Jun 2018 10:05:44 +0200
Message-Id: <20180626080546.3626-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Pacify Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Markus Armbruster (2):
  block-qdict: Pacify Coverity after commit f1b34a248e9
  block/crypto: Pacify Coverity after commit f853465aacb

 block/crypto.c        |  4 ++--
 qobject/block-qdict.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1
