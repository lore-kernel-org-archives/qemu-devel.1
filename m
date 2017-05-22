Received: from eggs.gnu.org ([2001:4830:134:3::10]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dCffg-0004TE-Kw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 01:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dCffe-0000p3-ND
	for qemu-devel@nongnu.org; Mon, 22 May 2017 01:14:20 -0400
Message-ID: <1495430041.22806.1.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 22 May 2017 15:14:01 +1000
In-Reply-To: <660ee5968bc04bc7a318835d53f331ba@TWMBX01.aspeed.com>
References: <20170520002653.20213-1-andrew@aj.id.au>
	<20170520002653.20213-2-andrew@aj.id.au>
	<59538b3b-2936-cdc7-f582-9d473c72ce09@amsat.org>
	<1495412633.23485.3.camel@aj.id.au>
	<660ee5968bc04bc7a318835d53f331ba@TWMBX01.aspeed.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6uxB/B5lwJbkw1Dp3FMi"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/adc: Add basic Aspeed
 ADC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Joel Stanley <joel@jms.id.au>


--=-6uxB/B5lwJbkw1Dp3FMi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-05-22 at 03:15 +0000, Ryan Chen wrote:
> In ASPEED SoC chip, all register access have following rule.=C2=A0
> Most of controller write access is only support 32bit access.=C2=A0
> Read is support 8bits/16bits/32bits.=C2=A0

Thanks for clearing that up Ryan.

Phil: I'll rework the model so the reads are 16-bits.

Thanks,

Andrew

>=20
>=20
>=20
> Best Regards,
> Ryan
>=20
> =E4=BF=A1=E9=A9=8A=E7=A7=91=E6=8A=80=E8=82=A1=E4=BB=BD=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
> ASPEED Technology Inc.
> 2F,No.15,Industry East Road 4.,Hsinchu Science Park, Hsinchu City 30077, =
Taiwan
> Tel: 886-3-578-9568=C2=A0 #857
> Fax: 886-3-578-9586
> ************* Email Confidentiality Notice ********************
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or =
other confidential information. If you have received it in error, please no=
tify the sender by reply e-mail and immediately delete the e-mail and any a=
ttachments without copying or disclosing the contents. Thank you.
>=20
> -----Original Message-----
> > From: Andrew Jeffery [mailto:andrew@aj.id.au]=C2=A0
> Sent: Monday, May 22, 2017 8:24 AM
> > To: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>; qemu-arm@nongnu.org
> > > > Cc: Peter Maydell <peter.maydell@linaro.org>; Ryan Chen <ryan_chen@=
aspeedtech.com>; Alistair Francis <alistair@alistair23.me>; qemu-devel@nong=
nu.org; C=C3=A9dric Le Goater <clg@kaod.org>; Joel Stanley <joel@jms.id.au>
> Subject: Re: [Qemu-arm] [PATCH 1/2] hw/adc: Add basic Aspeed ADC model
>=20
> Hi Phil,
>=20
> On Sat, 2017-05-20 at 00:21 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Andrew,
> >=20
> > On 05/19/2017 09:26 PM, Andrew Jeffery wrote:
> > > This model implements enough behaviour to do basic functionality=C2=
=A0
> > > tests such as device initialisation and read out of dummy sample=C2=
=A0
> > > values. The sample value generation strategy is similar to the STM=C2=
=A0
> > > ADC already in the tree.
> > >=20
> > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >=20
> > > ---
> > > =C2=A0hw/adc/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > =C2=A0hw/adc/aspeed_adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 246=C2=A0
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0include/hw/adc/aspeed_adc.h |=C2=A0=C2=A033 ++++++
> > > =C2=A03 files changed, 280 insertions(+)
> > > =C2=A0create mode 100644 hw/adc/aspeed_adc.c
> > > =C2=A0create mode 100644 include/hw/adc/aspeed_adc.h
> > >=20
> > > diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs index=C2=A0
> > > 3f6dfdedaec7..2bf9362ba3c4 100644
> > > --- a/hw/adc/Makefile.objs
> > > +++ b/hw/adc/Makefile.objs
> > > @@ -1 +1,2 @@
> > > =C2=A0obj-$(CONFIG_STM32F2XX_ADC) +=3D stm32f2xx_adc.o
> > > +obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_adc.o
> > > diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c new file mode=
=C2=A0
> > > 100644 index 000000000000..d08f1684f7bc
> > > --- /dev/null
> > > +++ b/hw/adc/aspeed_adc.c
> > > @@ -0,0 +1,246 @@
> > > +/*
> > > + * Aspeed ADC
> > > + *
> > > > > + * Andrew Jeffery <andrew@aj.id.au>
> > >=20
> > > + *
> > > + * Copyright 2017 IBM Corp.
> > > + *
> > > + * This code is licensed under the GPL version 2 or later.=C2=A0=C2=
=A0See
> > > + * the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/adc/aspeed_adc.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/log.h"
> > > +
> > > +#define ASPEED_ADC_ENGINE_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0=
0 #define=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_CH_EN_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff0000 #define=C2=A0=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_CH_EN(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((BIT(x)) << 16) #define=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_INIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(8) #define=C2=
=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_AUTO_COMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(5) #define=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_COMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(4) #define=C2=
=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_MODE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000e #define=C2=A0=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_MODE_OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0b000 << 1) #define=C2=A0=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_MODE_STANDBY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(0b001 << 1) #define=C2=A0=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_MODE_NORMAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0(0b111 << 1) #define=C2=A0=C2=A0
> > > +ASPEED_ADC_ENGINE_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(0)
> > > +
> > > +#define ASPEED_ADC_L_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(=
(1 << 10) - 1) #define=C2=A0
> > > +ASPEED_ADC_L(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0((x) & ASPEED_ADC_L_MASK) #define=C2=A0
> > > +ASPEED_ADC_H(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(((x) >> 16) & ASPEED_ADC_L_MASK) #define=C2=A0
> > > +ASPEED_ADC_LH_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ASPEED_ADC_L_=
MASK << 16 |=C2=A0
> > > +ASPEED_ADC_L_MASK)
> > > +
> > > +static inline uint32_t update_channels(uint32_t current) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t next =3D (current + 7) & 0x3f=
f;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return (next << 16) | next;
> > > +}
> > > +
> > > +static bool breaks_threshold(AspeedADCState *s, int ch_off) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t a =3D ASPEED_ADC_L(s->channel=
s[ch_off]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t a_lower =3D ASPEED_ADC_L(s->b=
ounds[2 * ch_off]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t a_upper =3D ASPEED_ADC_H(s->b=
ounds[2 * ch_off]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t b =3D ASPEED_ADC_H(s->channel=
s[ch_off]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t b_lower =3D ASPEED_ADC_L(s->b=
ounds[2 * ch_off +=C2=A0
> > > +1]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0const uint32_t b_upper =3D ASPEED_ADC_H(s->b=
ounds[2 * ch_off +=C2=A0
> > > +1]);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return ((a < a_lower || a > a_upper)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((=
b < b_lower || b > b_upper)); }
> > > +
> > > +static uint32_t read_channel_sample(AspeedADCState *s, int ch_off)=
=C2=A0
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0/* Poor man's sampling */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->channels[ch_off];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->channels[ch_off] =3D update_channels(s->c=
hannels[ch_off]);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (breaks_threshold(s, ch_off)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_irq_raise(s->ir=
q);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +}
> > > +
> > > +#define TO_INDEX(addr, base) (((addr) - (base)) >> 2)
> > > +
> > > +static uint64_t aspeed_adc_read(void *opaque, hwaddr addr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0unsigned int size) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0AspeedADCState *s =3D ASPEED_ADC(opaque);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint64_t ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0switch (addr) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x00:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->engine_ct=
rl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x04:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->irq_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x08:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->vga_detec=
t_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x0c:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->adc_clk_c=
trl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x10 ... 0x2e:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D read_channel=
_sample(s, TO_INDEX(addr, 0x10));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x30 ... 0x6e:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->bounds[TO=
_INDEX(addr, 0x30)];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x70 ... 0xae:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->hysteresi=
s[TO_INDEX(addr, 0x70)];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0xc0:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->irq_src;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0xc4:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D s->comp_trim=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_mask(LOG_UN=
IMP, "%s: addr: 0x%lx, size: %u\n",=C2=A0
> > > +__func__, addr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +}
> > > +
> > > +static void aspeed_adc_write(void *opaque, hwaddr addr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uin=
t64_t val, unsigned int size) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0AspeedADCState *s =3D ASPEED_ADC(opaque);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0switch (addr) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x00:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0uint32_t init;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0init =3D !!(val & ASPEED_ADC_ENGINE_EN);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0init *=3D ASPEED_ADC_ENGINE_INIT;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0val &=3D ~ASPEED_ADC_ENGINE_INIT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0val |=3D init;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val &=3D ~ASPEED_ADC=
_ENGINE_AUTO_COMP;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->engine_ctrl =3D v=
al;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x04:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->irq_ctrl =3D val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x08:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->vga_detect_ctrl =
=3D val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x0c:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->adc_clk_ctrl =3D =
val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x10 ... 0x2e:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->channels[TO_INDEX=
(addr, 0x10)] =3D val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x30 ... 0x6e:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->bounds[TO_INDEX(a=
ddr, 0x30)] =3D (val &=C2=A0
> > > +ASPEED_ADC_LH_MASK);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0x70 ... 0xae:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->hysteresis[TO_IND=
EX(addr, 0x70)] =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(val & (BIT(31) | ASPEED_ADC_LH_MASK));
> >=20
> > Can you add a #define for this BIT(31)?
>=20
> Sorry, that was an oversight!
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0xc0:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->irq_src =3D (val =
& 0xffff);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0case 0xc4:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->comp_trim =3D (va=
l & 0xf);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_mask(LOG_UN=
IMP, "%s: %lu\n", __func__, addr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +}
> > > +
> > > +static const MemoryRegionOps aspeed_adc_ops =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.read =3D aspeed_adc_read,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.write =3D aspeed_adc_write,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.endianness =3D DEVICE_LITTLE_ENDIAN,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.valid.min_access_size =3D 4,
> >=20
> > You sure about that? How the registers are aligned it seems this=C2=A0
> > device can also be accessed 2-byte wide.
>=20
> I'll address this below.
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.valid.max_access_size =3D 4,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.valid.unaligned =3D false,
> > > +};
> > > +
> > > +static void aspeed_adc_reset(DeviceState *dev) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0struct AspeedADCState *s =3D ASPEED_ADC(dev)=
;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->engine_ctrl =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->irq_ctrl =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->vga_detect_ctrl =3D 0x0000000f;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->adc_clk_ctrl =3D 0x0000000f;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0memset(s->channels, 0, sizeof(s->channels));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0memset(s->bounds, 0, sizeof(s->bounds));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0memset(s->hysteresis, 0, sizeof(s->hysteresi=
s));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->irq_src =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0s->comp_trim =3D 0;
> > > +}
> > > +
> > > +static void aspeed_adc_realize(DeviceState *dev, Error **errp) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0AspeedADCState *s =3D ASPEED_ADC(dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0sysbus_init_irq(sbd, &s->irq);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0memory_region_init_io(&s->mmio, OBJECT(s), &=
aspeed_adc_ops, s,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0TYPE_ASPEED_ADC, 0x1000);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0sysbus_init_mmio(sbd, &s->mmio); }
> > > +
> > > +static const VMStateDescription vmstate_aspeed_adc =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.name =3D TYPE_ASPEED_ADC,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.version_id =3D 1,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.minimum_version_id =3D 1,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.fields =3D (VMStateField[]) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(engin=
e_ctrl, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(irq_c=
trl, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(vga_d=
etect_ctrl, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(adc_c=
lk_ctrl, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32_ARRAY=
(channels, AspeedADCState,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASPEED_ADC_NR_CHANNELS / 2),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32_ARRAY=
(bounds, AspeedADCState,=C2=A0
> > > +ASPEED_ADC_NR_CHANNELS),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32_ARRAY=
(hysteresis, AspeedADCState,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASPEED_ADC_NR_CHANNELS),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(irq_s=
rc, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(comp_=
trim, AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_END_OF_LIST(=
),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +};
> > > +
> > > +static void aspeed_adc_class_init(ObjectClass *klass, void *data) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0dc->realize =3D aspeed_adc_realize;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0dc->reset =3D aspeed_adc_reset;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0dc->desc =3D "Aspeed Analog-to-Digital Conve=
rter",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0dc->vmsd =3D &vmstate_aspeed_adc; }
> > > +
> > > +static const TypeInfo aspeed_adc_info =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.name =3D TYPE_ASPEED_ADC,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.parent =3D TYPE_SYS_BUS_DEVICE,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.instance_size =3D sizeof(AspeedADCState),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D aspeed_adc_class_init, };
> > > +
> > > +static void aspeed_adc_register_types(void) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&aspeed_adc_info);
> > > +}
> > > +
> > > +type_init(aspeed_adc_register_types);
> > > diff --git a/include/hw/adc/aspeed_adc.h=C2=A0
> > > b/include/hw/adc/aspeed_adc.h new file mode 100644 index=C2=A0
> > > 000000000000..ae2089ac62ca
> > > --- /dev/null
> > > +++ b/include/hw/adc/aspeed_adc.h
> > > @@ -0,0 +1,33 @@
> > > +#ifndef _ASPEED_ADC_H_
> > > +#define _ASPEED_ADC_H_
> > > +
> >=20
> > You missed the license.
>=20
> Whoops.
>=20
> >=20
> > Can you also add a comment about which ADC are modeled (2400/2500 no
> > difference) as you explain in your cover letter?
>=20
> Yes, will add this.
>=20
> >=20
> > > +#include <stdint.h>
> > > +
> > > +#include "hw/hw.h"
> > > +#include "hw/irq.h"
> > > +#include "hw/sysbus.h"
> > > +
> > > +#define TYPE_ASPEED_ADC "aspeed.adc"
> > > +#define ASPEED_ADC(obj) OBJECT_CHECK(AspeedADCState, (obj),=C2=A0
> > > +TYPE_ASPEED_ADC)
> > > +
> > > +#define ASPEED_ADC_NR_CHANNELS 16
> > > +
> > > +typedef struct AspeedADCState {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0/* <private> */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0SysBusDevice parent;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion mmio;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0qemu_irq irq;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t engine_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t irq_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t vga_detect_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t adc_clk_ctrl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t channels[ASPEED_ADC_NR_CHANNELS / 2=
];
> >=20
> > I can't find the datasheet
>=20
> Unfortunately the datasheet isn't publicly available. However, Ryan
> (Cc'ed) can help answer specific hardware questions.
>=20
> > , but it seems this ADC has a 10-bit
> > resolution, so a channel sample can fit into a uint16_t.
>=20
> Indeed. I think I'll add a bit of a blurb about the device to cover this =
off.
>=20
> > It sounds weird to read ASPEED_ADC_NR_CHANNELS=3D16 then use
> > ASPEED_ADC_NR_CHANNELS/2 channels.
> > I think using an uint16_t array you can get rid of the ASPEED_ADC_L/H=
=C2=A0
> > macros.
>=20
> This is something I tried to clarify with Ryan on Friday.=C2=A0I am under=
 the impression the hardware only supports 32-bit accesses. In the datashee=
t the registers are defined in 32-bit quantities, which drove this approach=
. The driver from the SDK's kernel also uses 32-bit accesses and shifts.
>=20
> Ryan: So to clarify here, can we do 16-bit (aligned) MMIO accesses on the=
 hardware? Or are we restricted to 32-bit MMIO access as I've specified abo=
ve?
>=20
> Cheers,
>=20
> Andrew
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t bounds[ASPEED_ADC_NR_CHANNELS];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t hysteresis[ASPEED_ADC_NR_CHANNELS];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t irq_src;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t comp_trim;
> > > +} AspeedADCState;
> > > +
> > > +#endif /* _ASPEED_ADC_H_ */
> > >=20
> >=20
> > Regards,
> >=20
> > Phil.
--=-6uxB/B5lwJbkw1Dp3FMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZInOZAAoJEJ0dnzgO5LT5aTwP/jODFUBYmfCpxyTDbXChdmpV
eOLLubJxcWvMdcZIhwQa4uyWQilB0LlyGFarkvq1cKhoLhJbIGmhIcRgxrWF3oWf
w/gEUrGjQDBuqUtItD6KFxfUduSeat3Z7K8P/VtwUa0O1YBinOEvsVJ0/P/zxtnG
16DR2jiruxKqQHDw2rEjn7FTKOUoCWX4wsXT7DfqQ9w9k2IM3HSqRLL+lyenifdf
+5Ms/1KxLExglw6kQWx6vFlVk0h//mMisIV2iEpANVkjTNaYnfQlsxsa4Qz9mRNV
SjLRbYAALOjKMhA44xFS9y2yNgaofNyxu8DJn2WP1s2uf8/wnjn87F0CjJA5K7jr
qWZDPM2YJWsUlnKNT86vRR5o8Y4A0QalU3ZKoDir+iBQrKq3uI1iQrOAhuAsQX8H
A0nu1GMJ0Bcsum1rAaKhakZvcnnaCaMeBnF3TDx99ViEykq13mye9NJV3FTn466f
FBUpbu1vF5x27s8MIT6IMIzCNl4NfhA2J1lhb8XgI1EJoJ+fQaEoBylRvwmX2Y/Y
t8elnrx6h6uRnX29cd06c7k9mNoMCwdlhgY7vToIXS0a5gdNpZeIw8DJkwaMjdoK
PTfBaUGegX7ZHM0xbLsosLRB5cmQE+5VXC9R9siolVN43EsrOXTchGLwTUJ5Gs6/
VjX8JGO2Gl1oW7WHON7a
=AZoH
-----END PGP SIGNATURE-----

--=-6uxB/B5lwJbkw1Dp3FMi--
