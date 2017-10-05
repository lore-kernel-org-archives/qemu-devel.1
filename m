Received: from eggs.gnu.org ([2001:4830:134:3::10]:40689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07Fv-0002FR-Ro
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07Fu-0001rg-UM
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:07 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:55451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e07Fu-0001rG-OM
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:06 -0400
Received: by mail-qt0-x22d.google.com with SMTP id x54so25683714qth.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Oct 2017 10:35:57 -0400
Message-Id: <20171005143601.21584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] linux-user fixes for va mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, peter.maydell@linaro.org

Version 1 was back in July,

  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02033.html

  > At first I was simply going to add TARGET_SH to the existing
  > set of defines that trigger a 31-bit address space.  But then
  > I realized that one could create non-working va configurations
  > from the command-line.

Changes since v1:
  * Peter fixes the elfload bug that prevented ARM using the proper
    MAX_RESERVED_VA setting.
  * Adjust the arm MAX_RESERVED_VA.


r~


Peter Maydell (1):
  linux-user: Allow -R values up to 0xffff0000 for 32-bit ARM guests

Richard Henderson (3):
  tcg: Fix off-by-one in assert in page_set_flags
  linux-user: Tidy and enforce reserved_va initialization
  linux-user/sh4: Reduce TARGET_VIRT_ADDR_SPACE_BITS to 31

 linux-user/arm/target_cpu.h |  4 ++++
 target/mips/mips-defs.h     |  6 +++++-
 target/nios2/cpu.h          |  6 +++++-
 target/sh4/cpu.h            |  6 +++++-
 accel/tcg/translate-all.c   |  2 +-
 linux-user/elfload.c        |  2 +-
 linux-user/main.c           | 38 +++++++++++++++++++++++++-------------
 7 files changed, 46 insertions(+), 18 deletions(-)

-- 
2.13.6
