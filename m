Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHbl-0005YQ-0g
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHbk-0006DG-2b
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:44:01 -0500
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a99fa98-5e81-ffa6-22c1-240d41ecac96@redhat.com>
Date: Wed, 10 Jan 2018 08:43:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180110091846.10699-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pBMiFsgYmr10EY4XWy7acE0y63lXfjzXG"
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pBMiFsgYmr10EY4XWy7acE0y63lXfjzXG
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>
Message-ID: <6a99fa98-5e81-ffa6-22c1-240d41ecac96@redhat.com>
Subject: Re: [PATCH v4 3/9] block: Add VFIO based NVMe driver
References: <20180110091846.10699-1-famz@redhat.com>
 <20180110091846.10699-4-famz@redhat.com>
In-Reply-To: <20180110091846.10699-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 03:18 AM, Fam Zheng wrote:
> This is a new protocol driver that exclusively opens a host NVMe
> controller through VFIO. It achieves better latency than linux-aio by
> completely bypassing host kernel vfs/block layer.
>=20
>     $rw-$bs-$iodepth  linux-aio     nvme://
>     ----------------------------------------
>     randread-4k-1     10.5k         21.6k
>     randread-512k-1   745           1591
>     randwrite-4k-1    30.7k         37.0k
>     randwrite-512k-1  1945          1980
>=20
>     (unit: IOPS)
>=20
> The driver also integrates with the polling mechanism of iothread.
>=20
> This patch is co-authored by Paolo and me.

Then shouldn't you include Paolo's S-o-b?

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pBMiFsgYmr10EY4XWy7acE0y63lXfjzXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWJpcACgkQp6FrSiUn
Q2rKkAf+IDEIZSI3LblN07rq32s9ivBpVtLLnsxKvjIEvD23eulFguwR4jqngSqx
yxQrQJkOIhHY/297mW5VwcxQAPHLLar7OL+YMquggRufIzOIaiZPi54qSV4tPD+d
8+dcNekxAtXi0mS/BlB/Y4KmGU9grkFs34b/5Ud+Ln9fKDNy6vvO+XmgJoTnPIu1
WggQyUNGz2KTl8J0GpR2+wD8QVu+5t+5wdqzZmFQZXQeTHtKA6YlSJLuddaFmkYz
YPW1Zr+1ubOcjf0CzEEM75J8BgvX9Gf42eYFaa49CIbdOpj/SiLlD7F+E4RmYO+b
7f7Ga4dnbVKl7BsW4uV9gsyNHUeHgg==
=68KR
-----END PGP SIGNATURE-----

--pBMiFsgYmr10EY4XWy7acE0y63lXfjzXG--
