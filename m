Received: from eggs.gnu.org ([209.51.188.92]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggQwi-0001wl-L7
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggQwh-0007Jh-W5
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:11:44 -0500
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <99165260-157a-363e-e0bd-e2d7537ae5dc@redhat.com>
Date: Mon, 7 Jan 2019 10:02:15 +0100
MIME-Version: 1.0
In-Reply-To: <5C2F6ED2.33D0D1.16460@m12-13.163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?W3FlbXUtczM5MHhdIOetlOWkjTogW1BBVENIIHYy?=
 =?utf-8?q?=5D_s390=3A_avoid_potential_null_dereference_ins390=5Fpcihost?=
 =?utf-8?b?X3VucGx1Zygp?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "walling@linux.ibm.com" <walling@linux.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "rth@twiddle.net" <rth@twiddle.net>

On 04.01.19 15:33, Li Qiang wrote:
> What do you think of =E2=80=98g_assert_not_reached();=E2=80=99. For exa=
mple:
>=20
> =C2=A0
>=20
> else {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
>=20
> }
>=20

I agree, if thisever happens, it is a serious programming error, not an
error to report to the user. (after all, he did nothing wrong)

I'd prefer asserts.

--=20

Thanks,

David / dhildenb
