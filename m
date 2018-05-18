Received: from eggs.gnu.org ([2001:4830:134:3::10]:38313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJdoE-0006h7-Br
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJdoA-0007zD-T9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:30 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJdoA-0007xb-I5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:26 -0400
Received: by mail-wm0-x244.google.com with SMTP id a67-v6so13534303wmf.3
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 04:44:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 May 2018 12:44:22 +0100
Message-Id: <20180518114424.18054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] support reading of CNT[VCT|FRQ]_EL0
 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

The second patch won't build on master until the tcg testing revival
is merged but I've included it for reference.

Alex.

Alex Bennée (2):
  target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space
  tests/tcg/aarch64: userspace system register test

 target/arm/helper.c               | 27 ++++++++++++++++++++++++---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/sysregs.c       | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

-- 
2.17.0
