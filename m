Received: from eggs.gnu.org ([2001:4830:134:3::10]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfTRH-0002fi-AR
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfTRF-0007JW-49
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:02:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  9 Aug 2017 17:02:10 +0100
Message-Id: <20170809160212.29976-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] IDE: Do not flush empty drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

John Snow is offline until Monday, QEMU 2.10-rc3 is due to be tagged on
Tuesday, and so I've taken two patches John sent for 2.10 and addressed review
comments.

Kevin Wolf (1):
  IDE: test flush on empty CDROM

Stefan Hajnoczi (1):
  IDE: Do not flush empty CDROM drives

 hw/ide/core.c    | 10 +++++++++-
 tests/ide-test.c | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.13.3
