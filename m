Received: from eggs.gnu.org ([209.51.188.92]:57165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8TX-0000ix-S0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8TX-0007d4-2y
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:53:59 -0500
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<3f708207-2172-3c09-e32b-8267e1be9fc1@redhat.com>
	<0a20041f-e5b2-49d5-3f06-31d855d11fcb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1be61aa6-c6ad-ac25-8a3f-37a7b48f04da@redhat.com>
Date: Fri, 8 Feb 2019 09:53:54 -0600
MIME-Version: 1.0
In-Reply-To: <0a20041f-e5b2-49d5-3f06-31d855d11fcb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kWbdieXibtHUhDd6zNV8BV5ld0ruhqlFZ"
Subject: Re: [Qemu-devel] [PATCH v14 0/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kWbdieXibtHUhDd6zNV8BV5ld0ruhqlFZ
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev
 <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1be61aa6-c6ad-ac25-8a3f-37a7b48f04da@redhat.com>
Subject: Re: [PATCH v14 0/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3f708207-2172-3c09-e32b-8267e1be9fc1@redhat.com>
 <0a20041f-e5b2-49d5-3f06-31d855d11fcb@virtuozzo.com>
In-Reply-To: <0a20041f-e5b2-49d5-3f06-31d855d11fcb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 9:37 AM, Andrey Shinkevich wrote:
>=20
>=20
> On 08/02/2019 18:25, Eric Blake wrote:
>> On 2/8/19 9:06 AM, Andrey Shinkevich wrote:
>>> v14:
>>> The test 242 was amended to be safer against changes in the bitmap al=
location
>>> algorithm because the bitmap directory is reallocated on VM shutdown.=

>>> Unfortunately, an empty line at the end of the benchmark file 242.out=
 persists.
>>
>> Easy solution: in 242, add an extra log("Test complete") or similar
>> after the output that produces the blank line, then 242.out will no
>> longer have a trailing blank line.
>>
> Thank you, Eric. It is going to be version 15.

If that's the only change, then no need to post v15; you can check what
I'm preparing to include in Monday's pull request:

https://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kWbdieXibtHUhDd6zNV8BV5ld0ruhqlFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxdphIACgkQp6FrSiUn
Q2pxpAf7BtVXkB8ft/cphMKPO1y5QbnbkDFN2c2YhVUIPCEtqQUii1rEoPQECEiF
IEjOTzt0qrLUdUeu4y6Me3msFnz7pLwNLuxmfBoM32FD7GUPYXFIGHVzkCzy0cgL
S6YJyt+botnSXGu3ZFAcdkmA9MnpkKJduyUkKh+N/E/iAvSIPTVIOY4uIfwabfOn
oLJntzTdXgGFEIVlTQJM6PlpAIRnYgdu8t0iodhr11+NcUHUDLzg/6CP2w1sE1IU
GQIziaiA8s/sz+cj5ewhjvhtVAfvsy4u3iy8BHg+0VFCPuwC4RSZOfoXEz9/Zr5C
mS+xW1hOyzZ0G3gEtps55URQFQAFhw==
=kE3O
-----END PGP SIGNATURE-----

--kWbdieXibtHUhDd6zNV8BV5ld0ruhqlFZ--
