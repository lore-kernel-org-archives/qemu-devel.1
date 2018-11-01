Received: from eggs.gnu.org ([2001:4830:134:3::10]:35680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAPT-0007ZY-Fu
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAPP-0007gu-G0
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:41:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIAPP-0007gD-8S
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:41:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id y15-v6so19576450wru.9
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 03:41:03 -0700 (PDT)
Date: Thu, 1 Nov 2018 10:41:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101104100.GJ24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-2-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-2-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 01/13] qtest: Add set_irq_in command to
 set IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:15PM -0400, Steffen G=F6rtz wrote:
> Adds a new qtest command "set_irq_in" which allows
> to set qemu gpio lines to a given level.
>=20
> Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363.h=
tml
> which never got merged.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
> ---
>  qtest.c          | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.c | 10 ++++++++++
>  tests/libqtest.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

Aside from Laurent's comments:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2tg8AAoJEJykq7OBq3PIPbQH/3X9j1tpsiEWx/eVC4Rx+Y8p
LqSdXhzaxDisfVilucl29lHSKMaF3mLAXeNMoLQhgsxssqqXILwNfj8mu3oB/+zI
+GqYRjuISG/8nBZWbBn+meTPD/5krGpdJiTfMMFLhrfDqdhJ1CS05dHxiD9kAqEj
rFZZtj+8rWZBvftF4NnF+MIGqu9tMEEzx2Rgeqt64aNH1B3fZTfCgHx/6hUHr7DR
AetAleEniDZ+PqVM36R1U0iX+OFINCPo+DdX2calcVGZTD6yTThOP8Apry1yWaWg
J01gbUgLYGtUOBcIdeVXJgFHII8RSRo6SxR1I8KCU108R1vb3uOr12chce3KGz4=
=w2HA
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
