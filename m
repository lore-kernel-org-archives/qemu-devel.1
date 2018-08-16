Received: from eggs.gnu.org ([2001:4830:134:3::10]:59027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqCVB-0007ss-54
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqCV9-0002DH-TP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:15:25 -0400
Date: Thu, 16 Aug 2018 09:15:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180816071515.GC5511@localhost.localdomain>
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
	<d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, fullmanet@gmail.com, qemu-block@nongnu.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.08.2018 um 04:49 hat Max Reitz geschrieben:
> On 2018-08-16 04:39, Eric Blake wrote:
> > If convert were more powerful, I'd be fine dropping 'qemu-img dd' after
> > a proper deprecation period.
>=20
> Technically it has those features already, with the raw block driver's
> offset and size parameters.

In a way, yes. It requires you to precreate the target image, though,
because --target-image-opts requires -n.

We'll probably want to fix something in this area anyway because in the
common case, you already need those options to even precreate the image,
and qemu-img create doesn't support open options for the protocol layer
either (unlike blockdev-create).

> >> ((That gave me a good idea.=A0 Actually, it's probably not such a good
> >> idea, but I guess I'll do it in my spare time anyway.=A0 A qemu-img fu=
se
> >> might be nice which represents an image as a raw image at some mount
> >> point.=A0 Benefits over qemu-nbd: (1) You don't need root, (2) you don=
't
> >> need to type modprobe nbd.))
> >=20
> > So the kernel->userspace translation would be happening via the FUSE
> > interface instead of the NBD interface.=A0 Data still bounces around ju=
st
> > as much, but it might be a fun project.=A0 Does fuse behave well when
> > serving exactly one file at the mountpoint, rather than the more typical
> > file system rooted in a directory?=A0 NBD at least has the benefit of
> > claiming to be a block device all along, rather than complicating the
> > user interface with POSIX file system rules (which you'll be bending,
> > because you are serving exactly one file instead of a system).

To make it more real, you could expose a snapshots/ subdirectory. Or
maybe better not.

> Well, but I can just pretend my FUSE file is a block device, no?
>=20
> Also, I just discovered something really interesting: FUSE allows you to
> specify a single file as a mountpoint.
>=20
> And you know what?  You can open the original file before you replace it
> by the FUSE "filesystem".
>=20
> So my fun interface is going to looks like this:
>=20
> $ qemu-img fuse foo.qcow2
>=20
> And then your foo.qcow2 is a raw image until the next "fusermount -u
> foo.qcow2"!  Isn't that fun?

Yes, sounds fun. Until you realise that I'd actually like to merge
something like this when it exists. ;-)

For a more serious implementation, maybe it should even be a separate
qemu-fuse rather than a qemu-img subcommand.

Kevin

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbdSSDAAoJEH8JsnLIjy/WFc8P/1k9yN8Cvyp6aMisTa2LwlCm
o/qvuJTBOq3o6gasDETy6TEtrp9ySWM/C469ai25E7Q9EIFy/LNzlndsGlHbNuig
YV08mw/e693lcH6edg0ksH+wTPmhmgQr7Lw+HSTE93zKOCF44+PV1iHRhipuM89v
EEdPNZCkvB+y5+fICUMktXVPPl9KC+LXkx45Gwzn8/HDodEO/rmJ47+CKCELmiZs
3geQ+Xw2e2zY2ju/5nNX6TeFHfKyG/Twr79NHr51P+RJvcWGEK+5Yesvoz5DDlpj
hojq0W5J3AUDGMOpK/z7slIkLryzx2TLMoKND8QctBs27l83ZS6FY2rZLr/It3tu
aBcEHKF/MGDtYHBZq5jZ4icHKGXk4/H4LEAxhENwOfa7DUpD3am9t/bPFZCNGgGK
o/Er9ulIBQ6DGQNNmEUXsjywzk5C85ZvU/ytI0NsC3Rlqj9dHmp4JBCA1xdE3ie9
lXs/y8/FnLK/3obKm2qmI8x7oYDdGgQv+23CDQYiDc4b+xVS4m8jP0GTqyyiyoLe
6M6GAasrENLc4fDk2jg9fSxznvTTNCkCieb1YlKjLue/v443D1Eodmx5JqE0sgjc
4WFTNJQGH0gwTYAiAamo781Ar5/REDYTA4cljt3CoPk9PdxRIVqg79UCt4ZotC00
OI2kBLZ4m+zS4a0mp75r
=3d0l
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
