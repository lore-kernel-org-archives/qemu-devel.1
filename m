Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-000444-3g
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQh-0003L9-Ol
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQh-0003Ir-Hd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:46 -0400
Message-Id: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 00/14] fp-test + hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Sending this respin (little more than a rebase) in case there's
reviewer bandwidth available until the soft-freeze in 3 weeks.

v3: https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00455.html

Not much has changed since April's v3:

- Rebase to current master, fixing some conflicts.
- Add R-b tags
- Fix a typo in the long "hardfloat" comment.
- Move <system.h> header includes right after #include "qemu/osdep.h"
  Did this after seeing this message from Eric Blake:
  https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00831.html

Note: there are some checkpatch errors, but they are false positives.

Perf numbers for fp-bench are in each commit log; numbers for several
benchmarks are in the last patch's commit log.

You can fetch this series from:
  https://github.com/cota/qemu/tree/hardfloat-v4

Thanks,

		Emilio
