Received: from eggs.gnu.org ([209.51.188.92]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hB9Or-00039y-WA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hB9JE-0000fF-Rl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:37:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hB9JB-0000N9-Ug
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:37:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id a6so5803265oie.5
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 02:37:33 +0000
Message-ID: <CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tommy Jin <tjin@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pburton.wavecomp.com@gmail.com" <pburton.wavecomp.com@gmail.com>

On Tue, 2 Apr 2019 at 09:29, Tommy Jin <tjin@wavecomp.com> wrote:
> If always creating virtio-net-pci device is not a good idea, is it
> feasible to make virtio-net-pci as an option for boston without
> using libvirt?

It's always an option, just specify it on the command line.

> Actually, Botson board can have an Intel GBE network card in it,
> compared to mips malta, it also has a pcnet network card created
> in its machine, is it acceptable to create a pch_gbe network card
> if the user specify like "model=pch_gbe"?

Again, optional pluggable cards should just be created without
any board code required if the user specifies them on the command line.

In general, the QEMU command line does not aim for "short,
do what the user probably wants without them specifying
many options". It aims for "be flexible, allow the user
to configure what they want". The user-friendly interface
is supposed to be the next level up (libvirt, etc). This does
mean that command lines can get quite long in some cases. That's
unfortunate but I don't think we should be putting workarounds
for that in individual board models.

thanks
-- PMM
