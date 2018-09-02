Received: from eggs.gnu.org ([2001:4830:134:3::10]:41415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGKy-0001E3-45
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGKu-0003IX-Sn
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:33:56 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sat,  1 Sep 2018 20:33:19 -0400
Message-Id: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH v5 0/3] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Changes since v4:

* Simplified alignment checks by using tcg_gen_qemu_ld_i64 and
  MO_ALIGN*.

Pavel Zbitskiy (3):
  target/s390x: use regular spaces in translate.c
  target/s390x: exception on non-aligned LPSW(E)
  target/s390x: implement CVB, CVBY and CVBG

 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  4 +++
 target/s390x/int_helper.c       | 52 +++++++++++++++++++++++++++++++++
 target/s390x/translate.c        | 21 ++++++++++---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/cvb.c           | 18 ++++++++++++
 6 files changed, 93 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/s390x/cvb.c

-- 
2.18.0
