Received: from eggs.gnu.org ([2001:4830:134:3::10]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1HR-0002yb-5w
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1HQ-0001To-DP
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:56:53 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-5-mreitz@redhat.com>
	<8022d6f6-46b7-cc9d-fafc-6f1c95bbd45b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4dada5b-6ddb-e14d-5248-f56862b076aa@redhat.com>
Date: Wed, 14 Nov 2018 20:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <8022d6f6-46b7-cc9d-fafc-6f1c95bbd45b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yNAHRtrLIPwtzXl7lZQgKwaVX6DIp3KkR"
Subject: Re: [Qemu-devel] [PATCH v2 04/11] block: Storage child access
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNAHRtrLIPwtzXl7lZQgKwaVX6DIp3KkR
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a4dada5b-6ddb-e14d-5248-f56862b076aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/11] block: Storage child access
 function
References: <20180809223117.7846-1-mreitz@redhat.com>
 <20180809223117.7846-5-mreitz@redhat.com>
 <8022d6f6-46b7-cc9d-fafc-6f1c95bbd45b@redhat.com>
In-Reply-To: <8022d6f6-46b7-cc9d-fafc-6f1c95bbd45b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 23:32, Eric Blake wrote:
> On 8/9/18 5:31 PM, Max Reitz wrote:
>> For completeness' sake, add a function for accessing a node's storage
>> child, too.=C2=A0 For filters, this is there filtered child; for non-f=
ilters,
>=20
> s/there/their/
>=20
>> this is bs->file.
>>
>> Some places are deliberately left unconverted:
>> - BDS opening/closing functions where bs->file is handled specially
>> =C2=A0=C2=A0 (which is basically wrong, but at least simplifies probin=
g)
>> - bdrv_co_block_status_from_file(), because its name implies that it
>> =C2=A0=C2=A0 points to ->file
>=20
> I'm wondering if we can clean up block_status to let filters have a NUL=
L
> callback and io.c do the right thing automatically, rather than the
> current approach of filters assigning the callback to the common helper=

> routine.=C2=A0 Maybe later in the series.

Hm!  I didn't even think of that.  Yes, everything that uses
bdrv_co_block_status_from_*() seems to be an R/W filter, and which they
use simply depends on whether they use bs->backing or bs->file.  Well,
blkdebug is the exception, because it really wants to put an assertion
there, but inlining the code there shouldn't be the showstopper.

Max


--yNAHRtrLIPwtzXl7lZQgKwaVX6DIp3KkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvsffUACgkQ9AfbAGHV
z0C6cwf/VDQJ2Lck/7VkLgnSDDBSXZyHFo77j5l3EZcxHAy/FLErxz+HybV18Gqp
TdiXOm5CUBynmQidASP7FvUqXclnUGSDtBVaDX5wDgXVRWCMHVaor23AcBFyg5ov
WOiF7LUsxWcfdSGt+DiZyxRPvurURdUlGn5483ioYmzx391hHrjG9dRkT2ceJDcp
RSHKZrWtC1XLVbq7SVQHBMh3a97R//xUH6X66D01FLF5wgUIxarPjf0tAH4t9S9L
jvBDzA12o+hV+ifSypmH8tcvFCOecgrm6RWlHwBOymlMpCQX+OStRr434WMjusIo
0ovckEBJvMq2aYJnQ7iY8AOWJUmfMw==
=3p4n
-----END PGP SIGNATURE-----

--yNAHRtrLIPwtzXl7lZQgKwaVX6DIp3KkR--
