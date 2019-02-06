Received: from eggs.gnu.org ([209.51.188.92]:33141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEI-0005bT-MS
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEI-0007hi-4D
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKEH-0007hQ-Sz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id a16so6907808wrv.0
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:14:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:14:44 +0000
Message-Id: <20190206101446.6898-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH RISU 0/2] Do not enable --sve by default
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

In the process of noticing what the problem was, 
add fp regs to the aarch64 smoke test.


r~


Richard Henderson (2):
  aarch64: Fill in fp regs for test_aarch64.s
  risugen: Default to sve off

 risugen        |  3 ++-
 test_aarch64.s | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.17.2
