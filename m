Received: from eggs.gnu.org ([2001:4830:134:3::10]:50080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e56IU-00066Q-IW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e56IQ-0001mI-0L
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:35:22 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:46824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1e56IP-0001jy-PV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:35:17 -0400
Received: by mail-ua0-f177.google.com with SMTP id w45so5446983uac.3
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 01:35:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4d790f860a3cf21bd7e33e7c3f53b58b@hostfission.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
	<286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
	<92FEAF6E-3002-4F0F-B845-4EC3D29381A4@redhat.com>
	<c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
	<34b4df5da848d69b213f538e5751c0d3@hostfission.com>
	<CABdb734e-Fmfjk8auh-FzKnhmxjs0Bh9WpXWDmRBjYUWsZfe3A@mail.gmail.com>
	<0f911b72c94a0d0f1bedf1c6385b045e@hostfission.com>
	<CABdb735gdt_N=GDTb2G_sPENjpxS98dFxoPQBLqtMmp8EKCRFw@mail.gmail.com>
	<d5b66cd9f96b0dafedf4369ff02a7121@hostfission.com>
	<CABdb734KxNJ2uMo2e61sFOXNFRgax067ErkQNQ1U1iO7ROAvCw@mail.gmail.com>
	<4d790f860a3cf21bd7e33e7c3f53b58b@hostfission.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 19 Oct 2017 10:35:14 +0200
Message-ID: <CABdb737FAM-k18=8wKohxrn21otnqiBUFoBNKqdEyu==B-s_kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geoffrey McRae <geoff@hostfission.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Oct 18, 2017 at 5:04 PM,  <geoff@hostfission.com> wrote:
> Hi Ladi & Yan,
>
> I am pleased to present the completed driver for review, please see:
>
> https://github.com/gnif/kvm-guest-drivers-windows

Awesome!

Feel free to open pull request, it should be easier to comment on.

* WoW considerations: It would be nice if the driver could detect that
the map request is coming from a 32-bit process and expect a different
layout of struct IVSHMEM_MMAP.

* It would be cleaner to use READ_REGISTER_* and WRITE_REGISTER_*
from/to IVSHMEMDeviceRegisters instead of plain memory accesses. Or at
the very least the accesses should be marked volatile.

* In ivshmem.inf: ManufacturerName="Red Hat, Inc." instead of "RedHat"

* Is any of the API used by the driver Win10-only? Just curious, it's
fine to build the driver only for Win10 for now even if it isn't.

Thanks!

> All issues previously mentioned have been addressed and all missing
> functionality has been added.
>
> Please note that this work has exposed a bug in the qemu ivshmem
> virtual device itself, it seems that if the MSI interrupts are enabled
> and the driver is unloaded twice an assertion is thrown due to what
> looks to be a double free, crashing out qemu.
>
> Once this driver has been finalized I will look into the cause of
> this problem and see if I can correct it also.
>
> Kind Regards,
> Geoffrey McRae
