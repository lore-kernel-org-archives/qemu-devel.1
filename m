Received: from eggs.gnu.org ([2001:4830:134:3::10]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzKC-0003vB-S3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzK6-0005lr-UW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:24 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpzK6-0005jd-O4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:18 -0400
Received: by mail-wm0-x234.google.com with SMTP id n11so66666767wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:34:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Mar 2017 15:34:38 +0000
Message-Id: <20170320153441.2181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] MTTCG regression fixes for 2.9-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here are a few more fixes for regressions caused by the MTTCG merge.
There is still one regression I'm aware of left to fix (record/replay
breakage) but I thought it would be worth getting these posted now for
review.

Another fix for graphic artefacts has already been merged via Gerd's
graphics tree.

The first fix is really just for completeness. It wasn't spotted in
the original work and while I'm not aware of a regression attached to
it I fixed it while investigating the other bits.

The user-exec fix solves the looping assert Laurent found with running
LTP tests.

Finally the bsd-user fix is a compile tested only fix to ensure
mmap_lock and friends do actually work. I wasn't able to complete
building on my set-up due to an unrelated optionrom problem but I'm
confident the MTTCG regression is addressed.

Regards,

Alex.

Alex Bennée (3):
  cputlb: ensure tbl_set_dirty1 updates addr_write atomically
  user-exec: handle synchronous signals from QEMU gracefully
  bsd-user: align use of mmap_lock to that of linux-user

 bsd-user/mmap.c | 13 +------------
 bsd-user/qemu.h |  2 --
 cputlb.c        |  8 ++++++++
 user-exec.c     | 18 +++++++++++++++---
 4 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.11.0
