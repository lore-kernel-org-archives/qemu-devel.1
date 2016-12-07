Received: from eggs.gnu.org ([2001:4830:134:3::10]:45891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEeXU-0008Aq-AZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEeXQ-0003Dg-Pp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:53:48 -0500
References: <20161207123959.4565-1-fziglio@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61c44ab2-01c7-4187-7a5a-6c498f70e31c@redhat.com>
Date: Wed, 7 Dec 2016 09:53:40 -0600
MIME-Version: 1.0
In-Reply-To: <20161207123959.4565-1-fziglio@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3slJwEJIqtUMOs0Q4Rw7nqaxnmANIkICu"
Subject: Re: [Qemu-devel] [PATCH] usb: Fix typo in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3slJwEJIqtUMOs0Q4Rw7nqaxnmANIkICu
From: Eric Blake <eblake@redhat.com>
To: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <61c44ab2-01c7-4187-7a5a-6c498f70e31c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb: Fix typo in documentation
References: <20161207123959.4565-1-fziglio@redhat.com>
In-Reply-To: <20161207123959.4565-1-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 06:39 AM, Frediano Ziglio wrote:
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>

Mentioning 'simliar' in the commit message would make it easier to pick
out which word is being changed, when not using a colored-by-word diff.

This patch can also go through qemu-trivial (cc'd).

Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>  docs/usb-storage.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/docs/usb-storage.txt b/docs/usb-storage.txt
> index fbc1f2e..551af6f 100644
> --- a/docs/usb-storage.txt
> +++ b/docs/usb-storage.txt
> @@ -34,7 +34,7 @@ with tree logical units:
>  Number three emulates the classic bulk-only transport protocol too.
>  It's called "usb-bot".  It shares most code with "usb-storage", and
>  the guest will not be able to see the difference.  The qemu command
> -line interface is simliar to usb-uas though, i.e. no automatic scsi
> +line interface is similar to usb-uas though, i.e. no automatic scsi
>  disk creation.  It also features support for up to 16 LUNs.  The LUN
>  numbers must be continuous, i.e. for three devices you must use 0+1+2.=

>  The 0+1+5 numbering from the "usb-uas" example isn't going to work
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3slJwEJIqtUMOs0Q4Rw7nqaxnmANIkICu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSDCEAAoJEKeha0olJ0NqTyYH/ilgBCPnyyW2gFDna3cC+Qg7
sm0SmDVD3VxpQKU//yj0yiACSG9S4B3xEXwSNbOFry5WCBHKvwjjRErO1aw8lNKk
WlslPstfqos/ka8Gv3O49euGgZs4Ak26Wi6cdwzIwZLPdBbLg9Q5357HPIKeZWrh
PhPvaVrKA2fQP+3e9EBBXlM/TcaC0LDtOzJegD04Gv1LxtQN7Llt7p8x29ali5EY
gEjaXz5ZbgkzCfMBs68hgEMAHp8DDbgrAFcgr9UtUav2gjJvp+fmRa1jGfNZgJpX
w/U2dd4rJggXBC9Jz7VAAH+muomYUSA7T0m1U90z34qJQ260/yytWmVKBYtcdhA=
=dys6
-----END PGP SIGNATURE-----

--3slJwEJIqtUMOs0Q4Rw7nqaxnmANIkICu--
