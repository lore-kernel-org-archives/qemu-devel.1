Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec91b-0005Vn-DX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec91a-0004X7-Fv
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:10:31 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:45279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec91a-0004Wj-BA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:10:30 -0500
Received: by mail-oi0-x22b.google.com with SMTP id j129so15495711oib.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:10:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111045937.2119-7-david@gibson.dropbear.id.au>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
	<20180111045937.2119-7-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 12:10:09 +0000
Message-ID: <CAFEAcA--Gdhs+tTwGWw2S9PNuDOriaGCFKSAnLrEPciQGmL_=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 06/11] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, surajjs@au1.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>

On 11 January 2018 at 04:59, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> This is a common generic PCI SATA controller that is also used in PCs
> but more importantly guests running on the Sam460ex board prefer this
> card and have a driver for it (unlike for other SATA controllers
> already emulated).
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Acked-by: John Snow <jsnow@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

> +    case 0x1c8:
> +        val = d->regs[1].sien << 16;
> +        break;

There's a similar unintended-sign-extension issue here (CID 1385145);
again, a cast should fix.

thanks
-- PMM
