Received: from eggs.gnu.org ([209.51.188.92]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O2-0007eg-A0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O0-0005yy-5h
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm2Nz-0005qC-Gy
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 Jan 2019 15:10:38 -0500
Message-Id: <20190122201042.26394-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] fp-test fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Fix the issues reported by Peter in this thread:
  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04135.html

The most important fix is in patch 4 -- I forgot to include config-host.h
from platform.h! Thanks to Alex for pointing out on IRC that LITTLEENDIAN
was not consistently defined, that was the hint I needed to find the problem.

This series applies on top of Alex's fpu/next branch. With them,
`make check-softfloat' works on both little and big endian hosts.

Thanks,

		Emilio
