Received: from eggs.gnu.org ([2001:4830:134:3::10]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUdv-0007nN-S5
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUdu-00033U-PJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:20:51 -0400
References: <20180509182002.8044-1-mreitz@redhat.com>
	<20180509182002.8044-2-mreitz@redhat.com>
	<de872504-7edb-585d-92fd-a4756e36a204@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e1df9392-304e-8e6f-46cd-7830388a3c70@redhat.com>
Date: Wed, 9 May 2018 21:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <de872504-7edb-585d-92fd-a4756e36a204@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wphiS1yBEdzVVUrjXPdWTPOpGi8THKPz7"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wphiS1yBEdzVVUrjXPdWTPOpGi8THKPz7
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e1df9392-304e-8e6f-46cd-7830388a3c70@redhat.com>
Subject: Re: [PATCH v2 1/2] qemu-img: Resolve relative backing paths in rebase
References: <20180509182002.8044-1-mreitz@redhat.com>
 <20180509182002.8044-2-mreitz@redhat.com>
 <de872504-7edb-585d-92fd-a4756e36a204@redhat.com>
In-Reply-To: <de872504-7edb-585d-92fd-a4756e36a204@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 20:51, Eric Blake wrote:
> On 05/09/2018 01:20 PM, Max Reitz wrote:
>> Currently, rebase interprets a relative path for the new backing image=

>> as follows:
>> (1) Open the new backing image with the given relative path (thus
>> relative to
>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-img's working directory).
>> (2) Write it directly into the overlay's backing path field (thus
>> =C2=A0=C2=A0=C2=A0=C2=A0 relative to the overlay).
>>
>> If the overlay is not in qemu-img's working directory, both will be
>> different interpretations, which may either lead to an error somewhere=

>> (either rebase fails because it cannot open the new backing image, or
>> =C2=A0 your overlay becomes unusable because its backing path does not=
 point
>> =C2=A0 to a file), or, even worse, it may result in your rebase being
>> performed for a different backing file than what your overlay will poi=
nt
>=20
> Interesting indentation in this paragraph. A maintainer could tweak it.=


Well, it was meant this way (because of the opening paranthesis), but I
could out-dent it.

Max

>> to after the rebase.
>>
>> Fix this by interpreting the target backing path as relative to the
>> overlay, like qemu-img does everywhere else.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1569835
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qemu-img.c | 23 ++++++++++++++++++++++-
>> =C2=A0 1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--wphiS1yBEdzVVUrjXPdWTPOpGi8THKPz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzSgoACgkQ9AfbAGHV
z0Bcigf9GBEDCHH7Lx+9GeiDIjD/L5PuBWnMoZq7norcrzeQiHRSKXN7P3S/+LQL
MPKfsT69WSkJn/jp1Ow57Cplyf/YYvEdv++03Y/XgB0ceRdtdQobjQeNlPHt4Qfq
Dwuu5gBISC59hcEjn0vzMn22aRoPxZ4LtPV7VNNYEGb+idEqdukYo7Gm3zSvD8Pd
6d8Ij1DjPqKJmkmW+oPbNldF31+mq+0AGeHeDaXQQN4NuC/nwHcYMBlalB+sqnMw
eANdaOiwPy6Izt+2ftBwE5TyOJa04zO72Uzte9LLT6FMpJ3vK7QsADAwjDxnAGw/
8EhfIE9uSmNbbk77Dm4CDxTBuvkgHA==
=10DX
-----END PGP SIGNATURE-----

--wphiS1yBEdzVVUrjXPdWTPOpGi8THKPz7--
