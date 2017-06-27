Received: from eggs.gnu.org ([2001:4830:134:3::10]:45707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpsK-0004jJ-El
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpsJ-00017N-N4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:45:48 -0400
Date: Tue, 27 Jun 2017 13:45:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627124540.GF8555@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
	<20170626162641.cavidsn7d67absxb@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <20170626162641.cavidsn7d67absxb@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 07:26:41PM +0300, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
> > > +    bs->file =3D bdrv_open_child(NULL, options, "file",
> > > +                                    bs, &child_file, false, &local_e=
rr);
> > > +
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    qdict_flatten(options);
> > > +    return throttle_configure_tgm(bs, tgm, options, errp);
> >=20
> > Who destroys bs->file on error?
>=20
> It is reaped by bdrv_open_inherit() on failure, if I'm not mistaken.
> That's how other drivers handle this as well. Some (eg block/qcow2.c)
> check if bs->file is NULL instead of the error pointer they pass, so
> this is not not very consistent.

Maybe I'm missing it but I don't see relevant bs->file cleanup in
bdrv_open_inherit() or bdrv_open_common().

Please post the exact line where it happens.

Stefan

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUlN0AAoJEJykq7OBq3PIxZ0IAMltxfiII9bkedIxaLtPfBP5
LnYLN9KX3RZ67YmhLe4WDr8kjLRyzAn3v9xtpdj4DTalfkg7HdStiXiqRw3Nxokm
kV0z8sVZKPQwXjGdPoK1mtP1COoOHym0D4LfoUU0a8uUeP2uKLvQuOLehlHqbmsP
j4vRA1a1TcPKq3xzE0nnri7g8gHYP5uUeKnG1vIkpIgiMgquCFnhkBHR7WQ8OhpM
05kS//6uC/pvV6hqw92sd7qhlFvb41kto/TBaB5vf0NOG1fx6KKmMxgUZQepwu6n
ezAfFTo0wS2tNdV9+gbv+ixcH+bF8q9o9TJM1XeL2MqNy++LAkBhryO/NNlDe80=
=wMWD
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
