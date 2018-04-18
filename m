Received: from eggs.gnu.org ([2001:4830:134:3::10]:47292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nED-0006rr-K5
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nE9-0000CO-Gy
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:34:29 -0400
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d58cb4c-9202-34d1-bfe0-1e4edc108be1@redhat.com>
Date: Wed, 18 Apr 2018 08:34:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180418124753.GM27579@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TJUIfCo0r3vzTVK9QJFaplcfNvBGuAHBG"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Olaf Hering <olaf@aepfle.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TJUIfCo0r3vzTVK9QJFaplcfNvBGuAHBG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Olaf Hering <olaf@aepfle.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d58cb4c-9202-34d1-bfe0-1e4edc108be1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
References: <20180418123838.3511-1-olaf@aepfle.de>
 <20180418124753.GM27579@redhat.com>
In-Reply-To: <20180418124753.GM27579@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 07:47 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 18, 2018 at 02:38:37PM +0200, Olaf Hering wrote:
>> Since usage of g_realloc_n was introduced, glib-2.22 can not be used a=
nymore.
>> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
>=20
> Normally we expect ./include/glib-compat.h to be changed in this scenar=
io
> to add compat for the missing symbol.

Or rewrite the offending addition of g_realloc_n to use something like
g_renew that IS available in 2.22 (this is not the first time the issue
has appeared; see commit 071d405, for example).

>=20
> IIRC, one of Peters desired build targets required 2.22, but I guess we=

> missed this bug because that platform would not enable vfio functionali=
ty ?

Which platform?  CentOS 6 is at glib 2.28; we also require 2.30 for
building on mingw.  I'm not seeing an easy document that says which
distros we still actively support, and which culprit distro has the
oldest glib.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TJUIfCo0r3vzTVK9QJFaplcfNvBGuAHBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXSVUACgkQp6FrSiUn
Q2q00wgApfrqgOUKX1cVqPnX/1M0/2BgOwI6fLdEiqj+FeEciWhHv0hVqa1m8RWP
qkukskBa+jlu4EnK+lnruNyZG7idmekrOZCCR7YUwNIgn5OsCMh+3jYKyMpmlaL1
p/OohKzFozkWLbazBUdXrGfiefckrpSK+Pmrk2xW5JAVWeQkNRG7eRQF/tS+ua9k
Xi0fPWzGpWq4CqOqwRXkZTtY2nTZDvYVRGu2BSkdNztepYpY483lLgZ2UPFA5vTj
HzHDUpIWfU9t9/SsVYr0rCx4ac9uIhQGNhzYRA3fPrYSSNkmBMN3awUkPCJpG3m0
CyYUHzVRSm6etpH7gggz2HcLSEwbRQ==
=mcva
-----END PGP SIGNATURE-----

--TJUIfCo0r3vzTVK9QJFaplcfNvBGuAHBG--
