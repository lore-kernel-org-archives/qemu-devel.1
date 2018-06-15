Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTr3Y-0002f8-RF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTr3X-00008G-Pn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:54:32 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:47044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTr3X-00007r-IQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:54:31 -0400
Received: by mail-ot0-x22d.google.com with SMTP id v24-v6so2961009otk.13
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:54:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
	<bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F6E04@FRAEML521-MBX.china.huawei.com>
	<20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 16:54:10 +0100
Message-ID: <CAFEAcA-nG4Xv=PmxzW3tzs-TStziMDHMFxYi6_teSe1GhLH=hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

On 15 June 2018 at 16:44, Andrew Jones <drjones@redhat.com> wrote:
> If 0x40000000 falls into a reserved address region on some host, then
> I'm afraid the mach-virt model won't work with those devices unless the
> guest doesn't use UEFI and Peter is open to providing a machine property
> that one can enable in order to move the base address of memory.

Why should the VM ever care about where the address regions in the
host happen to be when it comes to where it's putting its RAM
in the VM's address layout? I feel like I'm missing something here...

thanks
-- PMM
