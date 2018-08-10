Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1foA9M-00046m-Eu
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1foA9I-00081T-Jp
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:20:28 -0400
Date: Fri, 10 Aug 2018 17:20:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180810162011.GT4714@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180809204010.3579-1-hpoussin@reactos.org>
	<20180809204010.3579-3-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809204010.3579-3-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Aug 09, 2018 at 10:40:10PM +0200, Herv=C3=A9 Poussineau wrote:
> - prep machine is a fictional machine, so has no specifications. Which
>   devices can be changed/added/removed without impact? Are interrupts
>   correctly mapped?
> - prep firmware (OHW) has support only for IDE drives (no SCSI).
>   Booting from IDE has been broken approximatively 3 years ago, and nob=
ody complained.
> - OHW is limited on IDE boot to a specific set of OS loaders.
>   These operating systems are of the 2004 time frame.
> - OHW can use -kernel. Linux kernel freezes a long time after PS/2 mous=
e
>   detection, and then screen becomes garbage. This was already broken i=
n
>   QEMU v2.7, 2 years ago, and nobody complained.
>=20
> On the other side:
> - 40p is a real machine, so emulation can be checked against
>   hardware specifications
> - OpenBIOS has support for SCSI block devices, including 40p LSI adapte=
r
> - OpenBIOS can start mostly all Linux kernels (including recent ones)
>   and recent operating system (like NetBSD 7.1.2)
>=20
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/ppc/prep.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 1558855247..fbcaebabc0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -676,6 +676,7 @@ static void ppc_prep_init(MachineState *machine)
> =20
>  static void prep_machine_init(MachineClass *mc)
>  {
> +    mc->deprecation_reason =3D "use 40p machine type instead";
>      mc->desc =3D "PowerPC PREP platform";
>      mc->init =3D ppc_prep_init;
>      mc->block_default_type =3D IF_IDE;

A deprecation needs to be listed in qemu-deprecated.texi for it to
be official.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
