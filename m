Received: from eggs.gnu.org ([2001:4830:134:3::10]:57300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLRP-0005xN-NA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLRM-0002se-AY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:52:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyLRM-0002sF-4y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:52:52 -0400
Date: Tue, 20 Mar 2018 19:52:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521568357-114127-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v3 0/2] linux-headers: unistd.h fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>

It turns out that we have unistd.h for some architectures but not
others.  We are thus unable to use e.g. usefaultfd on these systems.

Fix up update-linux-headers.sh to make sure we
get it for all architectures which have linux-headers/
(unfortunately this still does not mean "all linux systems").

Tested on x86 only.

Pls consider merging this through the migration tree.

Michael S. Tsirkin (2):
  update-linux-headers.sh: add unistd.h
  linux-headers: add asm-generic/unistd.h

 linux-headers/asm-arm/bitsperlong.h     |   1 +
 linux-headers/asm-arm64/bitsperlong.h   |  24 +
 linux-headers/asm-generic/bitsperlong.h |  16 +
 linux-headers/asm-generic/unistd.h      | 944 ++++++++++++++++++++++++++++++++
 linux-headers/asm-mips/bitsperlong.h    |   9 +
 linux-headers/asm-mips/unistd.h         |  44 +-
 linux-headers/asm-powerpc/bitsperlong.h |  13 +
 linux-headers/asm-s390/bitsperlong.h    |  14 +
 linux-headers/asm-x86/bitsperlong.h     |  14 +
 scripts/update-linux-headers.sh         |  20 +-
 10 files changed, 1086 insertions(+), 13 deletions(-)
 create mode 100644 linux-headers/asm-arm/bitsperlong.h
 create mode 100644 linux-headers/asm-arm64/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/unistd.h
 create mode 100644 linux-headers/asm-mips/bitsperlong.h
 create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
 create mode 100644 linux-headers/asm-s390/bitsperlong.h
 create mode 100644 linux-headers/asm-x86/bitsperlong.h

-- 
MST
