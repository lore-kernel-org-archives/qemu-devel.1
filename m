Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce5UJ-0002ZV-3A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce5UI-0007On-AH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ce5UI-0007OE-10
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:43:38 -0500
References: <1487053524-18674-1-git-send-email-den@openvz.org>
	<1487053524-18674-3-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <897e1cc8-5367-967c-cf56-f155b0f95192@redhat.com>
Date: Wed, 15 Feb 2017 13:43:34 -0600
MIME-Version: 1.0
In-Reply-To: <1487053524-18674-3-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G9tLNoigfXHETjxL631HU83rdH86tVmsq"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] report guest crash information in
 GUEST_PANICKED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G9tLNoigfXHETjxL631HU83rdH86tVmsq
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <897e1cc8-5367-967c-cf56-f155b0f95192@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] report guest crash information in
 GUEST_PANICKED event
References: <1487053524-18674-1-git-send-email-den@openvz.org>
 <1487053524-18674-3-git-send-email-den@openvz.org>
In-Reply-To: <1487053524-18674-3-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 12:25 AM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> it's not very convenient to use the crash-information property interfac=
e,
> so provide a CPU class callback to get the guest crash information, and=
 pass
> that information in the event
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---

> +++ b/qapi/event.json
> @@ -488,7 +488,9 @@
>  #
>  # @action: action that has been taken, currently always "pause"
>  #
> -# Since: 1.5
> +# @info: optional information about a panic
> +#
> +# Since: 1.5 (@info since 2.9)

This is more usually written:

# @info: #optional information about a panic (since 2.9)
#
# Since: 1.5


> +
> +    if (info) {
> +        qapi_free_GuestPanicInformation(info);

qapi_free_*() is safe to call on a NULL pointer, so this is a useless 'if=
'.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--G9tLNoigfXHETjxL631HU83rdH86tVmsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpK9mAAoJEKeha0olJ0NqTccIAKplInlkhR5F9LIZpqY38Rre
cDXgEscWNwY5HvVz4Deo1Tdp583Dhw/LpR8V3mhNbIiUvj1Wvn1/KO2d1QQR51UG
9EnueGm06WxrY9bdOJdFkZslrHop2IRgPTJvRA5LKyEeunwiKCQvPCJChkiGJE+D
e7n8loV6zEsZfD5hhzcx7MnKcL8uh9sO8PrpvvnOInC55rD1YpCxXZirrfYpi32p
tQtgQHJQmbDLI0lgWrPDsvNkB1y/xdsrqD34ciJtZWhPOqFW1FgkxZungKaPEwz8
1rjS1j+ZQTFNfINRn8V6RFr14JSKWo08TPMJo14zjngErdVV/YEAp72fXQMmDS4=
=HDvY
-----END PGP SIGNATURE-----

--G9tLNoigfXHETjxL631HU83rdH86tVmsq--
