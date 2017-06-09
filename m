Received: from eggs.gnu.org ([2001:4830:134:3::10]:33714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3l-0000fe-5b
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3d-0006mz-02
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dJK3c-0006mr-QF
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Jun 2017 15:34:24 +0200
Message-Id: <20170609133426.11447-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] s390x/cpumodel: wire up cpu type + id
 for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

Once Thomas' interception handler kvm-unit-test is only, I'll add my
stidp test.

I played with adding a "wout_m1_64_align", but I am not sure if that is
really helpful has we will only have a handful of users.

I am working on some more alignment fixes (spx, stap and friends ) and
will send them out soon.

Low address protection checks are missing as for most other instructions
as well.

v1 -> v2:
- Don't generate a helper
- Use MO_ALIGN to check alignment

David Hildenbrand (2):
  target/s390x: specification exceptions are suppressing
  s390x/cpumodel: wire up cpu type + id for TCG

 target/s390x/cpu.h         | 2 +-
 target/s390x/cpu_models.c  | 8 ++++++--
 target/s390x/helper.c      | 2 +-
 target/s390x/insn-data.def | 2 +-
 target/s390x/misc_helper.c | 9 ++++++---
 target/s390x/translate.c   | 9 ++-------
 6 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.9.3
