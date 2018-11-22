Received: from eggs.gnu.org ([2001:4830:134:3::10]:44198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPmQU-0007T0-AY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPmQT-0000eM-2u
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:41:38 -0500
MIME-Version: 1.0
References: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
	<e61b7517-a736-8cb5-ce35-815225f18c52@redhat.com>
	<CAFEAcA8XgZRXyHkjWnOZ4d_yrqzWdxCDJjo6DtR+PTzx4t1cxg@mail.gmail.com>
In-Reply-To: <CAFEAcA8XgZRXyHkjWnOZ4d_yrqzWdxCDJjo6DtR+PTzx4t1cxg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 22 Nov 2018 18:40:58 +0800
Message-ID: <CAKXe6SJer_4EVPSc9gY0TMVmihMvX8=rmPRcP+4nvdyd+Sr8AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: arm: musicpal: drop TYPE_WM8750 in
 object_property_set_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: philmd@redhat.com, jan.kiszka@web.de, qemu-arm@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>, maozhongyi@cmss.chinamobile.com, Markus Armbruster <armbru@redhat.com>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=882=
2=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:38=E5=86=99=E9=81=93=EF=BC=
=9A

> On 22 November 2018 at 10:35, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
> wrote:
> > Hi Li,
> >
> > On 22/11/18 11:00, Li Qiang wrote:
> >> The third argument of object_property_set_link() is the name of
> >> property, not related with the QOM type name, using the constant
> >> string instead.
> >
> > You are correct.
> >
> >>
> >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >> ---
> >>  hw/arm/musicpal.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> >> index 9648b3af44..726ae29394 100644
> >> --- a/hw/arm/musicpal.c
> >> +++ b/hw/arm/musicpal.c
> >> @@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
> >>      dev =3D qdev_create(NULL, TYPE_MV88W8618_AUDIO);
> >>      s =3D SYS_BUS_DEVICE(dev);
> >>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
> >> -                             TYPE_WM8750, NULL);
> >> +                             "wm8750", NULL);
> >
> > Since this property is not related to migration,


This property is not related with migration.


> maybe we can resolve
> > this the other way, using TYPE_WM8750 in mv88w8618_audio_init():
> >
> > -- >8 --
> > @@ -255,3 +255,3 @@ static void mv88w8618_audio_init(Object *obj)
> >
> > -    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
> > +    object_property_add_link(OBJECT(dev), TYPE_WM8750, TYPE_WM8750,
> >                               (Object **) &s->wm,
>

No, just as Peter point out, the property can be arbitrary name, here use
'TYPE_WM8750'
makes confusion.



> > ---
> >
> > So using the same definition would protect someone to accidentaly renam=
e
> > the property name.
>
> I think I prefer Li's patch -- the property name is just
> an arbitrary name not related to the type name necessarily.
>
>
Agree.

Thanks,
Li Qiang


> thanks
> -- PMM
>
