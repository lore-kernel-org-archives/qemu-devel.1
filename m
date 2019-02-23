Received: from eggs.gnu.org ([209.51.188.92]:55593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNER-0002ut-N1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNER-0002Uu-0K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:03 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:40283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNEQ-0002Sp-8r
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:02 -0500
Received: by mail-pl1-x62f.google.com with SMTP id bj4so1896882plb.7
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:51 -0800
Message-Id: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH+RFC 0/6] target/arm: Define cortex-a{73, 75, 76}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

There have been several announcements since the a72.

The a75 and a76 entries are RFC because, while they boot with a 3.15
kernel, they do not boot with a 5.0-rc7 kernel.  I'm really not sure
where things have gone off the rails.  It'll take some more serious
tracing to figure out what went wrong.

I post this now mostly to get feedback on patch 5.  Should we do
more to elide *all* of the aa32 system registers for that case?


r~


Richard Henderson (6):
  target/arm: Implement ID_PFR2
  target/arm: Define cortex-a73
  target/arm: Implement ID_AA64MMFR2
  target/arm: Define cortex-a75
  target/arm: Conditionalize DBGDIDR vs ID_AA64DFR0_EL1 assert
  target/arm: Define cortex-a76

 target/arm/cpu.h    |  18 +++++
 hw/arm/virt.c       |   3 +
 target/arm/cpu64.c  | 179 +++++++++++++++++++++++++++++++++++++++++++-
 target/arm/helper.c |  66 ++++++++++------
 target/arm/kvm64.c  |   2 +
 5 files changed, 240 insertions(+), 28 deletions(-)

-- 
2.17.2
