Received: from eggs.gnu.org ([2001:4830:134:3::10]:34327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTvdb-0003Og-1c
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTvdX-0005hc-4g
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:11:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTvdW-0005gx-RG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:11:11 -0500
References: <20170112182446.9600-1-lersek@redhat.com>
	<20170112182446.9600-3-lersek@redhat.com>
	<20170113140914.62af8755@nial.brq.redhat.com>
	<32d3f5cf-9428-29db-45bb-d3a35c6cbd04@redhat.com>
	<20170117122131.466d4147@nial.brq.redhat.com>
	<bbd7f2a5-cdec-aaf3-acfb-c99ce9054a3c@redhat.com>
	<20170117142059.3a7689de@nial.brq.redhat.com>
	<17a61164-0cb8-98fd-b340-8cb3a27edb0e@redhat.com>
	<20170117152056.4e37468e@nial.brq.redhat.com>
	<ce81a37b-231c-6a7d-feae-bbf5b6cd45a1@redhat.com>
	<20170118110353.3f2ac8a3@nial.brq.redhat.com>
	<98895612-58dd-f0cb-e761-515f9e29c373@redhat.com>
	<e94a097e-274b-b26a-ec89-70929c422c69@redhat.com>
	<20170118133844.75422b55@nial.brq.redhat.com>
	<73c6dc4e-805e-a9a1-712d-7373a3409b66@redhat.com>
	<20170118172608.0db201ce@nial.brq.redhat.com>
	<e0eabf75-dd4e-2c66-ce56-232a4dc262d2@redhat.com>
	<20170118190659.67b96115@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <51ca917e-ceb6-0c26-56e6-070e4577af67@redhat.com>
Date: Wed, 18 Jan 2017 20:11:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170118190659.67b96115@nial.brq.redhat.com>
Content-Type: multipart/mixed; boundary="------------4A884F08AC125E4DFAD0F149"
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 2/3] hw/isa/lpc_ich9: add
 broadcast SMI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Michael Kinney <michael.d.kinney@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

This is a multi-part message in MIME format.
--------------4A884F08AC125E4DFAD0F149
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 01/18/17 19:06, Igor Mammedov wrote:
> On Wed, 18 Jan 2017 18:23:45 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 

[snip]

>> If you agree with my participation as outlined above; that is,
>> - I care about this exact patch, as posted,
>> - someone else looks into cpu_synchronize_all_states(),
> CCing Radim who graciously agreed to take a look what wrong from KVM side,

Thank you, Radim!

> Could you give him steps to reproduce issue, pls.

Absolutely.

(1) My laptop is a ThinkPad W541, with an i7-4810MQ CPU. Quad-core with
HT enabled. It supports "unrestricted_guest" and both EPT and EPTAD. For
completeness, here are my current KVM/Intel module parameters:

> ==> /sys/module/kvm_intel/parameters/emulate_invalid_guest_state <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/enable_apicv <==
> N
>
> ==> /sys/module/kvm_intel/parameters/enable_shadow_vmcs <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/ept <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/eptad <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/fasteoi <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/flexpriority <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/nested <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/ple_gap <==
> 128
>
> ==> /sys/module/kvm_intel/parameters/ple_window <==
> 4096
>
> ==> /sys/module/kvm_intel/parameters/ple_window_grow <==
> 2
>
> ==> /sys/module/kvm_intel/parameters/ple_window_max <==
> 1073741823
>
> ==> /sys/module/kvm_intel/parameters/ple_window_shrink <==
> 0
>
> ==> /sys/module/kvm_intel/parameters/pml <==
> N
>
> ==> /sys/module/kvm_intel/parameters/unrestricted_guest <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/vmm_exclusive <==
> Y
>
> ==> /sys/module/kvm_intel/parameters/vpid <==
> Y

and the CPU flags:

> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>                   mca cmov pat pse36 clflush dts acpi mmx fxsr sse
>                   sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm
>                   constant_tsc arch_perfmon pebs bts rep_good nopl
>                   xtopology nonstop_tsc aperfmperf eagerfpu pni
>                   pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2
>                   ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
>                   movbe popcnt tsc_deadline_timer aes xsave avx f16c
>                   rdrand lahf_lm abm ida arat epb pln pts dtherm
>                   tpr_shadow vnmi flexpriority ept vpid fsgsbase
>                   tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt

(2) My host kernel is a semi-recent RHEL7 development kernel,
3.10.0-537.el7.x86_64. Other than that, the system is a fairly
un-modified RHEL-7.3.z install.

(3) QEMU was configured with:

  ./configure \
    --target-list=x86_64-softmmu,i386-softmmu \
    --audio-drv-list=alsa \
    --enable-werror \
    --enable-spice \
    --disable-gtk \
    --enable-trace-backends=log \
    --disable-stack-protector \
    --enable-debug

(I have the SDL devel packages installed, so for graphical display, the
above config will select SDL.)

(4) The QEMU tree comes together from the following "layers":

* baseline:
  current-ish master (0f2d17c1a59c9f11e7a874fb56fee3714b101705)

* on top of that:
  [PATCH v6 wave 1 0/4] fw-cfg: support writeable blobs and more files
  [PATCH v6 wave 2 0/3] q35: add negotiable broadcast SMI
  (please see the mailing list archive links in
  <https://bugzilla.redhat.com/show_bug.cgi?id=1412327#c3>)

* on top of that, apply the attached patch called "filter.patch".

(5) Download the "OVMF_CODE.32.fd" and "OVMF_VARS.fd" files from
<http://people.redhat.com/~lersek/bcast-smi-filter-428b6508-b3d6-4dd4-a329-691aa1eba80e/>.

This is an Ia32, -D SMM_REQUIRE build of OVMF, approximately at current
master, with my pending (not as yet posted) broadcast SMI enablement
patches on top, *plus* a trivial one-line debug patch that logs every
time the Trigger() function is called, and OVMF is about to write the
APM_CNT IO port.

(6) Run QEMU with the following commands:

  cp OVMF_VARS.fd varstore.fd

  qemu-system-i386 \
  \
  -machine pc-q35-2.9,smm=on,accel=kvm \
  -global driver=cfi.pflash01,property=secure,value=on \
  -smp cpus=4 \
  -cpu coreduo,-nx \
  \
  -m 2048 \
  \
  -device qxl-vga \
  -net none \
  \
  -drive if=pflash,readonly,format=raw,file=OVMF_CODE.32.fd \
  -drive if=pflash,format=raw,file=varstore.fd \
  \
  -debugcon file:debug.log \
  -global isa-debugcon.iobase=0x402 \
  \
  -chardev stdio,signal=off,mux=on,id=char0 \
  -mon chardev=char0,mode=readline \
  -serial chardev:char0

Without "filter.patch" applied, you should be reaching the UEFI shell
real quick.

With "filter.patch" applied, the boot will appear hung. However, if you
follow the OVMF debug log, written to the file "debug.log", from another
terminal, for example with "tail -f", you see that the boot is actually
progressing, just extremely slowly.

Every time the firmware is about to raise the SMI via the APM_CNT IO
port write, the debug log will say "SmmControl2DxeTrigger: 111", and
that's when the boot stalls for about one second (with one VCPU pegged
100%).

> 
>> - and then I'm willing to care about the incremental patch for the
>>   filtering,
> ok
> 
> 
>> then I propose we go ahead with this patch. It's the last one in the
>> series that needs your R-b.
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thank you very much for working through this with me.

Next question: who can pick this up please? Michael indicated he'd
prefer Paolo. Paolo, do you agree?

Thanks,
Laszlo

--------------4A884F08AC125E4DFAD0F149
Content-Type: text/x-patch;
 name="filter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="filter.patch"

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 59930dd9d09d..701a0821705b 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -50,6 +50,7 @@
 #include "qom/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 /*****************************************************************************/
 /* ICH9 LPC PCI to ISA bridge */
@@ -423,6 +424,29 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
 
 /* APM */
 
+static void ich9_apm_broadcast_smi(void)
+{
+    CPUState *cs;
+
+    pause_all_vcpus();
+    cpu_synchronize_all_states();
+    CPU_FOREACH(cs) {
+        X86CPU *cpu = X86_CPU(cs);
+        CPUX86State *env = &cpu->env;
+
+        if (env->smbase == 0x30000 && env->eip == 0xfff0) {
+            CPUClass *k = CPU_GET_CLASS(cs);
+            uint64_t cpu_arch_id = k->get_arch_id(cs);
+
+            trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_SMI);
+    }
+    resume_all_vcpus();
+}
+
 static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
 {
     ICH9LPCState *lpc = arg;
@@ -439,10 +463,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
         if (lpc->smi_negotiated_features &
             (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
-            CPUState *cs;
-            CPU_FOREACH(cs) {
-                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
-            }
+            ich9_apm_broadcast_smi();
         } else {
             cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
         }
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 9faca41a975d..a0df525d042a 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -7,3 +7,6 @@ pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
 pc87312_info_parallel(uint32_t base, uint32_t irq) "base 0x%x, irq %u"
 pc87312_info_serial(int n, uint32_t base, uint32_t irq) "id=%d, base 0x%x, irq %u"
+
+# hw/isa/lpc_ich9.c
+ich9_apm_broadcast_smi_skip(uint64_t cpu_arch_id) "cpu_arch_id=0x%"PRIx64

--------------4A884F08AC125E4DFAD0F149--
