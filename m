Received: from eggs.gnu.org ([2001:4830:134:3::10]:58334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETtC-0005Lm-Eh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETt7-0006aY-Is
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:30 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Dec 2016 20:30:18 -0800
Message-Id: <1481085020-2614-1-git-send-email-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/2] target-arm aarch64 big-endian fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

I ran Alex's risu tests on an s390x host, and ran into two
problems not related to the s390 backend.


r~


Richard Henderson (2):
  target-arm: Fix aarch64 disas_ldst_single_struct
  target-arm: Fix aarch64 vec_reg_offset

 target-arm/translate-a64.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.4
