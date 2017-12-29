Received: from eggs.gnu.org ([2001:4830:134:3::10]:36174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eUpv9-0002KY-Np
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 03:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eUpv7-0005cE-0O
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 03:21:39 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eUpv6-0005bb-Ql
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 03:21:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id n138so47153408wmg.2
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 00:21:36 -0800 (PST)
References: <20171123163538.31411-1-laurent@vivier.eu>
	<6339ce2a-3152-4227-20cb-7f5a3222829a@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <c8a9730b-c6f0-50a9-7ef4-51eaba66afd2@tuxfamily.org>
Date: Fri, 29 Dec 2017 09:21:31 +0100
MIME-Version: 1.0
In-Reply-To: <6339ce2a-3152-4227-20cb-7f5a3222829a@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Andreas Grabher <andreas.grabher@cable.vol.at>, william lin <wlsaidhi@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On 20.12.2017 19:25, Laurent Vivier wrote:
> Le 23/11/2017 à 17:35, Laurent Vivier a écrit :
>> Implement fmod, frem, fscale, fgetman and fgetexp.
>>
>> Instead of using functions of libm (v1 of this series)
>> and converting between host long double and floatx80 type
>> the new version (v2) adds new floatx80 functions in softfloat.
>>
>> All the floatx80 functions are copied from "Previous",
>> the NeXT Computer Emulator, and written by Andreas Grabher.
>>
>> Laurent Vivier (5):
>>   softfloat: add floatx80_mod()
>>   target/m68k: add fmod/frem
>>   softfloat: use floatx80_infinity in softfloat
>>   softfloat: add floatx80_getman(), floatx80_getexp(), floatx80_scale()
>>   target-m68k: add fscale, fgetman and fgetexp
>>
>>  fpu/softfloat-specialize.h |  29 +++++
>>  fpu/softfloat.c            | 258 ++++++++++++++++++++++++++++++++++++++++++---
>>  include/fpu/softfloat.h    |  13 ++-
>>  target/m68k/cpu.h          |   1 +
>>  target/m68k/fpu_helper.c   |  48 +++++++++
>>  target/m68k/helper.h       |   5 +
>>  target/m68k/translate.c    |  15 +++
>>  7 files changed, 355 insertions(+), 14 deletions(-)
>>
> 
> I have 37 more patches coming to implement FPU for m68k. I'd really like
> to go forward with that. Can I have a 'yes' or a 'no' for these 5 simple
> patches? and perhaps a merge?

IMHO the patch series is OK. So maybe simply send a pull request to
Peter (if there are no further other objections)?

 Thomas
