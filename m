Received: from eggs.gnu.org ([2001:4830:134:3::10]:45525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrip-0007LF-OV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnril-00010i-7k
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnril-00010I-00
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:02:59 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-24-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e48b766-d980-fdbd-0cc5-76ee0a753c05@redhat.com>
Date: Tue, 14 Mar 2017 14:02:56 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-24-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aEfpDK5hql1TW987BpvdcRDGRsj7c0rxM"
Subject: Re: [Qemu-devel] [PATCH for-2.9 23/47] qapi2texi: Don't hide
 undocumented members and arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEfpDK5hql1TW987BpvdcRDGRsj7c0rxM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4e48b766-d980-fdbd-0cc5-76ee0a753c05@redhat.com>
Subject: Re: [PATCH for-2.9 23/47] qapi2texi: Don't hide undocumented members
 and arguments
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-24-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Show undocumented object, alternate type members and command, event
> arguments exactly like undocumented enumeration type values.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Command: query-rocker
>=20
>       Return rocker switch information.
>=20
> +     Arguments:
> +     'name'
> +          Not documented
> +
>       Returns: 'Rocker' information
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aEfpDK5hql1TW987BpvdcRDGRsj7c0rxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyD5gAAoJEKeha0olJ0NqTw0H/RYQ863qy91Klye78OWn4ZQq
6QWh7/8X6bEDurTxQhBpgMSew+mKqi6UaTMIOufm2/8TAzDC+05jTorI4wsHtqEz
w4niP4BOXE6U8b94P6N1d+CYF9jZSxRangch+IGBNY67NhAal18QdAHX0OfjC6xC
HlSc4WW8Cjji/UA5/36kchxKCRg41LOoKpZnjnyRNjMW4BP+4jn46YPglXT6bRHk
+3HBQEmXWJRbTP8q/aAQCVocrx6siSMC+7ZOKcSNLw7tPztV++3aEhFmEereJfS6
XYPtG4YMukZNf/Q14KdlMLxiJgvYQcOna6o73VSprgy3oLGH4VI1O+y1gLq/zII=
=gHz8
-----END PGP SIGNATURE-----

--aEfpDK5hql1TW987BpvdcRDGRsj7c0rxM--
