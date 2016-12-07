Received: from eggs.gnu.org ([2001:4830:134:3::10]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEghE-0005EJ-6E
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEghB-0006YE-1W
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:12:00 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEghA-0006Y2-Lv
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:11:56 -0500
Received: by mail-ua0-f175.google.com with SMTP id 12so423759522uas.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 10:11:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207180727.6286-2-rth@twiddle.net>
References: <20161207180727.6286-1-rth@twiddle.net>
	<20161207180727.6286-2-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Dec 2016 18:10:35 +0000
Message-ID: <CAFEAcA_7kvm41Q-hzWW04ujk+y4jAekhoG9A4yYFSdaoDOgpHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] tcg/aarch64: Fix addsub2 for 0+C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 7 December 2016 at 18:07, Richard Henderson <rth@twiddle.net> wrote:
> When al == xzr, we cannot use addi/subi because that encodes xsp.
> Force a zero into the temp register for that (rare) case.

Incidentally I was slightly surprised that the optimisation
pass didn't turn "add2 rlo, rhi, 0, 0, 0, 0" into moves of 0
into rlo and rhi. Constant shifts of xzr in the guest don't
seem worth spending much effort on optimising though :-)

thanks
-- PMM
