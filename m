Received: from eggs.gnu.org ([2001:4830:134:3::10]:49488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVd0-00016J-Al
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVcv-0007JT-PE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:57:10 -0400
References: <20170707154646.22230-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <badd5084-8374-46e9-2e28-f973e7922e3f@redhat.com>
Date: Fri, 7 Jul 2017 10:56:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170707154646.22230-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4AD5WsCcattd17hODXx44qmo20r7q6jvw"
Subject: Re: [Qemu-devel] [PATCH] hxtool: remove dead -q option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4AD5WsCcattd17hODXx44qmo20r7q6jvw
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <badd5084-8374-46e9-2e28-f973e7922e3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hxtool: remove dead -q option
References: <20170707154646.22230-1-pbonzini@redhat.com>
In-Reply-To: <20170707154646.22230-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:46 AM, Paolo Bonzini wrote:
> This was used to extract .txt documentation for QMP.  This was
> changed to use the QAPI schema instead, so zap it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/hxtool | 46 +---------------------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)

Fun diffstat!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4AD5WsCcattd17hODXx44qmo20r7q6jvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX69LAAoJEKeha0olJ0NqZOsH/jbhOknXN5CPJHpPvhod83Bp
LCQF9hT2EwSAyorcg7BgtVMgLEsRndYqYG3YCBB9bqcgFRtTsEHJpC0NxDgLL699
uoPDygaQRBvB1z1kreog3Yop1SVxXF3SZTQ9uYPNDuOvT8GTYm/1RXKLCe25EzrT
fnkAohwDDqOfSnxOjj5Mnfu9pEUWu8iBYAYvGwZngInRgLPBU2dP3vVf76LhXw8F
ksFEC8JJvQGLBpNN+j7E3dUvXdqjlpOi49HIneOFOK+5ydaBH9kuya8RSu+elNnT
UEO4PSIPrjkAlyJeIRr2TWS4JFJ46uR7b7pDryF3iICbPpFlsAY+2ge/cWka9dU=
=7av+
-----END PGP SIGNATURE-----

--4AD5WsCcattd17hODXx44qmo20r7q6jvw--
