Received: from eggs.gnu.org ([2001:4830:134:3::10]:37574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvyb-0007wX-Ny
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvyX-0004py-SC
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvyX-0004pZ-MK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:59:09 -0500
References: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
	<1488810230-31945-3-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0536bfd6-1442-8a02-8c57-0f950d1439c6@redhat.com>
Date: Mon, 6 Mar 2017 10:59:07 -0600
MIME-Version: 1.0
In-Reply-To: <1488810230-31945-3-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lxqnd3NlNslkMb3JhI0Qji43bxvGaKqIL"
Subject: Re: [Qemu-devel] [PATCH 2/2] sm501: drop sm501_template.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lxqnd3NlNslkMb3JhI0Qji43bxvGaKqIL
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <0536bfd6-1442-8a02-8c57-0f950d1439c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] sm501: drop sm501_template.h
References: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
 <1488810230-31945-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488810230-31945-3-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 08:23 AM, Gerd Hoffmann wrote:
> Now that we include sm501_template.h only once there
> is no need to keep this stuff in a separate file.
>=20
> FIXME: as peter mentioned the TARGET_WORDS_BIGENDIAN dependency looks
>        suspious.  Left as-is for now.

s/suspious/suspicious/

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/sm501.c          | 110 +++++++++++++++++++++++++++++----
>  hw/display/sm501_template.h | 145 ------------------------------------=
--------
>  2 files changed, 98 insertions(+), 157 deletions(-)
>  delete mode 100644 hw/display/sm501_template.h
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lxqnd3NlNslkMb3JhI0Qji43bxvGaKqIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvZVbAAoJEKeha0olJ0NqMmkIAJQdSH9waISArJX47UJhaZ6R
WBXok2tsm7ptU+Ps/uZy/uJH+NhcDCqK6bIfdIEL9rgsw3UQR40hbBhqv/bchBUZ
g24DfZgb5C5irTfHS48sIJW8Rxv3QFvmDbk9jye8/T0lonyW+g/4rmo2Q1L5sH5t
17GMqgG8JZQyDpA12CdrVQmRzYHYV8zgVNxGdsu0crdnvbIGagFnSlpcnuNWkKEl
uQ8hfQG1E6fHYRnwxGT62UyapdaBSWwdM4PUSlK4nQ17ERbq78mMio0DFCpzrl6F
/slVbLfDCwCWUHMr3zkp3JY88loJFZyxMPR70R/BqO3YCt8IlgC/4gBg/D7aQ5Q=
=Zx8A
-----END PGP SIGNATURE-----

--lxqnd3NlNslkMb3JhI0Qji43bxvGaKqIL--
