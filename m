Received: from eggs.gnu.org ([2001:4830:134:3::10]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0zBN-000682-Ez
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0zBK-00014m-Bs
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:17 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:37020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0zBK-00014W-4s
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:14 -0400
Received: by mail-pg0-x22e.google.com with SMTP id n11so300505pgp.4
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:43:14 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 17:42:24 -0700
Message-Id: <1522197746-26020-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This series includes changes that are considered release critical,
such as floating point register file corruption under SMP Linux.

v2

- reverted to Richard W.M. Jone's original, more conservative fix
- reworded comment to be more concise and more general

Michael Clark (1):
  RISC-V: Workaround for critical mstatus.FS bug

 target/riscv/op_helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.7.0
