Received: from eggs.gnu.org ([209.51.188.92]:40726)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmFsp-0000rV-OE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmFsn-0001Es-HS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:35:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:46817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmFsn-00014Z-51
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:35:45 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
Date: Wed, 23 Jan 2019 11:36:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190123101238.GD27270@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EYxyhvCiICUDUDYvCdA01GikqDC9tz4U6"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EYxyhvCiICUDUDYvCdA01GikqDC9tz4U6
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-1-kraxel@redhat.com>
 <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
In-Reply-To: <20190123101238.GD27270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 11:12, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 23, 2019 at 10:50:18AM +0100, Thomas Huth wrote:
>> On 2019-01-23 10:36, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jan 23, 2019 at 09:27:48AM +0100, Thomas Huth wrote:
>>>> On 2019-01-23 09:00, Gerd Hoffmann wrote:
>>>>>
>>>>> This is RfC because we might look at the ordering.  On linux we pro=
bably
>>>>> want prefer alsa over oss.
>>>> Yes, please! I've run into the trap a couple of times already: OSS
>>>> headers were available, but these days the OSS compatibility kernel
>>>> modules are not loaded anymore by default. So you compile QEMU with =
OSS
>>>> support and then wonder why you do not get any audio output at all..=
=2E
>>>>
>>>> IMHO we should put OSS as last item in the list on Linux nowadays.
>>>
>>> Given our targetted platform list[1], are there even any platforms
>>> where we would *not* have alsa, but still have OSS ?  If not, then
>>> we could just drop the OSS driver entirely on the ground that it is
>>> obsolete.
>>
>> We likely could drop OSS on Linux, but it is still required on FreeBSD=

>> and NetBSD, isn't it? So unless we can drop it there, too, we can also=

>> simply keep it as last option in the list on Linux as well.
>=20
> Ah ok, I didn't realize that BSD implemneted the OSS subsystem too.
>=20
> Regards,
> Daniel
>=20

OSS is the portable UNIX audio backend. We could point some flaws in it,
but it's a good enough for portable UNIX applications. The question is
what UNIX-like desktop OS does not implement it or removed it.


--EYxyhvCiICUDUDYvCdA01GikqDC9tz4U6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIQ6YMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs7w0QAIEiaB9iVVQDSccA3gAgTZsSeCg9cPVcYK+sTWmO
EW+Ew+Fc9tw0Ir63uyWrlFlbBCKibSefZ0K1PYf6DUJax2JpFy8HQKuy39nAStv2
nSKzKlx4fK3nv6zaE4XjHNLBnr3e4XFO45mQpDkf8MJRK2IR4ipD7ZD9io6BqEG1
U28VxOKqxzs+8EkHJDanRR5oGASi2Dd3Iz96sRsX08a5J5LOm1JT/n76HVL7FNnH
9s4eO7dQ5P+UGqEtLFbyZUNIVbjt3RGyKYDf7ISy+1C/escPXPLgDW87Xu0ZiwC0
ftwD6Jj3N0bk1xHAd0aFFa8TN4aVul2kQj/xwfBfaxHxI2Q8z62MIV1W/2o+0E+W
zyyLgpI84rV1GqTGX525yezgv6tAeL5cqdxlcxINzN3NLOu6oO4BPVcxs3K0KDDf
qEkIIk5Or/MiMzWKUFp9UaKhiE7l/Q2tmFgmqrBIO2Tw71EDktCj8YzGEhJOmNN0
4oZcZWqPqy3VLQbS/zyLzPDKFry5Hr52o06yv0lYn79J30bl64Jidps0AjJCl+rT
GW9lneCJYBXtXj+TrqSWY1sCte8R5n9jkaq3ooSj/0tU0Y5k/J10SmbaYRX1+3JC
aGjDOtK2KJl+C4+ZNoK2und40SbzwxSsP+B/MYPspGLK+DIfSAO5zcYrKUsTAhbp
jDyM
=lzvt
-----END PGP SIGNATURE-----

--EYxyhvCiICUDUDYvCdA01GikqDC9tz4U6--
