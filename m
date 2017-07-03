Received: from eggs.gnu.org ([2001:4830:134:3::10]:48588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS601-00020u-Eo
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS600-0006qp-GQ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:23:05 -0400
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-19-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a2f0667-9060-6412-26ea-22aa484844c2@redhat.com>
Date: Mon, 3 Jul 2017 13:22:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170627192458.15519-19-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DFVE73D5fBE833aatEx9T73lK5rsrS3Pd"
Subject: Re: [Qemu-devel] [PATCH v3 18/20] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DFVE73D5fBE833aatEx9T73lK5rsrS3Pd
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <1a2f0667-9060-6412-26ea-22aa484844c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 18/20] block: Make bdrv_is_allocated()
 byte-based
References: <20170627192458.15519-1-eblake@redhat.com>
 <20170627192458.15519-19-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 02:24 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
>=20

> ---
> v2: rebase to earlier changes, tweak commit message
> ---
>  include/block/block.h |  4 +--
>  block/backup.c        | 17 ++++---------
>  block/commit.c        | 21 +++++++---------
>  block/io.c            | 49 +++++++++++++++++++++++++-----------
>  block/stream.c        |  5 ++--
>  block/vvfat.c         | 34 ++++++++++++++-----------

Now that Kevin's branch is sitting on a bunch of vvfat changes
(including reformatting to get rid of TABs), applying this will
conflict.  Do you need me to send a v4 to tackle the resolution?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DFVE73D5fBE833aatEx9T73lK5rsrS3Pd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWot4AAoJEKeha0olJ0NqStcH/1UK56kgXpBhlmyDuYBsQd5z
iyYLpg1u9sGlV9XlrDRIQwIWlG5f/CutsWs6i1WQGGZCQ5U4H+oEdcgHWVR9dUxp
F8JfSPYGETpkjiZNsw58MyH5ES4mKPUqb3mC2ZwqRuEO6JGf7jdSy7+SbDIeTIYn
mliI0YKnxt60p0K61CG1tmIhkv8o1dUVdvp7cARJatZ2QagmMXkXS9RtnnqkBBc2
TCEjG7vmvgvJYhF4hFp5rYT3YD7XkaurIreqjCxF6dmCImOZpur+Ocz8iMZcii7i
pe5onOvENs36Ty1t46Rjk3CWQlrQsbEpYlDSONXR2AtcXMsXkeMgTjN5dfkTf3E=
=BDEx
-----END PGP SIGNATURE-----

--DFVE73D5fBE833aatEx9T73lK5rsrS3Pd--
