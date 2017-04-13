Received: from eggs.gnu.org ([2001:4830:134:3::10]:60059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyihy-0005J7-Cb
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyihx-0007rk-FH
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:39:02 -0400
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
Date: Thu, 13 Apr 2017 12:38:50 -0500
MIME-Version: 1.0
In-Reply-To: <1492104214-29994-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2CprCi1a12OEqbF8xSF809XKiTLr2hawC"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter HMP readline
 escape characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2CprCi1a12OEqbF8xSF809XKiTLr2hawC
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Message-ID: <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
Subject: Re: [PATCH 2/3] qemu-iotests: Filter HMP readline escape characters
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
 <1492104214-29994-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492104214-29994-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> The only thing the escape characters achieve is making the reference
> output unreadable and lines that are potentially so long that git
> doesn't want to put them into an email any more. Let's filter them out.=


Hear! Hear!

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/028.out       | 2 +-
>  tests/qemu-iotests/130.out       | 4 ++--
>  tests/qemu-iotests/common.filter | 7 +++++++
>  tests/qemu-iotests/common.qemu   | 4 ++--
>  4 files changed, 12 insertions(+), 5 deletions(-)

Yay!  But I think you're incomplete:

What about 051, 068, 142, and 145?

(found by:
 git grep -l $'\e' tests/qemu-iotests/*.out
using bash as the shell)


> +++ b/tests/qemu-iotests/common.filter
> @@ -86,6 +86,13 @@ _filter_qmp()
>          -e '    QMP_VERSION'
>  }
> =20
> +# readline makes HMP command strings so long that git complains
> +_filter_hmp()
> +{
> +    sed -e 's/(qemu).*\o33\[D/(qemu) /g' \

\oNN is a GNU sed-ism, as far as I can tell.  Is it portable to our
BSD/MacOS builds?

> +        -e 's/\o33\[K//g'
> +}


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2CprCi1a12OEqbF8xSF809XKiTLr2hawC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY77eqAAoJEKeha0olJ0NqaHgH/jxf81t22UFRj7K7vn0k/5Z3
qSTDGvNopzyZo4V408bkQh4Yha8kdSdGe4ntvi9LMowZj0NK+hSLzmZs2etRYmi5
lulo8wxB92DUNJN/+NqeEclqNsoMkJ1dcVOikwUih1lQQHOtKFxUhBJ45vwPJqnY
kP5GdgYTpMDnYBQ6krHRv9LHoTqxZ9lkROnWV2/kzfT2EKZAGcnrdOpRC/OrZ29m
GIaRa+pp33aivP9xOt8F0fY+mLYJer4jDU7U3d7ROMFwM+CV3VBjlBA5cWDLo0bh
87HUZIINeMxyDYySKkSDujsjkU8KrWgW2nV264DrUqqtBA3tFOCdZS1Hf+vtZ+A=
=kEZP
-----END PGP SIGNATURE-----

--2CprCi1a12OEqbF8xSF809XKiTLr2hawC--
