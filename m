Received: from eggs.gnu.org ([209.51.188.92]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpN3-0003ij-DM
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpN1-0004Bd-EN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:30:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gwpN1-00046N-54
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:30:39 -0500
Date: Thu, 21 Feb 2019 15:30:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221153021.19e8a973@redhat.com>
In-Reply-To: <3ce8edac-562e-0b27-2fa8-f3a5befcdc64@redhat.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
	<20190219060719.8211-2-richardw.yang@linux.intel.com>
	<3ce8edac-562e-0b27-2fa8-f3a5befcdc64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] pc-dimm: remove check on pc-dimm
 hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com

On Tue, 19 Feb 2019 13:26:47 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/19/19 7:07 AM, Wei Yang wrote:
> > Function acpi_memory_plug_cb() is only invoked when dev is a PCDIMM,
> > which is hotpluggable. This means it is not necessary to check this
> > property again.
> >=20
> > This patch removes this check.
> >=20
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  hw/acpi/memory_hotplug.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >=20
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index 8c7c1013f3..b19673d337 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -266,10 +266,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_d=
ev, MemHotplugState *mem_st, =20
>=20
> This is also obvious because it takes a HotplugHandler argument.
                                          ^^^^
that's a sort of atavism, handler also takes care of coldplug wiring nowday=
s.
(it's just nobody came up with new name and fixed it up)


>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> >      MemStatus *mdev;
> >      DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> > =20
> > -    if (!dc->hotpluggable) {
> > -        return;
> > -    }
> > -
> >      mdev =3D acpi_memory_slot_status(mem_st, dev, errp);
> >      if (!mdev) {
> >          return;
> >  =20
>=20
