Received: from eggs.gnu.org ([209.51.188.92]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpw-0003k9-HA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpv-00006v-KO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKpv-000054-Am
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:47 -0500
Received: by mail-wr1-x435.google.com with SMTP id v13so7003388wrw.5
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:53:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:53:34 +0000
Message-Id: <20190206105337.11559-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/3] target/hppa queued patches
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

One of these, unfortunately, got lost on a local branch for a year.  ;-P


r~


The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190206

for you to fetch changes up to 68aa851aa21741ab0a3c019b641d6ce72f68b3d5:

  target/hppa: fix PSW Q bit behaviour to match hardware (2019-02-06 10:49:21 +0000)

----------------------------------------------------------------
Queued target/hppa patches

----------------------------------------------------------------
Emilio G. Cota (1):
      target/hppa: use tb_cflags() to access tb->cflags

Sven Schnelle (2):
      target/hppa: fix setting registers via gdb
      target/hppa: fix PSW Q bit behaviour to match hardware

 target/hppa/gdbstub.c   |  2 +-
 target/hppa/op_helper.c | 14 +++++++++-----
 target/hppa/translate.c |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)
