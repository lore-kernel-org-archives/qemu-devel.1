Received: from eggs.gnu.org ([2001:4830:134:3::10]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdYTK-0000ZJ-Di
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdYTF-0004X8-FY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:05:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdYTF-0004VL-8Q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:05:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id h10-v6so21065000wre.6
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:05:09 -0700 (PDT)
Date: Thu, 12 Jul 2018 11:05:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180712100506.GA17016@stefanha-x1.localdomain>
References: <20180710153335.1232-1-jusual@mail.ru>
	<20180711132553.GI31228@stefanha-x1.localdomain>
	<CAFEAcA_jekzwR8i3_1nB4smoQjoM6N_eUSP6jFP2gE08y8n9yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_jekzwR8i3_1nB4smoQjoM6N_eUSP6jFP2gE08y8n9yg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 02:33:14PM +0100, Peter Maydell wrote:
> On 11 July 2018 at 14:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Tue, Jul 10, 2018 at 06:33:35PM +0300, Julia Suvorova via Qemu-devel=
 wrote:
> >> The differences from ARMv7-M NVIC are:
> >>   * ARMv6-M only supports up to 32 external interrupts
> >>    (configurable feature already). The ICTR is reserved.
> >>   * Active Bit Register is reserved.
> >>   * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
> >>
> >> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> >> ---
> >>  hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
> >>  1 file changed, 25 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> >> index 38aaf3dc8e..8545c87caa 100644
> >> --- a/hw/intc/armv7m_nvic.c
> >> +++ b/hw/intc/armv7m_nvic.c
> >> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, =
bool secure, uint8_t prio)
> >>      assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios=
 */
> >>      assert(irq < s->num_irq);
> >>
> >> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
> >
> > ARMv8-M also has the NVIC:
> > https://static.docs.arm.com/ddi0553/a/DDI0553A_e_armv8m_arm.pdf
> >
> > Should arm_feature(&s->cpu->env, ARM_FEATURE_V6) be used instead of
> > !arm_feature(&s->cpu->env, ARM_FEATURE_V7)?
>=20
> All of v6M, v7M and v8M cores will set ARM_FEATURE_V6, so
> testing on it doesn't distinguish them.

Okay.

Stefan

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRyfSAAoJEJykq7OBq3PIM+cH/j4d/6FUMMnvQxifxbwTM2kl
mt2P1zlgWzEF1POOhBi0Q6Zk98gSYd4ysam/UkVPHwkDxUqsP/F37HvKBDTJ/bMY
wtJ/jccNSya6UVNCHkR5rEf6E0GB1LN0pxnsYaqy2qm6CWCEMHvGNyK+BIaQqTgf
xC3eQfBm3snqaKGQpp619YOtpVL+yZUccXD/b1oXLYlvjPvS7gpuhg4UijErN/Tp
63no+32zb5YuYYZX9kyU7SaVFRgo8hbZVnjtNK/BVEtK9z2ZLeA3pz2tOq9Y96oN
Qoj0Wbck7b/Rl+Zd8iMRX6m6s1LLO3dxr1hEhljSOwcrT1EdBIwqtOYBEeaVgh8=
=VIya
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
