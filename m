Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E89C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801632147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801632147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDU4h-0004Ui-RG
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:12:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDU3k-00040E-DT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDU3i-0003Y1-IV
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hDU3i-0003Xq-7l; Mon, 08 Apr 2019 09:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53E6C307D983;
	Mon,  8 Apr 2019 13:11:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D64D75D9C9;
	Mon,  8 Apr 2019 13:11:31 +0000 (UTC)
Date: Mon, 8 Apr 2019 15:11:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190408151127.19d45f24@redhat.com>
In-Reply-To: <1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 08 Apr 2019 13:11:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/9] cpu/topology: add ARM support for smp
 machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, like.xu@intel.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408131127.WGUEFyT-pRgjn12708rCNcWKK4Ibk8-x7ieVHM5eD3U@z>

On Fri, 29 Mar 2019 16:48:40 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  hw/arm/fsl-imx6.c      | 5 +++++
>  hw/arm/fsl-imx6ul.c    | 5 +++++
>  hw/arm/fsl-imx7.c      | 5 +++++
>  hw/arm/highbank.c      | 1 +
>  hw/arm/mcimx6ul-evk.c  | 1 +
>  hw/arm/mcimx7d-sabre.c | 3 +++
>  hw/arm/raspi.c         | 2 ++
>  hw/arm/realview.c      | 1 +
>  hw/arm/sabrelite.c     | 1 +
>  hw/arm/vexpress.c      | 3 +++
>  hw/arm/virt.c          | 7 +++++++
>  hw/arm/xlnx-zynqmp.c   | 7 +++++++
>  target/arm/cpu.c       | 7 +++++++
>  13 files changed, 48 insertions(+)
> 
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 7b7b97f..efed3a4 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -23,6 +23,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "hw/arm/fsl-imx6.h"
> +#include "hw/boards.h"
>  #include "sysemu/sysemu.h"
>  #include "chardev/char.h"
>  #include "qemu/error-report.h"
> @@ -33,9 +34,11 @@
>  
>  static void fsl_imx6_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6State *s = FSL_IMX6(obj);
>      char name[NAME_SIZE];
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
this is so broken, one creates all cpus here and ...

>          snprintf(name, NAME_SIZE, "cpu%d", i);
> @@ -93,9 +96,11 @@ static void fsl_imx6_init(Object *obj)
>  
>  static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6State *s = FSL_IMX6(dev);
>      uint16_t i;
>      Error *err = NULL;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      if (smp_cpus > FSL_IMX6_NUM_CPUS) {
>          error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
than checks for validity later.

(***)
Replacing smp_cpus with another global var in the form qdev_get_machine()
ain't much of improvement.
I suggest adding smp_cpus property here/set it from caller
and then move initializing cpus to realize time after this check.

The same same applies to other similar cases below.

> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 4b56bfa..426bf8e 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -23,14 +23,17 @@
>  #include "hw/misc/unimp.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/error-report.h"
> +#include "hw/boards.h"
>  
>  #define NAME_SIZE 20
>  
>  static void fsl_imx6ul_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6ULState *s = FSL_IMX6UL(obj);
>      char name[NAME_SIZE];
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
>          snprintf(name, NAME_SIZE, "cpu%d", i);
> @@ -156,10 +159,12 @@ static void fsl_imx6ul_init(Object *obj)
>  
>  static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6ULState *s = FSL_IMX6UL(dev);
>      int i;
>      qemu_irq irq;
>      char name[NAME_SIZE];
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
>          error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 7663ad6..b759f7b 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -25,11 +25,14 @@
>  #include "hw/misc/unimp.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/error-report.h"
> +#include "hw/boards.h"
>  
>  #define NAME_SIZE 20
>  
>  static void fsl_imx7_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      FslIMX7State *s = FSL_IMX7(obj);
>      char name[NAME_SIZE];
>      int i;
> @@ -155,11 +158,13 @@ static void fsl_imx7_init(Object *obj)
>  
>  static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX7State *s = FSL_IMX7(dev);
>      Object *o;
>      int i;
>      qemu_irq irq;
>      char name[NAME_SIZE];
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      if (smp_cpus > FSL_IMX7_NUM_CPUS) {
>          error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 96ccf18..58c77f6 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -240,6 +240,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>      SysBusDevice *busdev;
>      qemu_irq pic[128];
>      int n;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>      qemu_irq cpu_irq[4];
>      qemu_irq cpu_fiq[4];
>      qemu_irq cpu_virq[4];
> diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
> index fb2b015..29fb706 100644
> --- a/hw/arm/mcimx6ul-evk.c
> +++ b/hw/arm/mcimx6ul-evk.c
> @@ -29,6 +29,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
>      static struct arm_boot_info boot_info;
>      MCIMX6ULEVK *s = g_new0(MCIMX6ULEVK, 1);
>      int i;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      if (machine->ram_size > FSL_IMX6UL_MMDC_SIZE) {
>          error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> index 9c5f0e7..c2cdaf9 100644
> --- a/hw/arm/mcimx7d-sabre.c
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -20,6 +20,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> +#include "hw/boards.h"
>  
>  typedef struct {
>      FslIMX7State soc;
> @@ -28,10 +29,12 @@ typedef struct {
>  
>  static void mcimx7d_sabre_init(MachineState *machine)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      static struct arm_boot_info boot_info;
>      MCIMX7Sabre *s = g_new0(MCIMX7Sabre, 1);
>      Object *soc;
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
>          error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 66899c2..8ab8e10 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -113,6 +113,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>  {
>      static struct arm_boot_info binfo;
>      int r;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      binfo.board_id = raspi_boardid[version];
>      binfo.ram_size = ram_size;
> @@ -174,6 +175,7 @@ static void raspi_init(MachineState *machine, int version)
>      BlockBackend *blk;
>      BusState *bus;
>      DeviceState *carddev;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      object_initialize(&s->soc, sizeof(s->soc),
>                        version == 3 ? TYPE_BCM2837 : TYPE_BCM2836);
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index 242f5a8..517c275 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -69,6 +69,7 @@ static void realview_init(MachineState *machine,
>      NICInfo *nd;
>      I2CBus *i2c;
>      int n;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>      int done_nic = 0;
>      qemu_irq cpu_irq[4];
>      int is_mpcore = 0;
> diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
> index ee140e5..108faab 100644
> --- a/hw/arm/sabrelite.c
> +++ b/hw/arm/sabrelite.c
> @@ -47,6 +47,7 @@ static void sabrelite_init(MachineState *machine)
>  {
>      IMX6Sabrelite *s = g_new0(IMX6Sabrelite, 1);
>      Error *err = NULL;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      /* Check the amount of memory is compatible with the SOC */
>      if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index f07134c..1927d12 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -206,9 +206,11 @@ struct VEDBoardInfo {
>  static void init_cpus(const char *cpu_type, const char *privdev,
>                        hwaddr periphbase, qemu_irq *pic, bool secure, bool virt)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
pass machine as argument instead.

>      DeviceState *dev;
>      SysBusDevice *busdev;
>      int n;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      /* Create the actual CPUs */
>      for (n = 0; n < smp_cpus; n++) {
> @@ -558,6 +560,7 @@ static void vexpress_common_init(MachineState *machine)
>      MemoryRegion *flash0mem;
>      const hwaddr *map = daughterboard->motherboard_map;
>      int i;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      daughterboard->init(vms, machine->ram_size, machine->cpu_type, pic);
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ce2664a..ff1dff3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -555,11 +555,13 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
>  
>  static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>  {
> +    MachineState *ms = MACHINE(vms);
>      /* We create a standalone GIC */
>      DeviceState *gicdev;
>      SysBusDevice *gicbusdev;
>      const char *gictype;
>      int type = vms->gic_version, i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      uint32_t nb_redist_regions = 0;
>  
>      gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
> @@ -984,10 +986,12 @@ static void create_flash(const VirtMachineState *vms,
>  
>  static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
>  {
> +    MachineState *ms = MACHINE(vms);
>      hwaddr base = vms->memmap[VIRT_FW_CFG].base;
>      hwaddr size = vms->memmap[VIRT_FW_CFG].size;
>      FWCfgState *fw_cfg;
>      char *nodename;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
> @@ -1423,6 +1427,8 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>      bool aarch64 = true;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> +    unsigned int max_cpus = machine->topo.max_cpus;
>  
>      /*
>       * In accelerated mode, the memory map is computed earlier in kvm_type()
> @@ -1786,6 +1792,7 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int n;
> +    unsigned int max_cpus = ms->topo.max_cpus;
>      VirtMachineState *vms = VIRT_MACHINE(ms);
>  
>      if (ms->possible_cpus) {
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 4f8bc41..29b9427 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -19,6 +19,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> +#include "hw/boards.h"
>  #include "hw/arm/xlnx-zynqmp.h"
>  #include "hw/intc/arm_gic_common.h"
>  #include "exec/address-spaces.h"
> @@ -174,8 +175,10 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>  static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>                                     Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      Error *err = NULL;
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>  
>      if (num_rpus <= 0) {
> @@ -221,8 +224,10 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>  
>  static void xlnx_zynqmp_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>  
>      object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
> @@ -290,10 +295,12 @@ static void xlnx_zynqmp_init(Object *obj)
>  
>  static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      XlnxZynqMPState *s = XLNX_ZYNQMP(dev);
>      MemoryRegion *system_memory = get_system_memory();
>      uint8_t i;
>      uint64_t ram_size;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>      const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>      ram_addr_t ddr_low_size, ddr_high_size;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 4155782..e5d7e3b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -30,6 +30,7 @@
>  #include "hw/qdev-properties.h"
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/loader.h"
> +#include "hw/boards.h"
>  #endif
>  #include "hw/arm/arm.h"
>  #include "sysemu/sysemu.h"
> @@ -1183,6 +1184,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      init_cpreg_list(cpu);
>  
>  #ifndef CONFIG_USER_ONLY
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> +
>      if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
>          cs->num_ases = 2;
>  
> @@ -1713,6 +1717,9 @@ static void cortex_a9_initfn(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
for both hunks the same as [***]

> +
>      /* Linux wants the number of processors from here.
>       * Might as well set the interrupt-controller bit too.
>       */


