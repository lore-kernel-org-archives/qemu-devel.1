Received: from eggs.gnu.org ([2001:4830:134:3::10]:41648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cliPo-0005Lp-Py
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cliPn-0001L3-HU
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:42:32 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cliPn-0001KZ-9u
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:42:31 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so124545876wma.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 12:42:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAa=b7c4LFiBfNYWhoWPPmV00yRPjQ58RRgbKYV+ZPddL7RRPQ@mail.gmail.com>
References: <CAAa=b7c4LFiBfNYWhoWPPmV00yRPjQ58RRgbKYV+ZPddL7RRPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 21:42:09 +0100
Message-ID: <CAFEAcA_Oms7=XCqnaZKhdmweB5bO2dPAZUBfMfb=tjHZiA5CoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Performance difference between QEMU 2.2.0 and 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wenwen Wang <wenwang@cs.umn.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>

On 8 March 2017 at 18:17, Wenwen Wang <wenwang@cs.umn.edu> wrote:
> I just found that there is a significant performance difference between QEMU
> version 2.2.0 and 2.6.0.
>
> Here are the execution times of the benchmark 458.sjeng from SPEC CINT2006
> with test workload using user only emulation from ARM guest to x86-32 host:
>
> qemu-2.2.0: 29 seconds
> qemu-2.6.0: 38 seconds

2.6.0 is now quite old -- it would be interesting to test this on
the current git master.

> Could anyone tell me what this difference comes from or give me any hint?

There are lots of changes between those two releases, and we don't
in general track performance at all, so a regression is not very
surprising to me. If you wanted to try to identify what caused it
you could try a git bisect.

thanks
-- PMM
