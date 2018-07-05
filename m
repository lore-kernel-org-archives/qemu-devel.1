Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9my-0001D8-JD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9mv-000491-Fp
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:36 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb9mv-00048D-8A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:33 -0400
Received: by mail-pl0-x241.google.com with SMTP id b1-v6so1695296pls.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 12:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Jul 2018 12:19:27 -0700
Message-Id: <20180705191929.30773-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: SVE fixes
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

RISU testing with ARM Fast Models and VQ=16 showed up two bugs,
both affecting the PTRUE instruction.


r~


Richard Henderson (2):
  tcg: Restrict check_size_impl to multiples of the line size
  target/arm: Fix do_predset for large VL

 target/arm/translate-sve.c | 10 ++--------
 tcg/tcg-op-gvec.c          |  7 +++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.17.1
