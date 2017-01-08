Received: from eggs.gnu.org ([2001:4830:134:3::10]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhh-00032g-VL
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhg-0003s1-Uv
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:26 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQHhg-0003rl-Nz
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:24 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so11154816pgf.3
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:56:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  8 Jan 2017 09:56:09 -0800
Message-Id: <20170108175620.6605-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/11] tcg host mips64 support
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

This is v6 of Jin Guojie's patch set, as tested by Aurelien Jarno,
James Hogan, and Yun Qiang Su.  Plus one more patch from me to fix
a trival Werror in mips specific code with gcc 5.3.


r~


Jin Guojie (10):
  tcg-mips: Move bswap code to a subroutine
  tcg-mips: Add mips64 opcodes
  tcg-mips: Support 64-bit opcodes
  tcg-mips: Add bswap32u and bswap64
  tcg-mips: Adjust move functions for mips64
  tcg-mips: Adjust load/store functions for mips64
  tcg-mips: Adjust prologue for mips64
  tcg-mips: Add tcg unwind info
  tcg-mips: Adjust calling conventions for mips64
  tcg-mips: Adjust qemu_ld/st for mips64

Richard Henderson (1):
  translate-all: Avoid -Werror=switch-bool

 tcg/mips/tcg-target.h     |   60 ++-
 tcg/mips/tcg-target.inc.c | 1170 +++++++++++++++++++++++++++++++++++----------
 translate-all.c           |    2 +-
 3 files changed, 978 insertions(+), 254 deletions(-)

-- 
2.9.3
