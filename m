Received: from eggs.gnu.org ([2001:4830:134:3::10]:35648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4RUm-0008CY-Tu
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4RUl-0004aV-Tl
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:36 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4RUl-0004aG-OL
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:35 -0400
Received: by mail-ot0-x244.google.com with SMTP id h26-v6so1158437otj.12
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 14:33:14 +0100
Message-ID: <CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
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

On 6 April 2018 at 14:28,  <alarson@ddci.com> wrote:
> "Peter Maydell" <peter.maydell@linaro.org> wrote:
>> On 5 April 2018 at 22:23,  <alarson@ddci.com> wrote:
>> > I installed a fresh Cygwin with just the packages suggested at
>> > https://wiki.qemu.org/Hosts/W32#Native_builds_with_Mingw-w64 (plus
>> > some obviously missing ones like python, make, etc.) and the problem
>> > persists.  The updated configure line is:
>> >
>> > ../qemu-2.12.0-rc2/configure \
>> >     '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>> >     --prefix=/usr/local/qemu \
>> >     '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
>> >     --cross-prefix=i686-w64-mingw32-
>>
>> Hmm, if it's Windows-only that's unfortunate, since I'm not really
>> in a position to debug things that only happon on Windows hosts.
>>
>> Stefan, does this sort of bug sound familiar at all?
>>
>> Looking at your --cross-prefix you seem to be building 32-bit
>> binaries; was your Ubuntu VM 32 bit or 64 bit? I'm wondering
>> if this might turn out to be a 32-bit host issue rather than
>> necessarily a Windows one.
>
> 1. Ubuntu 17.10 is 64-bit, compilation was native, run on the
>    compilation host.  I.e., I did not cross compile to windows.
> 2. Cygwin was a 64-bit install, 64-bit windows 7 host.  I followed the
>    instructions on the wiki.  I was curious about the "ming32" part
>    myself, but cygwin package search doesn't indicate an obvious (to
>    me) replacement.

You're building your mingw32 binaries with an i686- compiler,
not an x86_64- one, so you'll end up with 32-bit Windows binaries
running on your 64-bit Windows installation.
If you have the 64-bit cross compiler and libraries for it you
could try a --cross-prefix=x86_64-w64-mingw32- build.

On this end I should try this with a 32-bit Linux host.

thanks
-- PMM
