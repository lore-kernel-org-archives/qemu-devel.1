Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejH-00064n-1G
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejG-0005Tn-9n
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:10 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:11488 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1eJejF-0005MT-UC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:10 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 28 Nov 2017 15:10:53 +0300
Message-Id: <20171128121055.6954-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Denis V . Lunev" <den@openvz.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

There are 2 cases I have spotted so far:
1) IDE ATAPI read processing. Actually this was reported from field
2) QEMU IO hmp command (found during evaluation of (1))

SCSI code checks during access that blk_is_available(). These patches add
same checks on different code paths.

Pls decide whether these patches should go through sub-system trees or via
block tree.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: John Snow <jsnow@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
