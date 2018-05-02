Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDnyI-0002JQ-6P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDnyE-0005S2-W3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:22:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDnyE-0005Rg-Pt
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:22:42 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
	<de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
	<CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ccd2677-0401-16c6-5431-29bc79b5ac1a@redhat.com>
Date: Wed, 2 May 2018 11:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 02.05.2018 11:03, Liviu Ionescu wrote:
> On 2 May 2018 at 11:13:49, Thomas Huth (thuth@redhat.com) wrote:
>=20
>> https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>=20
> Thank you, Thomas.
>=20
>> It took quite a while to get a consensus on that policy, so I don't
>> think that we want to sacrifice that for semver.
>=20
> ok, this might be a point.
>=20
> thinking twice, I'm not sure it is a real sacrifice; I think that the
> problem here is the strict definition:
>=20
> "The feature will remain functional for 2 releases prior to actual remo=
val."
>=20
> if it were:
>=20
> "The feature will remain functional for _at least_ 2 releases prior to
> actual removal.=C2=A0"
>=20
> or even better:
>=20
> "The feature will remain functional for _at least_ 2 _major_ releases
> prior to actual removal. "

Sorry, but this really does not match with what we discussed last year
(see the thread at
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01592.html for
example), so I doubt that we can get a consensus on this for QEMU.

 Thomas
