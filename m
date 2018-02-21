Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoZDX-0002qG-BU
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoZDQ-00080N-Bx
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:34:11 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoZDQ-0007zY-0S
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:34:04 -0500
Received: by mail-ot0-x230.google.com with SMTP id 95so2297665ote.5
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:34:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1802211754370.60913@zero.eik.bme.hu>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
	<20180220204450.GA27101@flamenco>
	<CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
	<alpine.BSF.2.21.1802211754370.60913@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2018 18:33:42 +0000
Message-ID: <CAFEAcA-UaWGqLHfN_Z7h+C-k=1A5ic_REaWUu0-w19ALcNJy_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Emilio G. Cota" <cota@braap.org>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 21 February 2018 at 17:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> It's not that upstream u-boot has abandoned board support (it only removed
> support for the PPC440 CPU it once had). The board itself never had support
> in upstream u-boot, it only exists in vendor's fork which is the reason we
> need a separate source and cannot use upstream u-boot source we already
> have.
>
> In my opinion we don't aim to take on support for this board in u-boot, we
> only need to include the firmware binary for the emulation to be useful
> which then requires us to also include the source for the GPL it's licensed
> under. I've also found a few bugs in the firmware which I've fixed but apart
> from such occasional bug fixes when needed I don't expect to take over
> support for the board from the hardware vendor so this source is only so we
> can include the firmware binary which is needed for the board emulation.
> Does this answer your concerns?

We have lots of boards we don't ship firmware blobs for and
which we expect the users to provide the guest code for
if they're going to use them. If we had a git submodule
for every random dev board model that needs some hardware
vendor's BSP and bootloader we'd probably have 50 submodules...

Which isn't to say I'm definitely against this -- I'm just
trying to figure out where we should draw the line of
"these bits of guest code we build for you and ship with
QEMU" versus "we provide the model of the hardware for you
to run whatever guest code you happen to have".

thanks
-- PMM
