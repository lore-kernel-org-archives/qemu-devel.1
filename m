Received: from eggs.gnu.org ([2001:4830:134:3::10]:38971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2coM-0002ms-D6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2coL-0004kw-G4
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:46 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2coL-0004kM-9F
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:45 -0400
Received: by mail-wm0-x234.google.com with SMTP id r190so65633660wme.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 05:09:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1492787889.git.balaton@eik.bme.hu>
References: <cover.1492787889.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 13:09:23 +0100
Message-ID: <CAFEAcA8zdKvg-y=kGGNH9x4s_Z9CSgu3gP8_GW8JANj74i2h0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 00/13] Improvements for SM501 display
 controller emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 21 April 2017 at 16:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> v7: Define default values for some variables to avoid an (invalid)
>     warning from gcc 6 or 7 as suggested by Aurelien Jarno.
>
> BALATON Zoltan (13):
>   sm501: Fixed code style and a few typos in comments
>   sm501: Use defined constants instead of literal values where available
>   sm501: Add missing arbitration control register
>   sm501: QOMify
>   sm501: Get rid of base address in draw_hwc_line
>   sm501: Add emulation of chip connected via PCI
>   sm501: Fix device endianness
>   sm501: Fix hardware cursor
>   sm501: Misc clean ups
>   sm501: Add support for panel layer
>   sm501: Add some more missing registers
>   sm501: Add vmstate descriptor
>   ppc: Add SM501 device in ppc softmmu targets default configs

Thanks for working through the code review process on this one.
Since SH4 is only 'odd fixes' and Aurelien has tested the code,
I've applied it directly to git master.

thanks
-- PMM
