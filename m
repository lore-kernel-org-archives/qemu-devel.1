Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71436C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45333206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45333206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFQ9-00019E-Hn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hiFLy-00086o-OI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hiFLw-00075x-Tb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hiFLw-00075i-KZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:45:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED7F0C057F2E
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 09:45:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5DE9608BA;
 Tue,  2 Jul 2019 09:45:28 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:45:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190702094525.GN21569@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-8-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628002844.24894-8-ehabkost@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 09:45:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 7/9] i386: Make unversioned CPU models
 be aliases
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 09:28:42PM -0300, Eduardo Habkost wrote:
> This will make unversioned CPU models behavior depend on the
> machine type:
> 
> * "pc-*-4.0" and older will not report them as aliases.
>   This is done to keep compatibility with older QEMU versions
>   after management software starts translating aliases.
> 
> * "pc-*-4.1" will translate unversioned CPU models to -v1.
>   This is done to keep compatibility with existing management
>   software, that still relies on CPU model runnability promises.
> 
> * "none" will translate unversioned CPU models to their latest
>   version.  This is planned become the default in future machine
>   types (probably in pc-*-4.3).
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Patch v1 was "[PATCH 4/6] i386: Infrastructure for versioned CPU
> models", and was split into multiple patches.
> 
> Changes v1 -> v2:
> * Make version numbers simple integers, completely independent
>   from machine type versions
> * New X86CPUVersion typedef
> * New CPU_VERSION_* defines to make X86CPUModel::version
>   semantics clearer
> ---
>  include/hw/i386/pc.h                       |   3 +
>  target/i386/cpu.h                          |  12 ++
>  hw/i386/pc.c                               |   3 +
>  hw/i386/pc_piix.c                          |   4 +
>  hw/i386/pc_q35.c                           |   4 +
>  target/i386/cpu.c                          |  52 ++++++++-
>  tests/acceptance/x86_cpu_model_versions.py | 126 +++++++++++++++++++++
>  7 files changed, 203 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ee79d71ccc..1946c1023f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -109,6 +109,9 @@ typedef struct PCMachineClass {
>  
>      /* Compat options: */
>  
> +    /* Default CPU model version.  See x86_cpu_set_default_version(). */
> +    int default_cpu_version;
> +
>      /* ACPI compat: */
>      bool has_acpi_build;
>      bool rsdp_in_ram;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 12bc3cd4a8..05393cf9d1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1934,11 +1934,23 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value);
>  /* Resolve to latest CPU version */
>  #define CPU_VERSION_LATEST -1
>  
> +/*
> + * Resolve to version defined by current machine type.
> + * See x86_cpu_set_default_version()
> + */
> +#define CPU_VERSION_AUTO   -2
> +
>  /* Don't resolve to any versioned CPU models, like old QEMU versions */
>  #define CPU_VERSION_LEGACY  0
>  
>  typedef int X86CPUVersion;
>  
> +/*
> + * Set default CPU model version for CPU models having
> + * version == CPU_VERSION_AUTO.
> + */
> +void x86_cpu_set_default_version(X86CPUVersion version);
> +
>  /* Return name of 32-bit register, from a R_* constant */
>  const char *get_register_name_32(unsigned int reg);
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3f0f221a5b..1df569620a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1649,6 +1649,9 @@ void pc_cpus_init(PCMachineState *pcms)
>      const CPUArchIdList *possible_cpus;
>      MachineState *ms = MACHINE(pcms);
>      MachineClass *mc = MACHINE_GET_CLASS(pcms);
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
> +
> +    x86_cpu_set_default_version(pcmc->default_cpu_version);
>  
>      /* Calculates the limit to CPU APIC ID values
>       *
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c07c4a5b38..0a069bff54 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -430,9 +430,11 @@ static void pc_i440fx_machine_options(MachineClass *m)
>  
>  static void pc_i440fx_4_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = 1;
> +    pcmc->default_cpu_version = 1;
>  }
>  
>  DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
> @@ -440,9 +442,11 @@ DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
>  
>  static void pc_i440fx_4_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_4_1_machine_options(m);
>      m->alias = NULL;
>      m->is_default = 0;
> +    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 57232aed6b..397e1fdd2f 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -367,8 +367,10 @@ static void pc_q35_machine_options(MachineClass *m)
>  
>  static void pc_q35_4_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_machine_options(m);
>      m->alias = "q35";
> +    pcmc->default_cpu_version = 1;

How will this work in future if we need to introduce a v2 of some,
but not all CPU models, and then further a v3 of some others.

Can we select Haswell-v1,  Skylake-Server-v2, CascadeLake-v3
as defaults in some way ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

