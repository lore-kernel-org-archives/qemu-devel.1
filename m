Received: from eggs.gnu.org ([209.51.188.92]:56272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0pDc-0001tf-Ha
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0pDb-0001J2-Ot
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:09:28 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0pDb-0001GL-G7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:09:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id g1so4453960otj.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20190301202921.21209-1-richard.henderson@linaro.org>
	<b2d06943-feef-789d-dab7-482bc78a7ea2@redhat.com>
In-Reply-To: <b2d06943-feef-789d-dab7-482bc78a7ea2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 15:09:15 +0000
Message-ID: <CAFEAcA-7vOvt3LVSsXhgDKHL6TPMfHYpVExrJD7pYgEMiYm1dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix PC test for LDM (exception
 return)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 2 Mar 2019 at 19:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 3/1/19 9:29 PM, Richard Henderson wrote:
> > Found by inspection: Rn is the base register against which the
> > load began; I is the register within the mask being processed.
> > The exception return should of course be procesed from the loaded PC.
>
> "processed"
>
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/translate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index 8f7f5b95aa..ad879e3480 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -10612,7 +10612,7 @@ static void disas_arm_insn(DisasContext *s, uns=
igned int insn)
> >                              } else if (i =3D=3D rn) {
> >                                  loaded_var =3D tmp;
> >                                  loaded_base =3D 1;
> > -                            } else if (rn =3D=3D 15 && exc_return) {
> > +                            } else if (i =3D=3D 15 && exc_return) {
> >                                  store_pc_exc_ret(s, tmp);
> >                              } else {
> >                                  store_reg_from_load(s, i, tmp);
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Applied to target-arm.next (with the typo fixed), thanks.

-- PMM
