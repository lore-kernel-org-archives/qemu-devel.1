Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhcbC-0007Et-VB
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhcbC-0004Jk-2k
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:18:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhcbB-0004JW-Sh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:18:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id l10-v6so1796927oii.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 08:18:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ce2458db-7b97-1672-48cf-b88c24d93157@kaod.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<ce2458db-7b97-1672-48cf-b88c24d93157@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 16:17:48 +0100
Message-ID: <CAFEAcA88a15YJ86bK+3=OMG-2=URAgfXEjFoAx603YpCsw5X2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] accel/tcg: Support execution from MMIO
 and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 23 July 2018 at 15:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 07/10/2018 06:00 PM, Peter Maydell wrote:
>> Note for the Xilinx folks: this patchset makes the mmio-exec
>> testcase for running from the SPI flash pass. Cedric: you might
>> like to test the aspeed image you had that relies on execution
>> from an MMIO region too.
>
> I have added a memory region alias at 0x0 on the memory region where
> the first flash device is mapped and all aspeed machines, palmetto,
> romulus, witherspoon booted fine.
>
> More or less 4MB of data access is generated and the slowdown is hardly
> noticeable, around one second on a laptop.
>
> I wonder if I should add a bool option to the machine to activate
> or not the feature ?

I would tend to go with "not" -- if we need the feature then
it's better to run slowly but correctly, and if we don't need
the feature then it doesn't cost us any speed I think.

thanks
-- PMM
