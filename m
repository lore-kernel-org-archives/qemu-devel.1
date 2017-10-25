Received: from eggs.gnu.org ([2001:4830:134:3::10]:50239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e7OO1-0006fQ-HS
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e7ONx-0005m2-4l
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:18:33 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171024121822.GE18756@stefanha-x1.localdomain>
Date: Wed, 25 Oct 2017 12:18:24 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF4EBA89-3871-4902-8CBC-50A6AEF38292@gmail.com>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
	<20171023160959.GC10220@stefanha-x1.localdomain>
	<CAFEAcA_13y2-uM11Ko_79TpEsfpFWMTz2-mAiwFseHfAM5CPgA@mail.gmail.com>
	<20171024121822.GE18756@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [libfdt][PATCH v3] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, devicetree-compiler@vger.kernel.org, ian@freebsd.org


> On Oct 24, 2017, at 8:18 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Mon, Oct 23, 2017 at 05:27:26PM +0100, Peter Maydell wrote:
>> On 23 October 2017 at 17:09, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>> +/* strnlen() is not available on Mac OS < 10.7 */
>>>> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
>>>=20
>>> Does this cover the case where MAC_OS_X_VERSION_MAX_ALLOWED is set =
to
>>> <1070 on a 10.7+ build machine?  It's possible that the <string.h>
>>> header would define strnlen() and your code redefines the function
>>> (compiler error).
>>=20
>> In that case you don't want to use the strnlen() declaration
>> from the header, you want the inline somehow, because even if
>> the declaration is present and using it doesn't fail compile
>> the definition won't be around at runtime.
>=20
> Perhaps one way around this case is to:
>=20
> # if !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED =
< MAC_OS_X_VERSION_10_7)
> #  include <string.h> /* make sure it isn't included again */
> #  define strnlen fdt_strnlen
> static inline fdt_strnlen(...) { ... }
>=20
> This way the symbol strnlen() isn't used and the system headers cannot
> cause problems.

I really like this idea. I will implement it in my next patch. Thanks!
