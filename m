Received: from eggs.gnu.org ([2001:4830:134:3::10]:50776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGgV-0006wJ-G1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGgQ-0006d3-IJ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:41:39 -0500
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:36453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjGgQ-0006cX-Ck
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:41:34 -0500
Received: by mail-qk0-x231.google.com with SMTP id n186so100139915qkb.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 18:41:34 -0800 (PST)
Received: from bigtime.twiddle.net.com (mail.taphouse.com.au. [180.214.90.195])
	by smtp.gmail.com with ESMTPSA id s3sm4459321qte.57.2017.03.01.18.41.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 Mar 2017 18:41:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  2 Mar 2017 13:41:04 +1100
Message-Id: <20170302024110.3978-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/6] target/s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Herein find my 3 year old STFLE patch, two of the patches that were
posted this week for LPP and LPD, and three patches to convert the
atomic operations in the s390 frontend to actually be atomic.


r~


Eric Bischoff (1):
  target/s390x: Implement LOAD PAIR DISJOINT

Miroslav Benes (1):
  target/s390x: Implement LOAD PROGRAM PARAMETER

Richard Henderson (4):
  target/s390x: Implement STORE FACILITIES LIST EXTENDED
  target/s390x: Diagnose specification exception for atomics
  target/s390x: Use atomic operations for COMPARE SWAP
  target/s390x: Use atomic operations for LOAD AND OP

 target/s390x/cpu.c         |   1 +
 target/s390x/cpu.h         |   3 +
 target/s390x/helper.c      |  16 ++++
 target/s390x/helper.h      |   3 +
 target/s390x/insn-data.def |  28 +++---
 target/s390x/mem_helper.c  |  39 ++++++++
 target/s390x/misc_helper.c |  41 ++++++++
 target/s390x/translate.c   | 229 +++++++++++++++++++++++++--------------------
 8 files changed, 245 insertions(+), 115 deletions(-)

-- 
2.9.3
