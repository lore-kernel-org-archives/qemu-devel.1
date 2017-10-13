Received: from eggs.gnu.org ([2001:4830:134:3::10]:37139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e35yl-0005IB-Sk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e35yi-0008Co-10
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e35yh-0008CY-Qa
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:50:39 -0400
References: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
	<CAFEAcA8yvST1fKaLjauz3OV=gRTEKsuLfWvJ3NgCA_weFy2cOg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b32eabb5-165a-f57c-2ecd-dd2008db4ea0@redhat.com>
Date: Fri, 13 Oct 2017 21:50:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yvST1fKaLjauz3OV=gRTEKsuLfWvJ3NgCA_weFy2cOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] dynamic DRAM base for ArmVirtQemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Drew Jones <drjones@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Andrea Bolognani <abologna@redhat.com>, libvirt devel <libvir-list@redhat.com>

On 10/13/17 18:18, Peter Maydell wrote:
> On 13 October 2017 at 13:51, Laszlo Ersek <lersek@redhat.com> wrote:
>> Another idea is to move *the* system DRAM base to a different guest-phys
>> address. (Likely using a different version of the "virt" machine type,
>> or even a different machine type entirely.) This would not be compatible
>> with current ArmVirtQemu, which hard-codes the system DRAM base in
>> several, quite brittle / sensitive, locations. (More on this later --
>> that's going to be the larger part of my email anyway.) In order to
>> handle the new base in ArmVirtQemu, two approaches are possible: change
>> the hard-coded address(es), or cope with the address dynamically.
> 
> I strongly don't want to move the DRAM base in the "virt" board.

You really cannot *not* want it more strongly than I :)

(See my answer to Ard for why I went to such lengths nonetheless in
mapping out the consequences for the firmware -- I knew and feared I'd
find monsters there, but when I'm invited to look, it's only honest to
look.)

> This is one of the few fixed things we've said that guest code
> can rely on without having to fish the information out of the
> device tree.

And, as one co-maintainer of one guest firmware, I'm immensely relieved
to learn about, and benefit from, this guarantee.

Thanks,
Laszlo
