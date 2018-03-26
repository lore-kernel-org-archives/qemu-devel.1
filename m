Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0TPV-0005Rx-Dr
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0TPS-0004h9-4O
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:45 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:45805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0TPR-0004gQ-Si
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:42 -0400
Received: by mail-pg0-x22c.google.com with SMTP id y63so4212631pgy.12
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 07:47:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Mar 2018 22:47:29 +0800
Message-Id: <20180326144730.6351-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] decodetree: fix 16-bit insns
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

It's a bug, so logically 2.12 material.
But no sense requiring risc-v to hold an extra local patch.


r~


The following changes since commit 2ffd221d07a671f72354a063d3080f244ec80b20:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-03-26 11:02:50 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-dt-20180326

for you to fetch changes up to 83d7c40c92cdfb1cd2d5d31f4539b22dc17fbcce:

  scripts/decodetree: Fix insnmask not marked as global in main() (2018-03-26 22:34:07 +0800)

----------------------------------------------------------------
Fix a decodetree problem with 16-bit insns

----------------------------------------------------------------
Bastian Koppelmann (1):
      scripts/decodetree: Fix insnmask not marked as global in main()

 scripts/decodetree.py | 1 +
 1 file changed, 1 insertion(+)
