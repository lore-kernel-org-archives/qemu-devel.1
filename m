Received: from eggs.gnu.org ([209.51.188.92]:46623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8p-0001PN-3K
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8o-00007J-1V
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDi8m-00005J-LA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id bf11so8558475plb.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 21:13:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Apr 2019 18:13:35 -1000
Message-Id: <20190409041337.23602-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RISU 0/2] i386 support for avx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.bobek@gmail.com

It's quite plausible that we should add a command-line argument for
risu, similar to the aarch64 --test-sve option, that explicitly
limits the size of the vectors to be recorded or compared.  Otherwise
I worry about the host supporting AVX-N and wanting to test TCG with
a narrower vector insns.

Anyway, adding a command-line option should be a relatively trivial
extension to the following, which works to extract state from the
Intel XSAVE structure that the kernel borrows for the signal frame.


r~


Richard Henderson (2):
  i386: Add avx512 state to reginfo_t
  HACK: Test avx2 state

 risu_reginfo_i386.h |  15 ++++
 risu_reginfo_i386.c | 194 ++++++++++++++++++++++++++++++++++++++++++--
 test_i386.S         |  39 +++++++++
 3 files changed, 243 insertions(+), 5 deletions(-)

-- 
2.17.1
