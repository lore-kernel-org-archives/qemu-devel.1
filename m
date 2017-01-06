Received: from eggs.gnu.org ([2001:4830:134:3::10]:60220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXkK-00068E-GJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXkG-0006lt-FS
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:52:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXkE-0006kR-KK
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:52:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFED19D786
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:51:58 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b87cd0c-a676-5fa8-9aa5-dd0636c8c46c@redhat.com>
Date: Fri, 6 Jan 2017 10:51:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BGoqUN8Ng73jMRHlIATCTRgLxNRSdnqia"
Subject: Re: [Qemu-devel] [PATCH 02/20] qemu-options: stdio is available on
 win32
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
--BGoqUN8Ng73jMRHlIATCTRgLxNRSdnqia
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <5b87cd0c-a676-5fa8-9aa5-dd0636c8c46c@redhat.com>
Subject: Re: [PATCH 02/20] qemu-options: stdio is available on win32
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Available since commit db418a0a7ef5887ea0f3d167584e6f500bb0c4c5
> (October 2011, qemu 1.0)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-options.hx | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(Isn't git history fun!)

>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c534a2f7f9..6ee8a8adc3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2431,8 +2431,6 @@ Connect to standard input and standard output of =
the QEMU process.
>  exiting QEMU with the key sequence @key{Control-c}. This option is ena=
bled by
>  default, use @option{signal=3Doff} to disable it.
> =20
> -@option{stdio} is not available on Windows hosts.
> -
>  @item -chardev braille ,id=3D@var{id}
> =20
>  Connect to a local BrlAPI server. @option{braille} does not take any o=
ptions.
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BGoqUN8Ng73jMRHlIATCTRgLxNRSdnqia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8ssAAoJEKeha0olJ0NquiMH/1xYLMOsw/qpJI6y1rSE7MUD
TPb9+P0/qsKFNutkSVtj27AK2xaUzM8w89AVdbP9BWYtv3tTOnV4tuZskY3f0t/x
EPKyU1qTLTpW3LBTdemvjT+hHY2b7Fzx+Nn109Znh/HjI4mdU5Lwfs+aY7V8KzfD
tXclAPhoC13IIL1IruYl55ylaZuGCrNMuR8Dic6JueB7rpOCCHUdOzrP+aTd0FkQ
F3+WQEQwBXjSbI4HOO+vIV7cQ0cpcrmenGJwEYBAGzqGiWn7L4Ji+5VJtL9GuxZ2
U/T8bsewY4Apg5NIe95sCtxqYEM376OCIqB14YdCjXwLIpK5JDM9LTLr/AAVf2c=
=zR8Y
-----END PGP SIGNATURE-----

--BGoqUN8Ng73jMRHlIATCTRgLxNRSdnqia--
