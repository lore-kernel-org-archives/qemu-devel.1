Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Siv-0005tR-VP
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Siv-0005tX-8L
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:52:18 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4Siv-0005tO-2p
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:52:17 -0400
Received: by mail-ot0-x244.google.com with SMTP id n40-v6so1460242otd.3
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 07:52:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
	<CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 15:51:55 +0100
Message-ID: <CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 6 April 2018 at 14:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> On this end I should try this with a 32-bit Linux host.

I've now done this, and can reproduce the problem. So the
issue is generic to 32-bit hosts.

I'll see if I can figure out what's going wrong. In the
meantime, you can probably work around it by building
64-bit binaries rather than 32-bit ones (they will
perform a bit better I think, so unless you need to
retain support for running on 32-bit Windows that would
be a good idea anyway).

thanks
-- PMM
