Received: from eggs.gnu.org ([2001:4830:134:3::10]:41412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXo-00022J-Ob
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXl-0000VM-Ny
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:56 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXl-0000T8-Ex
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:53 -0400
Received: by mail-lf0-x242.google.com with SMTP id f28so17185817lfi.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:54:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:31 +0200
Message-Id: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 00/17] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit fd479c60f5766f7fb247ad146b9e3c33d03d2055:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170603' into staging (2017-07-03 09:54:32 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next.for-upstream

for you to fetch changes up to 31cf950ea2a010c33e5384aaba91f01dc27c1599:

  xilinx-dp: Add support for the yuy2 video format (2017-07-04 09:22:20 +0200)

----------------------------------------------------------------
edgar/xilinx-next.for-upstream

----------------------------------------------------------------
Edgar E. Iglesias (16):
      target-microblaze: Correct bit shift for the PVR0 version field
      target-microblaze: Don't hard code 0xb as initial MB version
      target-microblaze: Add CPU versions 9.4, 9.5 and 9.6
      target-microblaze: Introduce a use-barrel property
      target-microblaze: Introduce a use-div property
      target-microblaze: Introduce a use-hw-mul property
      target-microblaze: Introduce a use-msr-instr property
      target-microblaze: Introduce a use-pcmp-instr property
      target-microblaze: dec_barrel: Use bool instead of unsigned int
      target-microblaze: dec_barrel: Use extract32
      target-microblaze: dec_barrel: Add braces around if-statements
      target-microblaze: dec_barrel: Plug TCG temp leak
      target-microblaze: dec_barrel: Add BSEFI
      target-microblaze: dec_barrel: Add BSIFI
      target-microblaze: Add CPU version 10.0
      xilinx-dp: Add support for the yuy2 video format

Stefan Weil (1):
      disas/microblaze: Add missing 'const' attributes

 disas/microblaze.c            | 18 ++++------
 hw/display/xlnx_dp.c          |  3 ++
 target/microblaze/cpu.c       | 39 ++++++++++++++--------
 target/microblaze/cpu.h       |  7 ++++
 target/microblaze/translate.c | 77 ++++++++++++++++++++++++++++++-------------
 5 files changed, 96 insertions(+), 48 deletions(-)
