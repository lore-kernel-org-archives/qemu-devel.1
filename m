Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dbxSE-0007k9-4m
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 19:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dbxSA-0003Vg-VI
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 19:16:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:49842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dbxSA-0003VB-K5
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 19:16:54 -0400
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
	<192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
	<CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <3a9c72ee-d36d-8958-a32d-cdeee34f004f@gmx.com>
Date: Mon, 31 Jul 2017 01:07:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5DOqHII6rwFwJKkbsHC1OGWQlVUWI17ME"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Patrick Steinhardt <ps@pks.im>, Alistair Francis <alistair23@gmail.com>, brad@comstyle.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5DOqHII6rwFwJKkbsHC1OGWQlVUWI17ME
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Patrick Steinhardt <ps@pks.im>, Alistair Francis <alistair23@gmail.com>,
 brad@comstyle.com
Message-ID: <3a9c72ee-d36d-8958-a32d-cdeee34f004f@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
 <CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
 <cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
 <20170729135042.GA1139@pks-xps>
 <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
 <192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
 <CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
In-Reply-To: <CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.07.2017 20:23, Peter Maydell wrote:
> On 30 July 2017 at 17:51, Kamil Rytarowski <n54@gmx.com> wrote:
>> On 29.07.2017 21:34, Peter Maydell wrote:
>>> On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
>>>> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> This is likely to break on BSD, but now than patchew has a NetBSD j=
ob
>>>>> you can trigger a build RESENDing this patch.
>>>
>>
>> I just checked patchew, and there is FreeBSD job. How far are we from
>> adding more BSDs?
>=20
> I now test OpenBSD and NetBSD as well in my pre-merge
> test setup. Patchew could add them as well if desired.
> (vm setup instructions at http://wiki.qemu.org/Hosts/BSD)
>=20

Please do.

> (I haven't bothered to send a patch marking OpenBSD
> as 'supported' since we've had zero contact from
> anybody in the OpenBSD community AFAIK.)
>=20

There is one maintainer in OpenBSD ports Brad Smith, but he's not an
OpenBSD developer as far as I can tell.

Adding him to CC.

> thanks
> -- PMM
>=20



--5DOqHII6rwFwJKkbsHC1OGWQlVUWI17ME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZfmapAAoJEEuzCOmwLnZs9CIP/3jq8D3jd2Y30qe7hfhzfPtM
MMoEQR2VI1xuqp9KMlSCq2orCsrRSGYY9v99r0lNuZLzjtoxfORekAdL1jHpG7qa
4Y+wmICR2GeMxXMbRKPHkqTb33HiPiYzdv2j/N+tTNLa4pXS75i/6UXhLNVLdHrD
etfp71DTInRzG8GLr6AydRaXGwxbOm+gag3FYbRt4j3+Ruq3xTo19hK+0lyWlcaW
iVGSrbokZmnSmgp5rWJDIusX0UrpOwzPt73FdHkteXOhfRuo8/le9aIDlIyKQp5A
wu/2ibwmdKH2QpeQsabAhCq4BBdRM3JtXqEvhvMDgU+Resy9mLp7IYt+TTI6mUqa
cop1mBi1vrNfZpT++B/bMyihAmqVSLCwlkmWPCRki2VIbss3Zg+LNQ7Sv6e/VjFP
tyKXnvIepHuBtY9y7lr6Og7CRallJdJuWSd0yQCinHMay3dv9GoLYcEvF8geXor+
hINM+cKKoTmrRzNzkMPFnStdUi5v9nSQTtDqWX87LS6TeoLFc1UxvWTr95BVHZqj
NrwTSsUH+vufgZ7/VSDapuOGX96rwSQKIf6Y+KMRrk3L8Y0UuCdULa3tyQHzkifB
RS2hbA6VjU0cNED+4EDUu56p3RHTgJ/TkQukvcBTOiAt6XUJ/7sxtMsJnzVWr18+
02ljIFhojgx7nhyDrauv
=KTRm
-----END PGP SIGNATURE-----

--5DOqHII6rwFwJKkbsHC1OGWQlVUWI17ME--
