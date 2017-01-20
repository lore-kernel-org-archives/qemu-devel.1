Received: from eggs.gnu.org ([2001:4830:134:3::10]:58107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUbFn-0002Kd-OD
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUbFm-0006iM-U9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:37:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUbFm-0006hF-Nr
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:37:26 -0500
Date: Fri, 20 Jan 2017 16:37:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170120163722.11ca9ce6@nial.brq.redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/13] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

On Wed, 18 Jan 2017 18:13:16 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

[...]
>   pc: cleanup: move smbios_set_cpuid() into pc_build_smbios()
>   pc: don't return cpu pointer from pc_new_cpu() as it's not needed
>     anymore
>   make possible_cpu_arch_ids() return const pointer
Eduardo,

Could you review/merge 2-4/13 as generic cleanups to PC code
so I won't spam list with them on respin?

>   pc: move pcms->possible_cpus init out of pc_cpus_init()
>   pc: calculate topology only once when possible_cpus is initialised
>   pc: pass apic_id to pc_find_cpu_slot() directly so lookup could be
>     done without CPU object
>   pc: add writeonly 'cpu' property to PCMachine
>   numa: introduce '-numa cpu' cpu option
>   numa: replace cpu_index_to_socket_id() with
>     cpu_index_to_instance_props()
>   numa: use new machine.cpu property with -numa cpus=... CLI
>   pc: drop usage of legacy numa_get_node_for_cpu()
>   pc: cpu: make sure that cpu.node-id matches -numa mapping
> 
>  include/hw/acpi/acpi_dev_interface.h |   2 +-
>  include/hw/boards.h                  |  14 ++-
>  include/hw/i386/pc.h                 |   2 +-
>  include/qom/cpu.h                    |   2 -
>  include/sysemu/numa.h                |   3 +-
>  target/arm/cpu.h                     |   2 +
>  target/i386/cpu.h                    |   1 +
>  target/ppc/cpu.h                     |   2 +
>  hw/acpi/cpu.c                        |  13 +--
>  hw/acpi/cpu_hotplug.c                |   4 +-
>  hw/arm/virt.c                        |  12 +-
>  hw/i386/acpi-build.c                 |  25 ++---
>  hw/i386/pc.c                         | 210 +++++++++++++++++++++++------------
>  hw/ppc/spapr.c                       |  15 ++-
>  hw/ppc/spapr_cpu_core.c              |   2 +-
>  monitor.c                            |   7 +-
>  numa.c                               |  89 +++++++++++----
>  qapi-schema.json                     |   3 +-
>  stubs/pc_madt_cpu_entry.c            |   2 +-
>  target/arm/cpu.c                     |   1 +
>  target/i386/cpu.c                    |   1 +
>  target/ppc/translate_init.c          |   1 +
>  vl.c                                 |   4 +-
>  23 files changed, 269 insertions(+), 148 deletions(-)
> 
