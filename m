Received: from eggs.gnu.org ([2001:4830:134:3::10]:41759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4V3n-00006D-IA
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4V3m-0006NX-Ew
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:21:59 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4V3m-0006Mw-9K
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:21:58 -0400
Received: by mail-ot0-x242.google.com with SMTP id i28-v6so1956900otf.8
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:21:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF4BD73ECC.1B5CB55D-ON88258267.005D53FE-86258267.005DF33E@ddci.com>
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
	<CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
	<OF4BD73ECC.1B5CB55D-ON88258267.005D53FE-86258267.005DF33E@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 18:21:37 +0100
Message-ID: <CAFEAcA-S=GRXa26i2h-n=0FcWf4DGoyUdPA33P=hwamj3R3r7Q@mail.gmail.com>
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

On 6 April 2018 at 18:06,  <alarson@ddci.com> wrote:
> "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/06/2018 09:51:55
> AM:
>
>> I've now done this, and can reproduce the problem. So the
>> issue is generic to 32-bit hosts.
>
> Supporting evidence: I compiled Cygwin/MINGW with x86_64 and the
> resulting binaries work properly
>
> FWIW, the compile had some anomalous behavior:
>
> .../qemu-2.12.0-rc2/scripts/feature_to_c.sh: line 71: /usr/bin/sed:
> Invalid argument
>
> line 71 is:
>     arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
>
> Not sure what the problem is, but I always use "-e" before scripts.

That's a bit odd. (POSIX allows both "-e script" and just "script".)
What version of sed is this, and what version of /bin/sh ?

thanks
-- PMM
