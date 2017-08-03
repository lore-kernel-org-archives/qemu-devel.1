Received: from eggs.gnu.org ([2001:4830:134:3::10]:60196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1ddFfQ-00088X-Ej
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1ddFfP-0001sr-EK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:55:56 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1ddFfP-0001qg-83
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:55:55 -0400
Received: by mail-pf0-x243.google.com with SMTP id j68so1432252pfc.2
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-2-git-send-email-zuban32s@gmail.com>
	<20170803155042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170803155042-mutt-send-email-mst@kernel.org>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Thu, 03 Aug 2017 12:55:42 +0000
Message-ID: <CAKSfGUADdtZyAKky0FOKhSNLj4vbA2E3j=6Mgni7WDSDagPc+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, imammedo@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, marcel@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, seabios@seabios.org

=D1=87=D1=82, 3 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. =D0=B2 15:52, Michael S. T=
sirkin <mst@redhat.com>:

> On Sat, Jul 29, 2017 at 02:37:49AM +0300, Aleksandr Bezzubikov wrote:
> > Unmask previously masked SHPC feature in _OSC method.
> >
> > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>
> This does not do what the subject says - it enables
> SHPC unconditionally. And I think it will actually break
> ACPI hotplug for the PC unless we add an interface to
> disable ACPI hotplug and enable SHPC.
>
> Pls limit to Q35 only.
>
>
But this function (build_q35_osc_method) is called only for q35, isn't it?

> ---
> >  hw/i386/acpi-build.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 6b7bade..2ab32f9 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1848,9 +1848,9 @@ static Aml *build_q35_osc_method(void)
> >
> >      /*
> >       * Always allow native PME, AER (no dependencies)
> > -     * Never allow SHPC (no SHPC controller in this system)
> > +     * Allow SHPC (PCI bridges can have SHPC controller)
> >       */
> > -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
> > +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> >
> >      if_ctx2 =3D aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> >      /* Unknown revision */
> > --
> > 2.7.4
>
--=20
Aleksandr Bezzubikov
