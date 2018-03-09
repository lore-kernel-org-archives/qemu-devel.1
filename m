Received: from eggs.gnu.org ([2001:4830:134:3::10]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOfF-00022M-Rb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOfB-0007SP-LE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:53 -0500
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:42523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euOfB-0007SF-FC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:49 -0500
Received: by mail-pl0-x22a.google.com with SMTP id 93-v6so5833750plc.9
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 12:30:49 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 09:29:34 +1300
Message-Id: <1520627374-93719-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V: Fix riscv_isa_string g_new0 size
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)

are available in the git repository at:

  https://github.com/michaeljclark/riscv-qemu.git fix-riscv-isa-string

for you to fetch changes up to 32b3a5716062f805a42e1cae1df95f2f869a78c1:

  RISC-V: Fix isa string logic bug, use popcount to count bits (2018-03-10 09:17:29 +1300)

----------------------------------------------------------------
Michael Clark (1):
      RISC-V: Fix isa string logic bug, use popcount to count bits

 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
