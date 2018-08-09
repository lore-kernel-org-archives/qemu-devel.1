Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboW-0006cX-Rq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboT-00036A-O0
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:40 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboT-00035l-GX
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:37 -0400
Received: by mail-pl0-x242.google.com with SMTP id g6-v6so1932600plq.9
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:22 -0700
Message-Id: <20180809034033.10579-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] target/arm: sve linux-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

I posted a few of these before, and I thought Peter had applied them
to his target-arm.for-3-1 branch, but I don't see them there now.  

I've taken the opportunity to tag all of these for backport into the
next stable release.  I'm intending to do so for all of the correctness
patches affecting sve linux-user so that 3.0.1 will be usable long-term.


r~


Richard Henderson (11):
  target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
  target/arm: Fix typo in do_sat_addsub_64
  target/arm: Reorganize SVE WHILE
  target/arm: Fix typo in helper_sve_movz_d
  target/arm: Fix typo in helper_sve_ld1hss_r
  target/arm: Fix sign-extension in sve do_ldr/do_str
  target/arm: Fix offset for LD1R instructions
  target/arm: Fix offset scaling for LD_zprr and ST_zprr
  target/arm: Reformat integer register dump
  target/arm: Dump SVE state if enabled
  target/arm: Add sve-max-vq cpu property to -cpu max

 target/arm/cpu.h           |   3 ++
 linux-user/syscall.c       |  19 ++++---
 target/arm/cpu.c           |   6 +--
 target/arm/cpu64.c         |  29 ++++++++++
 target/arm/helper.c        |   7 ++-
 target/arm/sve_helper.c    |  21 +++-----
 target/arm/translate-a64.c | 108 ++++++++++++++++++++++++++++++-------
 target/arm/translate-sve.c |  77 +++++++++++++++-----------
 8 files changed, 195 insertions(+), 75 deletions(-)

-- 
2.17.1
