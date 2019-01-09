Received: from eggs.gnu.org ([209.51.188.92]:40063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghI2C-0001Uj-BX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghI2B-0001G5-Gy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:52:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghI2B-0001Dw-88
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:52:55 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
Date: Wed, 9 Jan 2019 11:52:52 -0600
MIME-Version: 1.0
In-Reply-To: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QNv66DgGkblyXh3wPTOabQps1zE6137ao"
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
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QNv66DgGkblyXh3wPTOabQps1zE6137ao
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com
Message-ID: <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
In-Reply-To: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/9/19 11:38 AM, Max Reitz wrote:

>=20
> <general whining>
> Actually, to me what you're saying sounds more like "Our deprecation
> policy is useless" to which I wholeheartedly agree.  I think we should
> only remove things in major releases, and only if it was deprecated in
> the previous major release already.  (So if you deprecate something in
> 4.0, you can remove it in 5.0; but if you deprecate it in 4.1, you can
> remove it only in 6.0.)  From a user standpoint I really think we
> deprecate stuff too irregularly.
> </general whining>

That's actually incorrect. Our current version numbering scheme is that
the major version number is NOT synonymous with major releases: we just
bump the major version number once per year, and ALL releases are on
equal footing with no one release being more major than others.  Thus, a
policy that (at least) 2 releases is needed for a deprecation is
consistent, where one that requires waiting for a bump in the major
version number (which is as short as one release and as long as 3, given
that we bump every year with about 3 releases per year) is the one that
is less predictable and less meaningful (why is waiting for January
better than waiting for 2 releases?).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QNv66DgGkblyXh3wPTOabQps1zE6137ao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2NPQACgkQ3g5py3or
ov3TRggAgTo1KYBk/PHbtQeNwswmO28LDmgJPJmPthzPZWbS9zrPOYwX2WoGzNFp
5SGJsmjx9ZgrxWgRX0YyDIfNCdWbM7B5+FhX/yejTwuDX2Iqxr5Ppdhi+rdUlrkx
uoVEAx7HxXM8rHCoIdUej/KDPlTrW1eYbbcqAKsOIDCvIfzEhtxJxwmbRm+gc8kK
MCIQE3mQYlsKl48mQ8cdUPmfAmB99kYQy7pjGX3FeRlsxVkpzzPNr+kHgnyqiUsD
UGHfqxRxHgJeUEjijWWUyy/7r1Fm1lVL7E4Nf1uSZ5kwYd+qR8sWP4ZrNn5vyk+E
Aaft1hiz72ei2myNkea8u5tT72Jgpg==
=QEoI
-----END PGP SIGNATURE-----

--QNv66DgGkblyXh3wPTOabQps1zE6137ao--
