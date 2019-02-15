Received: from eggs.gnu.org ([209.51.188.92]:33147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gugqP-0001IY-PU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gugqL-00045L-LS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:07 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
	<20181203175211.8230-4-mreitz@redhat.com>
	<1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <55b60490-4a90-4385-029f-5be9c3c2f0a4@redhat.com>
Date: Fri, 15 Feb 2019 17:59:56 +0100
MIME-Version: 1.0
In-Reply-To: <1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AkWVVIZGesXPEvW6viMdYXaqs2Fp2uR7j"
Subject: Re: [Qemu-devel] [PATCH for-next 3/6] blkdebug: Add @iotype error
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AkWVVIZGesXPEvW6viMdYXaqs2Fp2uR7j
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <55b60490-4a90-4385-029f-5be9c3c2f0a4@redhat.com>
Subject: Re: [PATCH for-next 3/6] blkdebug: Add @iotype error option
References: <20181203175211.8230-1-mreitz@redhat.com>
 <20181203175211.8230-4-mreitz@redhat.com>
 <1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
In-Reply-To: <1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.19 03:35, Eric Blake wrote:
> On 12/3/18 11:52 AM, Max Reitz wrote:
>> This new error option allows users of blkdebug to inject errors only o=
n
>> certain kinds of I/O operations.  Users usually want to make a very
>> specific operation fail, not just any; but right now they simply hope
>> that the event that triggers the error injection is followed up with
>> that very operation.  That may not be true, however, because the block=

>> layer is changing (including blkdebug, which may increase the number o=
f
>> types of I/O operations on which to inject errors).
>>
>> The new option's default has been chosen to keep backwards
>> compatibility.
>>
>> Note that similar to the internal representation, we could choose to
>> expose this option as a list of I/O types.  But there is no practical
>> use for this, because as described above, users usually know exactly
>> which kind of operation they want to make fail, so there is no need to=

>> specify multiple I/O types at once.  In addition, exposing this option=

>> as a list would require non-trivial changes to qemu_opts_absorb_qdict(=
).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> If you want @iotype be a list, I have patches.
>=20
> Might be interesting to see, whether or not we take them.

Here you go:

https://git.xanclic.moe/XanClic/qemu/commit/f4fcf47cb24b24040d3f0b2306403=
b0a17b51439
https://git.xanclic.moe/XanClic/qemu/commit/bffaabee7e1995df2adfb6183dec5=
a2cf6a8e8c8

>> ---
>>  qapi/block-core.json | 26 +++++++++++++++++++++++
>>  block/blkdebug.c     | 50 ++++++++++++++++++++++++++++++++++++-------=
-
>>  2 files changed, 67 insertions(+), 9 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Once more, thanks!

Max


--AkWVVIZGesXPEvW6viMdYXaqs2Fp2uR7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxm8A0ACgkQ9AfbAGHV
z0Ab5wf/VNKlXIE25QX1fg1CvIxAe8Sv1+pMb5C4Glc3dQbcdZEpnFNt84YAbvIC
CWVfLDVC+vqwn+Aym5uYIKCIpkHnuiV6iVpJzMLX6VB7B5W0xIzlIa6V2GVWYS1v
eehz2yZYjWwePowEpO+rVFthRoSlkIsUGHehdj+VYWZW93jS+4rlGQxoOGD/iZeR
ze3V+sNo3ZQX4KMbGCMfJ7eYsSOYES8o1p56yJOsCaHEs6LOdKMBByeYZ/h1lfOH
s6HHELkHS0jrtLimNKP3FURfGQvKPMDYF8mn2Lx4gFvR9uwoFyxoUsgJ+q8JBOp3
Rp7x6EgVMNAkYCVdfW4qhNLJTRkF8g==
=vRgk
-----END PGP SIGNATURE-----

--AkWVVIZGesXPEvW6viMdYXaqs2Fp2uR7j--
