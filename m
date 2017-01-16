Received: from eggs.gnu.org ([2001:4830:134:3::10]:39817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2ps-0002Ls-2a
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2po-0000r5-5g
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:40:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT2pn-0000qQ-Vv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:40:12 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Jan 2017 16:40:03 +0800
Message-Id: <1484556005-29701-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/2] memory: extend "info mtree" with flat
 view dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v4:
- do unref of flatview when no view is there [Dave]

v3:
- rather than dump flatview directly in "info mtree", provide a new
  parameter "-f" for it. [Paolo]
- replace "RW" chars with the type of memory region [Paolo]
- (cc dave as well since it touches HMP interface)

v2:
- fix a size error in patch 2
- add r-b for Marc-Andr=C3=A9 in patch 1

Each address space has its own flatview. It's another way to observe
memory info besides the default memory region hierachy, for example,
if we want to know which memory region will handle the write to
specific address, a flatview will suite more here than the default
hierachical dump.

Please review. Thanks,

Peter Xu (2):
  memory: tune mtree_print_mr() to dump mr type
  memory: hmp: add "-f" for "info mtree"

 hmp-commands-info.hx  |  6 ++--
 include/exec/memory.h |  2 +-
 memory.c              | 89 ++++++++++++++++++++++++++++++++++++++-------=
------
 monitor.c             |  4 ++-
 4 files changed, 74 insertions(+), 27 deletions(-)

--=20
2.7.4
