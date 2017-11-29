Received: from eggs.gnu.org ([2001:4830:134:3::10]:50346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eK2dm-0001Pf-H9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eK2di-0005fr-5q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:43:06 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eK2dh-0005f5-RV
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:43:02 -0500
References: <20171123163538.31411-1-laurent@vivier.eu>
	<CAFEAcA9+f2cgUUS00DXzF9a96evPRnxY5MTUZpe+OA3Trv84WA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e6dc192f-6fcd-f25d-d1db-983280c915f4@vivier.eu>
Date: Wed, 29 Nov 2017 14:42:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+f2cgUUS00DXzF9a96evPRnxY5MTUZpe+OA3Trv84WA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 29/11/2017 à 13:49, Peter Maydell a écrit :
> On 23 November 2017 at 16:35, Laurent Vivier <laurent@vivier.eu> wrote:
>> Implement fmod, frem, fscale, fgetman and fgetexp.
>>
>> Instead of using functions of libm (v1 of this series)
>> and converting between host long double and floatx80 type
>> the new version (v2) adds new floatx80 functions in softfloat.
>>
>> All the floatx80 functions are copied from "Previous",
>> the NeXT Computer Emulator, and written by Andreas Grabher.
> 
> Hi; what license is that code under? Can you provide
> a link to the original sources that you're taking the
> functions from, please?

Hi,

these functions come from:

http://previous.alternative-system.com/

http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat.c

This is also a modified softfloat, release 2b
which is BSD license if I'm correct.

Their softfloat files seem to come from MAME

http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/README.txt

and MAME is GPL:
http://mamedev.org/legal.html

and Previous is a fork of Hatari (GPL), a fork of UAE (GPL)
https://hatari.tuxfamily.org/index.html

This code has also been copied to WinUAE (GPL), where softfloat has been
copied from QEMU:
https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat.cpp

But I think the bad news comes later:

all the other functions (sin, cos, tan, log, exp, ...) found in previous
(softfloat_fpsp.c) are "derived" from NeXT library FPSP:

http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat_fpsp.c

/*============================================================================

 This C source file is an extension to the SoftFloat IEC/IEEE Floating-point
 Arithmetic Package, Release 2a.

 Written by Andreas Grabher for Previous, NeXT Computer Emulator.

=============================================================================*/
...
/*----------------------------------------------------------------------------
| Algorithms for transcendental functions supported by MC68881 and MC68882
| mathematical coprocessors. The functions are derived from FPSP library.
*----------------------------------------------------------------------------*/

FPSP library can be found:

https://ftp.nice.ch/pub/next/developer/hardware/m68k/

And the assembly source code is not free at all:

https://ftp.nice.ch/pub/next/developer/hardware/m68k/_libFPSP.1.p2.N.s/l_fpsp.h


|		Copyright (C) Motorola, Inc. 1991
|			All Rights Reserved
|
|	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
|	The copyright notice above does not evidence any
|	actual or intended publication of such source code.


So I'm wondering what license apply to the C version found in "Previous".

Thanks,
Laurent
