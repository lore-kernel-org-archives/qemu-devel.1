Received: from eggs.gnu.org ([2001:4830:134:3::10]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISX-0000VS-4S
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISW-0004Vw-6y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:01 -0400
Date: Thu, 14 Jun 2018 11:52:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614015239.GI3042@umbus.fritz.box>
References: <20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
	<1524732340.23669.21.camel@redhat.com>
	<20180427021422.GL8800@umbus.fritz.box>
	<1524817870.23669.25.camel@redhat.com>
	<20180427121700.GP8800@umbus.fritz.box>
	<679d506dbec32c4978a03fe07f21de3e43fba2c0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <679d506dbec32c4978a03fe07f21de3e43fba2c0.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 03:48:54PM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-27 at 22:17 +1000, David Gibson wrote:
> > On Fri, Apr 27, 2018 at 10:31:10AM +0200, Andrea Bolognani wrote:
> > > On Fri, 2018-04-27 at 12:14 +1000, David Gibson wrote:
> > > > Right.. note that with the draft qemu patches a TCG guest will be
> > > > prevented from using hugepages *by default* (the default value of t=
he
> > > > capability is 16).  You have to explicitly change it to allow
> > > > hugepages to be used in a TCG guest (but you don't have to supply
> > > > hugepage backing).
> > >=20
> > > ... this will already happen. That's okay[1], we can't really
> > > avoid it if we want to ensure consistent behavior between KVM and
> > > TCG.
> >=20
> > So.. regarding [1].  The draft patches *do* change the behaviour on
> > older machine types.  I'll consider revisiting that, but I'd need to
> > be convinced.  Basically we have to choose between consistency between
> > accelerator and consistency between versions.  I think the former is
> > the better choice; at least I think it is given that we *can* get both
> > for the overwhelmingly common case in production (KVM HV).
>=20
> Forgot to answer this point.
>=20
> I agree that consistency between accelerators is the sane option
> going forward, but changing the behavior for old machine types will
> cause existing guests which have been using hugepages to lose the
> ability to do so after being restarted on a newer QEMU.
>=20
> Isn't that exactly the kind of scenario versioned machine types are
> supposed to prevent?

Yeah, it is.  What I was questioning was whether it was important
enough for the case of TCG and PR guests (which have never been as
well supported) to justify keeping the other inconsistency.

On reflection, I think it probably does.. and I also think I have a
way to preserve it without having to keep around masses of the old
code, so I'll adjust that for the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshymUACgkQbDjKyiDZ
s5KWEhAA31HVtnq0tj4UfBTn8MJ0mdBeL57/n68RyZ/qqkW7A8vQJeajRC1IrLK+
dOVSMLhyam1yOk9/9A+cvMJrV/pT6/9Q4m79I/LyW3UVggHaxso+oCbC9yPtUlqH
O/bg7EqYDoadx14wjgyo+hb47hWJvvFxPF+p1sGqt1DNaWTfNZV+5feVSAuIJIwT
w395R/uWDl1RYsLdkC3KSly+IVS4eymXsmxYH3KYfeuiIu6HrGuM00PEinKvSp3e
BjbGFxgod1QOPeuGsAPWYC5JBbLfJEMtyjJN2uOqp+3eIliCnAJ1dOMU4a/Eqyia
pqaUYu5Nd77cbLzTKaMGL35SZAoPv7gELuo4ec1HB0wE3fnIjLyjan3cD/uhSL4c
t0bfabnvZUxBloD2i8XcqBzPCgYhzvY+g6SeLRGoSFdW8MSdzoSt85yA/oi4J4ID
MqIMT51IyrwD5i5ea1JbfxLYiCekx6Uye/U89myxmUsRRr/EKen31Z7AA1kIyvX6
zfKm7Y/ODGxA3rsi+dff4lXs3V7OPIK0FsArynlh5e76Ix8cmmk53AnLgy+1t8A1
7OR4OYL7IcrF0EtWDPjZLBc3BPSc9S3uUpwo9XxuyhAMmWOIpwPwdtfAyYSaKa/1
M1qRzo/lWLZ+Y2RcdXUByCY061jw4XnMUJVYQJuUttHWCCvSTdM=
=6R6m
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
