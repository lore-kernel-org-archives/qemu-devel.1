Received: from eggs.gnu.org ([2001:4830:134:3::10]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csxA9-0003b7-0A
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csxA4-0000R3-9P
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:52:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csxA4-0000Qw-48
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:52:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 28 Mar 2017 16:52:04 -0300
Message-Id: <20170328195206.2761-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] i386: Fix for "-cpu host,invtsc=on" bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Last-minute fix for a bug found by Jiri Denemark. Unfortunately
not in time for -rc2, but I would like to get this in -rc3.

The following changes since commit df9046363220e57d45818312759b954c033c58ab:

  Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-pull-request

for you to fetch changes up to d4a606b38b5d4b3689b86cc1575908e82179ecfb:

  i386: Don't override -cpu options on -cpu host/max (2017-03-28 16:41:10 -0300)

----------------------------------------------------------------
i386: Fix for "-cpu host,invtsc=on" bug

----------------------------------------------------------------

Eduardo Habkost (2):
  i386: Replace uint32_t* with FeatureWord on feature getter/setter
  i386: Don't override -cpu options on -cpu host/max

 target/i386/cpu.h |  2 ++
 target/i386/cpu.c | 32 ++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.11.0.259.g40922b1
