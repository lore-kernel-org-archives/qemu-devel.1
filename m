Received: from eggs.gnu.org ([2001:4830:134:3::10]:39413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eMUxA-0007p5-47
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eMUx6-00080a-VH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:21:16 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eMUx6-0007zu-KV
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:21:12 -0500
References: <20171123163538.31411-1-laurent@vivier.eu>
	<CAFEAcA9+f2cgUUS00DXzF9a96evPRnxY5MTUZpe+OA3Trv84WA@mail.gmail.com>
	<e6dc192f-6fcd-f25d-d1db-983280c915f4@vivier.eu>
	<CAFEAcA9uOJ5i-XbK5zbxgFBSvu=kQ6p99EA-CyhrSTKtx+CF9A@mail.gmail.com>
	<e90eaeb0-19d4-659c-9007-5b0e18d87d9a@tuxfamily.org>
	<629dc696-a5e7-4b94-f964-0e9fdd7cf511@vivier.eu>
	<13637ee3-544f-11cc-4ee7-a27af2c91173@tuxfamily.org>
	<CAGC02hQ1RhaHC2rhFecjvCK4oGF0qMQpr6558XiWMXaUSvTq9g@mail.gmail.com>
	<1d262914-ffca-85c2-71da-2ef6184cd7e1@vivier.eu>
	<713F2EE1-A420-4DAC-A4E3-ED7A0CC6C0E5@cable.vol.at>
	<dc357e6c-ded2-63c3-6ca8-f13b25ce9e5c@vivier.eu>
	<CAGC02hR9tgwb2ZWHgSZGo09zXc+pM-syC-jOAVk=K9k39ExX1g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <94157a5d-4173-efaa-10eb-f47106431002@vivier.eu>
Date: Wed, 6 Dec 2017 09:20:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAGC02hR9tgwb2ZWHgSZGo09zXc+pM-syC-jOAVk=K9k39ExX1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/m68k: implement 680x0 FPU
 (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: william lin <wlsaidhi@gmail.com>
Cc: Andreas Grabher <andreas.grabher@cable.vol.at>, Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 05/12/2017 à 22:24, william lin a écrit :
> 
> 
> On Tue, Dec 5, 2017 at 2:01 PM, Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> wrote:
> 
>     Le 05/12/2017 à 18:42, Andreas Grabher a écrit :
>     >
>     > Am 05.12.2017 um 10:46 schrieb Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>
>     > <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>:
>     >
>     >> Le 05/12/2017 à 09:56, william lin a écrit :
>     >>> On Wed, Nov 29, 2017 at 9:19 AM, Thomas Huth <huth@tuxfamily.org
>     <mailto:huth@tuxfamily.org>
>     >>> <mailto:huth@tuxfamily.org <mailto:huth@tuxfamily.org>>
>     >>> <mailto:huth@tuxfamily.org <mailto:huth@tuxfamily.org>>> wrote:
>     >>>
>     >>>    On 29.11.2017 15:17, Laurent Vivier wrote:
...
>     >>>
>     >>> So we can't use these C code directly as it uses helpers from 2b.
>     >>> However, would it be 
>     >>> ok to write our own set of C code along with the necessary
>     helpers using
>     >>> the C and asm 
>     >>> code as reference? (would be part of 2a)
>     >>
>     >> I've ported all the functions written by Andreas to QEMU/softfloat 2a
>     >> and it doesn't need any helpers from 2b.
>     >>
>     >> What we need to know is what is the license of his code and if it has
>     >> been written based on the NetBSD code (BSD license) or from the
>     libFPSP
>     >> (proprietary code) [but I think the code is the same...]
>     >>
>     >> Thanks,
>     >> Laurent
> 
> 
> The functions we are looking for in particular are the transcendental
> and trig functions
> for floatx80. (sin, cos, twotox, etc..)
> 
> For some context:
> We need and implementation of those  functions for x86 as it currently
> converts floatx80 to
> double before calling into glibc and then converting back to floatx80.
> This results 
> in inaccuracies for calculations that use x87 instructions for
> intermediate operations.
> (https://bugs.launchpad.net/qemu/+bug/645662)
> 
> 
> I searched through the archive and found your code for this patch:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03766.html
> 
> ...
> 
> +void HELPER(sincos_FP0_FP1)(CPUM68KState *env)
> +{
> +    floatx80 res;
> +    long double val, valsin, valcos;
> +
> +    val = floatx80_to_ldouble(FP0_to_floatx80(env));
> +
> +    sincosl(val, &valsin, &valcos);
> +    res = ldouble_to_floatx80(valsin);
> +    floatx80_to_FP0(env, res);
> +    res = ldouble_to_floatx80(valcos);
> +    floatx80_to_FP1(env, res);
> +}
> 
> ...
> 
> In relation to the bug, this implementation would provide more accurate 
> results, but not be consistent with actual x87 hardware.
> 
> If these are not the code you are referring to, then can you please
> point to us the 
> correct ones?

The code ported from "previous" to QEMU can be found here:

https://github.com/vivier/qemu-m68k/blob/m68k-dev/fpu/softfloat.c#L7422

but it needs some more polishing.

Thanks,
Laurent
