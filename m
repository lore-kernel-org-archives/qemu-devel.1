Received: from eggs.gnu.org ([2001:4830:134:3::10]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsmU-0001yI-LE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsmT-0003U4-P8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:31:42 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-10-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a00e1720-ff79-c294-ec22-a66367a4afcd@redhat.com>
Date: Tue, 12 Sep 2017 16:31:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-10-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AptGcFJCMMPeb2KMt172ROVSrULESIVvT"
Subject: Re: [Qemu-devel] [PATCH 09/10] qemu-iotests: get rid of $iam
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AptGcFJCMMPeb2KMt172ROVSrULESIVvT
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a00e1720-ff79-c294-ec22-a66367a4afcd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] qemu-iotests: get rid of $iam
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-10-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> The variable is almost unused, and one of the two uses is actually
> uninitialized.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check     | 5 +----
>  tests/qemu-iotests/common.rc | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AptGcFJCMMPeb2KMt172ROVSrULESIVvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4UjQACgkQp6FrSiUn
Q2rOUgf/dlPB15OZv+pF9qYyHlmw6U5joIRxyfsFLO/oGeaZtWBl8kRcVA02foag
DPR1owrjLHlLJ/Y8Jhj0MtIjf3KNmxaV3jOsBRDQHaHgtRNjFqddbCcnc38x7FHA
SlGPpF2CDKckJJ32aUG4isH1BuRyUxajoFQXn3QnCdlDWW1HbiBv+3NAMUkjp4Vr
qQx36oxlY4AK4kEY4rPWLB0mwXMSAC70yoh9kaK10C7XQ8w8Lx6r/JoC0i6Xhhm4
/7jfiN2TY+5a1A+APVsItJboP2HAZQckk0UVQxW0V9lOkqUUoajUsdPL7yReWlFs
Yt9ZmcE+1V823nTMkjt+6SOIg6piPA==
=ie1J
-----END PGP SIGNATURE-----

--AptGcFJCMMPeb2KMt172ROVSrULESIVvT--
