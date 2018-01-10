Received: from eggs.gnu.org ([2001:4830:134:3::10]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEr-0005lm-Sc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEm-0000eS-80
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:57 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZBEm-0000dd-1W
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:52 -0500
Received: by mail-pl0-x243.google.com with SMTP id o2so6809245plk.12
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 23:55:51 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	h80sm15740147pfj.12.2018.01.09.23.55.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Jan 2018 23:55:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 23:55:45 -0800
Message-Id: <20180110075547.15841-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] tcg/ppc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I found two problems testing my ARM SVE branch on PPC64.


r~


Richard Henderson (2):
  tcg/ppc: Support tlb offsets larger than 64k
  tcg/ppc: Allow a 32-bit offset to the constant pool

 tcg/ppc/tcg-target.inc.c | 84 +++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

-- 
2.14.3
