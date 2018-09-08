Received: from eggs.gnu.org ([208.118.235.92]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyinC-0005yN-AB
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyijo-0008TP-3G
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fyijn-0008OZ-Nv
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  8 Sep 2018 15:17:33 -0400
Message-Id: <20180908191735.22861-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 0/2] softfloat tests based on berkeley's
 testfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

A few fixes since yesterday's v1:
  https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00884.html

- Convert copy_qemu_to_soft80 to qemu_to_soft80, just like the other
  conversion functions
- Set fp-test as the program name as reported by itself
- Fix Makefile to include .d files so that dependencies are
  properly tracked
- Update commit log

Grab this from:
  https://github.com/cota/qemu/tree/fp-test-v2

Thanks,

		Emilio
