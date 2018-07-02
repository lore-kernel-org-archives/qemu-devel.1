Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Ks-0004dV-0k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Kn-0005NZ-OZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:53 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:43888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fa1Kn-0005NI-H0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:49 -0400
Received: by mail-pf0-x236.google.com with SMTP id y8-v6so7719162pfm.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  2 Jul 2018 09:05:40 -0700
Message-Id: <20180702160546.31969-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 2d58e33ec1b76990f09bc1e3412e0b36e1ac4634:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-07-02 13:43:10 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20180702

for you to fetch changes up to 9c8c334b0637bf3c592d432b0c11f3b62dd5dba3:

  cpu: Assert asidx_from_attrs return value in range (2018-07-02 08:09:49 -0700)

----------------------------------------------------------------
Assorted tlb and tb caching fixes

----------------------------------------------------------------
Emilio G. Cota (1):
      translate-all: fix locking of TBs whose two pages share the same physical page

Peter Maydell (3):
      tcg: Define and use new tlb_hit() and tlb_hit_page() functions
      accel/tcg: Correct "is this a TLB miss" check in get_page_addr_code()
      accel/tcg: Don't treat invalid TLB entries as needing recheck

Richard Henderson (2):
      accel/tcg: Avoid caching overwritten tlb entries
      cpu: Assert asidx_from_attrs return value in range

 accel/tcg/softmmu_template.h | 16 ++++-----
 include/exec/cpu-all.h       | 23 +++++++++++++
 include/exec/cpu_ldst.h      |  3 +-
 include/qom/cpu.h            |  6 ++--
 accel/tcg/cputlb.c           | 78 +++++++++++++++++++++++---------------------
 accel/tcg/translate-all.c    | 32 ++++++++++++++----
 6 files changed, 100 insertions(+), 58 deletions(-)
