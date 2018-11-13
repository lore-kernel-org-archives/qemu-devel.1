Received: from eggs.gnu.org ([2001:4830:134:3::10]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMdEE-0003DU-Fb
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMd1b-0007zL-Dv
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:02:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMd1Z-0007vY-Ez
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:02:54 -0500
Received: by mail-wm1-x344.google.com with SMTP id u13-v6so12346335wmc.4
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 10:02:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 13 Nov 2018 19:01:50 +0100
Message-Id: <20181113180154.17903-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/4] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Facepalm.  I managed to not push the v3 changes anywhere,
so the v4 changes were done on top of v2.  Ho hum.

r~


Richard Henderson (4):
  target/arm: Install ARMISARegisters from kvm host
  target/arm: Fill in ARMISARegisters for kvm64
  target/arm: Introduce read_sys_reg32 for kvm32
  target/arm: Fill in ARMISARegisters for kvm32

 target/arm/kvm_arm.h |  1 +
 target/arm/kvm.c     |  1 +
 target/arm/kvm32.c   | 77 +++++++++++++++++++++++--------------
 target/arm/kvm64.c   | 90 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 139 insertions(+), 30 deletions(-)

-- 
2.17.2
