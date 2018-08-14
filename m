Received: from eggs.gnu.org ([2001:4830:134:3::10]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdtI-0003LQ-Gh
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdso-0005sk-85
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:00 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpdso-0005sI-0C
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:17:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id w126-v6so35328477oie.7
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 11:17:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B7314EF.5090005@gmx.com>
References: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
	<153414808571.8168.1723488818633453757.malone@wampee.canonical.com>
	<5B71D4C8.7060006@gmx.com>
	<CAFEAcA91Pj5WFfWtu+_OtpC86xeR003wx897jDJKo0cpdJAc6Q@mail.gmail.com>
	<5B7314EF.5090005@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:08 +0100
Message-ID: <CAFEAcA_EJpR6YT2gjpTrRxz9mbRfSTyZKh30Q5bchEXmb6CznA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel]
	=?utf-8?q?=5BBug_1785698=5D_Re=3A_Solaris_build_err?=
	=?utf-8?b?b3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdjcnlfZXJyb3JfdOKAmQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1785698 <1785698@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2018 at 18:44, Michele Denber <1785698@bugs.launchpad.net> wrote:
> On 08-14-2018 4:42 AM, Peter Maydell wrote:
>>
>> We do assume a posix shell and that that shell is /bin/sh.
>> We may have bugs where we assume non-posix behaviour
>> from it, since almost all users are going to be on systems
>> where /bin/sh is bash or dash or whatever the BSD /bin/sh is.
> Apparently Solaris is different in that regard (among others).

Yeah. I'm not sure how much I care about supporting OSes that
decide to be totally different from everybody else, to be honest.
It's the 21st century and POSIX is a thing.

>> (dtc is a sort-of-third-party module, not part of QEMU
>> proper.)
> I notice in the Makefile in dtc/ that it's calling python.  My default
> python is 2.6.9.

Our Python requirement is 2.7, and configure should check that.
If you're telling configure --python=/some/nondefault/python
then I guess the problem is we're not passing that on to dtc's
build process.

> Or is this dtc stuff really necessary?

It is necessary, but only for certain guest CPU types. You can
disable it by passing configure both "--disable-fdt" and also
"--target-list=<some list of targets which doesn't include
any arm, ppc, mips, microblaze or riscv targets>"
(for instance "--target-list=x86_64-softmmu".)

thanks
-- PMM
