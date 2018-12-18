Received: from eggs.gnu.org ([2001:4830:134:3::10]:35718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGN2-0000iu-9l
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGMx-0000r3-Cj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 18 Dec 2018 15:28:47 +0100
Message-Id: <20181218142851.9477-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org

The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f6c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into staging (2018-12-17 13:04:25 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to b2322003b6389c7c98104c8626ffa342928ba83c:

  error: Remove NULL checks on error_propagate() calls (2018-12-18 14:57:48 +0100)

----------------------------------------------------------------
Trivial patches (2018-12-18)

----------------------------------------------------------------

Emilio G. Cota (1):
  docs/devel/build-system: fix 'softmu' typo

Markus Armbruster (2):
  vl: Use error_fatal to simplify obvious fatal errors (again)
  error: Remove NULL checks on error_propagate() calls

Roman Bolshakov (1):
  i386: hvf: drop debug printf in decode_sldtgroup

 blockdev.c                   | 4 +---
 docs/devel/build-system.txt  | 2 +-
 hw/s390x/s390-pci-bus.c      | 4 +---
 qga/commands-posix.c         | 7 ++-----
 target/i386/hvf/x86_decode.c | 2 --
 vl.c                         | 7 ++-----
 6 files changed, 7 insertions(+), 19 deletions(-)

-- 
2.19.2
