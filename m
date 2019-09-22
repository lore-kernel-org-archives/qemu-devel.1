Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B150C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 12:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0329E20830
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 12:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0329E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iC1Jk-0004o9-Tj
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iC1IV-0004MM-0R
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 08:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iC1IS-0001bB-6m
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 08:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iC1IR-0001Zj-Ua
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 08:49:00 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35AE15AFE3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2019 12:48:58 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id b143so14391058qkg.9
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2019 05:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7L6oHeJgz9oCiNw4WARc6y3jmaKltA/9W+B+/rzSAq4=;
 b=VHhDKt5X5oW3J5k3nmOGKIXTBC2/+daFg/5zQtajw7uAqUn6Sfb12Ujsz3vtw7KSFp
 Bw7oX7PVcCS3XcMP2muwCZnR8Mhyq3JWeR3C0fVInXttSoZASCWVqVm4MR6eX7lts3Ct
 nLj41+r+EMOFUQFcJWHsE0Ssv/yGNy8QwyrBIWvHfjlTqcriNzEpfXkEBZjiSZH1JOau
 Rh9g6BaSjL4lOGCu5Vd1ELZf+jrnGDCeNHyVoWoAWFuJ0WFOpsEYGcFoE67uAHj6oUhQ
 Ph1g1dTQmGz79q04muDU4CSZgMWUS0uVG6QRE5UCglDg6HJ1e2BtvWUxkCEK/M2Qxhue
 28vg==
X-Gm-Message-State: APjAAAXj2BheJxQhkRwUwgHNjkVLXuOwXoN34U/iTg8E4fROSGNUVP66
 3d/vWTtrvoT59TzLvBNbuDz1D6ebCxtCcZnGyGEHeHTw6ujtps8+Y6Z53/kZ0IX9AsAHHBoGVQe
 wqF6WUaSDljDlSvk=
X-Received: by 2002:ac8:5414:: with SMTP id b20mr12046437qtq.85.1569156537522; 
 Sun, 22 Sep 2019 05:48:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynYDeWYTJnCSphvu5Q3hr+q+dgFTyJcSB3tTpkZHWhytfeVLLL3p9MGi/LRUk6a2yY+f973g==
X-Received: by 2002:ac8:5414:: with SMTP id b20mr12046427qtq.85.1569156537321; 
 Sun, 22 Sep 2019 05:48:57 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id n42sm5133377qta.31.2019.09.22.05.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2019 05:48:56 -0700 (PDT)
Date: Sun, 22 Sep 2019 08:48:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [RFC 2 PATCH 06/16] hw/core: Add core complex id in X86CPU
 topology
Message-ID: <20190922084003-mutt-send-email-mst@kernel.org>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779713686.21957.6192568272184346850.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779713686.21957.6192568272184346850.stgit@localhost.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "ssg.sos.staff" <ssg.sos.staff@amd.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 07:12:18PM +0000, Moger, Babu wrote:
> Introduce cpu core complex id(ccx_id) in x86CPU topology.
> Each CCX can have upto 4 cores and share same L3 cache.
> This information is required to build the topology in
> new apyc mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/core/machine-hmp-cmds.c |    3 +++
>  hw/core/machine.c          |   13 +++++++++++++
>  hw/i386/pc.c               |   10 ++++++++++
>  include/hw/i386/topology.h |    1 +
>  qapi/machine.json          |    4 +++-
>  target/i386/cpu.c          |    2 ++
>  target/i386/cpu.h          |    1 +
>  7 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 1f66bda346..6c534779af 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -89,6 +89,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>          if (c->has_die_id) {
>              monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
>          }
> +        if (c->has_ccx_id) {
> +            monitor_printf(mon, "    ccx-id: \"%" PRIu64 "\"\n", c->ccx_id);
> +        }
>          if (c->has_core_id) {
>              monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>          }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4034b7e903..9a8586cf30 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -694,6 +694,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
>              return;
>          }
>  
> +        if (props->has_ccx_id && !slot->props.has_ccx_id) {
> +            error_setg(errp, "ccx-id is not supported");
> +            return;
> +        }
> +
>          /* skip slots with explicit mismatch */
>          if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
>                  continue;
> @@ -707,6 +712,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                  continue;
>          }
>  
> +        if (props->has_ccx_id && props->ccx_id != slot->props.ccx_id) {
> +                continue;
> +        }
> +
>          if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
>                  continue;
>          }
> @@ -1041,6 +1050,10 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      if (cpu->props.has_die_id) {
>          g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
>      }
> +
> +    if (cpu->props.has_ccx_id) {
> +        g_string_append_printf(s, "ccx-id: %"PRId64, cpu->props.ccx_id);
> +    }
>      if (cpu->props.has_core_id) {
>          if (s->len) {
>              g_string_append_printf(s, ", ");
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9e1c3f9f57..f71389ad9f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2444,6 +2444,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>          topo_ids.pkg_id = cpu->socket_id;
>          topo_ids.die_id = cpu->die_id;
> +        topo_ids.ccx_id = cpu->ccx_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
>          cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
> @@ -2489,6 +2490,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      }
>      cpu->die_id = topo_ids.die_id;
>  
> +    if (cpu->ccx_id != -1 && cpu->ccx_id != topo_ids.ccx_id) {
> +        error_setg(errp, "property ccx-id: %u doesn't match set apic-id:"
> +            " 0x%x (ccx-id: %u)", cpu->ccx_id, cpu->apic_id, topo_ids.ccx_id);
> +        return;
> +    }
> +    cpu->ccx_id = topo_ids.ccx_id;
> +
>      if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>              " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
> @@ -2896,6 +2904,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          ms->possible_cpus->cpus[i].props.has_die_id = true;
>          ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
> +        ms->possible_cpus->cpus[i].props.has_ccx_id = true;
> +        ms->possible_cpus->cpus[i].props.ccx_id = topo_ids.ccx_id;
>          ms->possible_cpus->cpus[i].props.has_core_id = true;
>          ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index fb10863a66..5a61d53f05 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -170,6 +170,7 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>              (apicid >> apicid_die_offset(nr_cores, nr_threads)) &
>              ~(0xFFFFFFFFUL << apicid_die_width(nr_dies));
>      topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
> +    topo_ids->ccx_id = 0;
>  }
>  
>  /* Make APIC ID for the CPU 'cpu_index'
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6db8a7e2ec..bb7627e698 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -597,9 +597,10 @@
>  # @node-id: NUMA node ID the CPU belongs to
>  # @socket-id: socket number within node/board the CPU belongs to
>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
> +# @ccx-id: core complex number within node/board the CPU belongs to (Since 4.1)

Can we come up with a non-AMD specific name?
E.g. would "last level cache" be correct for AMD?
Better ideas?

>  # @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
>  #
> -# Note: currently there are 5 properties that could be present
> +# Note: currently there are 6 properties that could be present
>  # but management should be prepared to pass through other
>  # properties with device_add command to allow for future
>  # interface extension. This also requires the filed names to be kept in
> @@ -611,6 +612,7 @@
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',
> +            '*ccx-id': 'int',
>              '*core-id': 'int',
>              '*thread-id': 'int'
>    }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6d7f9b6b8b..ca02bc21ec 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5811,12 +5811,14 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
> +    DEFINE_PROP_INT32("ccx-id", X86CPU, ccx_id, 0),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
>  #else
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
> +    DEFINE_PROP_INT32("ccx-id", X86CPU, ccx_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8b3dc5533e..db940cdb2a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1508,6 +1508,7 @@ struct X86CPU {
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      int32_t socket_id;
>      int32_t die_id;
> +    int32_t ccx_id;
>      int32_t core_id;
>      int32_t thread_id;
>  
> 

