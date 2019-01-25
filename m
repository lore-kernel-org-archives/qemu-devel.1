Received: from eggs.gnu.org ([209.51.188.92]:42562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7ad-0006e5-AV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7S4-00081S-FS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:47:45 -0500
Date: Fri, 25 Jan 2019 14:47:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190125144650-mutt-send-email-mst@kernel.org>
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
	<f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
	<cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
	<CAAJhNetypG8pwa0Vs-RV=QbBcWwev5QtPF9n3CvTQJuzbNxkhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAJhNetypG8pwa0Vs-RV=QbBcWwev5QtPF9n3CvTQJuzbNxkhg@mail.gmail.com>
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
To: ksourav <sourav.jb1988@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, pbonzini@redhat.com, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 25, 2019 at 11:30:10PM +0530, ksourav wrote:
> On Fri, Jan 25, 2019 at 10:14 PM Philippe Mathieu-Daud=E9
> <philmd@redhat.com> wrote:
> >
> > On 1/25/19 4:24 PM, Thomas Huth wrote:
> > > On 2019-01-25 16:14, kumar sourav wrote:
> > >> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
> > >> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> > >>
> > >> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> > >> ---
> > >>  hw/input/pckbd.c | 1 +
> >
> > It seems we have other potential cases:
> >
> > $ git grep -L 'set_bit(DEVICE_CATEGORY_INPUT' hw/input/*c
> > hw/input/adb.c
> > hw/input/hid.c
> > hw/input/lm832x.c
> > hw/input/milkymist-softusb.c
> > hw/input/pckbd.c
> > hw/input/pl050.c
> > hw/input/ps2.c
> > hw/input/pxa2xx_keypad.c
> > hw/input/stellaris_input.c
> > hw/input/tsc2005.c
> > hw/input/tsc210x.c
> > hw/input/virtio-input-hid.c
> > hw/input/virtio-input-host.c
> >
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> > >> index 3e66713b47..72e7d5f6cc 100644
> > >> --- a/hw/input/pckbd.c
> > >> +++ b/hw/input/pckbd.c
> > >> @@ -574,6 +574,7 @@ static void i8042_class_initfn(ObjectClass *kl=
ass, void *data)
> > >>
> > >>      dc->realize =3D i8042_realizefn;
> > >>      dc->vmsd =3D &vmstate_kbd_isa;
> > >> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > >>  }
> > >>
> > >>  static const TypeInfo i8042_info =3D {
> > >>
> > >
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >
> Ok I will add device categories for these devices too. Should I send
> the changes in one patch for all these devices/files ?
> Or should I send it separately - one patch per device/file ?
>=20
> Thanks & Regards

Either is fine. One patch will be merged faster :)

--=20
MST
