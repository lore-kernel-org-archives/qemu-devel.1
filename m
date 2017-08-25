Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlLIe-0007oT-2z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 16:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlLId-0007Gs-4Y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 16:33:52 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
	<CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
	<8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bd56c2a-7361-370d-05d7-2aad80ae0470@redhat.com>
Date: Fri, 25 Aug 2017 22:33:36 +0200
MIME-Version: 1.0
In-Reply-To: <8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J8PmJd603ebjsmvcWrQsbkgOIqEU9vLdn"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] nbd-client: enter
 read_reply_co during init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J8PmJd603ebjsmvcWrQsbkgOIqEU9vLdn
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <1bd56c2a-7361-370d-05d7-2aad80ae0470@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/3] nbd-client: enter read_reply_co during
 init to avoid crash
References: <20170824153345.2244-1-stefanha@redhat.com>
 <440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
 <CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
 <8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
In-Reply-To: <8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/08/2017 17:08, Eric Blake wrote:
> On 08/24/2017 11:05 AM, Stefan Hajnoczi wrote:
>> On Thu, Aug 24, 2017 at 4:52 PM, Eric Blake <eblake@redhat.com> wrote:=

>>> On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
>>>> See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests co=
verage.
>>>>
>>>> This is a rare crash that we'll probably only see in testing.  It on=
ly seems to
>>>> happen with UNIX domain sockets.
>>>
>>> Rare enough that I don't think it is 2.10-rc4 material.  I'll review,=

>>> and if I don't find anything needing a respin, I'll add it to my NBD
>>> queue for 2.11.
>>
>> Great.  This is 2.11 material.
>=20
> Hmm - I wonder if https://bugs.launchpad.net/qemu/+bug/1712818 is
> related to this.  I really don't want to delay 2.10 further (downstream=

> distros can backport fixes) - but comment 3 stating that crashes are
> less frequent but still possible with -rc4 is not good.

Well, I won't be able to review or write the patch, so I think it's
better to wait.

Paolo


--J8PmJd603ebjsmvcWrQsbkgOIqEU9vLdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmgiaAACgkQv/vSX3jH
roO5gAf+M264qV0fj9MjrnSfw986CwTeOSqPPMExdzhXQ4b5VVMSPSM4jnvWbrBb
t+M4OxA4QsAh0iOr3Yx9mJe4nN2EV8qKggsR8K5KnoGb0Z+pUdrcBEv4eHmW0NDl
PT3db3B00nBMH018uvo1Smeiuosie7UxVdTAaBM5cO+t44Rpka0tXXXbj2nJWifj
eCjKsQ8Ez2eIbvx5jCbqdvk1ZDxouuAQYY0wYtcQKPmJY/7Jfplx0QwIZJxqyExX
uaS5juABG0vOdm/iq0hAv/beewWXE98KB2qWtMXEnueNE5lvHOROuFQ95/N10NuW
rhALDPuN2ozF8R6hINPjEIBdwPwbBw==
=vRkP
-----END PGP SIGNATURE-----

--J8PmJd603ebjsmvcWrQsbkgOIqEU9vLdn--
