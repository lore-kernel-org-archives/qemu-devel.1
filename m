Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vk0-0004G1-P1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vjw-00013h-T3
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2vjw-00013I-Mx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:44 -0400
Date: Fri, 13 Oct 2017 10:54:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171013105438.41daaad8@nial.brq.redhat.com>
In-Reply-To: <cover.1507852977.git.alistair.francis@xilinx.com>
References: <cover.1507852977.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Thu, 12 Oct 2017 17:07:23 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> There are numorous QEMU machines that only have a single or a handful of
> valid CPU options. To simplyfy the management of specificying which CPU
> is/isn't valid let's create a property that can be set in the machine
> init. We can then check to see if the user supplied CPU is in that list
> or not.
> 
> I have added the valid_cpu_types for some ARM machines only at the
> moment.
do you plan to complete work for other boards as well
so that new interface would replace current opencoded
checks across the tree?


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
> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
> 
> V2:
>  - Rebase
>  - Reorder patches
>  - Add a Raspberry Pi 2 CPU fix
> V1:
>  - Small fixes to prepare a series instead of RFC
>  - Add commit messages for the commits
>  - Expand the machine support to ARM machines
> RFC v2:
>  - Rebase on Igor's work
>  - Use more QEMUisms inside the code
>  - List the supported machines in a NULL terminated array
> 
> Alistair Francis (5):
>   netduino2: Specify the valid CPUs
>   bcm2836: Use the Cortex-A7 instead of Cortex-A15
>   raspi: Specify the valid CPUs
>   xlnx-zcu102: Specify the valid CPUs
>   xilinx_zynq: : Specify the valid CPUs
> 
>  hw/arm/bcm2836.c     |  2 +-
>  hw/arm/netduino2.c   | 10 +++++++++-
>  hw/arm/raspi.c       |  7 +++++++
>  hw/arm/xilinx_zynq.c |  6 ++++++
>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>  5 files changed, 40 insertions(+), 2 deletions(-)
> 
