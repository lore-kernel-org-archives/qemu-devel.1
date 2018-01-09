Received: from eggs.gnu.org ([2001:4830:134:3::10]:41193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYumA-0007ZR-Of
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYum5-0006BN-NN
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:14 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:51360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYum5-00069Q-EO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:09 -0500
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
	<20180109141224.axcsed4o2fbgmqhc@aurel32.net>
	<CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <84f1c253-88af-9fbf-8326-e77d40b810b6@vivier.eu>
Date: Tue, 9 Jan 2018 15:20:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TOD3HhvWEV3pzbJ=udHGQTqW1NQBicYypk9_AMHyj2g@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

Le 09/01/2018 à 15:14, Peter Maydell a écrit :
> On 9 January 2018 at 14:12, Aurelien Jarno <aurelien@aurel32.net> wrote:
>> On 2018-01-09 13:27, Laurent Vivier wrote:
>>> Le 09/01/2018 à 13:22, Alex Bennée a écrit :
>>>> It's not actively built and when enabled things fail to compile. I'm
>>>> not sure the type-checking is really helping here. Seeing as we "own"
>>>> our softfloat now lets remove the cruft.
>>>
>>> I think it would be better to fix the build break than to remove the
>>> type-checking tool.
>>>
>>> but that's only my opinion...
>>
>> I agree with that. Those checks are useful for targets which call host
>> floating point functions for some instructions. This is ugly, but that's
>> what is still done for at least x86 for the trigonometrical functions.
>> The check prevents assigning a float or double value to a softfloat type
>> without calling the conversion function.
> 
> Is gcc's codegen still bad enough that we have to default to not
> using the type-checking versions? If so, maybe we could at least
> enable the type-checking on an --enable-debug build, so it doesn't
> bitrot all the time.

What means "bad enough"? for some targets it works fine.

The problem with that is if it is not enabled all the time it becomes
broken really quick...

BTW, if it doesn't break Alex's work I'm volunteer to fix
USE_SOFTFLOAT_STRUCT_TYPES build.

Thanks,
Laurent
