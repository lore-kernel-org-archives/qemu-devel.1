Received: from eggs.gnu.org ([2001:4830:134:3::10]:41400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6fZt-0003uP-FJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6fZs-0006Qa-7C
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:27:49 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:57128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6fZs-0006Pu-0Q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:27:48 -0400
Received: by mail-wm0-x233.google.com with SMTP id z3so4002287wme.5
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:27:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023160959.GC10220@stefanha-x1.localdomain>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
	<20171023160959.GC10220@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2017 17:27:26 +0100
Message-ID: <CAFEAcA_13y2-uM11Ko_79TpEsfpFWMTz2-mAiwFseHfAM5CPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: John Arbuckle <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, devicetree-compiler@vger.kernel.org, ian@freebsd.org

On 23 October 2017 at 17:09, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> +/* strnlen() is not available on Mac OS < 10.7 */
>> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
>
> Does this cover the case where MAC_OS_X_VERSION_MAX_ALLOWED is set to
> <1070 on a 10.7+ build machine?  It's possible that the <string.h>
> header would define strnlen() and your code redefines the function
> (compiler error).

In that case you don't want to use the strnlen() declaration
from the header, you want the inline somehow, because even if
the declaration is present and using it doesn't fail compile
the definition won't be around at runtime.

> It would be best to check how <string.h>, <Availability.h>, and
> <AvailabilityMacros.h> work to make sure that all cases are handled.  I
> don't have access to a Mac right now, sorry.

It uses the clang 'attribute availability' syntax:
https://clang.llvm.org/docs/AttributeReference.html#availability

thanks
-- PMM
