Received: from eggs.gnu.org ([2001:4830:134:3::10]:32769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87sH-0006Dr-AD
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87s3-0005gE-74
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:14 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g87s2-0005eN-Lj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id u197-v6so8228630oif.5
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 10:57:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  4 Oct 2018 12:56:56 -0500
Message-Id: <20181004175700.20847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/4] softfloat: Fix division
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

Changes from v2:
  * Add shift128Left.  I had been using shortShift128Left,
    with a shift of 64, which lead to undefined behaviour.
    Which I suspect is exactly the Heisenbug Alex saw.

    I did keep the R-b tags I had already applied.


r~


Richard Henderson (4):
  softfloat: Fix division
  softfloat: Specialize udiv_qrnnd for x86_64
  softfloat: Specialize udiv_qrnnd for s390x
  softfloat: Specialize udiv_qrnnd for ppc64

 include/fpu/softfloat-macros.h | 62 +++++++++++++++++++++++++++++-----
 fpu/softfloat.c                | 35 ++++++++++++++-----
 2 files changed, 80 insertions(+), 17 deletions(-)

-- 
2.17.1
