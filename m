Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKtdP-00011W-Qd
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 18:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKtdI-000653-5H
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 18:22:43 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:51153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gKtd8-0005sF-DW
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 18:22:32 -0500
Date: Fri, 9 Nov 2018 10:22:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181108232211.GB26872@umbus.fritz.box>
References: <20181108141944.15769-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20181108141944.15769-1-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] ipmi: Allow UUID to be set for a BMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 08:19:42AM -0600, minyard@acm.org wrote:
> The code was using the qemu UUID for the BMC.  But that's really
> not a good method.  In general, you don't want the GUID to change
> when you migrate, and you want the GUID to be the same between
> invocations of qemu (if you have a GUID).

Hrm.  Generally the qemu UUID should remain the same across a
migration too, and I think that will be the case if using libvirt.
Maybe not if running qemu by hand and not specifying the uuid on the
command line.

I don't really have an objection to allowing the BMC's id to be
explicitly controlled, but the rationale above seems a bit
disingenuous.

> Plus, if you have multiple BMCs, they need to have different
> GUIDs or the host code cannot tell them apart.  I'm not sure
> anyone really uses multiple BMCs, but I do a lot of testing
> with that scenario.
>=20
> This change lets the user set the GUID on the command line, and
> if the GUID is not set return an error for the GUID fetch command.
> This maps better to how IPMI should work.
>=20
> This change relies on the UUID being set to all zeros to know that
> it is not set.  This is not optimal, perhaps, but an all zero
> UUID isn't valid (it's the Nil UUID), so it should be ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvkxSEACgkQbDjKyiDZ
s5LraQ//RxpWDh479wYK/h1W3u5iVfepBwKlOs0wTeZnAh6wCyDt9xPjhLN9WbTW
TDUmBX+Dhj/OO4uR0XV2Oi5hNO5OoGnwGDfSh9Bm3TQkwlLBlvhveP+c2GNLCKB/
BQn7D8e+jLasuxNaU7ygNqtje/uhvuY3O3KnypHdlXDYmEf6i4V9+ZPwjzfW2Glv
FJH+QpneHfgdBO8SLAgc8BKmsB/nNjKFfHV/QOAHh6Bq9WoH0zpSGssmkFirtRe+
hLBw4CRpG2X+gLRdSfs6qmdsG/PE9SN1C2/eEURDiulBOuzyhA6tQNUU1LIPYOg/
uXWw3iusV8JlVbJgV710EOxZBBzk2Efsoii0+IR4CFygDop+gVMpsBI39swqcBya
JYJFeVOxVU6HhGJsF1itOQU6UI4B9XF5vnc6moZYKef0gh5QPRpYnPBd+C0W9Bth
8dqMBsHjQXbAV64ss23H0TiDbBZzYveAHJmrm9TVjzDQX9NS3YYpQ/+0J3ZQSG1O
KUUxwh90u5e0UBGaJ+NQQLrirQ0r7tGjTZMKreGXXnifdCi5Ha/yEgKvMZuTTchB
w/mAl38WtfzebH/70GprwAmnvkAOjMNtFXle0Q0bxWneSeguJrhHpqaILXRiM7VN
/40UvvqDu8m/Tf9F8VRyg9n97PqpfBiEYi3BylZgSEVu9EoXiPQ=
=03FF
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
