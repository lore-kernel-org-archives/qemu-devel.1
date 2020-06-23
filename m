Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6229C20768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2XL9NvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6229C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnezP-0003zb-NL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneyh-0003OQ-Qt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:12:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneyf-0006ml-J0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr20HDa6HPBdI2KvYFKaEjpLkeDrAzqOePNOBDeLyKY=;
 b=a2XL9NvB+JjlddxyfqRHrPM9WSGpPQtzcA2FYrfykh5UpJh2lezgjgZbJE1GWb0aWVRxBo
 f/Tjsae71ICw2a07Lsg0lWc0bheP7Rv0psNXZ3EJbpGX0qt+GprplurVKEqetiq9zRro2Y
 uNohlaHwzb7p4EKDJr+2zJ2+i1ejV38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-NgXLvCfaOBW1NVoY6vEKQQ-1; Tue, 23 Jun 2020 05:12:21 -0400
X-MC-Unique: NgXLvCfaOBW1NVoY6vEKQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E3BF804004;
 Tue, 23 Jun 2020 09:12:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 534F160C47;
 Tue, 23 Jun 2020 09:12:05 +0000 (UTC)
Date: Tue, 23 Jun 2020 11:12:02 +0200
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Message-ID: <20200623091202.pbcbvwnk3pdvwyyy@kamzik.brq.redhat.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mehta.salil.lnk@gmail.com, gshan@redhat.com,
 pbonzini@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 david@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 linuxarm@huawei.com, eric.auger@redhat.com, will@kernel.org,
 qemu-arm@nongnu.org, james.morse@arm.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, imammedo@redhat.com, maran.wilson@oracle.com,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 13, 2020 at 10:36:07PM +0100, Salil Mehta wrote:
> This patch-set introduces the virtual cpu hotplug support for ARMv8
> architecture in QEMU. Idea is to be able to hotplug and hot-unplug the vcpus
> while guest VM is running and no reboot is required. This does *not* makes any
> assumption of the physical cpu hotplug availability within the host system but
> rather tries to solve the problem at virtualizer/QEMU layer and by introducing
> cpu hotplug hooks and event handling within the guest kernel. No changes are
> required within the host kernel/KVM.
> 
> Motivation:
> This allows scaling the guest VM compute capacity on-demand which would be
> useful for the following example scenarios,
> 1. Vertical Pod Autoscaling[3][4] in the cloud: Part of the orchestration
>    framework which could adjust resource requests (CPU and Mem requests) for
>    the containers in a pod, based on usage.
> 2. Pay-as-you-grow Business Model: Infrastructure provider could allocate and
>    restrict the total number of compute resources available to the guest VM
>    according to the SLA(Service Level Agreement). VM owner could request for
>    more compute to be hot-plugged for some cost.
> 
> Terminology:
> 
> (*) Present cpus: Total cpus with which guest has/will boot and are available
>                   to guest for use and can be onlined. Qemu parameter(-smp)
> (*) Disabled cpus: Possible cpus which will not be available for the guest to
>                    use. These can be hotplugged and made present. These can be
> 		   thought of as un-plugged vcpus. These will be included as
> 		   part of sizing.
> (*) Posssible cpus: Total vcpus which could ever exist in VM. This includes
>                     booted cpus plus any cpus which could be later plugged.
> 		    - Qemu parameter(-maxcpus)
> 	            - Possible vcpus = Present vcpus (+) Disabled vcpus
> 
> 
> Limitations of ARMv8 Architecture:
> 
> A. Physical Limitation to CPU Hotplug:
> 1. ARMv8 architecture does not support the concept of the physical cpu hotplug.
>    The closest thing which is recomended to achieve the cpu hotplug on ARM is
>    to bring down power state of the cpu using PSCI.
> 2. Other ARM components like GIC etc. have not been designed to realize
>    physical cpu hotplug capability as of now. 
> 
> B. Limitations of GIC to Support Virtual CPU Hotplug:
> 1. GIC requires various resources(related to GICR/redistributor, GICC/cpu
>    interface etc) like memory regions to be fixed at the VM init time and these
>    could not be changed later on after VM has inited.
> 2. Associations between GICC(GIC cpu interface) and vcpu get fixed at the VM
>    init time and GIC does not allows to change this association once GIC has
>    initialized.
> 
> C. Known Limitation of the KVM:
> 1. As of now KVM allows to create VCPUs but does not allows to delete the
>    already created vcpus. QEMU already provides an interface to manage created
>    vcpus at KVM level and then to re-use them.
> 2. Inconsistency in interpretation of the MPIDR generated by KVM for vcpus
>    vis-a-vis SMT/threads. This does not looks to be compliant to the MPIDR
>    format(SMT is present) as mentioned in the ARMv8 spec. (Please correct my
>    understanding if I am wrong here?)
>    
> 
> Workaround to the problems mentioned in Section B & C1:
> 1. We pre-size the GIC with possible vcpus at VM init time
> 2. Pre-create all possible vcpus at KVM and associate them with GICC 
> 3. Park the unplugged vcpus (similar to x86)
> 
> 
> (*) For all of above please refer to Marc's suggestion here[1]
> 
> 
> Overview of the Approach:
> At the time of machvirt_init() we pre-create all of the possible ARMCPU
> objects along with the corresponding KVM vcpus at the host. Disabled KVM vcpu
> (which are *not* "present" vcpus but are part of "possible" vcpu list) are
> parked at per VM list "kvm_parked_vcpus" after their initialization.
> 
> We create the ARMCPU objects(but these are not *realized* in QOM sense) even
> for the disabled vcpus to facilitate the GIC initialization (pre-sized with
> possible vcpus). After Initialization of the machine is complete we release
> the ARMCPU Objects for the disabled vcpus. These ARMCPU object shall be
> re-created at the time when vcpu is hot plugged. This new object is then
> re-attached with the earlier parked KVM vcpu which also gets unparked. The
> ARMCPU object gets now "realized" in QEMU, which means creation of the
> corresponding threads, pre_plug/plug phases, and event notification to the
> guest using ACPI GED etc. Similarly, hot-unplug leg will lead to the
> "unrealization" of the vcpus and will lead to similar ACPI GED events to the
> guest for unplug and cleanup and eventually ARMCPU object shall be released and
> KVM vcpus shall be parked again.
> 
> During machine init, ACPI MADT Table is sized with *possible* vcpus GICC
> entries. The unplugged/disabled vcpus are presented as MADT GICC DISABLED
> entries to the guest. This means the guest will have its resources pre-sized
> with possible vcpus(=present+disabled)
> 
> Other approaches to deal with ARMCPU object release(after machine init):
> 1. The ARMCPU objects for the disabled vcpus are released in context to the
>    virt_machine_done() notifier(approach adopted in this patch-set). 
> 2. Defer the release of current ARMCPU object till the new vcpu object is
>    hot plugged.
> 3. Never release and keep on reusing them and release once at VM exit. This
>    solves many problems with above 2 approaches but requires change in the way
>    qdev_device_add() fetches/creates the ARMCPU object for the new vcpus being
>    hotplugged. For the arm cpu hotplug case we need to figure out way how to
>    get access to old object and use it to "re-realize" instead of the new
>    ARMCPU object.
> 
> Concerns/Questions:
> 1. In ARM arch a cpu is uniquely represented in hierarchy using various
>    affinity levels which could represent thread, core, cluster, package. This
>    is generally represented by a value in MPIDR register as per the format
>    mentioned in specification. Now, the way MPIDR value is derived for vcpus is
>    done using vcpu-index. The concept of thread is not quite as same and rather
>    gets lost in the derivation of MPIDR for vcpus.
> 2. The topology info used to specify the vcpu while hot-plugging might not
>    match with the MPIDR value given back by the KVM for the vcpu at the time of
>    init. Concept of SMT bit in MPIDR gets lost as per the derivation being done
>    in the KVM. Hence, concept of thread-id, core-id, socket-id if used as a
>    topology info to derive MPIDR value as per ARM specification will not match
>    with MPIDR actually assigned by the KVM? 
>    Perhaps need to carry forward work of Andrew? please check here[2]
> 3. Further if this info is supplied to the guest using PPTT(once introduced in
>    QEMU) or even derived using MPIDR shall be inconsistent with the host vcpu. 
> 4. Any possibilities of interrupts(SGI/PPI/LPI/SPI) always remaining in
>    *pending* state for the cpus which have been hot-unplugged? IMHO it looks
>    okay but will need Marc's confirmation on this. 
> 5. If the ARMCPU object is released after the machine init, UEFI could call
>    back virt_update_table() to re-build the ACPI tables which might need an
>    ARMCPU object. Please check the discussion here[5]
> 
> 
> Commands Used:
> 
> A. Qemu launch commands to init the machine
> 
> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
> -cpu host -smp cpus=4,maxcpus=6 \
> -m 300M \
> -kernel Image \
> -initrd rootfs.cpio.gz \
> -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
> -nographic \
> -bios  QEMU_EFI.fd \
> 
> B. Hot-(un)plug related commands
> 
> # Hotplug a host vcpu(accel=kvm)
> $ device_add host-arm-cpu,id=core4,core-id=4
> 
> # Hotplug a vcpu(accel=tcg)
> $ device_add cortex-a57-arm-cpu,id=core4,core-id=4
> 
> # Delete the vcpu
> $ device_del core4
> 
> NOTE: I have not tested the current solution with '-device' interface. The use
>       is suggested by Igor here[6]. I will test this in coming times but looks
>       it should work with existing changes. 
> 
> 
> Sample output on guest after boot:
> 
> $ cat /sys/devices/system/cpu/possible
> 0-5
> $ cat /sys/devices/system/cpu/present
> 0-3
> $ cat /sys/devices/system/cpu/online
> 0-1
> $ cat /sys/devices/system/cpu/offline
> 2-5
> 
> 
> Sample output on guest after hotplug of vcpu=4:
> 
> $ cat /sys/devices/system/cpu/possible
> 0-5
> $ cat /sys/devices/system/cpu/present
> 0-4
> $ cat /sys/devices/system/cpu/online
> 0-1,4
> $ cat /sys/devices/system/cpu/offline
> 2-3,5
> 
> Note: vcpu=4 was explicitly 'onlined' after hot-plug
> $ echo 1 > /sys/devices/system/cpu/cpu4/online
> 
> 
> Repository:
>  (*) QEMU changes for vcpu hotplug could be cloned from below site,
>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v1
> 
>  (*) Guest Kernel changes required to co-work with the QEMU shall be posted soon
>      and repo made available at above site. 
> 
> 
> THINGS TO DO:
>  (*) Migration support 
>  (*) TCG/Emulation support is not proper right now. Works to a certain extent
>      but is not complete. especially the unrealize part in which there is a
>      overflow of tcg contexts. The last is due to the fact tcg maintains a 
>      count on number of context(per thread instance) so as we hotplug the vcpus
>      this counter keeps on incrementing. But during hot-unplug the counter is
>      not decremented.
>  (*) Support of hotplug with NUMA is not proper
>  (*) CPU Topology right now is not specified using thread/core/socket but 
>      rather flatly indexed using core-id. This needs consideration[2].
>  (*) Do we need PPTT Support for to specify right topology info to guest about
>      hot-plugged or unplugged vcpus?
>  (*) Test cases
>  (*) Docs need to be updated.
> 
>

Hi Salil,

I realize this is just a preliminary posting and the approach hasn't been
finalized, but maybe in a future posting we can put a lot of this
information into a doc patch. I think we'll need good documentation for
this feature to ensure we get it right and keep in maintained correctly.

Thanks,
drew 


