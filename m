Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyONa-0004wh-Rf
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyONV-0007HX-TT
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyONV-0007GE-PB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:05 -0400
Date: Tue, 20 Mar 2018 23:01:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521579652-180248-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v4 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <jhogan@kernel.org>

It turns out that we have unistd.h and kvm headers for some
architectures but not others.  We are thus unable to use e.g. usefaultfd
on these systems unless system headers have been updated.

Fix up update-linux-headers.sh to make sure we auto-updates
all architectures which have linux-headers/
(unfortunately this still does not mean "all linux systems").

Tested on x86 only.

Pls consider merging this through the ARM tree.

Michael S. Tsirkin (3):
  update-linux-headers.sh: add unistd.h and kvm on MIPS
  linux-headers: add unistd.h on all arches
  linux-headers: add kvm header for mips

 linux-headers/asm-arm/bitsperlong.h     |   1 +
 linux-headers/asm-arm64/bitsperlong.h   |  24 +
 linux-headers/asm-generic/bitsperlong.h |  16 +
 linux-headers/asm-generic/unistd.h      | 944 ++++++++++++++++++++++++++++++++
 linux-headers/asm-mips/bitsperlong.h    |   9 +
 linux-headers/asm-mips/kvm.h            |  25 +-
 linux-headers/asm-mips/sgidefs.h        |  45 ++
 linux-headers/asm-mips/unistd.h         |  44 +-
 linux-headers/asm-powerpc/bitsperlong.h |  13 +
 linux-headers/asm-s390/bitsperlong.h    |  14 +
 linux-headers/asm-x86/bitsperlong.h     |  14 +
 scripts/update-linux-headers.sh         |  22 +-
 12 files changed, 1155 insertions(+), 16 deletions(-)
 create mode 100644 linux-headers/asm-arm/bitsperlong.h
 create mode 100644 linux-headers/asm-arm64/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/unistd.h
 create mode 100644 linux-headers/asm-mips/bitsperlong.h
 create mode 100644 linux-headers/asm-mips/sgidefs.h
 create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
 create mode 100644 linux-headers/asm-s390/bitsperlong.h
 create mode 100644 linux-headers/asm-x86/bitsperlong.h

-- 
MST
