Received: from eggs.gnu.org ([2001:4830:134:3::10]:34819)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dniQ8-00038N-Ev
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dniQ5-0007HC-7w
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:39:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:51138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dniQ4-0007Go-TQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:39:21 -0400
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-5-famz@redhat.com>
	<e5d02327-dcfe-5af9-c036-bd238d1440e6@amsat.org>
	<20170901083938.GD4330@lemon.lan> <20170901092111.GC31680@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f4442a83-2126-224a-ba4e-c6fedc20e984@gmx.com>
Date: Fri, 1 Sep 2017 11:29:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170901092111.GC31680@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9jFqqdVaEte2LqSduujgdS8DdLEnIquD3"
Subject: Re: [Qemu-devel] [PATCH v5 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9jFqqdVaEte2LqSduujgdS8DdLEnIquD3
From: Kamil Rytarowski <n54@gmx.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <f4442a83-2126-224a-ba4e-c6fedc20e984@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/12] tests: Add vm test lib
References: <20170831064302.14427-1-famz@redhat.com>
 <20170831064302.14427-5-famz@redhat.com>
 <e5d02327-dcfe-5af9-c036-bd238d1440e6@amsat.org>
 <20170901083938.GD4330@lemon.lan> <20170901092111.GC31680@redhat.com>
In-Reply-To: <20170901092111.GC31680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.09.2017 11:21, Daniel P. Berrange wrote:
> On Fri, Sep 01, 2017 at 04:39:38PM +0800, Fam Zheng wrote:
>> On Thu, 08/31 12:59, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Fam,
>>>
>>> On 08/31/2017 03:42 AM, Fam Zheng wrote:
>>>> This is the common code to implement a "VM test" to
>>>>
>>>>    1) Download and initialize a pre-defined VM that has necessary
>>>>    dependencies to build QEMU and SSH access.
>>>
>>> Looking at this project:
>>>
>>> https://www.packer.io/docs/builders/qemu.html
>>>
>>> Maybe we can have another CI that prepare/upload those images (reprod=
ucible,
>>> easy upgrade version...), and document the build process in the JSON =
instead
>>> of the wiki (so the doc is up to date).
>>
>> Thanks for the pointer, looks interesting. The json files can be commi=
tted to
>> QEMU if we go that way. Though I'm not very convinced by the "screen c=
apture"
>> style automation that is used by the *BSD user recipes I've found with=
 google.
>> It would be good if *BSD can have cloud-init or kickstart -alike autom=
ation,
>> with those we don't even need Packer.
>=20
> FreeBSD at least supports automation of its installer. eg=20
>=20
>   https://github.com/clalancette/oz/blob/master/oz/FreeBSD.py
>=20
> Haven't found info on other *BSDs though.
>=20
> Regards,
> Daniel
>=20


NetBSD installer does not have scripting as far as I can say, but I
think it's waste of time and resources to do it for qemu CI. A single
image with BSD images will be supported for at least few years for
FreeBSD and NetBSD and one year for OpenBSD.


--9jFqqdVaEte2LqSduujgdS8DdLEnIquD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZqShnAAoJEEuzCOmwLnZsvBMP/3Nd8U1sQsEqUReGQ4nsk87j
2bCW4sg2vrtsaLc4aT4QwJyEAxwLBfB0gYA9TbtE0Dr3WVn61oC7kEM68m2+acas
w36gZYOTmbe2/yaW3xHgTRXr3wkFjwRK1SO0XmZX6g9xc3NIUadbdzVKB9PpbQIm
RlGZHQu2EdAmIw1XyxKpjE3cNHt3RVPuRYH54crdY2S86/XAJg5EwEYRDCMZ7F+I
W1dybXySIQIiusvC8DPKLktpNy7cLULiKSx4xtRLAkq2dBPyeVbuzGqhLx7e1IfU
6Wp03CXellTx7Ql9JwRz96+2ExOSflJvZrr0fFFS98FjdcX2CQdiS7pxoK0/4CJo
qBpMS379UlGpaKng0Y/ql1GNqQ1vsT3g/geMGKKR9jbzhqQDDBWJ53B4G/7A2KM/
m/Mc3emFCJQfItWpZXauy7pb58JrQXBGK8iolOO7sw9EcDIo5oBPHIPcuyYp6PTv
Z3yKKiqopVvTIhSYo9d6zH+p4jElZP6ksfrskoorpufLOzTXGppfgvyR94l6uY3M
P+69v5U9Y/xkab2z/ZzgePcmx7Z+nrQtf77a75/Nr87/45b8aZ1zD7lhLmnWXPP2
E7TstzHC9oOmWWihu4z7Dmc/6vz6F4pXAffM1LdRwWMZgjvzR4I4hepuUzJ1aXro
v8aG0hTprSY9ds4NrWG7
=KYxY
-----END PGP SIGNATURE-----

--9jFqqdVaEte2LqSduujgdS8DdLEnIquD3--
