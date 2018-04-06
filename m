Received: from eggs.gnu.org ([2001:4830:134:3::10]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Ns4-0006gi-9T
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Ns2-00083A-RD
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:41:24 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4Ns2-00082b-La
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:41:22 -0400
Received: by mail-ot0-x244.google.com with SMTP id y46-v6so548223otd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 02:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 10:41:01 +0100
Message-ID: <CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
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

On 5 April 2018 at 22:23,  <alarson@ddci.com> wrote:
> "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018 12:28:01
> PM:
>
>> From: "Peter Maydell" <peter.maydell@linaro.org>
>> To: alarson@ddci.com
>> Cc: "QEMU Developers" <qemu-devel@nongnu.org>
>> Date: 04/05/2018 12:28 PM
>> Subject: Re: [Qemu-devel] -icount changes physical address assignments
> in QEMU 2.10/2.11
>>
>> On 5 April 2018 at 17:44,  <alarson@ddci.com> wrote:
>> > "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018
> 09:05:53
>> > AM:
>> >> I've just tried your attached test image ...
>> >
>> > Curious.  I just downloaded qemu-2.12.0-rc2.tar.xz and built it using
>> > Cygwin (a version from about a month ago) using mingw compilers
>> > (mingw64-i686-gcc-g++ 6.4.0), and I still see the issue when the
>> > resulting QEMU binary is run using -icount 2 against my test binary,
>> > but not when run without -icount.  Here are the commands used:
>> >
>> > ../qemu-2.12.0-rc2/configure --python=/usr/bin/python \
>> >    '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>> >    --prefix=/usr/local/qemu \
>> >    --enable-sdl --with-sdlabi=2.0 \
>> >    '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
>> >    --cross-prefix=i686-w64-mingw32-
>> > /usr/bin/make -Otarget -j 8
>> >
>> > Any suggestions of things to try?
>>
>> Can you reproduce the problem on a Linux host? It would
>> be interesting to identify if this is a Windows-host
>> specific issue somehow.
>
> Linux "works".  I installed ubuntu 17.10 in a VM on my windows box,
> recompiled QEMU 2.12.0-rc2 (same sources as above), using a configure
> line the same as above except omitting --cross-prefix and --with-sdlabi.
> Both with "-icount 2" and without show expected results.
>
> I installed a fresh Cygwin with just the packages suggested at
> https://wiki.qemu.org/Hosts/W32#Native_builds_with_Mingw-w64 (plus
> some obviously missing ones like python, make, etc.) and the problem
> persists.  The updated configure line is:
>
> ../qemu-2.12.0-rc2/configure \
>     '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>     --prefix=/usr/local/qemu \
>     '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
>     --cross-prefix=i686-w64-mingw32-

Hmm, if it's Windows-only that's unfortunate, since I'm not really
in a position to debug things that only happon on Windows hosts.

Stefan, does this sort of bug sound familiar at all?

Looking at your --cross-prefix you seem to be building 32-bit
binaries; was your Ubuntu VM 32 bit or 64 bit? I'm wondering
if this might turn out to be a 32-bit host issue rather than
necessarily a Windows one.

thanks
-- PMM
