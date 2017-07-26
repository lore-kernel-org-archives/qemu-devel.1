Received: from eggs.gnu.org ([2001:4830:134:3::10]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUDg-0002N1-Vy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUDc-0004kt-UO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daUDc-0004kD-KQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:51:48 -0400
References: <20170726214010.420-1-f4bug@amsat.org>
	<20170726214010.420-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f8a9fad-0c14-54ad-4529-2c07d29804ed@redhat.com>
Date: Wed, 26 Jul 2017 16:51:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170726214010.420-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3iOSpc9oOSU25WGVPDLvRbR7TqOX9xUCd"
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: remember the user to run
 'git submodule' command in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3iOSpc9oOSU25WGVPDLvRbR7TqOX9xUCd
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 John Arbuckle <programmingkidx@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela
 <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <6f8a9fad-0c14-54ad-4529-2c07d29804ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: remember the user to run 'git
 submodule' command in source dir
References: <20170726214010.420-1-f4bug@amsat.org>
 <20170726214010.420-2-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 04:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:

In the subject: s/remember/remind/

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index f8b1d014d7..063de32773 100755
> --- a/configure
> +++ b/configure
> @@ -502,6 +502,7 @@ if test -f "./configure"; then
>      pwd_is_source_path=3D"y"
>  else
>      pwd_is_source_path=3D"n"
> +    git_submodule_path_info=3D"(in ${source_path})"
>  fi
> =20
>  check_define() {
> @@ -3313,7 +3314,7 @@ else
>      error_exit "pixman >=3D 0.21.8 not present. Your options:" \
>          "  (1) Preferred: Install the pixman devel package (any recent=
" \
>          "      distro should have packages as Xorg needs pixman too)."=
 \
> -        "  (2) Fetch the pixman submodule, using:" \
> +        "  (2) Fetch the pixman submodule, using: $git_submodule_path_=
info" \
>          "      git submodule update --init pixman"

Pre-patch (or in-tree build), we're merely giving the user something
they can directly paste into their terminal.  But "(in /path/to/xyz)" is
not directly useful.  Can we spell it:

(2) Fetch the pixman submodule, using:
    ( cd $source_path &&
      git submodule update --init pixman
    )

for even easier copy-and-paste on the user's part?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3iOSpc9oOSU25WGVPDLvRbR7TqOX9xUCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5DvAACgkQp6FrSiUn
Q2rQ1gf8D7SMtjSXxkcJqlaihDbA2BG0Vc328thrQ3CM+eMCFqVAlGbgReCKP14u
x929n8W9yc+lp34DF+Rd47S8MgSocr31osyiXbagfMNYqls/5HcTYUXd/o3uA5jr
u3TqXWhyO07UYGDmbjB0VR6WgXplgwyakPLWZk0KnzXlSf23mufxzDsbmWk1vPju
PRO48R6UQe9VXLrx+DfOkCTo9k4Iuuy6lREMzJUwNe74Vf829iHTHgD5rwMcLAgz
j9+blf2ABn5DnqxKE9CQaf4oYTJjjGVCfw+beTZqVTTILn3sjAfzU9gyA9z9Yv5U
5UWlgZCajitKKCLGW3Fid5El6p+nVw==
=3OYT
-----END PGP SIGNATURE-----

--3iOSpc9oOSU25WGVPDLvRbR7TqOX9xUCd--
