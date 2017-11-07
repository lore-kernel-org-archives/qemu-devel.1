Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0CY-00056k-4A
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0CW-00083I-Ey
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:29:46 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC0CW-00081d-6B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:29:44 -0500
Received: by mail-wr0-x241.google.com with SMTP id y9so11201231wrb.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 01:29:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03986f7a-f1f8-751a-4967-ab7d1a5093fd@vivier.eu>
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
	<03986f7a-f1f8-751a-4967-ab7d1a5093fd@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 09:29:21 +0000
Message-ID: <CAFEAcA8kXjH5dSM6KCGX5gfgJWJMAymz=D3BTMxjLwZQ7_s5hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Aaron Sierra <asierra@xes-inc.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2017 at 06:57, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 07/11/2017 =C3=A0 03:50, Aaron Sierra a =C3=A9crit :
>> Enable building PowerPC targets supporting a specific CPU, without
>> having to set QEMU_CPU via the environment. For example these build
>> targets (and many more) become available:
>>
>>     qemu-ppc.e500mc
>>     qemu-ppc.e500v2
>>     qemu-ppc.e5500
>>     qemu-ppc.e600
>>     qemu-ppc.e6500
>>
>> These (statically compiled) binaries have proven useful for emulating
>> PowerPC CPUs within Docker containers, where it's hard to reliably
>> define environment variables that are available for every process.
>
> I agree with you.
>
> I have patches to do that for years, perhaps we can merge our both
> solutions to have something working:
>
> linux-user: define default cpu model in configure instead of
> linux-user/main.c
> https://github.com/vivier/qemu-m68k/commit/1488df8c9fa3a5b099bbc4f41c077a=
6c69305cc2
>
> linux-user: specify the cpu model during configure
> https://github.com/vivier/qemu-m68k/commit/496f804fd97d5f0ef26da1090e1d95=
ad15bcc50e
>
> The part missing in my series is to rename the qemu binaries with the
> suffix of the default CPU.

I don't really like this -- it means we'll end up with a huge
extra range of executables, and every time a new CPU type is
added a new binary has to be plumbed in to our own 'make
install' machinery and into every distro's packaging.

The 'look at argv[0]' approach is perhaps a bit more
palatable. Or you could just write and use wrapper
scripts.

I take it there's no good "-cpu any" option for PPC that
would run all these binaries?

thanks
-- PMM
