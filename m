Received: from eggs.gnu.org ([2001:4830:134:3::10]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFcYu-00050b-2M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFcYp-0003hT-CQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:31:32 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFcYp-0003gS-6T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:31:27 -0400
Received: by mail-wm0-x234.google.com with SMTP id d127so87412563wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 01:31:26 -0700 (PDT)
Date: Tue, 30 May 2017 09:31:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530083123.GA11362@stefanha-x1.localdomain>
References: <20170523104454.31309-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20170523104454.31309-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/1] Silence "make check" warnings on NUMA
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 07:44:53AM -0300, Eduardo Habkost wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/ehabkost/qemu.git tags/numa-pull-request
>=20
> for you to fetch changes up to c6ff347c8078bb86f75d38955641cb73e9d5b309:
>=20
>   numa: Silence incomplete mapping warning under qtest (2017-05-22 14:24:=
52 -0300)
>=20
> ----------------------------------------------------------------
> Silence "make check" warnings on NUMA test
>=20
> ----------------------------------------------------------------
>=20
> Igor Mammedov (1):
>   numa: Silence incomplete mapping warning under qtest
>=20
>  hw/core/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.11.0.259.g40922b1
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLS3bAAoJEJykq7OBq3PI+7YH/1q5mWccXRZq/Z6LIwPjLQzY
sy0s+XomNJqRrqd86gRVvGALYUAO/SraMc1/WbeS+XcAyftbX65ZtL48cXPAQ8cF
GGholkv6S/7lBt2vRv/ROlCUPLAVZlwpOmACDlS42pGk9iB0t6cN3L3OhXucd2Z5
9r/3vq4YS+Gip22rEEa08woNYMD9OPCeEj+uKPvoKgHM3VtUKhLTYmnTgEmxnNHQ
ekjljn0U5h3/X6uaopLb3HwENr+7fts1+pJC+GjsSaWeuoh3SCfnytS5NMwdT9aB
f9QtVlQDC1j8ZreQPsaVUEhgcemxCvyA0ZpJSVHo2gCgu00iZRr6kG7NiEWg4D0=
=V76K
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
