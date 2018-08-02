Received: from eggs.gnu.org ([2001:4830:134:3::10]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flHeR-0006x2-4N
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flHeO-0007Of-0U
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:44:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1flHeN-0007N6-Os
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:44:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id a26-v6so1731039pfo.4
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 10:44:35 -0700 (PDT)
Date: Thu, 02 Aug 2018 10:44:32 -0700 (PDT)
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-df1b106f-72bb-4857-9acc-4095019307e4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alistair23@gmail.com, Michael Clark <mjc@sifive.com>

On Fri, 22 Jun 2018 12:28:14 PDT (-0700), alistair.francis@wdc.com wrote:
> Alistair Francis (5):
>   hw/riscv/virtio: Set the soc device tree node as a simple-bus
>   hw/riscv/virt: Increase the number of interrupts
>   hw/riscv/virt: Connect the Xilinx PCIe
>   hw/riscv/virt: Connect a VGA PCIe device
>   riscv64-softmmu.mak: Build Virtio Block support
>
>  default-configs/riscv32-softmmu.mak |  6 +++
>  default-configs/riscv64-softmmu.mak |  8 ++++
>  hw/riscv/virt.c                     | 73 ++++++++++++++++++++++++++++-
>  include/hw/riscv/virt.h             |  6 ++-
>  4 files changed, 90 insertions(+), 3 deletions(-)

Sorry I'm so slow here, I'm still chewing through my patch backlog.  It looks 
like this hasn't made it upstream yet.  I rebased it on top of master but have 
yet to figure out how to make it work, though I think that's on the Linux side.

I haven't yet looked at the code, but I like the functionality so I don't want 
to lose this.  Can you submit a v2 that applies cleanly to master, or do you 
want me to deal with it?
