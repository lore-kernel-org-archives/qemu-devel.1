Received: from eggs.gnu.org ([2001:4830:134:3::10]:56366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eos5v-0007XW-Uv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eos5v-0005K3-0v
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:43:35 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-2-mreitz@redhat.com>
	<20180222122700.GE4147@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c7b8ff6-20f8-3954-1d39-537738e77d7c@redhat.com>
Date: Thu, 22 Feb 2018 15:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180222122700.GE4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FcpBq7oTUvYrzvxILHC9LkYSwJYXOsfQB"
Subject: Re: [Qemu-devel] [PATCH v8 01/26] block/mirror: Small
 absolute-paths simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FcpBq7oTUvYrzvxILHC9LkYSwJYXOsfQB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <6c7b8ff6-20f8-3954-1d39-537738e77d7c@redhat.com>
Subject: Re: [PATCH v8 01/26] block/mirror: Small absolute-paths
 simplification
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-2-mreitz@redhat.com>
 <20180222122700.GE4147@localhost.localdomain>
In-Reply-To: <20180222122700.GE4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-22 13:27, Kevin Wolf wrote:
> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
>> When invoking drive-mirror in absolute-paths mode, the target's backin=
g
>> BDS is assigned to it in mirror_exit(). The current logic only does so=

>> if the target does not have that backing BDS already; but it actually
>> cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING =
in
>> qmp_drive_mirror()), so just assert that and assign the new backing BD=
S
>> unconditionally.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Introducing new assumptions that the graph stays unmodified between the=

> start of a block job and its completion feels a bit adventurous when al=
l
> of the blockdev work is moving towards making things more flexible.

But as the commit message hints at, MIRROR_SOURCE_BACKING_CHAIN is used
only by drive-mirror.  How flexible do you intend that to be?

Yes, technically you can specify a node name for the newly created image
and then go wild while the block job is still running.  But then
something inside me feels like you should see your VM crashing for
that...  OTOH, a crash is always bad.

I can't make it crash in the current state because the mirror job
creates a BB and blockdev-snapshot thus refuses to attach a backing file
to the target.  But I guess I'll drop this patch anyway (unless I find
it was important for some other patch in this series, which I hope it
wasn't...).

On a totally unrelated note, we need some protocol for hurting the user
if they do something that deserves a bit of pain.  Crashing is always
bad and our fault, so it needs to be something else.  Removing $HOME?
Marking all attached qcow2 images corrupt even though they aren't so you
have to run a qemu-img check?  I like that one.

Max


--FcpBq7oTUvYrzvxILHC9LkYSwJYXOsfQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqO1vwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aea0IAKdVXViKj1RqZXvRcPzyuO94RaJqcS5K
Slgppt+vFWJ3S+CfJ0+EBzV5URlqIRShSGj5KlndE3GCfbLiaFU6uQG+yB8nOWPr
be2+Xik/Li2p+oJDihf3MO7ltpn62jlV8arrL/grikCQZO0ybrgqDFth9n/3MpL2
H3N3z8JHrfd8M7fs+zVE3+IUWTtVUqZgdhp9IAHPOMi/0G+Dh6JLV6JSN4jQLILO
tWUwrfMLaKtDWrOGH8t8Dsv9SUAFZjxWD3t/1fkjXJlpsyqPlbOZh9geChKFI0OC
UhcXwKZJKoIq3+Hplad7mFXOuXcHIA5pi7A8DF2Sk//NE6CNZwPUA/M=
=IQaB
-----END PGP SIGNATURE-----

--FcpBq7oTUvYrzvxILHC9LkYSwJYXOsfQB--
