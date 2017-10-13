Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32gD-0001EN-Qf
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e32gD-0001wZ-0v
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:19:21 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:56771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e32gC-0001wL-QY
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:19:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id l68so22784312wmd.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:19:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
References: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Oct 2017 17:18:59 +0100
Message-ID: <CAFEAcA8yvST1fKaLjauz3OV=gRTEKsuLfWvJ3NgCA_weFy2cOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] dynamic DRAM base for ArmVirtQemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Drew Jones <drjones@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Andrea Bolognani <abologna@redhat.com>, libvirt devel <libvir-list@redhat.com>

On 13 October 2017 at 13:51, Laszlo Ersek <lersek@redhat.com> wrote:
> Another idea is to move *the* system DRAM base to a different guest-phys
> address. (Likely using a different version of the "virt" machine type,
> or even a different machine type entirely.) This would not be compatible
> with current ArmVirtQemu, which hard-codes the system DRAM base in
> several, quite brittle / sensitive, locations. (More on this later --
> that's going to be the larger part of my email anyway.) In order to
> handle the new base in ArmVirtQemu, two approaches are possible: change
> the hard-coded address(es), or cope with the address dynamically.

I strongly don't want to move the DRAM base in the "virt" board.
This is one of the few fixed things we've said that guest code
can rely on without having to fish the information out of the
device tree.

thanks
-- PMM
