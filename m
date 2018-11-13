Received: from eggs.gnu.org ([2001:4830:134:3::10]:42931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gMb00-000777-Py
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gMazy-0007Mm-0H
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:53:08 -0500
Message-ID: <d316de9ed544575a3c9f22882dd8befdf6e0309f.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 13 Nov 2018 16:52:55 +0100
In-Reply-To: <CAKmqyKMM=M-1G15k-0Rgo7+sp-jnq31z=GqcHaciXx5TuHNE2Q@mail.gmail.com>
References: <cover.1540937826.git.alistair.francis@wdc.com>
	<3f834825634e34ad107fe9e7af1b417cb47fc1f1.camel@redhat.com>
	<CAKmqyKNF+tQFf50BCj91_RypYeHbnoZLvpm8gH71iW1og9uWfA@mail.gmail.com>
	<f91286ff09066c577d359b1d185aca9fb7d21331.camel@redhat.com>
	<CAKmqyKMM=M-1G15k-0Rgo7+sp-jnq31z=GqcHaciXx5TuHNE2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Wed, 2018-11-07 at 13:47 -0800, Alistair Francis wrote:
> I don't think there is even MSI support in the interrupt spec (I
> haven't looked at all though), yet alone in QEMU. Unfortunately it
> seems low down on the list of things we need to do so it will probably
> be awhile.

That's perfectly fine; just be aware of the fact that, until
pcie-root-port can be used successfully, libvirt users will still
get virtio-mmio by default for RISC-V guests and will have to jump
through significant hoops in order to use virtio-pci instead.

-- 
Andrea Bolognani / Red Hat / Virtualization
