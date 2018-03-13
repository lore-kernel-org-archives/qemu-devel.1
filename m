Received: from eggs.gnu.org ([2001:4830:134:3::10]:57690)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1evpHK-0004Ou-4B
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1evpHG-0005jz-3R
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:08:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:39685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1evpHF-0005is-Pb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:08:02 -0400
References: <20180312201305.16972-1-berrange@redhat.com>
	<20180312201305.16972-3-berrange@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8462ca2a-5f81-21d5-0a03-6e5bda18b00e@gmx.com>
Date: Tue, 13 Mar 2018 20:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180312201305.16972-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1kIb1wMDFnxCm7c5GwbQ8eB5obF7DbgbN"
Subject: Re: [Qemu-devel] [PULL 2/9] cutils: add qemu_strtoi & qemu_strtoui
 parsers for int/unsigned int types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1kIb1wMDFnxCm7c5GwbQ8eB5obF7DbgbN
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8462ca2a-5f81-21d5-0a03-6e5bda18b00e@gmx.com>
Subject: Re: [Qemu-devel] [PULL 2/9] cutils: add qemu_strtoi & qemu_strtoui
 parsers for int/unsigned int types
References: <20180312201305.16972-1-berrange@redhat.com>
 <20180312201305.16972-3-berrange@redhat.com>
In-Reply-To: <20180312201305.16972-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.03.2018 21:12, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> There are qemu_strtoNN functions for various sized integers. This adds =
two
> more for plain int & unsigned int types, with suitable range checking.
>=20

There is a prior art in NetBSD with strtoi(3) and strtou(3).

http://netbsd.gw.com/cgi-bin/man-cgi?strtoi++NetBSD-current
http://netbsd.gw.com/cgi-bin/man-cgi?strtou++NetBSD-current

This is a clean room alternative for strtonum(3) with compat with some
other OSes.

The original code is in:

https://github.com/NetBSD/src/blob/trunk/common/lib/libc/stdlib/

It uses a wrapper for regular strtol(3)-like functions and strtol_l(3).

A simpler strtoi(3) wrapper is used in dhcpcd:

https://github.com/NetBSD/src/blob/trunk/external/bsd/dhcpcd/dist/compat/=


It has one difference compared to new POSIX (release 2016 or so) - no
conversion at all is ECANCELED, not EINVAL. I think ECANCELED makes more
sense and is distinguishable with input base error, and should be preserv=
ed.


--1kIb1wMDFnxCm7c5GwbQ8eB5obF7DbgbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlqoIhIMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsX7MP/1gTs1+snXtCpE05ASXqL1TzwB53AZQhW5QQoXS+
n9sEw4BQsJPMrrPod5Jo8WZ29sGpZHvjpgXm9PKssTLFzLceR/H6KQ0pZO4vwz8V
tbgbgyvNjr84wo56TInXpL8Vyrw9RcdAKtOCOuzTioEyx/b+XI1UWM7jZokImUUL
msOPyvTVYtSBccln67Y6F/a2N/QO2gHUsSdBVOznR4AnVcfzqSHPXdpQHsbS2V9P
Qpj4n97Li/XKTzBqkpeavl92FQt30pOfbLWhcDBYIU6Qt2ljJOGS0fQoQglbufqh
xI3ESlKJ7W2AjJsfUl4hlEku94zeiVKofn0B7VkWlbO1VwIdsyvvGsfjRrYgebnT
yrmb0chdobXTadwUqzzEjtfhYwgT5PkDr1NTwwiNGlEEuPv+h+EJOnRKulFvRzZn
h7bHzChTnnmlEwkYSlToxCtKV2+ZIvBZtv0cCj3KI9Xj6H/uUqZVGI9UVLUV8O3p
SKYy0Qy2g+KYejRutfCSOBZ6tx7+BX9p6ttz6ZfOW6MnFp8Y+PpdtAN9k4e3lfyY
z2aBozeeBqMmsPUTzyrplylkZNsZuYHecLdnCnn9DCeRJSCUCraYRAWiGwN6VTfn
MhkU4VFrEsAG5emeDH3zDzCncV5AmtesjwECJKMhajN0IVRfrAzlkRy7JxC8Q6Gb
rIrw
=RGxA
-----END PGP SIGNATURE-----

--1kIb1wMDFnxCm7c5GwbQ8eB5obF7DbgbN--
