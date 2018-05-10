Received: from eggs.gnu.org ([2001:4830:134:3::10]:40670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGr2z-0006QD-T9
	for qemu-devel@nongnu.org; Thu, 10 May 2018 15:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGr2v-0003uL-S6
	for qemu-devel@nongnu.org; Thu, 10 May 2018 15:16:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fGr2v-0003mc-MM
	for qemu-devel@nongnu.org; Thu, 10 May 2018 15:16:09 -0400
Date: Thu, 10 May 2018 20:15:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180510191556.GB2679@work-vm>
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
	<20180509110833.GD2527@work-vm>
	<CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 9 May 2018 at 12:08, Dr. David Alan Gilbert <dgilbert@redhat.com> wr=
ote:
> > This thread seems to have stalled; we've got the list of potential
> > migration breaks that Peter found and only some minor comments on the
> > actual patch.
> >
> > I'd like to get it going again sicne as well as C=E9dric, and Peter's
> > cases, there's Lai Jiangshan and now Eric Wheeler was asking for
> > something similar.
> >
> > Anyone understand the way forward? Do we have to go and fix the
> > odd board failures first?
>=20
> aspeed and highbank I already changed in master. That leaves
>=20
> hw/mips/boston.c:    memory_region_init_rom_nomigrate(flash, NULL,
> hw/mips/mips_malta.c:    memory_region_init_ram_nomigrate(bios_copy,
> NULL, "bios.1fc", BIOS_SIZE,
> hw/net/dp8393x.c:    memory_region_init_ram_nomigrate(&s->prom, OBJECT(=
dev),
>   [device only used on mips jazz board]
> hw/pci-host/xilinx-pcie.c:    memory_region_init_ram_nomigrate(&s->io,
> OBJECT(s), "io", 16, NULL);
>   [device only used on mips boston board]
>=20
> which affect mips boston, malta and jazz boards.
>=20
> I don't think we need to fix those first, but:
>=20
>  * we should note in the commit message for this patch that
>    it is a de-facto migration break for those boards
>  * we should fix those devices/boards in this release cycle,
>    since we've broken migration compat anyway
>  * we should check with the MIPS maintainers that they're ok
>    with a cross-version migration compat break for those boards
>    (I've cc'd them)

OK, in that case, as long as they're OK, then I think
we should go for it.

C=E9dric: Were you going to post a version that didn't
do it in set_idstr?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
