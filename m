Received: from eggs.gnu.org ([2001:4830:134:3::10]:47253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPR-0005Uu-Da
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPQ-0001BO-8e
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:13 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:34621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d7kPQ-0001BE-45
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:12 -0400
Received: by mail-qk0-x229.google.com with SMTP id k74so54743074qke.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:17:11 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	r55sm7864331qte.22.2017.05.08.08.17.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 May 2017 08:17:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  8 May 2017 08:17:01 -0700
Message-Id: <20170508151707.5434-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 0/6] target/s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v1 from March,
  * The STFLE patch rewritten a bit to address comments
    from David Hildenbrand.


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
 target/s390x/misc_helper.c |  54 +++++++++++
 target/s390x/translate.c   | 229 +++++++++++++++++++++++++--------------------
 8 files changed, 258 insertions(+), 115 deletions(-)

-- 
2.9.3
