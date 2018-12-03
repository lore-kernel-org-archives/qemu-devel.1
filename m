Received: from eggs.gnu.org ([2001:4830:134:3::10]:43895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTsLA-0004d3-Gw
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTsL8-00058o-Kf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:49:04 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTsL6-00056M-Mc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:49:00 -0500
Received: by mail-oi1-x243.google.com with SMTP id h25so11736025oig.1
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 09:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
In-Reply-To: <20181129040917.GF14697@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 17:48:46 +0000
Message-ID: <CAFEAcA8=xJCoTmXmygpK2yVdq5Viqi-dQoiTJrML=goutzKujQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 29 Nov 2018 at 04:55, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=C3=A9dric Le Goater wrote:
> > This will be used to remove the MMIO regions of the POWER9 XIVE
> > interrupt controller when the sPAPR machine is reseted.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Since the code looks sane.
>
> Hoever, I think using memory_region_set_enabled() would be a better
> idea for our purposes than actually adding/deleting the subregion.

The other approach I've used in the past is to use
sysbus_mmio_get_region() and then just map and unmap
that directly, rather than using the sysbus_mmio_map()
convenience function. (Often the kind of device that's
doing complicated things like this will be working in
a setup where it doesn't necessarily want to be mapping
directly into system memory rather than an SoC or similar
container MemoryRegion anyway.)

thanks
-- PMM
