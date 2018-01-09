Received: from eggs.gnu.org ([2001:4830:134:3::10]:39191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYug9-00053A-Sk
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYug8-00024O-Tf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:15:01 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:40209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYug8-000247-N6
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:15:00 -0500
Received: by mail-ot0-x22c.google.com with SMTP id d10so11410229oti.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:15:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109141224.axcsed4o2fbgmqhc@aurel32.net>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
	<20180109141224.axcsed4o2fbgmqhc@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:14:39 +0000
Message-ID: <CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2018 at 14:12, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On 2018-01-09 13:27, Laurent Vivier wrote:
>> Le 09/01/2018 =C3=A0 13:22, Alex Benn=C3=A9e a =C3=A9crit :
>> > It's not actively built and when enabled things fail to compile. I'm
>> > not sure the type-checking is really helping here. Seeing as we "own"
>> > our softfloat now lets remove the cruft.
>>
>> I think it would be better to fix the build break than to remove the
>> type-checking tool.
>>
>> but that's only my opinion...
>
> I agree with that. Those checks are useful for targets which call host
> floating point functions for some instructions. This is ugly, but that's
> what is still done for at least x86 for the trigonometrical functions.
> The check prevents assigning a float or double value to a softfloat type
> without calling the conversion function.

Is gcc's codegen still bad enough that we have to default to not
using the type-checking versions? If so, maybe we could at least
enable the type-checking on an --enable-debug build, so it doesn't
bitrot all the time.

thanks
-- PMM
