Received: from eggs.gnu.org ([2001:4830:134:3::10]:43643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6l-0007kw-Qt
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6k-00057K-UX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6k-00055i-OD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:50 -0300
Message-Id: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] x86 queue, 2017-02-27
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

The following changes since commit 3b1d8169844fafee184366b0e0d7080534758b4d:

  tests-aio-multithread: use atomic_read properly (2017-02-27 12:54:08 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-pull-request

for you to fetch changes up to b8097deb359bbbd92592b9670adfe9e245b2d0bd:

  i386: Improve query-cpu-model-expansion full mode (2017-02-27 13:23:35 -0300)

----------------------------------------------------------------
x86 queue, 2017-02-27

"-cpu max" and query-cpu-model-expansion support for x86. This
should be the last x86 pull request before 2.9 soft freeze.

----------------------------------------------------------------

Eduardo Habkost (11):
  i386: Unset cannot_destroy_with_object_finalize_yet on "host" model
  i386: Add ordering field to CPUClass
  i386: Rename X86CPU::host_features to X86CPU::max_features
  i386: Reorganize and document CPUID initialization steps
  qapi-schema: Comment about full expansion of non-migration-safe models
  i386: Create "max" CPU model
  i386: Make "max" model not use any host CPUID info on TCG
  i386: Don't set CPUClass::cpu_def on "max" model
  i386: Define static "base" CPU model
  i386: Implement query-cpu-model-expansion QMP command
  i386: Improve query-cpu-model-expansion full mode

 qapi-schema.json      |   9 +
 target/i386/cpu-qom.h |   8 +-
 target/i386/cpu.h     |   2 +-
 monitor.c             |   4 +-
 target/i386/cpu.c     | 455 +++++++++++++++++++++++++++++++++++++++++---------
 5 files changed, 397 insertions(+), 81 deletions(-)

-- 
2.11.0.259.g40922b1
