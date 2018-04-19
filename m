Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1f9Dcs-00075q-I3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1f9Dcp-0001Px-Ab
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:45:42 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com
	([104.47.32.62]:48480
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1f9Dco-0001PB-Is
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:45:39 -0400
Date: Thu, 19 Apr 2018 19:45:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180419174519.ardehg2pmp47fnvg@toto>
References: <20180413075200.15217-1-clg@kaod.org>
	<CAFEAcA_2314nBLZxaK91dNnEaefF9RAf5DA208Zg-Kyp-zQ5cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA_2314nBLZxaK91dNnEaefF9RAf5DA208Zg-Kyp-zQ5cQ@mail.gmail.com>
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, frederic.konrad@adacore.com

On Thu, Apr 19, 2018 at 06:32:07PM +0100, Peter Maydell wrote:
> On 13 April 2018 at 08:52, C=E9dric Le Goater <clg@kaod.org> wrote:
> > On the POWER9 processor, the XIVE interrupt controller can control
> > interrupt sources using MMIO to trigger events, to EOI or to turn off
> > the sources. Priority management and interrupt acknowledgment is also
> > controlled by MMIO in the presenter sub-engine.
> >
> > These MMIO regions are exposed to guests in QEMU with a set of 'ram
> > device' memory mappings, similarly to VFIO, and the VMAs are populated
> > dynamically with the appropriate pages using a fault handler.
> >
> > But, these regions are an issue for migration. We need to discard the
> > associated RAMBlocks from the RAM state on the source VM and let the
> > destination VM rebuild the memory mappings on the new host in the
> > post_load() operation just before resuming the system.
> >
> > To achieve this goal, the following introduces a new RAMBlock flag
> > RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> > vmstate_unregister_ram() routines. This flag is then used by the
> > migration to identify RAMBlocks to discard on the source. Some checks
> > are also performed on the destination to make sure nothing invalid was
> > sent.
>=20
> I think in theory this should Just Work for allowing us to
> enable migration when the xilinx-spips device is using its
> execute-from-mmio feature (we would just need to remove the
> code that puts in the migration blocker).
>=20
> Xilinx folks -- do you have a test image for a board that uses
> xilinx-spips and exercises the execute-from-mmio code, that
> we can use to test migration/vmsave with?

CC:ing Fred

I got an image from Fred a while back ago, I probably still have it
somewhere but I've totally forgotten the name for it.

Fred, do you have the image or roughly remember the filename?

Cheers,
Edgar
