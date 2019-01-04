Received: from eggs.gnu.org ([208.118.235.92]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gfVSA-000431-8Z
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gfVS1-0001sX-PK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:48:17 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gfVS0-0001qa-9V
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:48:12 -0500
Received: by mail-lf1-x141.google.com with SMTP id y14so7222231lfg.13
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 11:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20190104182057.8778-1-philmd@redhat.com>
	<8176371f-6dff-adee-84d1-5758ed74700c@redhat.com>
In-Reply-To: <8176371f-6dff-adee-84d1-5758ed74700c@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jan 2019 11:47:43 -0800
Message-ID: <CAKmqyKON+qf_+8sGYtaudLLcccdDz96SkiCNn_XztnJr8_m7bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: Do not update
 data register when device is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Fri, Jan 4, 2019 at 10:31 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/4/19 7:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > When the device is disable, the internal circuitry keep the data
>
> "keep" -> "keeps"
>
> > register loaded and doesn't update it.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> > ---
> >  hw/char/stm32f2xx_usart.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> > index f3363a2952..10392c70e2 100644
> > --- a/hw/char/stm32f2xx_usart.c
> > +++ b/hw/char/stm32f2xx_usart.c
> > @@ -53,14 +53,13 @@ static void stm32f2xx_usart_receive(void *opaque, c=
onst uint8_t *buf, int size)
> >  {
> >      STM32F2XXUsartState *s =3D opaque;
> >
> > -    s->usart_dr =3D *buf;
> > -
> >      if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE))=
 {
> >          /* USART not enabled - drop the chars */
> >          DB_PRINT("Dropping the chars\n");
> >          return;
> >      }
> >
> > +    s->usart_dr =3D *buf;
> >      s->usart_sr |=3D USART_SR_RXNE;
> >
> >      if (s->usart_cr1 & USART_CR1_RXNEIE) {
> >
>
