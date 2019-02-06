Received: from eggs.gnu.org ([209.51.188.92]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEw0-0001TT-BZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEvz-0007U5-EL
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:40 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grEvz-0007JS-7q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:39 -0500
Received: by mail-wr1-x435.google.com with SMTP id v13so6036381wrw.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 20:35:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 04:35:14 +0000
Message-Id: <20190206043516.11462-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/2] tcg queued patches
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

The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190206

for you to fetch changes up to 9fd9b7de61b24c70a8a82d9627a20ed95433e1b5:

  accel/tcg: Consider cluster index in tb_lookup__cpu_state() (2019-02-06 03:39:24 +0000)

----------------------------------------------------------------
Queued accel/tcg patches

----------------------------------------------------------------
Catherine Ho (1):
      tcg: add early clober modifier in atomic16_cmpxchg on aarch64

Peter Maydell (1):
      accel/tcg: Consider cluster index in tb_lookup__cpu_state()

 include/exec/tb-lookup.h | 4 ++++
 include/qemu/atomic128.h | 2 +-
 accel/tcg/cpu-exec.c     | 3 ---
 3 files changed, 5 insertions(+), 4 deletions(-)
