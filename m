Received: from eggs.gnu.org ([209.51.188.92]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghw24-0004iU-7V
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghw22-0001El-EW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:35:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghw1z-0001CR-I8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:35:25 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c6d6a292-5001-d63f-1162-fb40e01b22b2@redhat.com>
Date: Fri, 11 Jan 2019 13:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xzseGfAorsmvthsLPPLsXtdjeRNKVTrM9"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xzseGfAorsmvthsLPPLsXtdjeRNKVTrM9
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com
Message-ID: <c6d6a292-5001-d63f-1162-fb40e01b22b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
 <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
In-Reply-To: <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.01.19 18:52, Eric Blake wrote:
> On 1/9/19 11:38 AM, Max Reitz wrote:
>=20
>>
>> <general whining>
>> Actually, to me what you're saying sounds more like "Our deprecation
>> policy is useless" to which I wholeheartedly agree.  I think we should=

>> only remove things in major releases, and only if it was deprecated in=

>> the previous major release already.  (So if you deprecate something in=

>> 4.0, you can remove it in 5.0; but if you deprecate it in 4.1, you can=

>> remove it only in 6.0.)  From a user standpoint I really think we
>> deprecate stuff too irregularly.
>> </general whining>
>=20
> That's actually incorrect. Our current version numbering scheme is that=

> the major version number is NOT synonymous with major releases: we just=

> bump the major version number once per year, and ALL releases are on
> equal footing with no one release being more major than others.  Thus, =
a
> policy that (at least) 2 releases is needed for a deprecation is
> consistent, where one that requires waiting for a bump in the major
> version number (which is as short as one release and as long as 3, give=
n
> that we bump every year with about 3 releases per year) is the one that=

> is less predictable and less meaningful (why is waiting for January
> better than waiting for 2 releases?).

This sounds to me like we just don't have major releases because our
deprecation policy doesn't make use of it.  If we only broke APIs when
bumping the major release number, then by definition that would be major
releases, no?

Also, if you %s/major release/x.0 release/g in my whining, the argument
remains the same.

And, yes, I dislike our versioning policy, too.  My whining may have
indicated that I like semver.

Max


--xzseGfAorsmvthsLPPLsXtdjeRNKVTrM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4jXUACgkQ9AfbAGHV
z0A/SAgAhwMfClop8uudE0pVKTQNSYpprA0H9/FqUT+Vgf+mdZb1nQj5d+pqQHWi
+E1mwFds+D7Im/fNDSyrA2Y9fftnz4mE7QDpphotPTC9uUJnmenPg92vYw5LtPPN
Y4tpT3P0Hl8dyy30Tr6Z6K8Ji19qrD4/pxlKeS0dC2/1qBTxBFSH99Ej3ZqmiUFp
GOfoEnxwUoJo3DjsfqpnpX9tEDf/H/C+6JODTJDi1Lk6OsPSV14uYBEYcdcS51G9
1B1jWnydBJxdf/UPLHdL9+Os0O9RknZZxx3p9ghQ4BdGsaToimfVNW72I3+ROAl7
2Lpq/KsBlmmzdYxhqCBkby0m9+/jEQ==
=X5Td
-----END PGP SIGNATURE-----

--xzseGfAorsmvthsLPPLsXtdjeRNKVTrM9--
