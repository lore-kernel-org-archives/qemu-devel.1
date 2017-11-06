Received: from eggs.gnu.org ([2001:4830:134:3::10]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBjzt-0001MD-Jp
	for Qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBjzp-0004Oo-HA
	for Qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eBjzp-0004Mv-96
	for Qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:33 -0500
References: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
	<20171105195753.4td423texl32uo4z@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b0d5400-5668-11e8-0cd3-789494e6a95b@redhat.com>
Date: Mon, 6 Nov 2017 10:11:29 -0600
MIME-Version: 1.0
In-Reply-To: <20171105195753.4td423texl32uo4z@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I4t6uAfof9THp3AbONFRp9lieXn6fbxXe"
Subject: Re: [Qemu-devel] structured reply behavior for read of 0 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, nbd list <nbd@other.debian.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I4t6uAfof9THp3AbONFRp9lieXn6fbxXe
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 nbd list <nbd@other.debian.org>
Message-ID: <6b0d5400-5668-11e8-0cd3-789494e6a95b@redhat.com>
Subject: Re: structured reply behavior for read of 0 bytes
References: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
 <20171105195753.4td423texl32uo4z@grep.be>
In-Reply-To: <20171105195753.4td423texl32uo4z@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/05/2017 01:57 PM, Wouter Verhelst wrote:
>=20
> I'd like to take a step back first and wonder what a zero-sized read
> would actually mean. "Please read no data at this offset". What good
> does that do? I can't see anything useful coming out of that.

If the export is some sort of memory-mapped device, where a read of 0
has a different action than a read of 1, then maybe it has use - but
that gets into the dirty details of a client and server that know what
to expect. I agree that in the generic case it's probably easiest to
just leave things as unspecified behavior results.

I know that a 0-byte write is an interesting probe - does that succeed
on a read-only export, even when a write of one byte fails?  But that
just strengthens the argument that normal clients won't be doing 0-byte
transactions.  It is also feasible that some client/server pair may want
to special-case a length of 0 as meaning 4G.

>=20
> If we can come up with some useful semantics that we could apply to a
> zero-sized read, then I guess it makes sense to worry about handling it=
=2E
> In the absense of that though, I think it is more appropriate to just
> document that a client should not send it, but that a server's behaviou=
r
> upon such a command is not defined (other than that it should not cause=

> the server to quit, through a crash or otherwise).

I'll propose wording along those lines.

>=20
> In fact, the current spec, as you point out, already implicitly forbids=

> (with MUST) nonzero writes by requiring a data chunk to have nonzero
> payload (and that can't happen when you have a zero-sized read). It
> might make sense to make that explicit.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--I4t6uAfof9THp3AbONFRp9lieXn6fbxXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAibEACgkQp6FrSiUn
Q2q82wf9HYaNKebOT79vZTlSN5fAmNHaKmtzIxObEnoOkxNiEgave9JtTZmLTjJ2
P/1daHgdHtcKSc9o3ubqokvuaDvZxJCkhDLAno1pCNSlZVmjsVswSDQE0VA3tPHc
V0Clk/E10cu6/ydXXxuT/GCL7fGsoiIJgr9dvx989kCKQno12EIP57EJnsf9DDVX
rVVh+cRsFvkBh9vlTWpnvlGhlxhUTik8rgWAByH4SP//FcbhgCjlVJnwNts1cSzt
xFGwPERuKzZ16sQ5T78sdnEzgRijA/RfWeJGcfYmu5R5zMYG5Kd1BLrlMpa5jGXC
zopyh2z9biGimIS/I6Wiv1V9SzYEPw==
=zId3
-----END PGP SIGNATURE-----

--I4t6uAfof9THp3AbONFRp9lieXn6fbxXe--
