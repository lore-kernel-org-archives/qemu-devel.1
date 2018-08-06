Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUJ0-0008QT-OB
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUIx-0001FW-J8
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmUIx-0001F3-4i
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id h12-v6so5437113pgs.3
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 18:27:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  5 Aug 2018 18:27:21 -0700
Message-Id: <20180806012723.5639-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/ppc: Fixes for my fpu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk

David, please squash these with the patches you already
have on your ppc-for-3.1 branch.

The first fixes fp division within the vector insns.
The second fixes some typos within the load/store converters
as reported by Mark Cave-Ayland.


r~


Richard Henderson (2):
  fixup! target/ppc: Honor fpscr_ze semantics and tidy fdiv
  fixup! target/ppc: Use non-arithmetic conversions for fp load/store

 target/ppc/fpu_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.1
