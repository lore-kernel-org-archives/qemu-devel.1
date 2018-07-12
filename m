Received: from eggs.gnu.org ([2001:4830:134:3::10]:53789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdTje-0000nV-PS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdTjb-0008GR-Nu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:01:46 -0400
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
	<20180711062619.GQ22363@umbus.fritz.box>
	<20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
	<20180712010152.GR22363@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
Date: Thu, 12 Jul 2018 07:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180712010152.GR22363@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xTd90ZFb2dmPvXUnTHluSu16OWeLTc21q"
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries] pseries:
 Update SLOF firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTd90ZFb2dmPvXUnTHluSu16OWeLTc21q
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
Subject: Re: [Qemu-ppc] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
References: <20180702062644.48040-1-aik@ozlabs.ru>
 <20180710122244.7466489f@aik.ozlabs.ibm.com>
 <20180710064248.GM22363@umbus.fritz.box>
 <20180710171453.6e3eee34@aik.ozlabs.ibm.com>
 <20180711062619.GQ22363@umbus.fritz.box>
 <20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
 <20180712010152.GR22363@umbus.fritz.box>
In-Reply-To: <20180712010152.GR22363@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.07.2018 03:01, David Gibson wrote:
> On Wed, Jul 11, 2018 at 08:53:05PM +1000, Alexey Kardashevskiy wrote:
>> On Wed, 11 Jul 2018 16:26:19 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrote:=

>>>> On Tue, 10 Jul 2018 16:42:48 +1000
>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>  =20
>>>>> On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrot=
e: =20
>>>>>> On Mon,  2 Jul 2018 16:26:44 +1000
>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>    =20
>>>>>>> The following changes since commit edb1fb337f65f82fe32b989c4f018e=
fe85c1dddb:
>>>>>>>
>>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)=

>>>>>>>
>>>>>>> are available in the git repository at:
>>>>>>>
>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20180702
>>>>>>>
>>>>>>> for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85=
c1dddb:
>>>>>>>
>>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)=

>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>>
>>>>>>> I just missed a couple of gcc 8.1 fixes and thought I can still s=
queeze
>>>>>>> them before the 3.0  soft freeze.
>>>>>>>
>>>>>>>
>>>>>>> *** Note: this is not for master, this is for pseries   =20
>>>>>>
>>>>>>
>>>>>> Not good for 3.1 either?   =20
>>>>>
>>>>> Ugh.. somehow I missed this SLOF update request, and now we're in 3=
=2E0
>>>>> hard freeze.
>>>>>
>>>>> How bad are the bugs this SLOF update fixes? =20
>>>>
>>>> These only fix gcc 8.1 warnings and runtime errors =3D> not really
>>>> bugfixes so it is not a big deal if they miss 3.0. =20
>>>
>>> Ok, well, if you want to resend the update, I'll queue it for 3.1.
>>
>>
>> It is still on github, why resend?
>=20
> Good point, done.

Won't there be another update in the 3.1 time frame? If yes, this sounds
like wasted space in the repository to me (the firmware blobs are rather
big, and there are no new features in that binary, just fixes for
compiling with GCC 8 ... and people who want to compile SLOF on their
own can use the sources from aik's git tree, too).

 Thomas


--xTd90ZFb2dmPvXUnTHluSu16OWeLTc21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbRuCzAAoJEC7Z13T+cC21rMoP/0Oc4a/HoUVut7HMXR6R8FW5
QXo4hJQTZtsWlkfMJIXf/TbeTyxczlX6HebKDGQx3etImLI+xyM2edqb3rnxlBW+
3egHWu2fa2oQswvleqGxsYcQuW7bJdrQiFXEBbq9LRYyAOOFc+qq4wKYvel7UzHU
SSLSegODG+LMuHBVzPBHe0tabX0ejBSokhe1ugvHnsJhPmWnm7wiVlnud8aCDgZt
XzklqIe84R4VAjZQYpoWnGgybsymHCCpglGPuhiH7jI9SikEg2SfanxSETidQi9E
al3566bf1sTrV+i9557kUgult8YKyt1TbNwReFmvfnKpbetpmO+9pjy4nE0WKU53
K1d8ChC8gWtRpRiRsVt+UjQrYUAc1umwSdSRkEK9dUn4vcf0yampxRhaF3X49WAi
FZ7iywpg2wLfTwoXqs3g6A+K4ix07qfujFib5RGi8hLQo4eUDbLjppm2vmTMnaQR
Cwu1H34CRQoytFBAoiGmGcvQ70bi7v61QHB1v7/QqIdx+iAOstmf6VQzUzQavYNd
Mr6QHX5ZXAWDa4TcgWoOtI3Fdd266jyI8YxeROrvKJCUlfXocYy0kof14aojP4G0
o8L2n8LZEt+1HpQlpB5gxp7OByg18HVqp0B96sgYmr9+50TGXCgrL7Gj5Onl28LU
9r3fZ/lVOtAgoTc2Fr/N
=Y5nX
-----END PGP SIGNATURE-----

--xTd90ZFb2dmPvXUnTHluSu16OWeLTc21q--
