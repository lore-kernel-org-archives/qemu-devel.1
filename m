Received: from eggs.gnu.org ([2001:4830:134:3::10]:36271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Y16-00071p-3G
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Y15-0001yo-7P
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:15:24 -0400
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a888274-0687-16ef-79d0-2c5ba9513164@redhat.com>
Date: Wed, 10 May 2017 15:15:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o3KXTmHwipfAWiFCubJAFJqvGtXHKJiUf"
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o3KXTmHwipfAWiFCubJAFJqvGtXHKJiUf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>,
 qemu-arm@nongnu.org
Message-ID: <5a888274-0687-16ef-79d0-2c5ba9513164@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
References: <20170510200535.13268-1-f4bug@amsat.org>
 <20170510200535.13268-3-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 03:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using Coccinelle script.

Thinking forward a year - if I want to reproduce this (to see if other
instances have crept in), I have to dig up a mail archive to learn the
formula you used.  Better is to list your coccinelle command line
directly in the commit message, so that reproducing the fix involves
less effort.  Same comment applies throughout the series.

For reference, see how I did it in commit de6e7951.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o3KXTmHwipfAWiFCubJAFJqvGtXHKJiUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE3TTAAoJEKeha0olJ0NqdnwH+wadrcWapehQdArx3GIKXY52
ndC+3ECp0PXXv4gnSwRPrMGZ4d4hPP+35IAdHGvOzbr6WWoQGzSmPTIeTQXfg+Gg
zMFi2rWno9i14uerj6leK4FaDDSEv0PHDlqjXXtLtCHacfng9HzS1wAZBN1mFn55
BsjkhtCNJBL7p7j2dZ0+/mIz4rvbcKKoQWk4bWCtOJOE6G8MO8ZMZgDw+i3WnHT1
6zdnxzRUtc7t8zSbnTrlhqFwIaEqTGwX+c4sj2l2zZTKTiV9h4at1u4ndgVvaGbf
0qcP4QTwzuXcbVhOfqmValIbBYmBg8Y3iSId9SkaeqlfSMg3HNj4/fDRKmE9LLc=
=I24S
-----END PGP SIGNATURE-----

--o3KXTmHwipfAWiFCubJAFJqvGtXHKJiUf--
