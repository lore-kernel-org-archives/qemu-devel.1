Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1doth8-0004Mq-EH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1doth4-0007Jz-1o
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:53:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1doth3-0007JL-Oi
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:53:45 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
Date: Mon, 4 Sep 2017 17:53:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <n54@gmx.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 04/09/2017 à 17:02, Peter Maydell a écrit :
> On 4 September 2017 at 15:09, Laurent Vivier <laurent@vivier.eu> wrote:
>> You can:
>>
>> either replace the "#define floatx80_pi make_floatx80(...)" by a "const
>> floatx80 floatx80_pi = make_floatx80_init(...)"
>>
>> or replace all the macros in the m68k/fpu_helper.c array by
>> make_floatx80_init(...)
> 
> Taking a step back, what's different about floatx80 and float12
> that means they need separate _init and non-init versions of
> the macros, when for float16/float32/float64 we instead have
> #define make_float32(x) __extension__ ({ float32 f32_val = {x}; f32_val; })
> #define const_float32(x) { x }

floatx80/float128 are structureq while float16/float32/float64 are
native data types.

> ? Could we move to consistency for the macro naming we're using?

Do you mean "s/make_floatx80_init/const_floatx80/"?

Laurent
