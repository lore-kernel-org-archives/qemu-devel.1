Received: from eggs.gnu.org ([2001:4830:134:3::10]:34672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e35pN-0003Oi-1b
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e35pI-0002qw-5t
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e35pH-0002qa-Vx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:40:56 -0400
References: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
	<CAKv+Gu820vLCvNq2X_Fha2AW59HsNfTLk--J+wTt+fFdMu7FMw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7b84a76d-7708-7c8c-8fcf-7fe5549ed43f@redhat.com>
Date: Fri, 13 Oct 2017 21:40:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu820vLCvNq2X_Fha2AW59HsNfTLk--J+wTt+fFdMu7FMw@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Drew Jones <drjones@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Andrea Bolognani <abologna@redhat.com>, libvirt devel <libvir-list@redhat.com>

On 10/13/17 15:21, Ard Biesheuvel wrote:
> On 13 October 2017 at 13:51, Laszlo Ersek <lersek@redhat.com> wrote:
>> Hi Ard, Leif,
>>
>> the current physical memory map of the "virt" machine type doesn't leave
>> much room for ECAM / MMCONFIG, which limits the number of PCI Express
>> root ports and downstream ports (each port takes a separate bus number,
>> and each bus number eats up a chunk of the ECAM area). Also, each port
>> can only accommodate a single PCI Express device. In practice this
>> limits the number of (hot-pluggable) PCIe devices to approx. 16, which
>> is deemed by some "not scaleable enough". (For devices that only need to
>> be cold-plugged, they can be placed directly on the root complex, as
>> integrated devices, possibly grouping them into multifunction devices
>> even; so those don't need bus numbers.)
>>
>> In order to grow the MMCONFIG area (and for some other reasons
>> possibly), the phys memmap of "virt" should be shuffled around a bit.
>> This affects the "system" DRAM too.
>>
> 
> Is it really necessary to put the ECAM area below 4 GB? For ARM, I
> understand this would be an issue, but does the spec actually mandate
> anything like this?

No, I don't think it's inherently necessary to put ECAM under 4GB.

It's just that I approached the problem such that the firmware would be
burdened with the lion's share of the complexity, in order to keep
things "compatible" for the rest of the guest world.

(Speaking personally, I'd absolutely prefer to keep the DRAM base
untouched, at 1GB, but I was invited to take a good hard look at what
moving the DRAM base would take for the firmware, and I made an honest
effort to determine the impact. It doesn't imply that I like the result
in the least, or that I personally subscribe to the idea.)

Thanks!
Laszlo
