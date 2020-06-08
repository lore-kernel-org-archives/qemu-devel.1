Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9B9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C02064C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaOjpDUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJTt-0006Ar-Ss
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiJSi-0004qG-VC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:13:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiJSh-0006aY-K7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591629198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAghcKCih6wyXTEntsCRjRbAze4F6DKIzPzwKh0FQlM=;
 b=GaOjpDUhU+TJvxtzcuY6DL7Gowov5CGbv9SbptRU3ZHNGB+cRY3cIUGEBN/AznRYTNTVm9
 bz1zBMjayvs1jv/xCGqjsOjh3l0VjFbE74PYXbdFMR1vLwT86V6tk+9WyF51MnxPO6u2+A
 oaFiQOq5DIHsabbr5Ut5T+NnbNieyaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-NveAymocMZuhJdnD8wPbUg-1; Mon, 08 Jun 2020 11:13:04 -0400
X-MC-Unique: NveAymocMZuhJdnD8wPbUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A453FEC1A0;
 Mon,  8 Jun 2020 15:13:02 +0000 (UTC)
Received: from localhost (unknown [10.40.208.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5984079598;
 Mon,  8 Jun 2020 15:12:53 +0000 (UTC)
Date: Mon, 8 Jun 2020 17:12:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] numa: forbid '-numa node,mem' for 5.1 and newer
 machine types
Message-ID: <20200608171246.6a4adce0@redhat.com>
In-Reply-To: <20200608085442-mutt-send-email-mst@kernel.org>
References: <20200608120344.728549-1-imammedo@redhat.com>
 <20200608085442-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, URIBL_SBL=1.623,
 URIBL_SBL_A=0.1 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 08:55:08 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 08, 2020 at 08:03:44AM -0400, Igor Mammedov wrote:
> > Deprecation period is run out and it's a time to flip the switch
> > introduced by cd5ff8333a.  Disable legacy option for new machine
> > types (since 5.1) and amend documentation.
> > 
> > '-numa node,memdev' shall be used instead of disabled option
> > with new machine types.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Michal Privoznik <mprivozn@redhat.com>  
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
Thanks!

> numa things so I'm guessing Eduardo's tree?
yep, it's pure NUMA so it should go via Eduardo's tere.


> > ---
> > v1:
> >  - rebased on top of current master
> >  - move compat mode from 4.2 to 5.0
> > v2:
> >  - move deprection text to recently removed section
> > v3:
> >  - increase title line length for (deprecated.rst)
> >      '``-numa node,mem=``\ *size* (removed in 5.1)'
> > v4:
> >  - use error_append_hint() for suggesting valid CLI
> > 
> > CC: peter.maydell@linaro.org
> > CC: ehabkost@redhat.com
> > CC: marcel.apfelbaum@gmail.com
> > CC: mst@redhat.com
> > CC: pbonzini@redhat.com
> > CC: rth@twiddle.net
> > CC: david@gibson.dropbear.id.au
> > CC: libvir-list@redhat.com
> > CC: qemu-arm@nongnu.org
> > CC: qemu-ppc@nongnu.org
> > CC: eblake@redhat.com
> > CC: groug@kaod.org
> > ---
> >  docs/system/deprecated.rst | 37 ++++++++++++++++++++-----------------
> >  hw/arm/virt.c              |  2 +-
> >  hw/core/numa.c             |  7 +++++++
> >  hw/i386/pc.c               |  1 -
> >  hw/i386/pc_piix.c          |  1 +
> >  hw/i386/pc_q35.c           |  1 +
> >  hw/ppc/spapr.c             |  2 +-
> >  qemu-options.hx            |  9 +++++----
> >  8 files changed, 36 insertions(+), 24 deletions(-)
> > 
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 544ece0a45..e74a5717c8 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -101,23 +101,6 @@ error in the future.
> >  The ``-realtime mlock=on|off`` argument has been replaced by the
> >  ``-overcommit mem-lock=on|off`` argument.
> >  
> > -``-numa node,mem=``\ *size* (since 4.1)
> > -'''''''''''''''''''''''''''''''''''''''
> > -
> > -The parameter ``mem`` of ``-numa node`` is used to assign a part of
> > -guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> > -RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> > -so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> > -However since 2014 there is an alternative way to assign RAM to a NUMA node
> > -using parameter ``memdev``, which does the same as ``mem`` and adds
> > -means to actualy manage node RAM on the host side. Use parameter ``memdev``
> > -with *memory-backend-ram* backend as an replacement for parameter ``mem``
> > -to achieve the same fake NUMA effect or a properly configured
> > -*memory-backend-file* backend to actually benefit from NUMA configuration.
> > -In future new machine versions will not accept the option but it will still
> > -work with old machine types. User can check QAPI schema to see if the legacy
> > -option is supported by looking at MachineInfo::numa-mem-supported property.
> > -
> >  ``-numa`` node (without memory specified) (since 4.1)
> >  '''''''''''''''''''''''''''''''''''''''''''''''''''''
> >  
> > @@ -516,3 +499,23 @@ long starting at 1MiB, the old command::
> >  can be rewritten as::
> >  
> >    qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
> > +
> > +Command line options
> > +--------------------
> > +
> > +``-numa node,mem=``\ *size* (removed in 5.1)
> > +''''''''''''''''''''''''''''''''''''''''''''
> > +
> > +The parameter ``mem`` of ``-numa node`` is used to assign a part of
> > +guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> > +RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> > +so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> > +However since 2014 there is an alternative way to assign RAM to a NUMA node
> > +using parameter ``memdev``, which does the same as ``mem`` and adds
> > +means to actualy manage node RAM on the host side. Use parameter ``memdev``
> > +with *memory-backend-ram* backend as an replacement for parameter ``mem``
> > +to achieve the same fake NUMA effect or a properly configured
> > +*memory-backend-file* backend to actually benefit from NUMA configuration.
> > +In future new machine versions will not accept the option but it will still
> > +work with old machine types. User can check QAPI schema to see if the legacy
> > +option is supported by looking at MachineInfo::numa-mem-supported property.
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 37462a6f78..063d4703f7 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2262,7 +2262,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
> >      hc->pre_plug = virt_machine_device_pre_plug_cb;
> >      hc->plug = virt_machine_device_plug_cb;
> >      hc->unplug_request = virt_machine_device_unplug_request_cb;
> > -    mc->numa_mem_supported = true;
> >      mc->nvdimm_supported = true;
> >      mc->auto_enable_numa_with_memhp = true;
> >      mc->default_ram_id = "mach-virt.ram";
> > @@ -2375,6 +2374,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> >  static void virt_machine_5_0_options(MachineClass *mc)
> >  {
> >      virt_machine_5_1_options(mc);
> > +    mc->numa_mem_supported = true;
> >  }
> >  DEFINE_VIRT_MACHINE(5, 0)
> >  
> > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > index 316bc50d75..7814e646e4 100644
> > --- a/hw/core/numa.c
> > +++ b/hw/core/numa.c
> > @@ -117,6 +117,13 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
> >      }
> >  
> >      if (node->has_mem) {
> > +        if (!mc->numa_mem_supported) {
> > +            error_setg(errp, "Parameter -numa node,mem is not supported by this"
> > +                      " machine type");
> > +            error_append_hint(errp, "Use -numa node,memdev instead");
> > +            return;
> > +        }
> > +
> >          numa_info[nodenr].node_mem = node->mem;
> >          if (!qtest_enabled()) {
> >              warn_report("Parameter -numa node,mem is deprecated,"
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2128f3d6fe..a86136069c 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1960,7 +1960,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >      hc->unplug = pc_machine_device_unplug_cb;
> >      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
> >      mc->nvdimm_supported = true;
> > -    mc->numa_mem_supported = true;
> >      mc->default_ram_id = "pc.ram";
> >  
> >      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index f66e1d73ce..8955436efa 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -438,6 +438,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
> >      pc_i440fx_5_1_machine_options(m);
> >      m->alias = NULL;
> >      m->is_default = false;
> > +    m->numa_mem_supported = true;
> >      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> >      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 4ba8ac8774..af6b32adb7 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -366,6 +366,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
> >  {
> >      pc_q35_5_1_machine_options(m);
> >      m->alias = NULL;
> > +    m->numa_mem_supported = true;
> >      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> >      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
> >  }
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 3b1a5ed865..210d61d1b3 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4511,7 +4511,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >       * in which LMBs are represented and hot-added
> >       */
> >      mc->numa_mem_align_shift = 28;
> > -    mc->numa_mem_supported = true;
> >      mc->auto_enable_numa = true;
> >  
> >      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> > @@ -4599,6 +4598,7 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
> >  {
> >      spapr_machine_5_1_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> > +    mc->numa_mem_supported = true;
> >  }
> >  
> >  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 93bde2bbc8..196f468786 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -239,10 +239,11 @@ SRST
> >          -numa node,nodeid=0 -numa node,nodeid=1 \
> >          -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
> >  
> > -    '\ ``mem``\ ' assigns a given RAM amount to a node. '\ ``memdev``\ '
> > -    assigns RAM from a given memory backend device to a node. If
> > -    '\ ``mem``\ ' and '\ ``memdev``\ ' are omitted in all nodes, RAM is
> > -    split equally between them.
> > +    Legacy '\ ``mem``\ ' assigns a given RAM amount to a node (not supported
> > +    for 5.1 and newer machine types). '\ ``memdev``\ ' assigns RAM from
> > +    a given memory backend device to a node. If '\ ``mem``\ ' and
> > +    '\ ``memdev``\ ' are omitted in all nodes, RAM is split equally between them.
> > +
> >  
> >      '\ ``mem``\ ' and '\ ``memdev``\ ' are mutually exclusive.
> >      Furthermore, if one node uses '\ ``memdev``\ ', all of them have to
> > -- 
> > 2.26.2  
> 


