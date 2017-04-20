Received: from eggs.gnu.org ([2001:4830:134:3::10]:37889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1JvL-0005xH-4w
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1JvK-00024t-5O
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:47:35 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1JvJ-00023w-Vd
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:47:34 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r190so3345481wme.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 14:47:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33474e1b82c6459604edec522cee585ccdb871ee.1492721026.git.balaton@eik.bme.hu>
References: <cover.1492721026.git.balaton@eik.bme.hu>
	<33474e1b82c6459604edec522cee585ccdb871ee.1492721026.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 22:47:12 +0100
Message-ID: <CAFEAcA-Q7PaT0ejkXHCTnUkfsOHUg8HdY7KtYc0Bo7On3+oDhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 07/13] sm501: Fix device endianness
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

On 20 April 2017 at 21:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> We only emulate the sysbus device in its default LE mode and PCI is LE
> as well so specify this for registers and framebuffer memory.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

I think it's worth a comment to the effect of:

Note that though the Linux kernel driver has code which
claims to handle both big and little endian, it is obviously
bogus for 16 bit and cannot be trusted as a source of
information on the framebuffer pixel format. This is
our best guess about device behaviour based on the specs.

(so if we find ourselves wondering about this mismatch
in a couple of years time at least we'll know why this
end is the way it is.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
