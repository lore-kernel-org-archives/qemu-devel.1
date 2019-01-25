Received: from eggs.gnu.org ([209.51.188.92]:41902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn5mO-0007Oj-06
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn5mL-0001aU-V5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:00:35 -0500
MIME-Version: 1.0
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
	<f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
	<cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
In-Reply-To: <cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
From: ksourav <sourav.jb1988@gmail.com>
Date: Fri, 25 Jan 2019 23:30:10 +0530
Message-ID: <CAAJhNetypG8pwa0Vs-RV=QbBcWwev5QtPF9n3CvTQJuzbNxkhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, pbonzini@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, mst@redhat.com

On Fri, Jan 25, 2019 at 10:14 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/25/19 4:24 PM, Thomas Huth wrote:
> > On 2019-01-25 16:14, kumar sourav wrote:
> >> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
> >> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> >>
> >> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> >> ---
> >>  hw/input/pckbd.c | 1 +
>
> It seems we have other potential cases:
>
> $ git grep -L 'set_bit(DEVICE_CATEGORY_INPUT' hw/input/*c
> hw/input/adb.c
> hw/input/hid.c
> hw/input/lm832x.c
> hw/input/milkymist-softusb.c
> hw/input/pckbd.c
> hw/input/pl050.c
> hw/input/ps2.c
> hw/input/pxa2xx_keypad.c
> hw/input/stellaris_input.c
> hw/input/tsc2005.c
> hw/input/tsc210x.c
> hw/input/virtio-input-hid.c
> hw/input/virtio-input-host.c
>
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> >> index 3e66713b47..72e7d5f6cc 100644
> >> --- a/hw/input/pckbd.c
> >> +++ b/hw/input/pckbd.c
> >> @@ -574,6 +574,7 @@ static void i8042_class_initfn(ObjectClass *klass,=
 void *data)
> >>
> >>      dc->realize =3D i8042_realizefn;
> >>      dc->vmsd =3D &vmstate_kbd_isa;
> >> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> >>  }
> >>
> >>  static const TypeInfo i8042_info =3D {
> >>
> >
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
Ok I will add device categories for these devices too. Should I send
the changes in one patch for all these devices/files ?
Or should I send it separately - one patch per device/file ?

Thanks & Regards
