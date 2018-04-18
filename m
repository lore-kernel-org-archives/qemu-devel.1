Received: from eggs.gnu.org ([2001:4830:134:3::10]:37714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8odA-00044Q-Nz
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8od6-00016r-Kf
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:04:20 -0400
References: <20180418145443.6332-1-olaf@aepfle.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
Date: Wed, 18 Apr 2018 10:04:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180418145443.6332-1-olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O5DKzP0mPbDx2l0S82kFbO1vtLB4HMCWQ"
Subject: Re: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O5DKzP0mPbDx2l0S82kFbO1vtLB4HMCWQ
From: Eric Blake <eblake@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
References: <20180418145443.6332-1-olaf@aepfle.de>
In-Reply-To: <20180418145443.6332-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 09:54 AM, Olaf Hering wrote:
> Since usage of g_realloc_n was introduced, glib-2.22 can not be used
> anymore on Linux. Leave non-Linux unchanged because one developer syste=
m
> still uses it.
> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Rather than hacking configure, why not fix util/vfio-helpers.c to avoid
g_realloc_n()?  We've done it before; see commit 071d405

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--O5DKzP0mPbDx2l0S82kFbO1vtLB4HMCWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXXmMACgkQp6FrSiUn
Q2oErwgArtHE1OO3SN414XYyx2BqWj07K+iNuyH4hX51WhfQ6RI6fiIE2lws5H/S
6lCYYcMn1wCndf+5Zd/ZoM4Yl2mHvIcR6UvbqqiMPMSKJ+iBfkj5gH4rOtU8PHp3
zr/rlUGQvIq5wo4RH3sWmAHfzrr2oKrpixNyEdke4/Ga0tnmoVTMfBlzY6cdvQA5
b7fPZMlHNvTo3P+QV1ApRmvxBQdWMPT/PZgaKj25qTf8QoX4YzUgH0hOMV1ndSW/
OEk3JWEgfLYPQ+p5TlqSzRQM7r7S4Jt5beAl6uf/ouzMwrPa6bo59UWpgZ1USCEQ
uvLMblMQ5lCXiXcNn4/HIT4R7MGnPg==
=Z9Pv
-----END PGP SIGNATURE-----

--O5DKzP0mPbDx2l0S82kFbO1vtLB4HMCWQ--
