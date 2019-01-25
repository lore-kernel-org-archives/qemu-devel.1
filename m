Received: from eggs.gnu.org ([209.51.188.92]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bk-0004Jz-CX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002dk-Dy
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bi-0002RR-4K
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m22so7566606wml.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:19 +0000
Message-Id: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] target/arm: Fix various underdecodings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

This patchset fixes the various cases of underdecoded instructions
that Laurent spotted and sent a bug report for. (The exception
is "missing default in disas_data_proc_1src", which got fixed in
commit 18de2813c35e359621a.)

thanks
-- PMM

Peter Maydell (7):
  target/arm/translate-a64: Don't underdecode system instructions
  target/arm/translate-a64: Don't underdecode PRFM
  target/arm/translate-a64: Don't underdecode SIMD ld/st multiple
  target/arm/translate-a64: Don't underdecode SIMD ld/st single
  target/arm/translate-a64: Don't underdecode add/sub extended register
  target/arm/translate-a64: Don't underdecode FP insns
  target/arm/translate-a64: Don't underdecode SDOT and UDOT

 target/arm/translate-a64.c | 53 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

-- 
2.20.1
