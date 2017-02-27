Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQag-0001Mm-V4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQad-0005n4-AO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:04:10 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciQad-0005mp-3E
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:04:07 -0500
Received: by mail-wr0-x235.google.com with SMTP id g10so58805091wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:04:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7df56441-6efd-e178-a31d-e77d6d594319@msgid.tls.msk.ru>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<7df56441-6efd-e178-a31d-e77d6d594319@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 19:03:45 +0000
Message-ID: <CAFEAcA_yGs=TA6f6AbwbsjQRW0xH8m6URQuM_6vUg5B9WUGt-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 00/14] Improvements for SM501 display
 controller emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 27 February 2017 at 18:11, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 26.02.2017 03:17, BALATON Zoltan wrote:
>> Second try, addressing review comments.
>
> So.. I'm not sure what to do with this :)
>
> I can apply it to -trivial, but this smells a bit unfair
> on my side, while on the other hand, is there any more
> appropriate tree?

I think it's a bit of a stretch to argue that
"1089 insertions(+), 741 deletions" is "trivial", but
the difficulty is that sh4 isn't really very maintained.
Since the purpose seems to be to improve ppc emulation
somehow it could perhaps go via the ppc tree, but I dunno.

I have said I'll try to review this (since I looked at
v1), but I don't think I'm going to get to this before the
softfreeze deadline, I'm afraid. If you want to go through
and review it all feel free -- you probably have as much
knowledge about sh4 and this device as I do :-)

thanks
-- PMM
