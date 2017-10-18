Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pic-0001gb-Df
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4piY-0001Xr-Bm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e4piY-0001XJ-2F
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:53:10 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-3-git-send-email-imammedo@redhat.com>
	<20171018032732.GO2776@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb54a695-4a15-c6fc-f7f5-c9038c1af2de@redhat.com>
Date: Wed, 18 Oct 2017 09:53:06 -0500
MIME-Version: 1.0
In-Reply-To: <20171018032732.GO2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qdE2Mxon3JVvncH7VbMgcDpiT5UVTuf4o"
Subject: Re: [Qemu-devel] [RFC 2/6] numa: split out NumaOptions parsing into
 parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qdE2Mxon3JVvncH7VbMgcDpiT5UVTuf4o
From: Eric Blake <eblake@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ehabkost@redhat.com,
 pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 cohuck@redhat.com
Message-ID: <cb54a695-4a15-c6fc-f7f5-c9038c1af2de@redhat.com>
Subject: Re: [RFC 2/6] numa: split out NumaOptions parsing into
 parse_NumaOptions()
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
 <1508170976-96869-3-git-send-email-imammedo@redhat.com>
 <20171018032732.GO2776@umbus.fritz.box>
In-Reply-To: <20171018032732.GO2776@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 10:27 PM, David Gibson wrote:
> On Mon, Oct 16, 2017 at 06:22:52PM +0200, Igor Mammedov wrote:
>> it will allow to reuse parse_NumaOptions() for parsing
>> configuration commands received via QMP interface
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>=20
> Revieed-by: David Gibson <david@gibson.dropbear.id.au>

Does it still count as R-b with the typo? :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qdE2Mxon3JVvncH7VbMgcDpiT5UVTuf4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnatIACgkQp6FrSiUn
Q2rc7Af/Y+tRx2Sg8z0gs4+xiEXSasaI2c3oCja/LJvScazJfo7f7WenkW2QkyXO
2rPsNtz8Q5mFbVHzcY17L92kB87uEWmTOKtQGJU0UD97Vol+ROjhj5D5FNusqyd4
o5KO5X7bRFgFKKfDNRs+0LPYXaLjHaL9Ib9LZYqRglEgyU1Oimi1bzffzJvCqHyI
Ren9qnTbtcEVG+m6THQgUsPNhZLqKyplgttMAFpE1fETn8tKNlcDPCLuJfUVp2/S
HO7tbjfR8iP9vfp7WPQK8YJpIFaiwgouQk0m8d1UhMpok+qpJvaosXOyQFdfFoxA
+jSxSsUaIq3DMEtcbm1Uo/5pBwOpAA==
=HtqM
-----END PGP SIGNATURE-----

--qdE2Mxon3JVvncH7VbMgcDpiT5UVTuf4o--
