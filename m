Received: from eggs.gnu.org ([209.51.188.92]:38219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8bU-0006YG-Ky
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8bS-0006UW-PJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:04 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8bR-0006TK-1A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:01 -0400
Received: by mail-oi1-x243.google.com with SMTP id n187so8695704oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
	<98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
	<b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
In-Reply-To: <b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:53:48 +0100
Message-ID: <CAFEAcA8xWTwbU6RSBbQkF2j5OfozEq9g3Pq83KyYG_J1CqGM-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, Qemu-block <qemu-block@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On Mon, 29 Apr 2019 at 16:34, Thomas Huth <thuth@redhat.com> wrote:
>
> On 25/04/2019 17.53, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thomas,
> >
> > On 4/18/19 8:00 PM, Thomas Huth wrote:
> >> Dependencies have been determined by looking at hw/arm/virt.c
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  default-configs/arm-softmmu.mak | 11 +----------
> >>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
> >>  hw/arm/Makefile.objs            |  3 ++-
> >>  3 files changed, 22 insertions(+), 11 deletions(-)

> > Without -nodefaults I get:
> > qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
> > This is expected.
>
> Yes, it should still work with "-nic none" or "-nodefaults".

Er, if you need either -nic none or -nodefaults after this
patch then this would be a change in behaviour, which seems
wrong to me.

thanks
-- PMM
