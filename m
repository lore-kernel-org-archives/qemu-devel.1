Received: from eggs.gnu.org ([2001:4830:134:3::10]:34944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MUv-0002Ur-6p
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MUp-00049b-Nb
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f3MUp-00049D-IL
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Apr 2018 11:01:05 -0300
Message-Id: <20180403140107.26125-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Fix memory leaks when using
 object_property_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 5d7bc72a4336f922ba42bab545529051c706ac4b:

  sev/i386: fix memory leak in sev_guest_init() (2018-04-02 23:05:26 -0300)

----------------------------------------------------------------
Fix memory leaks when using object_property_get_str()

----------------------------------------------------------------

Greg Kurz (2):
  exec: fix memory leak in find_max_supported_pagesize()
  sev/i386: fix memory leak in sev_guest_init()

 exec.c            | 1 +
 target/i386/sev.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.14.3
