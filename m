Received: from eggs.gnu.org ([2001:4830:134:3::10]:55411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYg-0002f8-0j
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYb-0005AM-OU
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7lYb-0003z2-CT
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id 22-v6so4321046oiz.2
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 11:07:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Oct 2018 13:07:07 -0500
Message-Id: <20181003180711.19335-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/4] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org

Changes from v1:
  * Preserve udiv_qrnnd as a separate division primitive that
    could be used as a building block for float128 division.
  * Include asm fragments for x86_64, s390x, and ppc64.


r~


Richard Henderson (4):
  softfloat: Fix division
  softfloat: Specialize udiv_qrnnd for x86_64
  softfloat: Specialize udiv_qrnnd for s390x
  softfloat: Specialize udiv_qrnnd for ppc64

 include/fpu/softfloat-macros.h | 35 +++++++++++++++++++++++++++++++---
 fpu/softfloat.c                | 35 ++++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.17.1
