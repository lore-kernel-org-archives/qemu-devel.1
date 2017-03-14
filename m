Received: from eggs.gnu.org ([2001:4830:134:3::10]:47584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqsM-00016N-Qc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqsI-0006Qr-5I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:08:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqsH-0006QR-SU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:08:46 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-22-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fbb0052-f0b1-3bd0-3731-68660a088f72@redhat.com>
Date: Tue, 14 Mar 2017 13:08:43 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-22-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o0VaqcTKoROT7sm9cjULDmbjFPSQ86O1W"
Subject: Re: [Qemu-devel] [PATCH for-2.9 21/47] qapi2texi: Present the table
 of members more clearly
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
--o0VaqcTKoROT7sm9cjULDmbjFPSQ86O1W
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <5fbb0052-f0b1-3bd0-3731-68660a088f72@redhat.com>
Subject: Re: [PATCH for-2.9 21/47] qapi2texi: Present the table of members
 more clearly
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-22-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> The table of members follows the main descriptive text immediately.
> Makes it hard to see what it is about.  Start a new paragraph, and
> lead with a line "Members:" for object and alternate types, "Values:"
> for enumeration types, and "Arguments:" for commands and events.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Command: set_link
>=20
>       Sets the link status of a virtual network adapter.
> +
> +     Arguments:
>       'name'
>            the device name of the virtual network adapter
>       'up'
>            true to set the link status to be up
>=20
>       Returns: Nothing on success If 'name' is not a valid network
>       device, DeviceNotFound
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--o0VaqcTKoROT7sm9cjULDmbjFPSQ86O1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyDGrAAoJEKeha0olJ0Nqfz0H/jjuAyn0BEfmA7B5RKishPdE
rJozH2GXE1y2wlL/62V+9uUPs0Of91LJEsDxb44LMN7tJWj3ia+DYWQIW51vGUWV
3HjtRhuhsy5ln0mkjYDlEWNU5LZRkDtmeGwHZjScIinzsy/71r+0M1L/NQLNJXS1
01mP2zpT170sKbc/L4JyCnCSYcu9o3ToSbqYBXpatAVRYFhWeMyAw5lwGTZuNmnL
bbRyHRk9e9KbWw3A/0BkBfIZI8cJeaqd/C4loh7JU1cWhkCJKXoZmLHB8jx9Kavq
BgNgRAXpJtgEGIIraur75h1bC4cob+74DZtiCBSXNU438bFWiI20cpf+pnZXx0c=
=h4kH
-----END PGP SIGNATURE-----

--o0VaqcTKoROT7sm9cjULDmbjFPSQ86O1W--
