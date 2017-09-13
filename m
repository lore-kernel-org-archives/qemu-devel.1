Received: from eggs.gnu.org ([2001:4830:134:3::10]:60451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsBE7-0008Mg-8r
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsBE2-0002d4-Rw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:13:27 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsBE2-0002bn-MY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:13:22 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 082E6AB885
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 19:13:20 +0200 (CEST)
Date: Wed, 13 Sep 2017 19:13:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170913191309.56bf8fa4@bahia.lan>
In-Reply-To: <760c3889-8561-9bce-e565-ccbcb9eb8cf5@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
	<20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
	<4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
	<d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
	<20170913060203.GG7550@umbus.fritz.box>
	<760c3889-8561-9bce-e565-ccbcb9eb8cf5@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/r2DfEmTwgnTsuI+k8=Sllkv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, lvivier@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org

--Sig_/r2DfEmTwgnTsuI+k8=Sllkv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2017 17:44:54 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 13/09/17 07:02, David Gibson wrote:
>=20
> >>> Alexey - do you recall from your analysis why these fields were no
> >>> longer deemed necessary, and how your TCG tests were configured? =20
> >>
> >> I most certainly did not do analysis (my bad. sorry) - I took the patch
> >> from David as he left the team, fixed to compile and pushed away. I am=
 also
> >> very suspicions we did not try migrating TCG or anything but pseries. =
My
> >> guest that things did not break (if they did not which I am not sure a=
bout,
> >> for the TCG case) because the interrupt controller (XICS) or the
> >> pseries-guest took care of resending an interrupt which does not seem =
to be
> >> the case for mac99. =20
> >=20
> > Right, that's probably true.  The main point, though, is that these
> > fields were dropped a *long* time ago, when migration was barely
> > working to begin with.  In particular I'm pretty sure most of the
> > non-pseries platforms were already pretty broken for migration
> > (amongst other things).
> >=20
> > Polishing the mac platforms up to working again, including migration,
> > is a reasonable goal.  But it can't be at the expense of pseries,
> > which is already working, used in production, and much better tested
> > than mac99 or g3beige ever were. =20
>=20
> Oh I completely agree since I'm well aware pseries likely has more users
> than the Mac machines - my question was directed more about why we
> support backwards migration.
>=20

Downstream support backward migration because end users/customers ask for it
for maximum flexibility when it comes to move workloads around different sy=
stems
with different QEMU versions. This is fairly usual in data centers with many
systems.

As others already said, breaking things upstream may turn downstream work
into a nightmare (and FWIW, most of the people working on ppc are also
involved in downstream work).

Cheers,

--
Greg

> I spent several hours yesterday poking my Darwin test case with trying
> the different combinations of pending_interrupts, irq_input_state and
> access_type and could easily provoke migration failures unless all 3 of
> the fields were present so a practical test shows they are still
> required for TCG migration. I think ppc_set_irq()'s use of the interrupt
> fields in hw/ppc/ppc.c and the subsequent reference to pending
> interrupts in target/ppc may explain why I see freezes/hangs until a key
> is pressed in many cases.
>=20
>=20
> ATB,
>=20
> Mark.


--Sig_/r2DfEmTwgnTsuI+k8=Sllkv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWblnJQAKCRAC/DrrAQHb
wjHbAJsH7P1LWYJVaXNUtvyv1aDLUajmXACggCB2VIXKSbh05tDNrDZhn02GjpY=
=K8Xq
-----END PGP SIGNATURE-----

--Sig_/r2DfEmTwgnTsuI+k8=Sllkv--
