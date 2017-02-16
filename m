Received: from eggs.gnu.org ([2001:4830:134:3::10]:35403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cePMc-0005Cj-BE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cePMY-0007zt-CF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:57:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cePMY-0007zP-31
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:56:58 -0500
References: <aefcd4e5-8d7e-b50e-e080-981e18013967@openvz.org>
	<1487262601-78993-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <379bfc0c-10ab-19ea-c7db-b3c61ddfcf5d@redhat.com>
Date: Thu, 16 Feb 2017 10:56:55 -0600
MIME-Version: 1.0
In-Reply-To: <1487262601-78993-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TTAqsiuapHKvRiCDXuNdrFF7XgfMMI1C7"
Subject: Re: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TTAqsiuapHKvRiCDXuNdrFF7XgfMMI1C7
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <379bfc0c-10ab-19ea-c7db-b3c61ddfcf5d@redhat.com>
Subject: Re: [PATCH] qmp-events: fix GUEST_PANICKED description formatting
References: <aefcd4e5-8d7e-b50e-e080-981e18013967@openvz.org>
 <1487262601-78993-1-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1487262601-78993-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 10:30 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/event.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/event.json b/qapi/event.json
> index 970ff02..e02852c 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -488,9 +488,9 @@
>  #
>  # @action: action that has been taken, currently always "pause"
>  #
> -# @info: optional information about a panic
> +# @info: #optional information about a panic (since 2.9)
>  #
> -# Since: 1.5 (@info since 2.9)
> +# Since: 1.5

My comment on v4 also pointed out a useless conditional that should be
fixed at the same time:

https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03361.html

And it's probably better to submit this patch as a top-level thread
rather than buried in-reply-to a pull request.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TTAqsiuapHKvRiCDXuNdrFF7XgfMMI1C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpdnXAAoJEKeha0olJ0NqJxEH/RjzacR3aTxndAj77FtIpbis
eRzOcIqqkhDmQNFOup5oaVUn9v/R7Fru7fK5qGz31uT8/b5bScdw9VMUKczEvsbP
s5wDifvqFQnZH8XpJxIHOdKq5rH1NW0yue8PCMkFzuh3EMlfL4sZDKMGOM3kvn7D
aw8ztk3j2VAqUr+KUWHbzVN5vuH/G3tVOOvuYcjqbMuAThRhxqM5eR2t13PKnueU
xwh9rIlIloMmzvJNWMiVM7hBeT2Z1bcfsDs+tRvmc8Wf//MUGyKxReJtOxhEAcnm
WdXKJUUEytWW6w6Yhifckim306c1bWGmde3KpU/E/Qnz3iVfOwekG5Nkp7UKEPM=
=8iAt
-----END PGP SIGNATURE-----

--TTAqsiuapHKvRiCDXuNdrFF7XgfMMI1C7--
