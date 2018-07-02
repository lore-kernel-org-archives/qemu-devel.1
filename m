Received: from eggs.gnu.org ([2001:4830:134:3::10]:51839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZvLp-0000Pb-PM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZvLo-0001m6-Vq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:42:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZvLo-0001la-Fu
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:42:28 -0400
Received: by mail-oi0-x243.google.com with SMTP id s198-v6so11312528oih.11
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 02:42:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 10:42:07 +0100
Message-ID: <CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 30 June 2018 at 21:34, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Tue, 26 Jun 2018, BALATON Zoltan wrote:
>>
>> Version 2 of the sm501 changes with fixes that are needed to get
>> AmigaOS 4.1FE to boot and able to produce graphics.
>>
>> The strange blue-white colors that first appear are actually correct
>> and because of AmigaOS selecting a low resolution PAL mode by default
>> instead of a board specific mode. To work around this one can select
>> the last option to boot the live CD and then select a better board
>> specific mode from ScreenMode Prefs. It takes a while for the
>> ScreenMode window to appear and graphics operations are slow which
>> could use some improvement but at least it seems to work correctly now
>> apart from some unimplemented drawing modes for compositing.
>>
>> If this could be merged before the freeze with the sam460ex patches
>> and Sebastian's ehci patch then QEMU 3.0 could be the first version
>> that can boot AmigaOS.
>
>
> Ping? Sorry to push it but it would be great if this could get in for 3.0.
> Peter, this may need your attention like last time as it's not clear whose
> tree it should go through and David did not seem to be confident taking it
> via the ppc tree.

I can have a look, but really I think these should go via the
ppc tree -- the device is used in a ppc machine and an sh4 one,
and the ppc tree is much more active than sh4.

thanks
-- PMM
