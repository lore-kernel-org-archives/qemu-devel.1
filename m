Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xJ-0000pg-QY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xE-0007Kf-Tr
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:45 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:45319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZ9xE-0007KB-Mg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:40 -0500
Received: by mail-pl0-x242.google.com with SMTP id o2so6716383plk.12
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 22:33:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 22:33:35 -0800
Message-Id: <20180110063337.21538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: split out vfp_expand_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

One more piece of target/arm prep work from my SVE branch.

I saw that Alex was touching the same bit of code in his ARMv8.2
fp16 patch set and thought we should coordinate on this.


r~


Richard Henderson (2):
  target/arm: Split out vfp_expand_imm
  target/arm: Add fp16 support to vfp_expand_imm

 target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 16 deletions(-)

-- 
2.13.6
