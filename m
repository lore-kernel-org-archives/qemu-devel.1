Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAMD-0004Tt-MK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAM8-00042P-OR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dbAM8-000424-KH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:24 -0400
Received: by mail-qt0-x242.google.com with SMTP id u19so10839001qtc.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 11:51:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 28 Jul 2017 11:50:48 -0700
Message-Id: <20170728185050.20395-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Two quick tcg-ish fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

One found by Coverity and one found while working on
some code destined for 2.11.


r~


Richard Henderson (2):
  tcg/arm: Fix runtime overalignment test
  target/s390x: Fix CSST for 16-byte store

 target/s390x/mem_helper.c | 1 +
 tcg/arm/tcg-target.inc.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.13.3
