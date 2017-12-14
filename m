Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePVxJ-0004PM-Qe
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePVxD-0004cz-ND
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:01:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
	<CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e414ed3c-8fe1-d1c4-5ea1-70775ae8df92@amsat.org>
Date: Thu, 14 Dec 2017 13:01:35 -0300
MIME-Version: 1.0
In-Reply-To: <CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="4MQwPAb433TVs6QP2iwfRKP3OWtxxTStG"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4MQwPAb433TVs6QP2iwfRKP3OWtxxTStG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Nir Soffer <nirsof@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <e414ed3c-8fe1-d1c4-5ea1-70775ae8df92@amsat.org>
Subject: Re: [Qemu-block] [PATCH 0/6] QTests: use Python to run complex tests
References: <20171213213557.26561-1-f4bug@amsat.org>
 <20171214093907.GA14433@stefanha-x1.localdomain>
 <d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
 <CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
In-Reply-To: <CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nir,

On 12/14/2017 12:39 PM, Nir Soffer wrote:
> On Thu, Dec 14, 2017 at 1:36 PM Paolo Bonzini <pbonzini@redhat.com
[...]
>     > Device qtests are better done in C than Python.=C2=A0 Python is n=
ot good at
>     > binary I/O and porting this to Python 3 will be extra work later
>     (Python
>     > 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>     >
>     > More importantly, we already have libqos in C with a guest memory=

>     > allocator, PCI, and virtio support.=C2=A0 Fragmenting the small a=
mount
>     effort
>     > that goes into device testing will delay libqos reaching critical=

>     mass.
>     > Critical mass is where libqos provides all the infrastructure you=
 need
>     > to set up a device and focus on your actual test instead of machi=
ne,
>     > bus, or device initialization.=C2=A0 Starting a Python device tes=
ting
>     effort
>     > will just lead to duplication and 2 underdeveloped device testing=

>     > frameworks.
>=20
>     I agree that fragmentation is bad.=C2=A0 However, libqos is small (=
about 4k
>     lines of code, maybe 3k in Python).
>=20
>     I also agree that any qtest written in Python should be written in
>     Python 3 from the beginning (in fact we should consider dropping Py=
thon
>     2.x support in 2.12).=C2=A0 Doing so should not make binary I/O muc=
h
>     different than C.
>=20
>=20
> Using python 3 will make it hard to develop and test qemu on RHEL/CentO=
S
> which do not provide python 3 yet.

Restricting it to python 2 also make it hard to develop and test QEMU on
Arch Linux which default come with python 3 ;)

> Doing binary io in python 2 and 3 is the same, there is no need to use
> python 3 for this. The only advantage is not having to backport code
> later from 2 to 3.
>=20
> Nir


--4MQwPAb433TVs6QP2iwfRKP3OWtxxTStG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAloyoF8ACgkQ4+MsLN6t
wN6ubxAAqGavJDKG0FEipUnib2vAi4XJhxjl11T8dfWiNFcZNsN/Qw66BOdYLt7I
8Q7xO0dmIEU+1kt55PLOXK7HZUBwY7MHaHidFaiOXIjM+pjMv22KvYD9SMJsDhnU
ifwMTT1Je58ZJpw0w0fa6/LKmdcCQ+QkKMx8sdwMZHfqb/Mxi1lQlLj9fTagx48d
OvHrUJgaHmEa8nCpGmbNpcC/xT4pcRq3ZoDgoDDbCcJyKk0wch2SyCCyzn/4tfjL
Ic2S476mvpJVeWAgOAw9cRkgEv1hblrq4/0qfBYBgnzGglszfGjQstMfs6Xs3VHt
KWYoZ7d/4oY9DH6+aJeLxsyyOHpw44KSM2QiGlyqHaak1CJRKnL2dAiTCRv+Xo8v
/16M5Zh7VmBqXMdC7UcycWeRyxe903lrsNR2xLiABYSVVXtl3+IJ6xJfarO9EqKg
KtMkFHhOxngffkNl756ZtdiiAfWEkE2SqCEd+R0vBun2GIZshsURmPcb5Z3yKjpz
1k2+Id0Mvj+CtzCxqmXJq+vG7WlmE7uZUCxjxM2R5mrIjKpISUOSbR6xFDKGc+CH
NZqwUGfi+571aPpCCJdUuW+NFV9yakdnHYpxgNaoRRRAVSenmxA5T51dxRTDCHb2
MCsyZksCQnVtmFFbdkn4nGG13dm+piDKL8W1WoPrdnedf0/fT7o=
=WT4D
-----END PGP SIGNATURE-----

--4MQwPAb433TVs6QP2iwfRKP3OWtxxTStG--
