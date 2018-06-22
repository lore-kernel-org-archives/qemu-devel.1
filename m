Received: from eggs.gnu.org ([2001:4830:134:3::10]:44036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1G-0001bp-PV
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1D-0002Hs-Ld
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:10 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fWH1D-0002FN-Am
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:07 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri, 22 Jun 2018 11:01:36 +0300
Message-Id: <20180622080138.17702-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 0/2] Strict alignment for ARMv6-M and
 ARMv8-M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v2:
    * Added feature bit for the Main Extention
    * Alignment patch is modified to use ARM_FEATURE_M_MAIN

Julia Suvorova (2):
  target/arm: Introduce ARM_FEATURE_M_MAIN
  target/arm: Strict alignment for ARMv6-M and ARMv8-M Baseline

 target/arm/cpu.c       |  3 +++
 target/arm/cpu.h       |  1 +
 target/arm/translate.c | 18 ++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.17.0
