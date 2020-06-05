Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F89FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C3B206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C3B206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFXE-0008UH-Gq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jhFWC-0007XF-HV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:48:32 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:60615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jhFWA-00015n-CL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:48:32 -0400
Received: from player732.ha.ovh.net (unknown [10.110.208.44])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1A533211306
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 18:48:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id B00C312F8DE81;
 Fri,  5 Jun 2020 16:47:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00171f0a97b-1de5-4267-aee7-336a0a374b76,78B6A409CB68D4ADAA3DD5D4BC07D4D8F234AD6B)
 smtp.auth=groug@kaod.org
Date: Fri, 5 Jun 2020 18:47:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3] numa: forbid '-numa node, mem' for 5.1 and newer
 machine types
Message-ID: <20200605184758.6a7aa3ef@bahia>
In-Reply-To: <20200605160321.671964-1-imammedo@redhat.com>
References: <20200605160321.671964-1-imammedo@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8598216115286284654
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudegfedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.38.119; envelope-from=groug@kaod.org;
 helo=11.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:48:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  5 Jun 2020 12:03:21 -0400
Igor Mammedov <imammedo@redhat.com> wrote:

> Deprecation period is run out and it's a time to flip the switch
> introduced by cd5ff8333a.  Disable legacy option for new machine
> types (since 5.1) and amend documentation.
> 
> '-numa node,memdev' shall be used instead of disabled option
> with new machine types.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> ---
> v1:
>  - rebased on top of current master
>  - move compat mode from 4.2 to 5.0
> v2:
>  - move deprection text to recently removed section
> v3:
>  - increase title line length for (deprecated.rst)
>      '``-numa node,mem=``\ *size* (removed in 5.1)'
> 
> CC: peter.maydell@linaro.org
> CC: ehabkost@redhat.com
> CC: marcel.apfelbaum@gmail.com
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> CC: david@gibson.dropbear.id.au
> CC: libvir-list@redhat.com
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> ---
>  docs/system/deprecated.rst | 37 ++++++++++++++++++++-----------------
>  hw/arm/virt.c              |  2 +-
>  hw/core/numa.c             |  6 ++++++
>  hw/i386/pc.c               |  1 -
>  hw/i386/pc_piix.c          |  1 +
>  hw/i386/pc_q35.c           |  1 +
>  hw/ppc/spapr.c             |  2 +-
>  qemu-options.hx            |  9 +++++----
>  8 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index f0061f94aa..502e41ff35 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -101,23 +101,6 @@ error in the future.
>  The ``-realtime mlock=on|off`` argument has been replaced by the
>  ``-overcommit mem-lock=on|off`` argument.
>  
> -``-numa node,mem=``\ *size* (since 4.1)
> -'''''''''''''''''''''''''''''''''''''''
> -
> -The parameter ``mem`` of ``-numa node`` is used to assign a part of
> -guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> -RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> -so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> -However since 2014 there is an alternative way to assign RAM to a NUMA node
> -using parameter ``memdev``, which does the same as ``mem`` and adds
> -means to actualy manage node RAM on the host side. Use parameter ``memdev``
> -with *memory-backend-ram* backend as an replacement for parameter ``mem``
> -to achieve the same fake NUMA effect or a properly configured
> -*memory-backend-file* backend to actually benefit from NUMA configuration.
> -In future new machine versions will not accept the option but it will still
> -work with old machine types. User can check QAPI schema to see if the legacy
> -option is supported by looking at MachineInfo::numa-mem-supported property.
> -
>  ``-numa`` node (without memory specified) (since 4.1)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> @@ -512,3 +495,23 @@ long starting at 1MiB, the old command::
>  can be rewritten as::
>  
>    qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
> +
> +Command line options
> +--------------------
> +
> +``-numa node,mem=``\ *size* (removed in 5.1)
> +''''''''''''''''''''''''''''''''''''''''''''
> +
> +The parameter ``mem`` of ``-numa node`` is used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> +RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> +so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA node
> +using parameter ``memdev``, which does the same as ``mem`` and adds
> +means to actualy manage node RAM on the host side. Use parameter ``memdev``
> +with *memory-backend-ram* backend as an replacement for parameter ``mem``
> +to achieve the same fake NUMA effect or a properly configured
> +*memory-backend-file* backend to actually benefit from NUMA configuration.
> +In future new machine versions will not accept the option but it will still
> +work with old machine types. User can check QAPI schema to see if the legacy
> +option is supported by looking at MachineInfo::numa-mem-supported property.
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 37462a6f78..063d4703f7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2262,7 +2262,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      hc->pre_plug = virt_machine_device_pre_plug_cb;
>      hc->plug = virt_machine_device_plug_cb;
>      hc->unplug_request = virt_machine_device_unplug_request_cb;
> -    mc->numa_mem_supported = true;
>      mc->nvdimm_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->default_ram_id = "mach-virt.ram";
> @@ -2375,6 +2374,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
>      virt_machine_5_1_options(mc);
> +    mc->numa_mem_supported = true;
>  }
>  DEFINE_VIRT_MACHINE(5, 0)
>  
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 316bc50d75..05be412e59 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -117,6 +117,12 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      }
>  
>      if (node->has_mem) {
> +        if (!mc->numa_mem_supported) {
> +            error_setg(errp, "Parameter -numa node,mem is not supported by this"
> +                      " machine type. Use -numa node,memdev instead");

What about using error_append_hint() for the hint part ?

> +            return;
> +        }
> +
>          numa_info[nodenr].node_mem = node->mem;
>          if (!qtest_enabled()) {
>              warn_report("Parameter -numa node,mem is deprecated,"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..a86136069c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1960,7 +1960,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      hc->unplug = pc_machine_device_unplug_cb;
>      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported = true;
> -    mc->numa_mem_supported = true;
>      mc->default_ram_id = "pc.ram";
>  
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f66e1d73ce..8955436efa 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -438,6 +438,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
>      pc_i440fx_5_1_machine_options(m);
>      m->alias = NULL;
>      m->is_default = false;
> +    m->numa_mem_supported = true;
>      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4ba8ac8774..af6b32adb7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -366,6 +366,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
>  {
>      pc_q35_5_1_machine_options(m);
>      m->alias = NULL;
> +    m->numa_mem_supported = true;
>      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b1a5ed865..210d61d1b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4511,7 +4511,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift = 28;
> -    mc->numa_mem_supported = true;
>      mc->auto_enable_numa = true;
>  
>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> @@ -4599,6 +4598,7 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
>      spapr_machine_5_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    mc->numa_mem_supported = true;
>  }
>  
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 93bde2bbc8..196f468786 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -239,10 +239,11 @@ SRST
>          -numa node,nodeid=0 -numa node,nodeid=1 \
>          -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
>  
> -    '\ ``mem``\ ' assigns a given RAM amount to a node. '\ ``memdev``\ '
> -    assigns RAM from a given memory backend device to a node. If
> -    '\ ``mem``\ ' and '\ ``memdev``\ ' are omitted in all nodes, RAM is
> -    split equally between them.
> +    Legacy '\ ``mem``\ ' assigns a given RAM amount to a node (not supported
> +    for 5.1 and newer machine types). '\ ``memdev``\ ' assigns RAM from
> +    a given memory backend device to a node. If '\ ``mem``\ ' and
> +    '\ ``memdev``\ ' are omitted in all nodes, RAM is split equally between them.
> +
>  
>      '\ ``mem``\ ' and '\ ``memdev``\ ' are mutually exclusive.
>      Furthermore, if one node uses '\ ``memdev``\ ', all of them have to


