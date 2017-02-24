Received: from eggs.gnu.org ([2001:4830:134:3::10]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chKOs-0004Gm-Ik
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chKOp-0001hX-Rh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:15:26 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:50091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1chKOp-0001gF-Di
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:15:23 -0500
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <619a06f3-1b9a-ba3e-2469-76e57bf838f0@vivier.eu>
Date: Fri, 24 Feb 2017 19:15:12 +0100
MIME-Version: 1.0
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH risu 0/9] risu: refactor and reduce
 CPU-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Le 24/02/2017 à 18:35, Peter Maydell a écrit :
> This patchset refactors the risu C code to reduce the significant
> amount of duplicated and duplicated-but-not-quite-the-same code
> in the per-CPU files.
> 
> I've compile tested this for all architectures, but I'm not in a
> position to do runtime tests for non-ARM (my attempt to use the
> ppc64le risu under QEMU gives mismatch errors even without these
> patches, and the m68k risu makes QEMU crash, presumably because our
> m68k support isn't complete yet).  So I wasn't quite prepared to just

Yes, the FPU part is missing.

> push it straight out to master the way I've done with previous
> changes I've been making.
> 
> Nikunj, Laurent: if you have time to test this patchset to confirm
> that it hasn't broken anything for you that would be great.

for m68k
Tested-by: Laurent Vivier <laurent@vivier.eu>

> 
> My motivation for all this, incidentally, is that I wanted to have
> a go at resurrecting the x86 backend as a test case for how we
> should support variable-length instruction sets.

I think m68k is needing that too.

Thanks,
Laurent
