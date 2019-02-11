Received: from eggs.gnu.org ([209.51.188.92]:59931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtF9I-00024i-Fq
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtExk-0000tb-4V
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:45 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtExi-0000qj-Ar
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id g6so1609990pfh.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:01:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 09:01:32 -0800
Message-Id: <20190211170136.18680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] tcg queued patches
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

The following changes since commit a044e3de2917d54b95f1211f4d14ec30cac9a59f:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-110219-1' into staging (2019-02-11 14:47:44 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190211

for you to fetch changes up to 6d967cb86d5b4a60ba15b497126b621ce9ca6609:

  cputlb: update TLB entry/index after tlb_fill (2019-02-11 08:52:44 -0800)

----------------------------------------------------------------
Fix dynamic tlb resize
Fix x86 host vector saturation
Diagnose missing tcg labels

----------------------------------------------------------------
Emilio G. Cota (2):
      exec-all: document that tlb_fill can trigger a TLB resize
      cputlb: update TLB entry/index after tlb_fill

Mark Cave-Ayland (1):
      tcg/i386: fix unsigned vector saturating arithmetic

Richard Henderson (1):
      tcg: Diagnose referenced labels that have not been emitted

 accel/tcg/softmmu_template.h |  8 ++++++++
 include/exec/exec-all.h      |  5 +++++
 tcg/tcg-op.h                 |  1 +
 tcg/tcg.h                    | 12 +++++++++---
 accel/tcg/cputlb.c           |  4 ++++
 tcg/i386/tcg-target.inc.c    |  4 ++--
 tcg/tcg.c                    | 23 +++++++++++++++++++++++
 7 files changed, 52 insertions(+), 5 deletions(-)
