Received: from eggs.gnu.org ([2001:4830:134:3::10]:37434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8A7O-0002ZJ-77
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8A7J-00050G-Lz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8A7J-000502-Cj
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 545F17F6AC
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 18:44:12 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <047c88ac-ff8f-b05d-3924-c6dbf897e263@redhat.com>
Date: Tue, 9 May 2017 13:44:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170509173559.31598-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p31obr4hGWuH914jwHIdTOCB3gtGQv3hi"
Subject: Re: [Qemu-devel] [PATCH 02/17] object: fix potential leak in getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p31obr4hGWuH914jwHIdTOCB3gtGQv3hi
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <047c88ac-ff8f-b05d-3924-c6dbf897e263@redhat.com>
Subject: Re: [PATCH 02/17] object: fix potential leak in getters
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 12:35 PM, Marc-Andr=C3=A9 Lureau wrote:
> If the property is not of the requested type, the getters will leak a
> QObject.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p31obr4hGWuH914jwHIdTOCB3gtGQv3hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEg34AAoJEKeha0olJ0Nqz/AH/Rn6l9rgWx9ptMfRVBW5yWPe
ZMa5IhlZAwP30Zb9X6zRz14idW5ZcUiI238Lr3OaH7k7pJcVVxYvsW3ppLMuc37V
rmcXutCkJWa20vVkWsxP4vQK647+RhQWR0W+lfE3vockOAiblyU1/JaTGBuuRQSG
QBMsTSnxFuzgZysP3vAzYZu2wki9wLoPm7seskW2+9Vmatxv6AfdDxns4Z5ARc60
3Kd0sP7RrvO1GPUrBKeNvxKBsfF5cW+0GHaiBFju1fqndLhiNlGc1U5QhBc+qxG6
OHvOSliI8ds3pPXBsGQuZgGyeJJcAZYHvoIrE/BC8COgq8eH+mT2qhRTJ5+dmfk=
=xvtM
-----END PGP SIGNATURE-----

--p31obr4hGWuH914jwHIdTOCB3gtGQv3hi--
