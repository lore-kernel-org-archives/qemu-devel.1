Received: from eggs.gnu.org ([2001:4830:134:3::10]:34220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eMJPw-00089I-Fl
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eMJPs-0001rw-HO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:02:12 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eMJPs-0001qa-69
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:02:08 -0500
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
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dc357e6c-ded2-63c3-6ca8-f13b25ce9e5c@vivier.eu>
Date: Tue, 5 Dec 2017 21:01:36 +0100
MIME-Version: 1.0
In-Reply-To: <713F2EE1-A420-4DAC-A4E3-ED7A0CC6C0E5@cable.vol.at>
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
To: Andreas Grabher <andreas.grabher@cable.vol.at>
Cc: william lin <wlsaidhi@gmail.com>, Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 05/12/2017 à 18:42, Andreas Grabher a écrit :
> 
> Am 05.12.2017 um 10:46 schrieb Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>>:
> 
>> Le 05/12/2017 à 09:56, william lin a écrit :
>>> On Wed, Nov 29, 2017 at 9:19 AM, Thomas Huth <huth@tuxfamily.org
>>> <mailto:huth@tuxfamily.org>
>>> <mailto:huth@tuxfamily.org>> wrote:
>>>
>>>    On 29.11.2017 15:17, Laurent Vivier wrote:
>>>> Le 29/11/2017 à 15:08, Thomas Huth a écrit :
>>>>> On 29.11.2017 14:59, Peter Maydell wrote:
>>>>>> On 29 November 2017 at 13:42, Laurent Vivier <laurent@vivier.eu
>>>>>> <mailto:laurent@vivier.eu>
>>>    <mailto:laurent@vivier.eu>> wrote:
>>>>>>> these functions come from:
>>>>>>>
>>>>>>> http://previous.alternative-system.com/
>>>    <http://previous.alternative-system.com/>
>>>>>>>
>>>>>>>
>>>    http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat.c
>>>    <http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat.c>
>>>>>>>
>>>>>>> This is also a modified softfloat, release 2b
>>>>>>> which is BSD license if I'm correct.
>>>>>>
>>>>>> We can't use softfloat2b code (the part of the license that goes
>>>>>> "USE OF THIS SOFTWARE IS RESTRICTED TO PERSONS
>>>>>> AND ORGANIZATIONS [...] WHO FURTHERMORE EFFECTIVELY INDEMNIFY JOHN
>>>>>> HAUSER AND THE INTERNATIONAL COMPUTER SCIENCE INSTITUTE" isn't
>>>>>> GPL compatible).
>>>>>>
>>>>>> We can use softfloat2a code, which doesn't have that indemnity
>>>    clause.
>>>>>
>>>>> Sigh. That's why WinUAE and Hatari immediately switched back to
>>>>> softfloat2a (derived from QEMU) after we've identified the problem
>>>>> there. Looks like the Previous folks forgot to do that step, too :-(
>>>>>
>>>>>>> This code has also been copied to WinUAE (GPL), where softfloat
>>>    has been
>>>>>>> copied from QEMU:
>>>>>>>
>>>    https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat.cpp
>>> <https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat.cpp>
>>>>>>
>>>>>> Yes, lots of projects used the softfloat2b code without realising
>>>>>> it wasn't GPL compatible (including QEMU -- we had a painful job
>>>>>> to fix things up and convert to the 2a codebase a while back).
>>>>>>
>>>>>>> But I think the bad news comes later:
>>>>>>>
>>>>>>> all the other functions (sin, cos, tan, log, exp, ...) found in
>>>    previous
>>>>>>> (softfloat_fpsp.c) are "derived" from NeXT library FPSP:
>>>>>>>
>>>>>>>
>>>    http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat_fpsp.c
>>>    <http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat_fpsp.c>
>>>>>>>
>>>>>>>
>>>    /*============================================================================
>>>>>>>
>>>>>>>   This C source file is an extension to the SoftFloat IEC/IEEE
>>>    Floating-point
>>>>>>>   Arithmetic Package, Release 2a.
>>>>>>>
>>>>>>>   Written by Andreas Grabher for Previous, NeXT Computer Emulator.
>>>>>>>
>>>>>>>
>>>    =============================================================================*/
>>>>>>> ...
>>>>>>>
>>>    /*----------------------------------------------------------------------------
>>>>>>> | Algorithms for transcendental functions supported by MC68881
>>>    and MC68882
>>>>>>> | mathematical coprocessors. The functions are derived from
>>>    FPSP library.
>>>>>>>
>>>    *----------------------------------------------------------------------------*/
>>>>>>>
>>>>>>> FPSP library can be found:
>>>>>>>
>>>>>>> https://ftp.nice.ch/pub/next/developer/hardware/m68k/
>>>    <https://ftp.nice.ch/pub/next/developer/hardware/m68k/>
>>>>>>>
>>>>>>> And the assembly source code is not free at all:
>>>>>>>
>>>>>>>
>>>    https://ftp.nice.ch/pub/next/developer/hardware/m68k/_libFPSP.1.p2.N.s/l_fpsp.h
>>>    <https://ftp.nice.ch/pub/next/developer/hardware/m68k/_libFPSP.1.p2.N.s/l_fpsp.h>
>>>>>>>
>>>>>>>
>>>>>>> |               Copyright (C) Motorola, Inc. 1991
>>>>>>> |                       All Rights Reserved
>>>>>>> |
>>>>>>> |       THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
>>>>>>> |       The copyright notice above does not evidence any
>>>>>>> |       actual or intended publication of such source code.
>>>>>>>
>>>>>>>
>>>>>>> So I'm wondering what license apply to the C version found in
>>>    "Previous".
>>>>>>
>>>>>> Good question. It's clearly not copied code (since the FPSP
>>>    library is
>>>>>> all native m68k assembly), but presumably it's the same algorithms
>>>>>> transliterated into C...
>>>>>
>>>>> There also seem to be other versions of that library available, e.g.:
>>>>>
>>>>>
>>>    https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch/m68k/fpsp/l_fpsp.h
>>>    <https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch/m68k/fpsp/l_fpsp.h>
>>>>>
>>>>> Maybe Andreas (now on CC: ) could clarify which version he used / how
>>>>> the C sources were developed?
>>>>
>>>> Thank you Thomas,
>>>>
>>>> This seems to be the same code re-licensed to:
>>>>
>>>> MOTOROLA MICROPROCESSOR & MEMORY TECHNOLOGY GROUP
>>>> M68000 Hi-Performance Microprocessor Division
>>>> M68040 Software Package
>>>>
>>>> M68040 Software Package Copyright (c) 1993, 1994 Motorola Inc.
>>>> All rights reserved.
>>>>
>>>> THE SOFTWARE is provided on an "AS IS" basis and without warranty.
>>>> To the maximum extent permitted by applicable law,
>>>> MOTOROLA DISCLAIMS ALL WARRANTIES WHETHER EXPRESS OR IMPLIED,
>>>> INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A
>>>> PARTICULAR PURPOSE and any warranty against infringement with
>>>> regard to the SOFTWARE (INCLUDING ANY MODIFIED VERSIONS THEREOF)
>>>> and any accompanying written materials.
>>>>
>>>> To the maximum extent permitted by applicable law,
>>>> IN NO EVENT SHALL MOTOROLA BE LIABLE FOR ANY DAMAGES WHATSOEVER
>>>> (INCLUDING WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS
>>>> PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR
>>>> OTHER PECUNIARY LOSS) ARISING OF THE USE OR INABILITY TO USE THE
>>>> SOFTWARE.  Motorola assumes no responsibility for the maintenance
>>>> and support of the SOFTWARE.
>>>>
>>>> You are hereby granted a copyright license to use, modify, and
>>>> distribute the SOFTWARE so long as this entire notice is retained
>>>> without alteration in any modified and/or redistributed versions,
>>>> and that such modified versions are clearly identified as such.
>>>> No licenses are granted by implication, estoppel or otherwise
>>>> under any patents or trademarks of Motorola, Inc.
>>>
>>>    IANAL, but to me that sounds like it is compatible to the GPL, so I
>>>    think there should not be a problem if the C sources are based on
>>> these
>>>    assembler sources?
>>>
>>>     Thomas
>>>
>>>
>>>
>>>
>>> After looking into all these files, I noticed that the previous code:
>>>
>>> http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat_fpsp.c
>>>
>>> uses SoftFloat 2b code for the helper functions:
>>> http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat.h
>>>
>>> I'm not familiar with licensing but to me it appears that Andreas Grabher
>>> has his code as an extension to the wrong release of SoftFloat.
>>>
>>>>>>>
>>> /*============================================================================
>>>>>>>
>>>>>>>   This C source file is an extension to the SoftFloat IEC/IEEE 
>>>>>>> Floating-point
>>>>>>>   Arithmetic Package, Release 2a.
>>>>>>>
>>>>>>>   Written by Andreas Grabher for Previous, NeXT Computer Emulator.
>>>>>>>
>>>>>>>
>>> =============================================================================*/
>>>>>>> ...
>>>>>>>
>>> /*----------------------------------------------------------------------------
>>>>>>> | Algorithms for transcendental functions supported by MC68881 and
>>> MC68882
>>>>>>> | mathematical coprocessors. The functions are derived from FPSP
>>> library.
>>>>>>>
>>> *----------------------------------------------------------------------------*/
>>>
>>> So we can't use these C code directly as it uses helpers from 2b.
>>> However, would it be 
>>> ok to write our own set of C code along with the necessary helpers using
>>> the C and asm 
>>> code as reference? (would be part of 2a)
>>
>> I've ported all the functions written by Andreas to QEMU/softfloat 2a
>> and it doesn't need any helpers from 2b.
>>
>> What we need to know is what is the license of his code and if it has
>> been written based on the NetBSD code (BSD license) or from the libFPSP
>> (proprietary code) [but I think the code is the same...]
>>
>> Thanks,
>> Laurent
> 
> 
> AFAIK SoftFloat 2a and 2b are identical, except for the license headers.
> So i don't see any need to rewrite any code. Just replace the headers.
> 
> I did translate the FPSP functions from this release of NetBSD:

Thank you for your answer (and your work).

> |$NetBSD: copyright.s,v 1.2 1994/10/26 07:48:57 cgd Exp $
> 
> .text
> .ascii"MOTOROLA MICROPROCESSOR & MEMORY TECHNOLOGY GROUP\n"
> .ascii"M68000 Hi-Performance Microprocessor Division\n"
> .ascii"M68040 Software Package\n"
> .ascii"\n"
> .ascii"M68040 Software Package Copyright (c) 1993, 1994 Motorola Inc.\n"
> .ascii"All rights reserved.\n"
> .ascii"\n"
> .ascii"THE SOFTWARE is provided on an \"AS IS\" basis and without
> warranty.\n"
> .ascii"To the maximum extent permitted by applicable law,\n"
> .ascii"MOTOROLA DISCLAIMS ALL WARRANTIES WHETHER EXPRESS OR IMPLIED,\n"
> .ascii"INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A\n"
> .ascii"PARTICULAR PURPOSE and any warranty against infringement with\n"
> .ascii"regard to the SOFTWARE (INCLUDING ANY MODIFIED VERSIONS THEREOF)\n"
> .ascii"and any accompanying written materials. \n"
> .ascii"\n"
> .ascii"To the maximum extent permitted by applicable law,\n"
> .ascii"IN NO EVENT SHALL MOTOROLA BE LIABLE FOR ANY DAMAGES WHATSOEVER\n"
> .ascii"(INCLUDING WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS\n"
> .ascii"PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR\n"
> .ascii"OTHER PECUNIARY LOSS) ARISING OF THE USE OR INABILITY TO USE THE\n"
> .ascii"SOFTWARE.  Motorola assumes no responsibility for the maintenance\n"
> .ascii"and support of the SOFTWARE.  \n"
> .ascii"\n"
> .ascii"You are hereby granted a copyright license to use, modify, and\n"
> .ascii"distribute the SOFTWARE so long as this entire notice is retained\n"
> .ascii"without alteration in any modified and/or redistributed versions,\n"
> .ascii"and that such modified versions are clearly identified as such.\n"
> .ascii"No licenses are granted by implication, estoppel or otherwise\n"
> .ascii"under any patents or trademarks of Motorola, Inc.\n"
> 
> 
> Anyway i still think we generally violate some copyrights just by
> emulating the 68k. I can't imagine we are allowed to copy Motorola's CPU
> design in software and give it away. In its 68030 and 68040 users's
> manuals it tells:
> 
> "... Motorola does not assume any liability arising out of the
> application or use of any product or circuit described herein; neither
> does it convey any license under its patent rights nor the rights of
> others. ..." 

I'm not a lawyer, and this is only my opinion, but I think our case is
covered by EU Directive 2009/24 [1]:

(15) The unauthorised reproduction, translation, adaptation or
transformation of the form of the code in which a copy of a computer
program has been made available constitutes an infringement of the
exclusive rights of the author. Nevertheless, circumstances may exist
when such a reproduction of the code and translation of its form are
indispensable to obtain the necessary information to achieve the
interoperability of an independently created program with other
programs. It has therefore to be considered that, in these limited
circumstances only, performance of the acts of reproduction and
translation by or on behalf of a person having a right to use a copy of
the program is legitimate and compatible with fair practice and must
therefore be deemed not to require the authorisation of the rightholder.
An objective of this exception is to make it possible to connect all
components of a computer system, including those of different
manufacturers, so that they can work together. Such an exception to the
author's exclusive rights may not be used in a way which prejudices the
legitimate interests of the rightholder or which conflicts with a normal
exploitation of the program.

Thanks,
Laurent

[1] http://eur-lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX:32009L0024
