Received: from eggs.gnu.org ([209.51.188.92]:40406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goTzy-0004Zo-RX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goTzv-000071-EP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goTzr-0008Pn-Hj
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:04:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id z5so22160713wrt.11
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:04:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 14:04:09 +0000
Message-Id: <20190129140411.682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Fix FCMLA decoding errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Desnogues <laurent.desnogues@gmail.com>

This patchset fixes the two bugs in our decode of
FCMLA (by element) reported by Laurent.

Based-on: 20190125182626.9221-1-peter.maydell@linaro.org
("target/arm: Fix various underdecodings")

thanks
-- PMM

Peter Maydell (2):
  target/arm/translate-a64: Fix FCMLA decoding error
  target/arm/translate-a64: Fix mishandling of size in FCMLA decode

 target/arm/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1
