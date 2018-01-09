Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYvmA-0003aJ-Mf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYvm7-0002kC-Ak
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:25:18 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYvm7-0002jR-1Y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:25:15 -0500
Received: by mail-wm0-x243.google.com with SMTP id 123so1413141wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:25:14 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
	<20180109141224.axcsed4o2fbgmqhc@aurel32.net>
	<CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
	<84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
Date: Tue, 09 Jan 2018 15:25:12 +0000
Message-ID: <878td7njfr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 09/01/2018 =C3=A0 15:14, Peter Maydell a =C3=A9crit:
>> On 9 January 2018 at 14:12, Aurelien Jarno <aurelien@aurel32.net> wrote:
>>> On 2018-01-09 13:27, Laurent Vivier wrote:
>>>> Le 09/01/2018 =C3=A0 13:22, Alex Benn=C3=A9e a =C3=A9crit :
>>>>> It's not actively built and when enabled things fail to compile. I'm
>>>>> not sure the type-checking is really helping here. Seeing as we "own"
>>>>> our softfloat now lets remove the cruft.
>>>>
>>>> I think it would be better to fix the build break than to remove the
>>>> type-checking tool.
>>>>
>>>> but that's only my opinion...
>>>
>>> I agree with that. Those checks are useful for targets which call host
>>> floating point functions for some instructions. This is ugly, but that's
>>> what is still done for at least x86 for the trigonometrical functions.
>>> The check prevents assigning a float or double value to a softfloat type
>>> without calling the conversion function.
>>
>> Is gcc's codegen still bad enough that we have to default to not
>> using the type-checking versions? If so, maybe we could at least
>> enable the type-checking on an --enable-debug build, so it doesn't
>> bitrot all the time.
>
> What means "bad enough"? for some targets it works fine.
>
> The problem with that is if it is not enabled all the time it becomes
> broken really quick...
>
> BTW, if it doesn't break Alex's work I'm volunteer to fix
> USE_SOFTFLOAT_STRUCT_TYPES build.

Be my guest - I suspect getting that merged would be on a faster path
than the rest of the softfloat re-factoring patch series (unless the
relative silence means everyone is happy with it ;-).

By the way I mentioned in my header mail that the types are included
from bswap.h so it would be nice to move the softfloat types somewhere
where they could be more easily included to avoid triggering a re-build
every time softfloat.h is touched.

--
Alex Benn=C3=A9e
