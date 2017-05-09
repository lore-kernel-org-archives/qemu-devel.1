Received: from eggs.gnu.org ([2001:4830:134:3::10]:53873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d89Xd-00011X-Uo
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d89Xd-0002e9-7R
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:07:21 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:36244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d89Xd-0002de-37
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:07:21 -0400
Received: by mail-qt0-x233.google.com with SMTP id m91so7742794qte.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 11:07:21 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id w12sm213102qtc.20.2017.05.09.11.07.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 May 2017 11:07:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  9 May 2017 11:07:09 -0700
Message-Id: <20170509180715.22910-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 0/6] target/s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v2:
  * Fix STFLE patch as pointed out by Aurelien.
  * Adjust CS patch to change is_64 boolean in
    s->insn->data to TCGMemOp.


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
 target/s390x/insn-data.def |  38 ++++----
 target/s390x/mem_helper.c  |  39 ++++++++
 target/s390x/misc_helper.c |  59 ++++++++++++
 target/s390x/translate.c   | 229 ++++++++++++++++++++++++---------------------
 8 files changed, 267 insertions(+), 121 deletions(-)

-- 
2.9.3
