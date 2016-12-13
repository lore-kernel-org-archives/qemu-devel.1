Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGrB3-0006nS-0B
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGrAy-0004Jp-HO
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:47:45 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cGrAy-0004JO-9Z
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:47:40 -0500
Received: by mail-lf0-f65.google.com with SMTP id 96so640937lfs.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 09:47:40 -0800 (PST)
MIME-Version: 1.0
References: <583d5d12.8529c80a.4a33a.c6f9@mx.google.com>
	<CAKXe6SJu9=Mr2OL-2LDqwpK_QLdzPhXKD_dSb63uJVF75Li7-A@mail.gmail.com>
In-Reply-To: <CAKXe6SJu9=Mr2OL-2LDqwpK_QLdzPhXKD_dSb63uJVF75Li7-A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Dec 2016 17:46:28 +0000
Message-ID: <CAJ+F1C+3fDb46t7=+q+3wzdWtHuxF6U1Xs-UUjkkr17Fa8tPDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: es1370: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

good, and could be better, see my ac97 review

On Tue, Dec 13, 2016 at 11:57 AM Li Qiang <liq3ea@gmail.com> wrote:

> ping!
>
> 2016-11-29 18:48 GMT+08:00 Li Qiang <liq3ea@gmail.com>:
>
> > From: Li Qiang <liqiang6-s@360.cn>
> >
> > Currently the es1370 device emulation doesn't have a exit function,
> > hot unplug this device will leak some leak. Add a exit function to
> > avoid this.
> >
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > ---
> >  hw/audio/es1370.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> > index 8449b5f..8f70f72 100644
> > --- a/hw/audio/es1370.c
> > +++ b/hw/audio/es1370.c
> > @@ -1041,6 +1041,13 @@ static void es1370_realize(PCIDevice *dev, Error
> > **errp)
> >      es1370_reset (s);
> >  }
> >
> > +static void es1370_exit(PCIDevice *dev)
> > +{
> > +    ES1370State *s =3D ES1370(dev);
> > +
> > +    AUD_remove_card(&s->card);
> > +}
> > +
> >  static int es1370_init (PCIBus *bus)
> >  {
> >      pci_create_simple (bus, -1, TYPE_ES1370);
> > @@ -1053,6 +1060,7 @@ static void es1370_class_init (ObjectClass *klass=
,
> > void *data)
> >      PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
> >
> >      k->realize =3D es1370_realize;
> > +    k->exit =3D es1370_exit;
> >      k->vendor_id =3D PCI_VENDOR_ID_ENSONIQ;
> >      k->device_id =3D PCI_DEVICE_ID_ENSONIQ_ES1370;
> >      k->class_id =3D PCI_CLASS_MULTIMEDIA_AUDIO;
> > --
> > 1.8.3.1
> >
> >
>
--=20
Marc-Andr=C3=A9 Lureau
