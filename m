Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fO0PD-0005ry-Hq
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fO0PC-0004aS-Q7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:40:43 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fO0PC-0004Zo-K7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:40:42 -0400
Received: by mail-ot0-x244.google.com with SMTP id g7-v6so20908466otj.11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 05:40:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530075002.4618-1-clg@kaod.org>
References: <20180530075002.4618-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 May 2018 13:40:21 +0100
Message-ID: <CAFEAcA_a+nduAKWhLiwoKvoybL+cKN=51xV5M9f-VatPdbnf6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] aspeed: add MMIO exec support to the
 FMC controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>

On 30 May 2018 at 08:49, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> When MMIO execution support is active, these changes let the Aspeed
> SoC machine boot directly from CE0. As there is still some
> issues, the feature is disabled by default and should be activated
> with :
>
>         -global driver=3Daspeed.smc,property=3Dmmio-exec,value=3Dtrue

I'd really rather not add another mmio-exec device until
we've sorted out making it actually work properly...

thanks
-- PMM
