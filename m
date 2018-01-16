Received: from eggs.gnu.org ([2001:4830:134:3::10]:56286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSKR-0000QC-K6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSKN-000579-L6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:35:07 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSKN-00056r-Fy
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:35:03 -0500
Received: by mail-ot0-x242.google.com with SMTP id v5so3423499oth.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:35:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-10-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:34:42 +0000
Message-ID: <CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Add code needed to get a functional PCI subsytem when using in
> conjunction with upstream Linux guest (4.13+). Tested to work against
> "e1000e" (network adapter, using MSI interrupts) as well as
> "usb-ehci" (USB controller, using legacy PCI interrupts).
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  default-configs/arm-softmmu.mak  |   2 +
>  hw/pci-host/Makefile.objs        |   2 +
>  hw/pci-host/designware.c         | 618 +++++++++++++++++++++++++++++++++=
++++++
>  include/hw/pci-host/designware.h |  93 ++++++
>  include/hw/pci/pci_ids.h         |   2 +
>  5 files changed, 717 insertions(+)
>  create mode 100644 hw/pci-host/designware.c
>  create mode 100644 include/hw/pci-host/designware.h

I'm not familiar enough with our PCI code to be able to review
this, I'm afraid. MST and Marcel are our PCI subsystem maintainers --
could one of you have a look at whether this seems to be a correct
implementation of a pcie host controller ?

I did notice it seems to be missing device state save/load support.

thanks
-- PMM
