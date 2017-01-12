Received: from eggs.gnu.org ([2001:4830:134:3::10]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoYn-00054m-3T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoYj-000275-TG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRoYj-00026q-N7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D85B27F7C5
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:13:29 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-26-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e70cedc3-c600-49a9-51e1-84f5b594ddfe@redhat.com>
Date: Thu, 12 Jan 2017 17:13:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-26-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qmmWgkQcpfgM2hDCeQ36TUueLRTNUQlCW"
Subject: Re: [Qemu-devel] [PATCH 25/40] char: rename and move to header
 CHR_READ_BUF_LEN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qmmWgkQcpfgM2hDCeQ36TUueLRTNUQlCW
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <e70cedc3-c600-49a9-51e1-84f5b594ddfe@redhat.com>
Subject: Re: [PATCH 25/40] char: rename and move to header CHR_READ_BUF_LEN
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> This define is used by several character devices, place it in char
> common header.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  1 +
>  chardev/char.c        | 13 ++++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qmmWgkQcpfgM2hDCeQ36TUueLRTNUQlCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeA2XAAoJEKeha0olJ0NqmkwH/j8yV6qbqYAUTRr3Yslx71ur
XRaQhQ5DNb5fGM8HBCK6Zk+ldGqc73NFE1w6B+wu+8WPrf6iiGpx1Cmecp+3wZ9V
xAJubW/bH7/N9SAnGvTRnefvwCvZNxjBqY4y+CXi0qweKFadq5GG2i/MyHN02Bng
3RN/1ySlHHGyatK3TsC+cpqCB/iskpNGBQJrP77pdM7Un3m7Djo/Lo52LzkF2rSe
TXCO9EyU82Tyy4o1Wq8NOaFQnwZxQbEVW5+kkU4x/fZ9HQC1G7WQBEBPzcCVS81Z
bYnDcH0sCzh5wryA/dl1LpZq+TlY1ZAeZySQJiM53m9+OGMKl9cUquAagHrexVk=
=ol6T
-----END PGP SIGNATURE-----

--qmmWgkQcpfgM2hDCeQ36TUueLRTNUQlCW--
