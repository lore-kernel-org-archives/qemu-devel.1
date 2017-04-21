Received: from eggs.gnu.org ([2001:4830:134:3::10]:49676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1cHW-0003EJ-KA
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1cHV-0001oL-Qb
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:23:42 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1cHV-0001oF-Jz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:23:41 -0400
Received: by mail-wm0-x230.google.com with SMTP id o81so20808535wmb.1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 10:23:41 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 18:23:19 +0100
Message-ID: <CAFEAcA_3fm+-6QaH0eb46wF7OS1qFnCEcEBa-q6UnGZD5HemPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] How expensive is an extra QEMU TLB MMU index ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi; I have a feature for the ARM M profile emulation which I think
needs to be implemented by giving it a separate mmu index value.
[The HFNMIENA control bit allows "privileged and execution priority
is higher than 0" to run with the MPU effectively off even if normal
privileged execution has enabled the MPU.]

I could implement this by just bumping ARM's NB_MMU_MODES to 8
and using the extra value for this. On the other hand, several
of the current 7 index values are not needed for M profile CPUs,
so in theory I could reuse one of those (so it would have different
meanings if the CPU was M profile or not). But that feels like it would
be pretty accident-prone, since so much of the code is shared.

So, just how expensive is having an extra MMU mode which isn't
actually used? Is it bad enough to be worth the reduced
maintainability?

thanks
-- PMM
