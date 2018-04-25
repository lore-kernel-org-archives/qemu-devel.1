Received: from eggs.gnu.org ([2001:4830:134:3::10]:57008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPmb-00074x-Bg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPmX-0004P9-1l
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:08:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPmW-0004OK-Ru
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:08:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85C68406C744
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 19:08:44 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-4-lersek@redhat.com>
	<5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
	<20180425125446.GJ30024@redhat.com>
	<c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6e96ed4-ab0d-10db-69c9-324fbdad94d5@redhat.com>
Date: Wed, 25 Apr 2018 14:08:41 -0500
MIME-Version: 1.0
In-Reply-To: <c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="28Y488dHSr2xzk89tZtFah8ZZfn9xb3ap"
Subject: Re: [Qemu-devel] [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--28Y488dHSr2xzk89tZtFah8ZZfn9xb3ap
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <a6e96ed4-ab0d-10db-69c9-324fbdad94d5@redhat.com>
Subject: Re: [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-4-lersek@redhat.com>
 <5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
 <20180425125446.GJ30024@redhat.com>
 <c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
In-Reply-To: <c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 02:05 PM, Laszlo Ersek wrote:

>>>> +             'x86_64', 'xtensa', 'xtensaeb' ] }
>>>
>>> x86_64 doesn't match our typical conventions of preferring '-' over '=
_';
>>> also, wikipedia mentions both spellings but under the page name
>>> 'x86-64'.  Is it worth switching that enum constant?
>>>
>>> https://en.wikipedia.org/wiki/X86-64
>>
>> I would not want that - SysEmuTarget is supposed to be correlated with=

>> the qemu-system-$TARGET  binary names and we use qemu-system-x86_64
>> there.
>=20
> Right; also TARGET_NAME is looked up as follows in patch #4, in
> qmp_query_target():
>=20
> +    info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, =
-1,
> +                                 &error_abort);
>=20
> That would fail if we used "x86-64" here.

Then worth a mention in the commit message to make it obvious that our
choice of _ for over-the-wire QMP is intentional.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--28Y488dHSr2xzk89tZtFah8ZZfn9xb3ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0jkACgkQp6FrSiUn
Q2phwAf+PINfDqhQBoKuhp/tZJ7TwbP9h0Mg8l30RCjNmJa+Ya4qdU+rjk8HZDP1
Dzm8DfTy27Fs3KN+JKGFnZn34QajW2G84QQ4ZVPpmze1dgN6CkIStUVQCARdpZpC
eWVoHvN9PegHIX1O19GZaiSBkcLEBv//uPIOp7TQt9A0HiNnekqPXmUxRbNcguni
OW4PgCPocYLjl+Ad2H5oQXVKxoqKAx6ZnIFEtyS4tZLZzzWEy+QSalKUYFs7sNno
NNTAH2UjpLvCHqiPRRQ8R4+xr/81/UnKjN/NdL8agmjwDILush2YRsHjQAMmGO2e
/KYa7P6N25BJNEf0GLuwahX/DLrtzg==
=utI1
-----END PGP SIGNATURE-----

--28Y488dHSr2xzk89tZtFah8ZZfn9xb3ap--
