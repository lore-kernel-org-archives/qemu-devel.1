Received: from eggs.gnu.org ([2001:4830:134:3::10]:59844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAjVD-00012i-RI
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAjVC-0002Cc-TZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:27:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171103202624.5956-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db255c93-a4c6-216d-8ea3-10f340a916f6@amsat.org>
Date: Fri, 3 Nov 2017 18:27:36 -0300
MIME-Version: 1.0
In-Reply-To: <20171103202624.5956-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] softfloat: fix some helper
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Laurent,

On 11/03/2017 05:26 PM, Laurent Vivier wrote:
> This series fixes some errors found by
> enabling USE_SOFTFLOAT_STRUCT_TYPES.
> 
> Most of them are helpers using int types
> instead of float types.
> This also requires the use of floatXX_val()
> and make_floatXX().
> 
> Laurent Vivier (4):
>   arm: fix float64 helper definitions
>   openrisc: fix float32 and float64 helper definitions
>   tricore: use make_float32() and float32_val()
>   softfloat: use floatXX_val() in XX_minmax()
> 
>  fpu/softfloat.c              |  8 +++----
>  target/arm/helper-a64.h      |  6 ++---
>  target/openrisc/fpu_helper.c | 52 ++++++++++++++++++++++----------------------
>  target/openrisc/helper.h     | 20 ++++++++---------
>  target/tricore/fpu_helper.c  | 34 ++++++++++++++---------------
>  5 files changed, 60 insertions(+), 60 deletions(-)
> 

I'm getting those errors:

$ make subdir-arm-softmmu -j2

/source/qemu/migration/vmstate-types.c:430:5: error: conversion to
non-scalar type requested
     qemu_put_be64(f, float64_val(*v));
     ^~~~~~~~~~~~~
make: *** [migration/vmstate-types.o] Error 1

In file included from /source/qemu/fpu/softfloat.c:87:0:
/source/qemu/fpu/softfloat-specialize.h: In function ‘float16_default_nan’:
/source/qemu/include/fpu/softfloat.h:117:26: error: expected expression
before ‘{’ token
 #define const_float16(x) { x }
                          ^
/source/qemu/fpu/softfloat-specialize.h:95:12: note: in expansion of
macro ‘const_float16’
     return const_float16(0x7E00);
            ^~~~~~~~~~~~~
make: *** [fpu/softfloat.o] Error 1
