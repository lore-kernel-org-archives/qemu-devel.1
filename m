Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLyC5-0003hF-22
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLyC0-0002yE-78
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:54:45 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:40963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fLyC0-0002wa-0d
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:54:40 -0400
Received: by mail-pl0-x232.google.com with SMTP id az12-v6so1843016plb.8
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 14:54:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <78dbf5ad-a067-0e0e-a073-1b854109df7e@twiddle.net>
Date: Thu, 24 May 2018 14:54:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RISC-V] Coverity 1390849, Logically dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel <qemu-devel@nongnu.org>

In the latest Coverity scan, it reports

405    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
406        return 0;
407    }
408#if defined(TARGET_RISCV32)
409    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
   	
CID 1390849 (#1 of 1): Logically dead code (DEADCODE)
dead_error_line: Execution cannot reach this statement: return 0U;.

410        return 0;
411    }
412#endif


I believe the condition at op_helper.c:409 should be testing CSR_MHPMCOUNTER3H
and CSR_MHPMCOUNTER31H.  Must run now, otherwise I'd also send the trivial patch.


r~
