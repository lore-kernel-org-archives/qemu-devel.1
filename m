Received: from eggs.gnu.org ([209.51.188.92]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm13j-0003Y0-FQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm13f-0004UX-Re
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:03 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:44164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gm13e-0004Mt-Jm
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:59 -0500
Received: by mail-pf1-x434.google.com with SMTP id u6so12177132pfh.11
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:45:55 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 22 Jan 2019 04:20:45 -0800
Message-Id: <20190122122048.10845-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 0/3] Xilinx queue
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

The following changes since commit e56b86bc7735dd076939fa33a76e1ee9d5907e47:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2019-01-21 19:19:47 +0000)

are available in the Git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2019-01-22.for-upstream

for you to fetch changes up to 2867a96ffb63fa363820e4b0110b96a06218068b:

  target/microblaze: Add props enabling exceptions on failed bus accesses (2019-01-22 03:17:34 -0800)

----------------------------------------------------------------
Pullreq 2019-01-22

----------------------------------------------------------------
Edgar E. Iglesias (2):
      hw/microblaze: s3adsp1800: Create an unimplemented GPIO area
      target/microblaze: Add props enabling exceptions on failed bus accesses

Peter Maydell (1):
      target/microblaze: Switch to transaction_failed hook

 hw/microblaze/petalogix_s3adsp1800_mmu.c |  4 ++++
 target/microblaze/cpu.c                  | 14 ++++++++++++--
 target/microblaze/cpu.h                  |  9 ++++++---
 target/microblaze/op_helper.c            | 22 ++++++++++++----------
 4 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.19.1
