Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnM-00064c-UM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnJ-00065l-BD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:12 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:44197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnJ-00064b-49
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:09 -0400
Received: by mail-wr0-x235.google.com with SMTP id p12-v6so5237599wrn.11
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:43 +0100
Message-Id: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 00/22] ARM SVE support for RISU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Peter,

Not much different from v3 apart from the last SVE register dump patch
is now fatter with stuff that was from the handle variable VQ series.
The binary format has stayed the same and we have a current test set
for SVE at:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/sve-all-short-v83+sve.tar.xz

Unless you have any comments I reckon these are ready to be merged.

Alex Bennée (16):
  risu_reginfo_aarch64: include signal.h for FPSIMD_MAGIC
  comms: include header for writev
  build-all-arches: expand the range of docker images
  build-all-arches: do a distclean $(SRC) configured
  risu: add zlib indication to help text
  Makefile: include risu_reginfo_$(ARCH) in HDRS
  risugen: add --sve support
  contrib/generate_all.sh: allow passing of arguments to risugen
  risu: move optional args to each architecture
  risu_reginfo_aarch64: drop stray ;
  risu_reginfo_aarch64: unionify VFP regs
  risu_reginfo: introduce reginfo_size()
  risu_reginfo_aarch64: left justify regnums and drop masks
  risu_reginfo_aarch64: add support for copying SVE register state
  risu_reginfo_aarch64: add SVE support to reginfo_dump_mismatch
  risu_reginfo_aarch64: handle variable VQ

Richard Henderson (6):
  risugen: Initialize sve predicates with random data
  risugen: use fewer insns for aarch64 immediate load
  risugen: add reg_plus_imm_pl and reg_plus_imm_vl address helpers
  risugen: add dtype_msz address helper
  risu: add process_arch_opt
  risu_reginfo_aarch64: limit SVE_VQ_MAX to current architecture

 Makefile                |   5 +-
 build-all-archs         |  12 +-
 comms.c                 |   1 +
 contrib/generate_all.sh |  14 +-
 reginfo.c               |   6 +-
 risu.c                  |  51 ++++---
 risu.h                  |  12 +-
 risu_reginfo_aarch64.c  | 308 +++++++++++++++++++++++++++++++++++-----
 risu_reginfo_aarch64.h  |  31 +++-
 risu_reginfo_arm.c      |  22 +++
 risu_reginfo_m68k.c     |  14 ++
 risu_reginfo_ppc64.c    |  14 ++
 risugen                 |   3 +
 risugen_arm.pm          | 243 ++++++++++++++++++++++++++++---
 14 files changed, 649 insertions(+), 87 deletions(-)

-- 
2.17.1
