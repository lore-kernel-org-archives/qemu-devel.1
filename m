Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPmmE-0008Pg-Bf
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPmmB-0000Tn-6F
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:04:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPmmA-0000Sy-VD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:04:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so8660212wmh.0
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 03:04:02 -0800 (PST)
References: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
	<e61b7517-a736-8cb5-ce35-815225f18c52@redhat.com>
	<CAFEAcA8XgZRXyHkjWnOZ4d_yrqzWdxCDJjo6DtR+PTzx4t1cxg@mail.gmail.com>
	<CAKXe6SJer_4EVPSc9gY0TMVmihMvX8=rmPRcP+4nvdyd+Sr8AA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c712c5d2-25da-3b04-f11c-fbcf972be2de@redhat.com>
Date: Thu, 22 Nov 2018 12:03:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJer_4EVPSc9gY0TMVmihMvX8=rmPRcP+4nvdyd+Sr8AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Li Qiang <liq3ea@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: jan.kiszka@web.de, qemu-arm@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>, maozhongyi@cmss.chinamobile.com, Markus Armbruster <armbru@redhat.com>

On 22/11/18 11:40, Li Qiang wrote:
> Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> 于2018年11月22日周四 下午6:38写道：
> 
>     On 22 November 2018 at 10:35, Philippe Mathieu-Daudé
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>     > Hi Li,
>     >
>     > On 22/11/18 11:00, Li Qiang wrote:
>     >> The third argument of object_property_set_link() is the name of
>     >> property, not related with the QOM type name, using the constant
>     >> string instead.
>     >
>     > You are correct.
>     >
>     >>
>     >> Signed-off-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>
>     >> ---
>     >>  hw/arm/musicpal.c | 2 +-
>     >>  1 file changed, 1 insertion(+), 1 deletion(-)
>     >>
>     >> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>     >> index 9648b3af44..726ae29394 100644
>     >> --- a/hw/arm/musicpal.c
>     >> +++ b/hw/arm/musicpal.c
>     >> @@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState
>     *machine)
>     >>      dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>     >>      s = SYS_BUS_DEVICE(dev);
>     >>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>     >> -                             TYPE_WM8750, NULL);
>     >> +                             "wm8750", NULL);
>     >
>     > Since this property is not related to migration, 
> 
> 
> This property is not related with migration.
>  
> 
>     maybe we can resolve
>     > this the other way, using TYPE_WM8750 in mv88w8618_audio_init():
>     >
>     > -- >8 --
>     > @@ -255,3 +255,3 @@ static void mv88w8618_audio_init(Object *obj)
>     >
>     > -    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
>     > +    object_property_add_link(OBJECT(dev), TYPE_WM8750, TYPE_WM8750,
>     >                               (Object **) &s->wm,
> 
> 
> No, just as Peter point out, the property can be arbitrary name, here
> use 'TYPE_WM8750'
> makes confusion.
> 
>  
> 
>     > ---
>     >
>     > So using the same definition would protect someone to accidentaly
>     rename
>     > the property name.
> 
>     I think I prefer Li's patch -- the property name is just
>     an arbitrary name not related to the type name necessarily.

OK, fine then!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

> 
> 
> Agree.
> 
> Thanks,
> Li Qiang
>  
> 
>     thanks
>     -- PMM
> 
