Received: from eggs.gnu.org ([2001:4830:134:3::10]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrvh-00027c-9i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrvd-0001zd-AH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnrvd-0001zE-1E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:16:17 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-26-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1320cf0a-f7ad-5135-4bb9-6d1e0adda372@redhat.com>
Date: Tue, 14 Mar 2017 14:16:14 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-26-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E7pttQKRlux6TO8M9LoJmLoBqvX5guMuV"
Subject: Re: [Qemu-devel] [PATCH for-2.9 25/47] qapi2texi: Include member
 type in generated documentation
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
--E7pttQKRlux6TO8M9LoJmLoBqvX5guMuV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <1320cf0a-f7ad-5135-4bb9-6d1e0adda372@redhat.com>
Subject: Re: [PATCH for-2.9 25/47] qapi2texi: Include member type in generated
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-26-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> The recent merge of docs/qmp-commands.txt and docs/qmp-events.txt into
> the schema lost type information.  Fix this documentation regression.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Struct: InputKeyEvent
>=20
>       Keyboard input event.
>=20
>       Members:
> -     'button'
> +     'button: InputButton'
>            Which button this event is for.
> -     'down'
> +     'down: boolean'
>            True for key-down and false for key-up events.
>=20
>       Since: 2.0

Definitely worth having.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py      | 14 ++++++++++++++
>  scripts/qapi2texi.py |  8 ++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--E7pttQKRlux6TO8M9LoJmLoBqvX5guMuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyEF+AAoJEKeha0olJ0Nqu08H/jYNqps71CGmiWIJ2ar6iPug
REZYSb3Oonq+nrTe/MzMQ+Dmts6TQ3edrAdufXvEA0bVxU2Bs8Bt4NOAZZ8Zu0s4
gqJPsTTlItzHoyqtAYFXBoD+09d45SO34wBLtS3id/S1brYhRP5v/3OXORwjWglU
o//9N1blgafH/fYER+GpBn4hmGIqLg2idwZ4fr3cKrKIXtYOQjTybAhzE5gKRq8j
QfrEySqPhecULO/f+CkpHWZ9iQ4ZIiuefaaxQdwJ/Xnz6H48SfZ0MnflUBL2/pFl
4LW/L8DmOj1Ee39/FpAhpVBn6f0ca/5TVo/E+Svijl3dAJ8bpjCRwyWdQmwxYtQ=
=75xn
-----END PGP SIGNATURE-----

--E7pttQKRlux6TO8M9LoJmLoBqvX5guMuV--
