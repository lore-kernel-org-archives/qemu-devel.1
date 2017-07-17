Received: from eggs.gnu.org ([2001:4830:134:3::10]:45589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8vF-0005ek-Rf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8vB-0001yH-Us
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:31:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX8vB-0001xn-MJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:30:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6CB0C04B32C
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:30:56 +0000 (UTC)
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-2-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f34cae70-00f7-9058-c5aa-1f209b742172@redhat.com>
Date: Mon, 17 Jul 2017 11:30:47 -0500
MIME-Version: 1.0
In-Reply-To: <1500279971-13875-2-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l5TXH5SpJaPbkQxgsb8Se96pukaPV4c4o"
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5TXH5SpJaPbkQxgsb8Se96pukaPV4c4o
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <f34cae70-00f7-9058-c5aa-1f209b742172@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
 <1500279971-13875-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 03:26 AM, Peter Xu wrote:
> We have merely all the stuff, but this one is missing. Add it in.

s/merely/nearly/

>=20
> Am going to use this new helper for MigrationParameters fields, since
> most of them are int64_t.
>=20
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  2 files changed, 35 insertions(+)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l5TXH5SpJaPbkQxgsb8Se96pukaPV4c4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls5jcACgkQp6FrSiUn
Q2owYAf/dpvsZcEvFyXQMWNse5UNnMWfqDJScr6foc8AC6dmhfsxDdiHPr0+2p3t
2tvZsv8l0L6xc1pmFl/o65UwfftAQ1QuGZQH8br/aFI8ZRi6puzp+/F9fEkSxBiN
zxYzob8qHcUcqplyqNFLShD/1OufHu8xuMWYCf12f+Ru0I3K14zWbWE7mCuNZ/+/
JIhRD5PR0eiYnAnXrVSONm4r4+dUhADKUBUbRPWTRLw/5NaipLqj+Rgi0VXvcWhm
QQiPpSDd+qB7XkOy283ReIBJKorM7IlncjBpgAXTIglZEv5pTM2bwoUHrd7MsplB
IJh22abSj4ncgHrmxR/RAWhxXXrskQ==
=VGNs
-----END PGP SIGNATURE-----

--l5TXH5SpJaPbkQxgsb8Se96pukaPV4c4o--
