Received: from eggs.gnu.org ([2001:4830:134:3::10]:49017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYv8B-0003B6-IA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYv8A-0003q5-OB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:43:59 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:42020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYv8A-0003pr-IB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:43:58 -0500
Received: by mail-ot0-x22b.google.com with SMTP id a7so1355841otd.9
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:43:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
	<20180109141224.axcsed4o2fbgmqhc@aurel32.net>
	<CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
	<84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:43:37 +0000
Message-ID: <CAFEAcA-dcwG06cHxDS7F-WW4saCC_pOf4q=aKDdgysHfYCTo=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2018 at 14:20, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/01/2018 =C3=A0 15:14, Peter Maydell a =C3=A9crit :
>> Is gcc's codegen still bad enough that we have to default to not
>> using the type-checking versions? If so, maybe we could at least
>> enable the type-checking on an --enable-debug build, so it doesn't
>> bitrot all the time.
>
> What means "bad enough"? for some targets it works fine.

I mean whatever the problem was that made us write the comment
   A sufficiently clever compiler and
   sane ABI should be able to see though these structs.  However
   x86/gcc 3.x seems to struggle a bit, so leave them disabled by default.

In theory the code generated should be no worse than without structs...

> The problem with that is if it is not enabled all the time it becomes
> broken really quick...

Yes, that's why I'd like it at least default-enabled for --enable-debug,
if we can't enable it always.

thanks
-- PMM
