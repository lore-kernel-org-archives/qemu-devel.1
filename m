Received: from eggs.gnu.org ([2001:4830:134:3::10]:36294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cePPC-0008WG-KP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cePP8-0000bS-44
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:59:42 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d80521c7-f548-7ec5-0860-e654125da113@redhat.com>
Date: Thu, 16 Feb 2017 10:59:35 -0600
MIME-Version: 1.0
In-Reply-To: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7tK3BcG49XM9tLk5bvaHECPTLGfdtrp3q"
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tK3BcG49XM9tLk5bvaHECPTLGfdtrp3q
From: Eric Blake <eblake@redhat.com>
To: Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Message-ID: <d80521c7-f548-7ec5-0860-e654125da113@redhat.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
In-Reply-To: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 10:30 AM, Chad Joan wrote:
> Hello,
>=20
> This is a one-line patch to the configure script that will allow QEMU t=
o be
> built on musl-libc based Linux systems.  This problem is only noticeabl=
e
> when QEMU is built with --enable-curses.
>=20
> Detailed reading material if you want to know where this came from:
> https://bugs.gentoo.org/show_bug.cgi?id=3D609364
>=20
> Hope that helps!
> - Chad
>=20
>=20
> qemu-2.8.0-musl-ncurses.patch
>=20


Thanks for the patch.  However, it is not in the usual format (we prefer
'git send-email's inline format, rather than attachements), and is
missing a Signed-off-by: designation, so it cannot be applied without
that being fixed first.  More information at:

http://wiki.qemu-project.org/Contribute/SubmitAPatch

>=20
> diff --git configure configure
> index 1c9655e..9f83176 100755
> --- configure
> +++ configure
> @@ -682,6 +682,7 @@ Haiku)
>    vhost_net=3D"yes"
>    vhost_scsi=3D"yes"
>    vhost_vsock=3D"yes"
> +  QEMU_CFLAGS=3D"-D_XOPEN_SOURCE=3D500 $QEMU_CFLAGS"
>    QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers=
 $QEMU_INCLUDES"
>  ;;
>  esac
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7tK3BcG49XM9tLk5bvaHECPTLGfdtrp3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpdp3AAoJEKeha0olJ0Nqu4gH/iqjD7G2aca0/5eCnV8PdKIk
eofVcU3sUIyLw70JBmEhg4Ach9BfjWTZ+45MI+3mR8fadGKOAG0ZelhMtmG1b0KY
29Uu8YPfYTfFAUEHYIKltm2X4qblhsU9wzYR9EBg1Uy/41VQFK6leV0Xe4qcd1OW
w/fkatfpl4+k/6a01jgbok7nBZKFJGNhbpe4iYeYM9SyX3d1Hs1Rg3JtLeZnQ7eo
a7iFxGzexxdbKmTeqOt5R6a1cUYli8KZp5Go+FzfVXucDO+sBKRi8/7nAoj5m+dv
Ubt4rommwkiXycnzzLse0fyaZNBXqka1jpmddSr65i+bIOg3qw4rO5yqY38P2BI=
=swEo
-----END PGP SIGNATURE-----

--7tK3BcG49XM9tLk5bvaHECPTLGfdtrp3q--
