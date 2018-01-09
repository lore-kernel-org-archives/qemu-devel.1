Received: from eggs.gnu.org ([2001:4830:134:3::10]:40113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYx1r-0005JL-EQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYx1n-0001B3-IC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:45:35 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:36239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYx1n-0001Ah-Ag
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:45:31 -0500
Received: by mail-pg0-x232.google.com with SMTP id j2so7135686pgv.3
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:45:31 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
	<20180109141224.axcsed4o2fbgmqhc@aurel32.net>
	<CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
	<84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
	<CAFEAcA-dcwG06cHxDS7F-WW4saCC_pOf4q=aKDdgysHfYCTo=Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99834878-4d80-6bdd-af4a-acf1c49c0a24@linaro.org>
Date: Tue, 9 Jan 2018 08:45:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dcwG06cHxDS7F-WW4saCC_pOf4q=aKDdgysHfYCTo=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/20] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On 01/09/2018 06:43 AM, Peter Maydell wrote:
> On 9 January 2018 at 14:20, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 09/01/2018 à 15:14, Peter Maydell a écrit :
>>> Is gcc's codegen still bad enough that we have to default to not
>>> using the type-checking versions? If so, maybe we could at least
>>> enable the type-checking on an --enable-debug build, so it doesn't
>>> bitrot all the time.
>>
>> What means "bad enough"? for some targets it works fine.
> 
> I mean whatever the problem was that made us write the comment
>    A sufficiently clever compiler and
>    sane ABI should be able to see though these structs.  However
>    x86/gcc 3.x seems to struggle a bit, so leave them disabled by default.

E.g. the i386 ABI is *not* sane in this respect.  Nor is sparcv8plus.  I'd have
to check on the others.

If we enable USE_SOFTFLOAT_STRUCT_TYPES, then we *must* remove the markup for
f32 and f64 from include/exec/helper-head.h, because structures are passed
differently from integers as parameters and/or return values.

I personally do not think USE_SOFTFLOAT_STRUCT_TYPES is worth the headache.


r~
