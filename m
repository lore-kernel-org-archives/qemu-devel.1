Received: from eggs.gnu.org ([2001:4830:134:3::10]:37601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1pG-0003T6-6j
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1pE-0000vp-5B
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:26 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fq1pA-0000uE-VM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:22 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so3954484oie.13
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 12:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2515-5b748080-b-e0a2440@99331474>
References: <CAFEAcA-fEe2TsRpd5Q1i7Z-0MC67o0xkfgLW1ifV64HpfL2czg@mail.gmail.com>
	<2515-5b748080-b-e0a2440@99331474>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 20:50:56 +0100
Message-ID: <CAFEAcA8B3Qvxtoh0n6RyiBJEHVG39HoEzCfEZHCuyrbdnoYGwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] MIPS queue for QEMU upstream,
 August 14, 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 20:35, Aleksandar Markovic
<Aleksandar.Markovic@rt-rk.com> wrote:
> These functions are used in the patches that follow in nanoMIPS series, but
> not submitted in this pull request.
>
> Ok, I will reorganize the patches so that there is no such case, and will
> send the new pull request soon.
>
> Do we require that bisect works for clang builds too (meaning that after
> each patch, clang build must be success)?

Yes, please. (As usual with breaking-bisection, if you get it wrong by
accident we may well not notice, but it's worth trying to get right.)

thanks
-- PMM
