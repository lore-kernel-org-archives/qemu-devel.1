Received: from eggs.gnu.org ([2001:4830:134:3::10]:37353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1bKv-0007lA-Ok
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1bKr-0004IF-FI
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:27:41 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1bKr-0004HS-7V
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:27:37 -0400
Received: by mail-pf0-x242.google.com with SMTP id t16so3697336pfh.4
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 10:27:37 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 29 Mar 2018 10:26:56 -0700
Message-Id: <1522344417-60114-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>

The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-important-fixes' into staging (2018-03-28 22:13:38 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-critical-fixes

for you to fetch changes up to b02403363f1056421d120c8e974fdf9c76a84f95:

  RISC-V: Workaround for critical mstatus.FS bug (2018-03-29 10:22:26 -0700)

----------------------------------------------------------------
RISC-V: Critical fixes for QEMU 2.12

This series includes changes that are considered release critical,
such as floating point register file corruption under SMP Linux
due to incorrect handling of mstatus.FS.

This workaround will be replaced with a more comprehensive fix
for mstatus.FS handling in QEMU 2.13.

----------------------------------------------------------------
Michael Clark (1):
      RISC-V: Workaround for critical mstatus.FS bug

 target/riscv/op_helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)
