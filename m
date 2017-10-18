Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4oQC-0001gl-VI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4oQ8-00059S-VX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e4oQ8-000598-Mc
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:30:04 -0400
References: <20171017153742.10026-1-richard.henderson@linaro.org>
	<20171017153742.10026-10-richard.henderson@linaro.org>
	<1508305702.10073.2.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac10a86b-ba34-3cdb-8b05-d87ed2c2ccb7@redhat.com>
Date: Wed, 18 Oct 2017 08:29:56 -0500
MIME-Version: 1.0
In-Reply-To: <1508305702.10073.2.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lCO8h5XAtgOQrq3wObuD0aIooq1nqXWFX"
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCO8h5XAtgOQrq3wObuD0aIooq1nqXWFX
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Message-ID: <ac10a86b-ba34-3cdb-8b05-d87ed2c2ccb7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
References: <20171017153742.10026-1-richard.henderson@linaro.org>
 <20171017153742.10026-10-richard.henderson@linaro.org>
 <1508305702.10073.2.camel@redhat.com>
In-Reply-To: <1508305702.10073.2.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 12:48 AM, Gerd Hoffmann wrote:
>   Hi,
>=20
>> +if [ "$capstone_internal" =3D "yes" ]; then
>> +=C2=A0=C2=A0echo "config-host.h: subdir-capstone" >> $config_host_mak=

>> +fi
>=20
> I think this isn't going to work correctly.  In case both capstone and
> dtc are used we need a single line with the dependencies, i.e.
>=20
>   config-host.h: subdir-dtc subdir-capstone

Make allows the composition of dependencies, as in:

a: b
a: c

It works as long as at most one a: line contains the rule for building
a, and all the other lines just add dependencies.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lCO8h5XAtgOQrq3wObuD0aIooq1nqXWFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnV1QACgkQp6FrSiUn
Q2qSvwf+IQgntgIGn5QWgGp12j6TJG7An/KrGP7CV25jBx3ZB0kLpjw96X5MK0Wt
WmCB5LSBolObEnaSkTQJ28m3Cs3mNbC7sS5lBK6WNgU/l2sJ1erj/ZApbjDST6Ak
TA4ZGx/VPPbhNIWOuuYKaglB3/kTpyNOMSCjaINjJY4Un2/rUM5o9fS58qRt7CDe
8ndrZWV93yZS196v2c+2533+lXeSejQQWln5OUqZ2+diLfoVTZKcHzzYDFZsPq/w
2eMx4POON3ePbf0Ses2UNB1SiAJQL4zLhyxZw24s9crnu9DKDKqLsx+PrinXXfmL
6Z/chgmLkZJwBTKtD9eiMFW6bWpAVA==
=pvDX
-----END PGP SIGNATURE-----

--lCO8h5XAtgOQrq3wObuD0aIooq1nqXWFX--
