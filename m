Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3imv-00017Y-6E
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3imu-0002nd-CR
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:44:49 -0400
References: <1493270454-1448-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1fdc5e2-dc85-6ce3-77f3-236c0077e7c5@redhat.com>
Date: Thu, 27 Apr 2017 07:44:38 -0500
MIME-Version: 1.0
In-Reply-To: <1493270454-1448-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tRmvwvaL3cKlSAMIjh2AXXK8O0oOvgSAD"
Subject: Re: [Qemu-devel] [PATCH v3] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tRmvwvaL3cKlSAMIjh2AXXK8O0oOvgSAD
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1fdc5e2-dc85-6ce3-77f3-236c0077e7c5@redhat.com>
Subject: Re: [PATCH v3] Issue a deprecation warning if the user specifies the
 "-hdachs" option.
References: <1493270454-1448-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1493270454-1448-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 12:20 AM, Thomas Huth wrote:
> If the user needs to specify the disk geometry, the corresponding
> parameters of the "-device ide-hd" option should be used instead.
> "-hdachs" is considered as deprecated and might be removed soon.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3:
>  - Recommend to use the parameters of -device ide-hd instead
>  - Also add the deprecation warning to the documentation
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tRmvwvaL3cKlSAMIjh2AXXK8O0oOvgSAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAee2AAoJEKeha0olJ0NqBNMH/3BUHCsJoYT+ywK0zgU7+p2d
NKh3PVVfBjKKzU22WDj4W6DApB1G8Ju93b365cu2+4Mht/2LxQSqL9ug0YUfJ3Ue
hW4X0JyAHQX1vMUyTtiITnEKo87v/4VEXXNXsQoi1jR4IDV4BHsFNGv18SZbyDSW
4GPigowLRxazkhwFt0bWMRA+6yhc9hfMCXXNANil5OSbjKljUXCJeWbwqz7NUNHA
5cjoa+2mmNiaI77aaN0guL2KGCyt3zpfI6YI9ZqiC4utu+dN1Y2ADQeS2VonXPJ1
MfG30nyTLwFNX2fTz9DALYm9hCFQsaKyrNS7YvxO+PdA7mco7aLpKbGcpTQe2f8=
=5ZGe
-----END PGP SIGNATURE-----

--tRmvwvaL3cKlSAMIjh2AXXK8O0oOvgSAD--
