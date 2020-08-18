Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A63C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06B82067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g63r9/71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06B82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zPA-0007RE-4Z
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k7zOV-0006mg-PU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:03:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k7zOU-0006K8-9R
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597748585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOsFZAgnz0eIAgMXTGDtTPSElQdXe0+Sudz5oXli/ac=;
 b=g63r9/71d+YU2iSwzcvqMcgG00dXjX2V7T5lKVN//gFTuMjR7yM9QWXx+7GPzQk23jaMs0
 0qb+Wp6IdaK8eYjPyxNGup5MVp62xLZ7dGVGCqMePU1Uve498OStv3z+f9G2vhMjoVTUhJ
 5tFNlXL16V/zpaE2zwdDSPRarYYgq0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-NzrpHyNVNi6-5ml-e2xWUg-1; Tue, 18 Aug 2020 07:03:01 -0400
X-MC-Unique: NzrpHyNVNi6-5ml-e2xWUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FEE801AAE;
 Tue, 18 Aug 2020 11:02:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5AD25C1DC;
 Tue, 18 Aug 2020 11:02:44 +0000 (UTC)
Date: Tue, 18 Aug 2020 13:02:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 4/8] ppc/e500: Use start-powered-off CPUState property
Message-ID: <20200818130243.38d00c5d@redhat.com>
In-Reply-To: <20200818033323.336912-5-bauerman@linux.ibm.com>
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-5-bauerman@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 00:33:19 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

[...]

> Also change creation of CPU object from cpu_create() to object_new() and
> qdev_realize() because cpu_create() realizes the CPU and it's not possible
> to set a property after the object is realized.

cpu_create was introduced to remove code duplication in simple cases where
we do not need to set properties on created cpu.

returning back to manual object_new + realize() is fine if it 's only
small set of of boards. If it's tree-wide change then that would bring
back all code duplication that cpu_create() got rid of.

An alternative way is to use 'hotplug' callbacks to let board set
additional properties before cpu's realize is called.

example:
  hw/ppc/spapr.c:
   spapr_machine_class_init()
     mc->get_hotplug_handler = spapr_get_hotplug_handler;                         
     hc->pre_plug = spapr_machine_device_pre_plug; 
   ...
   static const TypeInfo spapr_machine_info = {
   ...
        { TYPE_HOTPLUG_HANDLER },

that might work in generic case if it is put into generic machine code,
and existing users of mc->get_hotplug_handler/hc->pre_plug were taken care of.
In which case board would only need to set MachineClass:cpu-start-powered-of
to gate property setting.

 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  hw/ppc/e500.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index ab9884e315..0077aca74d 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
>  
>      cpu_reset(cs);
>  
> -    /* Secondary CPU starts in halted state for now. Needs to change when
> -       implementing non-kernel boot. */
> -    cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
>  }
>  
> @@ -864,8 +861,9 @@ void ppce500_init(MachineState *machine)
>          PowerPCCPU *cpu;
>          CPUState *cs;
>          qemu_irq *input;
> +        Error *err = NULL;
>  
> -        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> +        cpu = POWERPC_CPU(object_new(machine->cpu_type));
>          env = &cpu->env;
>          cs = CPU(cpu);
>  
> @@ -897,6 +895,19 @@ void ppce500_init(MachineState *machine)
>          } else {
>              /* Secondary CPUs */
>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> +
> +            /*
> +             * Secondary CPU starts in halted state for now. Needs to change
> +             * when implementing non-kernel boot.
> +             */
> +            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
> +                                     &error_abort);
> +        }
> +
> +        if (!qdev_realize(DEVICE(cs), NULL, &err)) {
> +            error_report_err(err);
> +            object_unref(OBJECT(cs));
> +            exit(EXIT_FAILURE);
>          }

btw:
board leaks cpu reference (from cpu_create()/object_new()) since qdev_realize()
adds it's own and the caller of object_new() is suposed to free the original one.

in this case qdev_realize_and_unref() fits nicely.


>      }
>  
> 


