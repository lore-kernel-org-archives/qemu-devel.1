Received: from eggs.gnu.org ([2001:4830:134:3::10]:51974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftp0-00044N-Ly
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftoz-0007aN-Iz
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:40:30 -0500
References: <20170220165204.1980-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ae46905-78f4-7bb9-8e83-9c7e2f8b982a@redhat.com>
Date: Mon, 20 Feb 2017 13:40:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170220165204.1980-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wiLNJ4jc0fnR0NOo38wkGgsoaRHfp8JJ3"
Subject: Re: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wiLNJ4jc0fnR0NOo38wkGgsoaRHfp8JJ3
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
Message-ID: <9ae46905-78f4-7bb9-8e83-9c7e2f8b982a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
References: <20170220165204.1980-1-stefanha@redhat.com>
In-Reply-To: <20170220165204.1980-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 10:52 AM, Stefan Hajnoczi wrote:
> The disk I/O throttling options have been listed for a long time but
> never explained on the QEMU man page.
>=20
> Suggested-by: Nini Gu <ngu@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-options.hx | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5633d39..b2254cc 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -587,6 +587,31 @@ file sectors into the image file.
>  conversion of plain zero writes by the OS to driver specific optimized=

>  zero write commands. You may even choose "unmap" if @var{discard} is s=
et
>  to "unmap" to allow a zero write to be converted to an UNMAP operation=
=2E
> +@item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
> +Specify bandwidth throttling limits in bytes per second, either for al=
l request
> +types or for reads or writes only.  Values must be larger than the max=
imum
> +request size to avoid timeouts or hangs in the guest.  At minimum use =
2 MB/s

s/At minimum/At a minimum,/

With that tweak,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wiLNJ4jc0fnR0NOo38wkGgsoaRHfp8JJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0YlAAoJEKeha0olJ0NqmPAIAIaQPWoF22mfVFHqfpWRW38H
4UCTFtPvLvwfIj9AcRhmRiEbJy8g5GG3o8oznt7Ja+DOWS7MHhD7f5qM0N+teeeK
0KQ4liFXPz/TApo3S54fvHPveo/eOSEUTxYd5BrRmvuqDgAU/8KgvKEV3Ua382AG
ZqbWKf4aAqn7PM/VjX1hKdSHUkKIgIz8I7ePxflkUNjunENAGKuKNBVW3ukCTVwY
e/7CCre8sxj0zQArFyEMJJUrNfzAMGJWLh8iPr9ffPAPDlBiNCVgW9DKc+agCMQu
Nr8TdihbJHAHbvMG4tg4jwcc4nRgNILxUCn6l52lr32VTyXdLMgMVjXsFrennSI=
=eWC+
-----END PGP SIGNATURE-----

--wiLNJ4jc0fnR0NOo38wkGgsoaRHfp8JJ3--
