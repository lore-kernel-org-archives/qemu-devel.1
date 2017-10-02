Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dz5fu-0002Fl-DO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dz5ft-0004nO-JK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:42:42 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dz5ft-0004mS-CK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:42:41 -0400
Received: by mail-wr0-x243.google.com with SMTP id v38so1399178wrc.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 11:42:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1506037164.git.alistair.francis@xilinx.com>
References: <cover.1506037164.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Oct 2017 11:42:09 -0700
Message-ID: <CAKmqyKOo_TJ=9GbYMdCAuEW6kKh8_5bjz9_8f3Ggc85OwWpd+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add a valid_cpu_types property
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 21, 2017 at 4:41 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> There are numorous QEMU machines that only have a single or a handful of
> valid CPU options. To simplyfy the management of specificying which CPU
> is/isn't valid let's create a property that can be set in the machine
> init. We can then check to see if the user supplied CPU is in that list
> or not.
>
> Here is what specifying the CPUs looks like now:
>
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) info cpus
> * CPU #0: thread_id=24175
> (qemu) q
>
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) q
>
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
>
> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
> qemu-system-aarch64: Invalid CPU: cortex-a9-arm-cpu
> The valid options are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>

Any comments on this?

Otherwise I'll prepare a patch series and start adding support for
more machines.

Thanks,
Alistair

> RFC v2:
>  - Rebase on Igor's work
>  - Use more QEMUisms inside the code
>  - List the supported machines in a NULL terminated array
>
> Alistair Francis (2):
>   machine: Add a valid_cpu_types property
>   netduino2: Specify the valid CPUs
>
>  hw/arm/netduino2.c  | 10 +++++++++-
>  hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/boards.h |  1 +
>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> --
> 2.11.0
>
