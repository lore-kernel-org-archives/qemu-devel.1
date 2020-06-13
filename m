Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE4BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877FF20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877FF20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkDyR-0006kw-O0
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDx5-00058K-7m; Sat, 13 Jun 2020 17:44:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42886 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDx2-000340-1c; Sat, 13 Jun 2020 17:44:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 12674BF89475B5D65B4E;
 Sun, 14 Jun 2020 05:44:20 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:11 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Date: Sat, 13 Jun 2020 22:36:07 +0100
Message-ID: <20200613213629.21984-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch-set introduces the virtual cpu hotplug support for ARMv8
architecture in QEMU. Idea is to be able to hotplug and hot-unplug the vcpus
while guest VM is running and no reboot is required. This does *not* makes any
assumption of the physical cpu hotplug availability within the host system but
rather tries to solve the problem at virtualizer/QEMU layer and by introducing
cpu hotplug hooks and event handling within the guest kernel. No changes are
required within the host kernel/KVM.

Motivation:
This allows scaling the guest VM compute capacity on-demand which would be
useful for the following example scenarios,
1. Vertical Pod Autoscaling[3][4] in the cloud: Part of the orchestration
   framework which could adjust resource requests (CPU and Mem requests) for
   the containers in a pod, based on usage.
2. Pay-as-you-grow Business Model: Infrastructure provider could allocate and
   restrict the total number of compute resources available to the guest VM
   according to the SLA(Service Level Agreement). VM owner could request for
   more compute to be hot-plugged for some cost.

Terminology:

(*) Present cpus: Total cpus with which guest has/will boot and are available
                  to guest for use and can be onlined. Qemu parameter(-smp)
(*) Disabled cpus: Possible cpus which will not be available for the guest to
                   use. These can be hotplugged and made present. These can be
		   thought of as un-plugged vcpus. These will be included as
		   part of sizing.
(*) Posssible cpus: Total vcpus which could ever exist in VM. This includes
                    booted cpus plus any cpus which could be later plugged.
		    - Qemu parameter(-maxcpus)
	            - Possible vcpus = Present vcpus (+) Disabled vcpus


Limitations of ARMv8 Architecture:

A. Physical Limitation to CPU Hotplug:
1. ARMv8 architecture does not support the concept of the physical cpu hotplug.
   The closest thing which is recomended to achieve the cpu hotplug on ARM is
   to bring down power state of the cpu using PSCI.
2. Other ARM components like GIC etc. have not been designed to realize
   physical cpu hotplug capability as of now. 

B. Limitations of GIC to Support Virtual CPU Hotplug:
1. GIC requires various resources(related to GICR/redistributor, GICC/cpu
   interface etc) like memory regions to be fixed at the VM init time and these
   could not be changed later on after VM has inited.
2. Associations between GICC(GIC cpu interface) and vcpu get fixed at the VM
   init time and GIC does not allows to change this association once GIC has
   initialized.

C. Known Limitation of the KVM:
1. As of now KVM allows to create VCPUs but does not allows to delete the
   already created vcpus. QEMU already provides an interface to manage created
   vcpus at KVM level and then to re-use them.
2. Inconsistency in interpretation of the MPIDR generated by KVM for vcpus
   vis-a-vis SMT/threads. This does not looks to be compliant to the MPIDR
   format(SMT is present) as mentioned in the ARMv8 spec. (Please correct my
   understanding if I am wrong here?)
   

Workaround to the problems mentioned in Section B & C1:
1. We pre-size the GIC with possible vcpus at VM init time
2. Pre-create all possible vcpus at KVM and associate them with GICC 
3. Park the unplugged vcpus (similar to x86)


(*) For all of above please refer to Marc's suggestion here[1]


Overview of the Approach:
At the time of machvirt_init() we pre-create all of the possible ARMCPU
objects along with the corresponding KVM vcpus at the host. Disabled KVM vcpu
(which are *not* "present" vcpus but are part of "possible" vcpu list) are
parked at per VM list "kvm_parked_vcpus" after their initialization.

We create the ARMCPU objects(but these are not *realized* in QOM sense) even
for the disabled vcpus to facilitate the GIC initialization (pre-sized with
possible vcpus). After Initialization of the machine is complete we release
the ARMCPU Objects for the disabled vcpus. These ARMCPU object shall be
re-created at the time when vcpu is hot plugged. This new object is then
re-attached with the earlier parked KVM vcpu which also gets unparked. The
ARMCPU object gets now "realized" in QEMU, which means creation of the
corresponding threads, pre_plug/plug phases, and event notification to the
guest using ACPI GED etc. Similarly, hot-unplug leg will lead to the
"unrealization" of the vcpus and will lead to similar ACPI GED events to the
guest for unplug and cleanup and eventually ARMCPU object shall be released and
KVM vcpus shall be parked again.

During machine init, ACPI MADT Table is sized with *possible* vcpus GICC
entries. The unplugged/disabled vcpus are presented as MADT GICC DISABLED
entries to the guest. This means the guest will have its resources pre-sized
with possible vcpus(=present+disabled)

Other approaches to deal with ARMCPU object release(after machine init):
1. The ARMCPU objects for the disabled vcpus are released in context to the
   virt_machine_done() notifier(approach adopted in this patch-set). 
2. Defer the release of current ARMCPU object till the new vcpu object is
   hot plugged.
3. Never release and keep on reusing them and release once at VM exit. This
   solves many problems with above 2 approaches but requires change in the way
   qdev_device_add() fetches/creates the ARMCPU object for the new vcpus being
   hotplugged. For the arm cpu hotplug case we need to figure out way how to
   get access to old object and use it to "re-realize" instead of the new
   ARMCPU object.

Concerns/Questions:
1. In ARM arch a cpu is uniquely represented in hierarchy using various
   affinity levels which could represent thread, core, cluster, package. This
   is generally represented by a value in MPIDR register as per the format
   mentioned in specification. Now, the way MPIDR value is derived for vcpus is
   done using vcpu-index. The concept of thread is not quite as same and rather
   gets lost in the derivation of MPIDR for vcpus.
2. The topology info used to specify the vcpu while hot-plugging might not
   match with the MPIDR value given back by the KVM for the vcpu at the time of
   init. Concept of SMT bit in MPIDR gets lost as per the derivation being done
   in the KVM. Hence, concept of thread-id, core-id, socket-id if used as a
   topology info to derive MPIDR value as per ARM specification will not match
   with MPIDR actually assigned by the KVM? 
   Perhaps need to carry forward work of Andrew? please check here[2]
3. Further if this info is supplied to the guest using PPTT(once introduced in
   QEMU) or even derived using MPIDR shall be inconsistent with the host vcpu. 
4. Any possibilities of interrupts(SGI/PPI/LPI/SPI) always remaining in
   *pending* state for the cpus which have been hot-unplugged? IMHO it looks
   okay but will need Marc's confirmation on this. 
5. If the ARMCPU object is released after the machine init, UEFI could call
   back virt_update_table() to re-build the ACPI tables which might need an
   ARMCPU object. Please check the discussion here[5]


Commands Used:

A. Qemu launch commands to init the machine

$ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
-cpu host -smp cpus=4,maxcpus=6 \
-m 300M \
-kernel Image \
-initrd rootfs.cpio.gz \
-append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
-nographic \
-bios  QEMU_EFI.fd \

B. Hot-(un)plug related commands

# Hotplug a host vcpu(accel=kvm)
$ device_add host-arm-cpu,id=core4,core-id=4

# Hotplug a vcpu(accel=tcg)
$ device_add cortex-a57-arm-cpu,id=core4,core-id=4

# Delete the vcpu
$ device_del core4

NOTE: I have not tested the current solution with '-device' interface. The use
      is suggested by Igor here[6]. I will test this in coming times but looks
      it should work with existing changes. 


Sample output on guest after boot:

$ cat /sys/devices/system/cpu/possible
0-5
$ cat /sys/devices/system/cpu/present
0-3
$ cat /sys/devices/system/cpu/online
0-1
$ cat /sys/devices/system/cpu/offline
2-5


Sample output on guest after hotplug of vcpu=4:

$ cat /sys/devices/system/cpu/possible
0-5
$ cat /sys/devices/system/cpu/present
0-4
$ cat /sys/devices/system/cpu/online
0-1,4
$ cat /sys/devices/system/cpu/offline
2-3,5

Note: vcpu=4 was explicitly 'onlined' after hot-plug
$ echo 1 > /sys/devices/system/cpu/cpu4/online


Repository:
 (*) QEMU changes for vcpu hotplug could be cloned from below site,
     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v1

 (*) Guest Kernel changes required to co-work with the QEMU shall be posted soon
     and repo made available at above site. 


THINGS TO DO:
 (*) Migration support 
 (*) TCG/Emulation support is not proper right now. Works to a certain extent
     but is not complete. especially the unrealize part in which there is a
     overflow of tcg contexts. The last is due to the fact tcg maintains a 
     count on number of context(per thread instance) so as we hotplug the vcpus
     this counter keeps on incrementing. But during hot-unplug the counter is
     not decremented.
 (*) Support of hotplug with NUMA is not proper
 (*) CPU Topology right now is not specified using thread/core/socket but 
     rather flatly indexed using core-id. This needs consideration[2].
 (*) Do we need PPTT Support for to specify right topology info to guest about
     hot-plugged or unplugged vcpus?
 (*) Test cases
 (*) Docs need to be updated.


DISCLAIMER:
This is not a complete work but an effort to present the arm vcpu hotplug
implementation to the community. This work is *mostly* in the lines of the
discussions which have happened in the previous years[see refs below]. This
RFC is being used as a way to verify the idea mentioned above and to further
get community views. As of now this is *not* a production level code and might
have bugs. Only a basic testing has been done on HiSilicon Kunpeng920 SoC for
Servers to verify the proof-of-concept. But the concept works!

ACKNOWLEDGEMENTS:
Although this is just a start of work but I would like to take this opportunity
to thank Marc Zyngier, Igor mammedov, James Morse, Andre, Sudeep Holla, Andrew
Jones, Jonathan Cameron, Shameer, Xuwei/Joy, Zengtao/Prime for discussions at
various points with me. Special thanks to Zhukeqian & Wangxiongfeng for their
contributions in the QEMU and the kernel part. And to the other people of
community who have been involved in the discussions in the past related to this
work and have pitched-in their ideas.

Best regards
Salil.

REFERENCES:
[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
[3] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
[4] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html 
[5] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
[6] https://lkml.org/lkml/2019/7/10/235
[7] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
 

Organization of Patches:
[Patch 1-3] Misc logic pre-cursor to machine init
 (*) some validation checks
 (*) introduces core-id property and some util functions required later.
[Patch 4-7,14] logic required during machine init
 (*) Logic to pre-create vcpus
 (*) GIC initialization pre-sized with possible vcpus.
 (*) some refactoring to have common hot and cold plug logic together.
[Patch 8-13] logic related to ACPI at machine init time
 (*) Changes required to Enable ACPI for cpu hotplug
 (*) Changes to enhance ACPI GED to cater CPU Hotplug Events
 (*) ACPI MADT/MAT changes
[Patch 15-22] Logic required during vcpu hot-(un)plug
 (*) Basic framework changes to suppport vcpu hot-(un)plug
 (*) ACPI GED changes for hot-(un)plug hooks.
 (*) wire-unwire the IRQs 
 (*) GIC notification logic
 (*) ARMCPU unrealize logic
 

Salil Mehta (22):
  arm/cpuhp: Add QMP vcpu params validation support
  arm/cpuhp: Add new ARMCPU core-id property
  arm/cpuhp: Add common cpu utility for possible vcpus
  arm/cpuhp: Machine init time change common to vcpu {cold|hot}-plug
  arm/cpuhp: Pre-create disabled possible vcpus @machine init
  arm/cpuhp: Changes to pre-size GIC with possible vcpus @machine init
  arm/cpuhp: Init PMU at host for all possible vcpus
  arm/cpuhp: Enable ACPI support for vcpu hotplug
  arm/cpuhp: Init GED framework with cpu hotplug events
  arm/cpuhp: Update CPUs AML with cpu-(ctrl)dev change
  arm/cpuhp: Update GED _EVT method AML with cpu scan
  arm/cpuhp: MADT Tbl change to size the guest with possible vcpus
  arm/cpuhp: Add ACPI _MAT entry for Processor object
  arm/cpuhp: Release objects for *disabled* possible vcpus after init
  arm/cpuhp: Update ACPI GED framework to support vcpu hotplug
  arm/cpuhp: Add/update basic hot-(un)plug framework
  arm/cpuhp: Changes to (un)wire GICC<->VCPU IRQs during hot-(un)plug
  arm/cpuhp: Changes to update GIC with vcpu hot-plug notification
  arm/cpuhp: Changes required to (re)init the vcpu register info
  arm/cpuhp: Update the guest(via GED) about cpu hot-(un)plug events
  arm/cpuhp: Changes required for reset and to support next boot
  arm/cpuhp: Add support of *unrealize* ARMCPU during vcpu hot-unplug

 accel/kvm/kvm-all.c                    |  31 ++
 cpus-common.c                          |  20 +
 exec.c                                 |  24 +
 gdbstub.c                              |  13 +
 hw/acpi/cpu.c                          |  34 +-
 hw/acpi/generic_event_device.c         |  54 ++
 hw/arm/Kconfig                         |   1 +
 hw/arm/boot.c                          |   2 +-
 hw/arm/virt-acpi-build.c               |  51 +-
 hw/arm/virt.c                          | 717 +++++++++++++++++++++----
 hw/core/qdev.c                         |   2 +-
 hw/i386/acpi-build.c                   |   2 +-
 hw/intc/arm_gicv3.c                    |   1 +
 hw/intc/arm_gicv3_common.c             |  66 ++-
 hw/intc/arm_gicv3_cpuif.c              | 145 ++---
 hw/intc/arm_gicv3_kvm.c                |  34 +-
 hw/intc/gicv3_internal.h               |   2 +
 include/exec/exec-all.h                |   8 +
 include/exec/gdbstub.h                 |   1 +
 include/hw/acpi/cpu.h                  |   5 +-
 include/hw/acpi/cpu_hotplug.h          |   5 +
 include/hw/acpi/generic_event_device.h |   5 +
 include/hw/arm/boot.h                  |   2 +
 include/hw/arm/virt.h                  |   9 +-
 include/hw/core/cpu.h                  |  23 +
 include/hw/intc/arm_gicv3_common.h     |   2 +
 include/hw/qdev-core.h                 |   2 +
 include/sysemu/kvm.h                   |   2 +
 target/arm/cpu-qom.h                   |   3 +
 target/arm/cpu.c                       |  98 ++++
 target/arm/cpu.h                       |  14 +
 target/arm/cpu64.c                     |   9 +
 target/arm/helper.c                    |  31 ++
 target/arm/internals.h                 |   1 +
 target/arm/kvm.c                       |  32 ++
 target/arm/kvm64.c                     |   7 +-
 target/arm/kvm_arm.h                   |  11 +
 37 files changed, 1260 insertions(+), 209 deletions(-)

-- 
2.17.1



