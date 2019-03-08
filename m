Received: from eggs.gnu.org ([209.51.188.92]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2MTt-0007C6-4m
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2MTs-00050D-Fe
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:52:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h2MTs-0004zW-4o
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:52:36 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
	<150efd5f-dea0-93bd-c74c-6d012f4ab7d1@redhat.com>
	<d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
	<6bd609b0-15e2-6a9e-2639-7904db417c0f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad46133c-d49a-32c8-b3e4-502df136abdc@redhat.com>
Date: Fri, 8 Mar 2019 14:52:32 -0600
MIME-Version: 1.0
In-Reply-To: <6bd609b0-15e2-6a9e-2639-7904db417c0f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ei5gCp0txepSf2kzHrnqdlKVSYfkVoAO4"
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ei5gCp0txepSf2kzHrnqdlKVSYfkVoAO4
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <ad46133c-d49a-32c8-b3e4-502df136abdc@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion, excluding ARM and
 MIPS
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
 <150efd5f-dea0-93bd-c74c-6d012f4ab7d1@redhat.com>
 <d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
 <6bd609b0-15e2-6a9e-2639-7904db417c0f@redhat.com>
In-Reply-To: <6bd609b0-15e2-6a9e-2639-7904db417c0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 4:12 AM, Thomas Huth wrote:
> On 05/03/2019 21.08, Eric Blake wrote:
> [...]
>> 'make distclean' is a heavy hammer, is there anything smaller in scope=

>> that will fix the problem without nuking everything, such as a strateg=
ic
>> touch or rm of one particular file?
>=20
> Try this in the top-level folder of your build directory:
>=20
>  rm *.mak.d

Worked here, thanks!

>=20
> ... not sure whether we can somehow integrate that into the Makefile
> magic, though...

I'm not sure either, nor did I want to spend time today trying.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Ei5gCp0txepSf2kzHrnqdlKVSYfkVoAO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyC1hAACgkQp6FrSiUn
Q2qb8Af+OFLuDGyiWTON6dWI8RDUevVGjrQlor0MWgG8Ii7YMhcXzKcNNBQ2vEHZ
rDo84pUcr/+28Sy2a7eAeqyzqwIzGNYJxWwUE8iYqXMPHcmkxMagW48FGXlu0PDO
MU3dLxpxWX2s0xAWiX0NjERaCcPQEYBssDlFBccol3LIthp4kj3x5mA+PkI+acNL
3aPRbe49Wu9U6DKAFxUafMtSNlLzPrH83Zt9DhLuRby9LUCRAVDDJHFpxdJPxKZm
oS7eeqm1zEQAgfJpfX+9zQ2z+pAURLZ9cm1Sl6z47S5rbAg0qHz9fhF90mEipbt9
tz2ALt/5s2LHb7xSEwYBoRZP9wvbnw==
=5p+P
-----END PGP SIGNATURE-----

--Ei5gCp0txepSf2kzHrnqdlKVSYfkVoAO4--
