Received: from eggs.gnu.org ([2001:4830:134:3::10]:57306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRj3n-0005ag-SL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRj3k-000600-Oa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:25:43 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:64215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRj3k-0005zh-FP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:25:40 -0500
References: <20171123163538.31411-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6339ce2a-3152-4227-20cb-7f5a3222829a@vivier.eu>
Date: Wed, 20 Dec 2017 19:25:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
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
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Andreas Grabher <andreas.grabher@cable.vol.at>, william lin <wlsaidhi@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Le 23/11/2017 à 17:35, Laurent Vivier a écrit :
> Implement fmod, frem, fscale, fgetman and fgetexp.
> 
> Instead of using functions of libm (v1 of this series)
> and converting between host long double and floatx80 type
> the new version (v2) adds new floatx80 functions in softfloat.
> 
> All the floatx80 functions are copied from "Previous",
> the NeXT Computer Emulator, and written by Andreas Grabher.
> 
> Laurent Vivier (5):
>   softfloat: add floatx80_mod()
>   target/m68k: add fmod/frem
>   softfloat: use floatx80_infinity in softfloat
>   softfloat: add floatx80_getman(), floatx80_getexp(), floatx80_scale()
>   target-m68k: add fscale, fgetman and fgetexp
> 
>  fpu/softfloat-specialize.h |  29 +++++
>  fpu/softfloat.c            | 258 ++++++++++++++++++++++++++++++++++++++++++---
>  include/fpu/softfloat.h    |  13 ++-
>  target/m68k/cpu.h          |   1 +
>  target/m68k/fpu_helper.c   |  48 +++++++++
>  target/m68k/helper.h       |   5 +
>  target/m68k/translate.c    |  15 +++
>  7 files changed, 355 insertions(+), 14 deletions(-)
> 

I have 37 more patches coming to implement FPU for m68k. I'd really like
to go forward with that. Can I have a 'yes' or a 'no' for these 5 simple
patches? and perhaps a merge?

The license issue has been clearly solved as the code comes from
previous (GPL) and Andreas explained his work is derived from code from
the NetBSD code (Motorola (c) but compatible with the GPL), with
softfloat 2a.

Thanks,
Laurent
