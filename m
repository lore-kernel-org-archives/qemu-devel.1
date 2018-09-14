Received: from eggs.gnu.org ([2001:4830:134:3::10]:51362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0gLi-00059F-Ra
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0gLh-00022Z-RX
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:08:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g0gLh-00020F-G7
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:08:57 -0400
Received: by mail-qt0-x242.google.com with SMTP id j7-v6so7688866qtp.2
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 22:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180912160118.21158-1-liq3ea@163.com>
	<20180912160118.21158-6-liq3ea@163.com>
	<256edc89-6f54-da5d-10e1-a57ffb4ca613@redhat.com>
In-Reply-To: <256edc89-6f54-da5d-10e1-a57ffb4ca613@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Sep 2018 13:08:20 +0800
Message-ID: <CAKXe6S+YmYgv9UkU+ZX_ZJ9fBN=hbnJah_=_JfUEWnuUc0rKtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] hw: designware: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, ehabkost@redhat.com, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:12=E5=86=99=E9=81=93=EF=BC=9A

> On 12/09/2018 18:01, Li Qiang wrote:
> > From: Li Qiang <liq3ea@gmail.com>
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/pci-host/designware.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> > index 29ea313798..f5641b5c8c 100644
> > --- a/hw/pci-host/designware.c
> > +++ b/hw/pci-host/designware.c
> > @@ -57,6 +57,12 @@ designware_pcie_root_to_host(DesignwarePCIERoot *roo=
t)
> >      return DESIGNWARE_PCIE_HOST(bus->parent);
> >  }
> >
> > +static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr add=
r,
> > +                                              unsigned size)
> > +{
> > +    return 0;
> > +}
> > +
> >  static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
> >                                             uint64_t val, unsigned len)
> >  {
> > @@ -71,6 +77,7 @@ static void designware_pcie_root_msi_write(void
> *opaque, hwaddr addr,
> >  }
> >
> >  static const MemoryRegionOps designware_pci_host_msi_ops =3D {
> > +    .read =3D designware_pcie_root_msi_read,
> >      .write =3D designware_pcie_root_msi_write,
> >      .endianness =3D DEVICE_LITTLE_ENDIAN,
> >      .valid =3D {
> >
>
> This probably needs to generate an unassigned access too, because the
> datasheet says that the device basically traps memory writes.
>
> Generating an unassigned access is probably a good idea for the memory
> core; devices can then override the behavior to return zero.  I'm
> queuing patches 1-4, with slightly expanded commit messages.
>
>
Hi Paolo,
Thanks for your review!

These patches has been got a deep discuss, I'm not sure these patches is
necessory.
The discussion can be found in this thread.
-->https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01391.html


Thanks,
Li Qiang


> Paolo
>
