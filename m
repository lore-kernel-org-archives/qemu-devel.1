Received: from eggs.gnu.org ([2001:4830:134:3::10]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1foA6S-0001wy-3H
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1foA6O-0005Qg-7X
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:17:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.21049.1533850544.1289.qemu-devel@nongnu.org>
Date: Fri, 10 Aug 2018 12:17:20 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD0AD40F-6B3E-489C-82A8-2DFCE2D03795@gmail.com>
References: <mailman.21049.1533850544.1289.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type
 'prep', replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herv? Poussineau <hpoussin@reactos.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


> On Aug 9, 2018, at 5:35 PM, qemu-devel-request@nongnu.org wrote:
>=20
> Date: Thu,  9 Aug 2018 22:40:10 +0200
> From: Herv? Poussineau <hpoussin@reactos.org>
> To: qemu-devel@nongnu.org
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,	David Gibson
> 	<david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
> 	qemu-ppc@nongnu.org, Herv? Poussineau <hpoussin@reactos.org>
> Subject: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type
> 	'prep', replaced by '40p'
> Message-ID: <20180809204010.3579-3-hpoussin@reactos.org>
> Content-Type: text/plain; charset=3DUTF-8
>=20
> - prep machine is a fictional machine, so has no specifications. Which
>  devices can be changed/added/removed without impact? Are interrupts
>  correctly mapped?
> - prep firmware (OHW) has support only for IDE drives (no SCSI).
>  Booting from IDE has been broken approximatively 3 years ago, and =
nobody complained.
> - OHW is limited on IDE boot to a specific set of OS loaders.
>  These operating systems are of the 2004 time frame.
> - OHW can use -kernel. Linux kernel freezes a long time after PS/2 =
mouse
>  detection, and then screen becomes garbage. This was already broken =
in
>  QEMU v2.7, 2 years ago, and nobody complained.
>=20
> On the other side:
> - 40p is a real machine, so emulation can be checked against
>  hardware specifications
> - OpenBIOS has support for SCSI block devices, including 40p LSI =
adapter
> - OpenBIOS can start mostly all Linux kernels (including recent ones)
>  and recent operating system (like NetBSD 7.1.2)
>=20
> Signed-off-by: Herv? Poussineau <hpoussin@reactos.org>
> ---
> hw/ppc/prep.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 1558855247..fbcaebabc0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -676,6 +676,7 @@ static void ppc_prep_init(MachineState *machine)
>=20
> static void prep_machine_init(MachineClass *mc)
> {
> +    mc->deprecation_reason =3D "use 40p machine type instead";
>     mc->desc =3D "PowerPC PREP platform";
>     mc->init =3D ppc_prep_init;
>     mc->block_default_type =3D IF_IDE;
> --=20
> 2.11.0

Can a real 40p machine boot Windows NT 4.0 PowerPC?
