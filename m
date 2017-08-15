Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdkv-0007gB-KK
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdkr-0004yF-KF
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhdkr-0004xq-Bw
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:27:41 -0400
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-4-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd541c61-a9f9-28c9-5fd8-8659500dae81@redhat.com>
Date: Tue, 15 Aug 2017 10:27:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170815145714.17635-4-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2sJsLcShVKQROWVup5s06F9O1pSeP1MdG"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2sJsLcShVKQROWVup5s06F9O1pSeP1MdG
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
 alistair.francis@xilinx.com
Message-ID: <dd541c61-a9f9-28c9-5fd8-8659500dae81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
References: <20170815145714.17635-1-richard.henderson@linaro.org>
 <20170815145714.17635-4-richard.henderson@linaro.org>
In-Reply-To: <20170815145714.17635-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 09:57 AM, Richard Henderson wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> Acording to the ARM ARM exclusive loads require the same allignment as

s/Acording/According/
s/allignmnet/alignment/

> exclusive stores. Let's update the memops used for the load to match
> that of the store. This adds the alignment requirement to the memops.
>=20
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> [rth: Require 16-byte alignment for 64-bit LDXP.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2sJsLcShVKQROWVup5s06F9O1pSeP1MdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTEukACgkQp6FrSiUn
Q2pcTAf/dMAGQj+bs9k8xb/WcfV0I5Mx25uIsajPIvkc6HsX8INQmeXGtjrnz1U7
FsH0oh+znIqd6vn8gOJr7qOk5Q8bd2F7tPspGWKLRrw1KkKaWj94EBSWZ+uEVrs8
cJqobWLnRxS9qvsyddfWYc0xUz5aYKe3sFjJCTU+mOtJ+rPIRAG7vDb1RBIIwT3A
DYCzpI+mYQ6fxOCcXHIteppOtAGONbmRidBdshotOBebi4PrfsK4HOIO00qO+SJN
Kt8uQnReHjWeZKoc8V02Me9VW8zPWihs4rMeIA8BpeeP61s09NvsoNQdery69JoU
58U4Zo+WRIE4wxgAKHfyyO7yZcb3SQ==
=jRNY
-----END PGP SIGNATURE-----

--2sJsLcShVKQROWVup5s06F9O1pSeP1MdG--
