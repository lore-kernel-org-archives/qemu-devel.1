Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bruno@clisp.org>) id 1dRiTm-0002vz-BH
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 13:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bruno@clisp.org>) id 1dRiTj-0008J8-5U
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 13:16:14 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::8]:16893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bruno@clisp.org>) id 1dRiTi-0008I3-Ry
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 13:16:11 -0400
From: Bruno Haible <bruno@clisp.org>
Date: Sun, 02 Jul 2017 19:03:50 +0200
Message-ID: <1900117.Shkreimp6b@omega>
In-Reply-To: <20170702163220.8039-1-aurelien@aurel32.net>
References: <20170702163220.8039-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/sh4: fix fabs and optimize fneg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

Hi Aurelien,

> This patchset should fix the bug #1701821 reported by Bruno Haible,
> which makes the gnulib testsuite to fail for single precision libm
> tests.
> 
> Aurelien Jarno (2):
>   target/sh4: do not check for PR bit for fabs instruction
>   target/sh4: do not use a helper to implement fneg

Thanks. It fixes most of the reported issues indeed. The following tests
still fail, though:

$ ~/inst-qemu/2.9.0/bin/qemu-sh4 test-floor2
../../gltests/test-floor2.c:130: assertion 'correct_result_p (x, reference)' failed
qemu: uncaught target signal 6 (Aborted) - core dumped

$ ~/inst-qemu/2.9.0/bin/qemu-sh4 test-round2
reference implementations disagree: round(nan(nan)) = nan(nan) or 0(0x0p+0)?

$ ~/inst-qemu/2.9.0/bin/qemu-sh4 test-roundf2
reference implementations disagree: roundf(nan(nan)) = nan(nan) or 0(0x0p+0)?

But these could also be glibc bugs in the respective functions; I cannot tell.

Bruno
