Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B4F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B4F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwvn-0005V1-3D
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgwqF-00029z-4j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgwq7-0002Ha-Oh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgwq4-0002Du-EI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E506307D844;
 Fri, 28 Jun 2019 19:47:14 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD88600C6;
 Fri, 28 Jun 2019 19:47:05 +0000 (UTC)
Date: Fri, 28 Jun 2019 16:47:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190628194703.GH1862@habkost.net>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628115349.60293-5-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 28 Jun 2019 19:47:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This looks good, overall, I'm just confused by the versioning
system.  Comments below:


On Fri, Jun 28, 2019 at 01:53:49PM +0200, Sergio Lopez wrote:
> Microvm is a machine type inspired by both NEMU and Firecracker, and
> constructed after the machine model implemented by the latter.
> 
> It's main purpose is providing users a KVM-only machine type with fast
> boot times, minimal attack surface (measured as the number of IO ports
> and MMIO regions exposed to the Guest) and small footprint (specially
> when combined with the ongoing QEMU modularization effort).
> 
> Normally, other than the device support provided by KVM itself,
> microvm only supports virtio-mmio devices. Microvm also includes a
> legacy mode, which adds an ISA bus with a 16550A serial port, useful
> for being able to see the early boot kernel messages.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
[...]
> +static const TypeInfo microvm_machine_info = {
> +    .name          = TYPE_MICROVM_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .abstract      = true,
> +    .instance_size = sizeof(MicrovmMachineState),
> +    .instance_init = microvm_machine_instance_init,
> +    .class_size    = sizeof(MicrovmMachineClass),
> +    .class_init    = microvm_class_init,

[1]

> +    .interfaces = (InterfaceInfo[]) {
> +         { TYPE_NMI },
> +         { }
> +    },
> +};
> +
> +static void microvm_machine_init(void)
> +{
> +    type_register_static(&microvm_machine_info);
> +}
> +type_init(microvm_machine_init);
> +
> +static void microvm_1_0_instance_init(Object *obj)
> +{
> +}

You shouldn't need a instance_init function if it's empty, I
believe you can delete it.

> +
> +static void microvm_machine_class_init(MachineClass *mc)

Why do you need both microvm_machine_class_init() [1] and
microvm_class_init()?

> +{
> +    mc->init = microvm_machine_state_init;
> +
> +    mc->family = "microvm_i386";
> +    mc->desc = "Microvm (i386)";
> +    mc->units_per_default_bus = 1;
> +    mc->no_floppy = 1;
> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugcon");
> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugexit");
> +    mc->max_cpus = 288;

Where does this limit come from?

> +    mc->has_hotpluggable_cpus = false;
> +    mc->auto_enable_numa_with_memhp = false;
> +    mc->default_cpu_type = X86_CPU_TYPE_NAME ("host");
> +    mc->nvdimm_supported = false;
> +    mc->default_machine_opts = "accel=kvm";
> +
> +    /* Machine class handlers */
> +    mc->cpu_index_to_instance_props = cpu_index_to_props;
> +    mc->get_default_cpu_node_id = cpu_get_default_cpu_node_id;
> +    mc->possible_cpu_arch_ids = cpu_possible_cpu_arch_ids;;

I don't think these methods should be mandatory if you don't
support NUMA or CPU hotplug.  Do you really need them?

(If the core machine code makes them mandatory, it's probably not
intentional).


> +    mc->reset = microvm_machine_reset;
> +}
> +
> +static void microvm_1_0_machine_class_init(MachineClass *mc)
> +{
> +    microvm_machine_class_init(mc);
> +}
> +DEFINE_MICROVM_MACHINE_AS_LATEST(1, 0)


We only have multiple versions of some machine types (pc-*,
virt-*, pseries-*, s390-ccw-virtio-*) because of Guest ABI
compatibility (which you are not implementing here).  What's the
reason behind having multiple microvm machine versions?


[...]
> +#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")

Using MACHINE_TYPE_NAME("microvm") might eventually cause
conflicts with the "microvm" alias you are registering.  I
suggest using something like "microvm-machine-base".

A separate base class will only be necessary if you are really
planning to provide multiple versions of the machine type,
though.


> +#define MICROVM_MACHINE(obj) \
> +    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
> +#define MICROVM_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
> +#define MICROVM_MACHINE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(MicrovmMachineClass, class, TYPE_MICROVM_MACHINE)
> +
> +#endif
> -- 
> 2.21.0
> 

-- 
Eduardo

