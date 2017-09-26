Received: from eggs.gnu.org ([2001:4830:134:3::10]:49399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwkBp-0000ks-2K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwkBl-00076O-Uk
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwkBl-00076C-OX
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:21:53 -0400
Message-ID: <1506410511.32072.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 09:21:51 +0200
In-Reply-To: <053ad89e-9084-905e-a6cd-4a1f4c4638e8@siemens.com>
References: <20170926063820.30773-1-kraxel@redhat.com>
	<053ad89e-9084-905e-a6cd-4a1f4c4638e8@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: fix libusb config variable name.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org

On Tue, 2017-09-26 at 09:16 +0200, Jan Kiszka wrote:
> On 2017-09-26 08:38, Gerd Hoffmann wrote:
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Fixes: 4e5ee5b21c84fe3023a64b5cc2e12a52ab0597c1
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> > =C2=A0hw/usb/Makefile.objs | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> > index 9255234c63..0e6d54b21f 100644
> > --- a/hw/usb/Makefile.objs
> > +++ b/hw/usb/Makefile.objs
> > @@ -42,7 +42,7 @@ redirect.o-cflags =3D $(USB_REDIR_CFLAGS)
> > =C2=A0redirect.o-libs =3D $(USB_REDIR_LIBS)
> > =C2=A0
> > =C2=A0# usb pass-through
> > -ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
> > +ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
> > =C2=A0common-obj-y +=3D host-libusb.o host-legacy.o
> > =C2=A0else
> > =C2=A0common-obj-y +=3D host-stub.o
> >=20
>=20
> This won't still work, only patch did -> CONFIG_USB isn't set when
> building the common objects.

I've tested it, and it did work.  Also note that there are a bunch of

   common-obj-$(CONFIG_USB) +=3D something

lines in hw/usb/Makefile.objs

cheers,
  Gerd
