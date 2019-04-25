Received: from eggs.gnu.org ([209.51.188.92]:51325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hJhEU-00037l-0R
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hJhES-0003OP-Tp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hJhES-0003NL-NK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so2029991wmi.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-25-thuth@redhat.com>
	<4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
In-Reply-To: <4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 25 Apr 2019 18:28:06 +0200
Message-ID: <CAP+75-UkU6RkqD02FE81g1WffkhqP-uGarX42afkbdT3b_r2Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 24/29] hw/arm: Express
 dependencies for remaining IMX boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, Qemu-block <qemu-block@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On Thu, Apr 25, 2019 at 6:14 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 4/18/19 8:00 PM, Thomas Huth wrote:
> > IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > ---
> >  default-configs/arm-softmmu.mak |  2 --
> >  hw/arm/Kconfig                  | 19 +++++++++++++++++++
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> > index 1455d083d8..6dc388c43e 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -37,7 +37,6 @@ CONFIG_SABRELITE=3Dy
> >  CONFIG_EMCRAFT_SF2=3Dy
> >
> >  CONFIG_VGA=3Dy
> > -CONFIG_IMX_FEC=3Dy
> >
> >  CONFIG_NRF51_SOC=3Dy
> >
> > @@ -49,4 +48,3 @@ CONFIG_PCIE_PORT=3Dy
> >  CONFIG_XIO3130=3Dy
> >  CONFIG_IOH3420=3Dy
> >  CONFIG_I82801B11=3Dy
> > -CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index f5cd63860d..58439c492a 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -283,6 +283,10 @@ config XLNX_VERSAL
> >
> >  config FSL_IMX25
> >      bool
> > +    select IMX

At some point we should split the IMX config in hw/misc/Kconfig.

> > +    select IMX_FEC
> > +    select IMX_I2C
> > +    select DS1338
[...]
