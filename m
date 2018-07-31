Received: from eggs.gnu.org ([2001:4830:134:3::10]:41653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkNxt-0000Nx-6m
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkNxs-0000ZF-38
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:17:01 -0400
Date: Tue, 31 Jul 2018 16:06:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180731060617.GJ2708@umbus.fritz.box>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
	<alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
	<20180731001847.GF2708@umbus.fritz.box>
	<52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 06:57:31AM +0200, Sebastian Bauer wrote:
> Am 2018-07-31 02:18, schrieb David Gibson:
> > > David, can you please drop this patch, we'll come up with a
> > > different fix.
> > Done.  Should have looked at that patch a bit closer.
>=20
> I created a follow up patch, unfortunately, based on the previous patch, =
as
> I did not spot your mail earlier than now. Note that the previous patch w=
as
> an improvement over the old behaviour and under normal conditions the
> difference was not visible (as the OS serves both interrupts in the same =
run
> and at least on AmigaOS the interrupt handling is deferred but IRQs are
> acked quickly; it is still not correct though). The old implementation was
> not correct at all, i.e., all interrupts were missed. So it was technical=
 an
> improvement (and the easiest to come up without deep understanding QEMU) =
;)
>=20
> Anyway, I don't know if that follow up patch is the right approach. But
> building the logical or gate seems also be very much code, especially as =
in
> pci.c the case of multiple irqs sources are seems to be already handled (=
if
> I understand that code correctly). The follow up patch most likely does n=
ot
> model the hardware correctly, but the behaviour should be the same. The
> logical or gate would model the hardware more closely.

Yeah, I think routing all the irqs to pin A should be ok for now.
AIUI it's not user or guest visible so we can fix it up later if we
get more information on the hardware.  I believe there are a number of
other embedded boards that have a similar hack too, since they only
have a single PCI LSI line on the board-level PIC.

> Let me know if I should rebase to the state before my initial patch (I ju=
st
> looked and the previous patch was still not dropped) if you think that the
> change is fine.

I'd prefer a rebase onto the current state of my ppc-for-3.0 tree,
please.

> There is also the possibility to make the special (num-irqs =3D=3D 1) the=
 common
> case, as the Sam460ex platform is the only user of this bus so far (and
> probably stays the only one). I'm not sure if it is worth all the hassle.
> Also note that the entire ppc440_pcix.c source file seems to be created f=
or
> the sam board. I have no idea why that mapping function based on slots was
> chosen in the first place so I kept it. I would also be fine to remove th=
at,
> which would simplify things a lot.
>=20
> Let me know how to proceed.
>=20
> Bye
> Sebastian
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltf/FgACgkQbDjKyiDZ
s5LV6BAAjaiiObzdd1mmD+nEI/Ge3bYmVm3C1GvLHTL3uR5FNCPOl1KQ7M8BHrvc
ZuNR41HOGw2/1sW8e5FQL4WkgyP+cENyHlMg/oGkY/F0n5Qm8N2w0i/HC4o5p43c
6zUUymSnxYseU9vEaParnq/p2NYgd1yVBnO0foWrYXCCH5O/pf7NxIU8EZWvraaN
02ghKZm4aS3gmvKsIwjr4gjoAksvZDay+9GITXUKeb6n5O0QoWzhzTiS9q/KxK6b
0vM0PYo/LJflMIYWXLdTv+k6JI3uQVd1S6fPdg2qlHRqJBPGOJbvoelrTwy40k7W
bCgzTlx8q9F8xrFkmGti4xweOubp8hNWkhpH0PBPAOydci/P/06gEBMzdN0gzM7A
rcu1rm5/FWcEmiOqOrPzcuXUM2gZuu29GZOttNYFdxiIGs7R4ojlyECv6xYtD6ku
Su+ElmrN/7/rStK25C1aRcIewLmveyaEgh7Pe+8denN5gx0WCe0YhpZaWpZyms1t
Bxmpmss63/TOP9LmK6DPzfzFC/ibtWjs7QUHiFAAv8tO44lezdQv/xZv0Jo94ZxU
gTokcCmj782Jhgx44HyMziQpYX92OqgzU1BmSnvWG3DFNqNrgcVCCTLjmSWXZ982
lbOyWNCQQXD9zcH4WxVJKj8YazizY82+YlYRRfZxUlbj8FE0BRE=
=pZSr
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
