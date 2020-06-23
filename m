Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9683C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41AB20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mrx85yyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41AB20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneaM-00074J-Iz
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneZZ-0006CZ-WB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:46:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneZX-0006QX-1A
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592901986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7tVgCxLEVKIKPPk/JELCpOA5FPdEYgvnSl+jolOanA=;
 b=Mrx85yyBqvpPPPatGNE6wQDT48K6A8COFdtCgnJ/NdynmdSv+heDOjjRBYUrpwjgd5AQYT
 +Uei/YArLHWmyaFhhotvX3iU5wbZXI0KeRg0Sx+C41dtL6FPwiqJIE2RkAbUjdZ645qg4s
 e8LvtKkC4y0wSl5zacqDZr7ukjxy+AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-mVTjF9WZPz-C8pwhTkP4ow-1; Tue, 23 Jun 2020 04:46:24 -0400
X-MC-Unique: mVTjF9WZPz-C8pwhTkP4ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 975F318A0739;
 Tue, 23 Jun 2020 08:46:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD48119D61;
 Tue, 23 Jun 2020 08:46:06 +0000 (UTC)
Date: Tue, 23 Jun 2020 10:46:03 +0200
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH RFC 01/22] arm/cpuhp: Add QMP vcpu params validation
 support
Message-ID: <20200623084603.i4kv3udz3dlcxlak@kamzik.brq.redhat.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <20200613213629.21984-2-salil.mehta@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200613213629.21984-2-salil.mehta@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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

On Sat, Jun 13, 2020 at 10:36:08PM +0100, Salil Mehta wrote:
> For now, vcpu hotplug is only supported with single socket single thread,
> single die. NUMA is not supported either and everthing falls into single
> node. Work to properly support these could be taken later once community
> agrees with the base framework changes being presented to support ARM vcpu
> hotplug in QEMU. Hence, these checks.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/arm/virt.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 37462a6f78..5d1afdd031 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2201,6 +2201,46 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>  
> +static void virt_smp_parse(MachineState *ms, QemuOpts *opts)
> +{
> +    if (opts) {
> +        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 1);
> +        unsigned sockets = qemu_opt_get_number(opts, "sockets", 1);
> +        unsigned cores   = qemu_opt_get_number(opts, "cores", cpus);
> +        unsigned threads = qemu_opt_get_number(opts, "threads", 1);
> +        unsigned int max_cpus;
> +
> +        if (sockets > 1 || threads > 1) {
> +            error_report("does not support more than one socket or thread");
> +            exit(1);
> +        }
> +
> +        if (cores != cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * cores (%u) * threads (%u) < "
> +                         "smp_cpus (%u)",
> +                         sockets, cores, threads, cpus);
> +            exit(1);
> +        }
> +
> +        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +        if (sockets * cores * threads > max_cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * cores (%u) * threads (%u) > "
> +                         "maxcpus (%u)",
> +                         sockets, cores, threads,
> +                         max_cpus);
> +            exit(1);
> +        }
> +
> +        ms->smp.max_cpus = max_cpus;
> +        ms->smp.sockets = sockets;
> +        ms->smp.cpus = cpus;
> +        ms->smp.cores = cores;
> +        ms->smp.threads = threads;
> +    }
> +}
> +
>  /*
>   * for arm64 kvm_type [7-0] encodes the requested number of bits
>   * in the IPA address space
> @@ -2266,6 +2306,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->nvdimm_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->default_ram_id = "mach-virt.ram";
> +    mc->smp_parse = virt_smp_parse;
>  
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>          virt_get_acpi, virt_set_acpi,
> -- 
> 2.17.1
> 
> 
>

Hi Salil,

This patch and the whole series has inspired me to pick up the vcpu
topology work again. In fact, I think it may be necessary in order
to properly describe a cpu when hot[un]plugging. I'll try to pull
together an RFC soon, at least for TCG. For KVM, we may need to
change KVM in order to allow user-controlled MPIDR. Although I'm
not sure about that anymore, because, as you stated somewhere else,
we already have user-controlled MPIDR to some degree, since KVM simply
transforms the cpu index.

Regarding this patch specifically, I would change this to allow
sockets, but prefer cores (i.e. when only '-smp N' is given, then
N is the number of cores, not sockets). Also I would allow threads,
but only for !kvm_enabled(). Then the function would be similar to
something I think I once posted long ago, or at least wrote and maybe
never posted...

Thanks,
drew


