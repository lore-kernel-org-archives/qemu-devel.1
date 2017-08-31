Received: from eggs.gnu.org ([2001:4830:134:3::10]:58777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnM0l-0002wD-6s
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnM0i-0001sp-35
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnM0h-0001sM-T5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:43:40 -0400
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
	<CAJ+F1C+sdOFyNT9-HMEkaSTbt4diPEA-m=+Do2x7GObyyxb7fQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6847dc61-6097-33b4-b3af-5b8da52442d1@redhat.com>
Date: Thu, 31 Aug 2017 11:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+sdOFyNT9-HMEkaSTbt4diPEA-m=+Do2x7GObyyxb7fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 31.08.2017 11:36, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Aug 31, 2017 at 7:20 AM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>=20
>     On 31.08.2017 05:53, Philippe Mathieu-Daud=C3=A9 wrote:
>     > Suggested-by: Peter Maydell <peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>>
>     > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     > ---
>     >=C2=A0 include/hw/char/serial.h |=C2=A0 1 +
>     >=C2=A0 hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++++=
+++++++++
>     >=C2=A0 2 files changed, 14 insertions(+)
>     >
>     > diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
>     > index c4daf11a14..96bccb39e1 100644
>     > --- a/include/hw/char/serial.h
>     > +++ b/include/hw/char/serial.h
>     > @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion
>     *address_space,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr base, int it_shift,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq irq, int baudbase,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chardev *chr, enum device_endian e=
nd);
>     > +Chardev *serial_chr_nonnull(Chardev *chr);
>=20
>     Why do you need the prototype? Please make the function static if
>     possible (otherwise please add some rationale in the patch descript=
ion).
>=20
> It's being used from other units in following patches

Ah, well, right. I was only on CC: in the first two patches, so I missed
the other ones at the first glance. So never mind my comment, the
prototype is fine here.

 Thomas
