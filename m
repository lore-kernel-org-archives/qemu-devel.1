Received: from eggs.gnu.org ([2001:4830:134:3::10]:37092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f4OZK-0003iI-I4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f4OZH-00079u-Eq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:26:06 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:51066
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1f4OZH-000791-69
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:26:03 -0400
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <78966219-7e8e-9458-2eb1-a2a4b8070c06@weilnetz.de>
Date: Fri, 6 Apr 2018 12:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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
To: Peter Maydell <peter.maydell@linaro.org>, alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 06.04.2018 um 11:41 schrieb Peter Maydell:
> On 5 April 2018 at 22:23,  <alarson@ddci.com> wrote:
>> Linux "works". I installed ubuntu 17.10 in a VM on my windows box,
>> recompiled QEMU 2.12.0-rc2 (same sources as above), using a configure
>> line the same as above except omitting --cross-prefix and --with-sdlabi.
>> Both with "-icount 2" and without show expected results.
>>
>> I installed a fresh Cygwin with just the packages suggested at
>> https://wiki.qemu.org/Hosts/W32#Native_builds_with_Mingw-w64 (plus
>> some obviously missing ones like python, make, etc.) and the problem
>> persists.  The updated configure line is:
>>
>> ../qemu-2.12.0-rc2/configure \
>>     '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>>     --prefix=/usr/local/qemu \
>>     '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
>>     --cross-prefix=i686-w64-mingw32-
> Hmm, if it's Windows-only that's unfortunate, since I'm not really
> in a position to debug things that only happon on Windows hosts.
>
> Stefan, does this sort of bug sound familiar at all?

No, It's new for me. But the last time when I used "-icount" must be
several years ago, so I have to look.

> Looking at your --cross-prefix you seem to be building 32-bit
> binaries; was your Ubuntu VM 32 bit or 64 bit? I'm wondering
> if this might turn out to be a 32-bit host issue rather than
> necessarily a Windows one.

That might be a possible. I think there are not many QEMU users running
it on 32 bit Linux, especially not to emulate a 64 bit guest. We should
test this first, as testing and debugging QEMU on Linux is much easier
than on Windows.

Stefan
