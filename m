Received: from eggs.gnu.org ([2001:4830:134:3::10]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bruno@clisp.org>) id 1dRnHp-0003XZ-Pm
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 18:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bruno@clisp.org>) id 1dRnHm-0004kF-Lp
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 18:24:13 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::5]:29092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bruno@clisp.org>) id 1dRnHm-0004jn-Bw
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 18:24:10 -0400
From: Bruno Haible <bruno@clisp.org>
Date: Mon, 03 Jul 2017 00:24:07 +0200
Message-ID: <3106220.iSoDK9SyKm@omega>
In-Reply-To: <20170702202814.27793-1-aurelien@aurel32.net>
References: <20170702202814.27793-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/sh4: misc FPU fixes and
 optimizations
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

Aurelien Jarno wrote:
> This patchset should fix the bug#1701821 reported by Bruno Haible,
> which makes the gnulib testsuite to fail for single precision libm
> tests or for tests relying on unordered comparisons.

It does fix it: All floating-point related tests of gnulib now pass with
qemu-sh4. Thanks!

Bruno
