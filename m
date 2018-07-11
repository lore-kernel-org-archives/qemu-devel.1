Received: from eggs.gnu.org ([2001:4830:134:3::10]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdF84-0007SD-TP
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdF80-0004kU-TO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:26:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdF80-0004jr-LT
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:25:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id c13-v6so18142177wrt.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:25:56 -0700 (PDT)
Date: Wed, 11 Jul 2018 14:25:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711132553.GI31228@stefanha-x1.localdomain>
References: <20180710153335.1232-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <20180710153335.1232-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 06:33:35PM +0300, Julia Suvorova via Qemu-devel wro=
te:
> The differences from ARMv7-M NVIC are:
>   * ARMv6-M only supports up to 32 external interrupts
>    (configurable feature already). The ICTR is reserved.
>   * Active Bit Register is reserved.
>   * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 38aaf3dc8e..8545c87caa 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, boo=
l secure, uint8_t prio)
>      assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
>      assert(irq < s->num_irq);
> =20
> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {

ARMv8-M also has the NVIC:
https://static.docs.arm.com/ddi0553/a/DDI0553A_e_armv8m_arm.pdf

Should arm_feature(&s->cpu->env, ARM_FEATURE_V6) be used instead of
!arm_feature(&s->cpu->env, ARM_FEATURE_V7)?

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRgVhAAoJEJykq7OBq3PIygcIAIcXTKD68R/OjgOCHWJVBAM+
W/St7NRLKAmcA+QhcSJ5jSKxIUSx0qhMsGO3rc+rAjymPjb79JkgVHe5ot1tG23P
2VkpE0lqI4Z8kpRL70xpc75w+568xLfA84X1m+uxBOSeM0akUSAWPPnI7ubZl/2v
8pliPxy+6JuQEd/r4KrEQ5A/RZP6plLNb/A1hiz/ogxv0/fb9VAmx7vJmMHbGRqy
2/kp0utCBiXvHyWvW+79KCAgFS2XgSlEheEV9vV28G8PtJ9chU2jxZH4JHWq2Csb
dfYmYgPyCJCgLGHAYIo0A+/Ua9l59H3J8lM4tGEk29ZIHivKh6Kk6/2h0v2Ojes=
=b7O1
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
