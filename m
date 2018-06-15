Received: from eggs.gnu.org ([2001:4830:134:3::10]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTqGU-0001lu-4H
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTqGQ-0007BQ-Sh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:50 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fTqGQ-0007Aa-KL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:46 -0400
Received: by mail-lf0-x241.google.com with SMTP id y20-v6so15130056lfy.0
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:03:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 15 Jun 2018 17:03:41 +0200
Message-Id: <20180615150343.4937-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 0/2] MicroBlaze Coverity fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 3b2a4d3901b8b45840c0e0495ee1cbd13123739d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-06-12 16:42:53 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-06-15.for-upstream

for you to fetch changes up to 462c254430b49ef708c75e038d7e796764058ca1:

  target-microblaze: Rework NOP/zero instruction handling (2018-06-15 09:05:00 +0200)

----------------------------------------------------------------
xilinx-next-2018-06-15.for-upstream

----------------------------------------------------------------
Edgar E. Iglesias (2):
      target-microblaze: mmu: Correct masking of output addresses
      target-microblaze: Rework NOP/zero instruction handling

 target/microblaze/mmu.c       |  1 -
 target/microblaze/translate.c | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.14.1
