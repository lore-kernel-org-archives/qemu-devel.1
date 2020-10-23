Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D7C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E546820E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/SoQU+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E546820E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2ck-0006rc-Oj
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 15:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2br-0006Gc-AC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2bo-0006mN-Ex
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603480815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9aV75y4ILQsmdgDEBCj9cbzrtT06USNdAlTJ3P/+AE=;
 b=O/SoQU+B9uJweRFEdec81J6edGzC90yMZSqFQY/MekJtna1KM/qGRUuP2fefDjStLIlwkj
 wuKA6xy6F2DDIHR9DDvxeduyg77x4KKuHAZV7zzzL0bjAX69o5y0QxQIC5xD6xehSMA7ZU
 IyXaTgoFy5E0GGaH+fp0xAhBR+CVaQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-2Fh8HbnfNduenk6lsKnhnA-1; Fri, 23 Oct 2020 15:20:13 -0400
X-MC-Unique: 2Fh8HbnfNduenk6lsKnhnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 813BE8DFFF0;
 Fri, 23 Oct 2020 19:20:01 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC6F5C5FE;
 Fri, 23 Oct 2020 19:19:20 +0000 (UTC)
Date: Fri, 23 Oct 2020 21:19:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/5] pc-dimm: Drop @errp argument of pc_dimm_plug()
Message-ID: <20201023211919.77377cb9@redhat.com>
In-Reply-To: <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 10:48:04 +0200
Greg Kurz <groug@kaod.org> wrote:

> pc_dimm_plug() doesn't use it. It only aborts on error.
> 
> Drop @errp and adapt the callers accordingly.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

arguably the same should be done in spapr.

> ---
>  hw/arm/virt.c            |    9 +--------
>  hw/i386/pc.c             |    8 +-------
>  hw/mem/pc-dimm.c         |    2 +-
>  hw/ppc/spapr.c           |    5 +----
>  include/hw/mem/pc-dimm.h |    2 +-
>  5 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e465a988d683..27dbeb549ef1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2261,12 +2261,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>      MachineState *ms = MACHINE(hotplug_dev);
>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> -    Error *local_err = NULL;
>  
> -    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms));
>  
>      if (is_nvdimm) {
>          nvdimm_plug(ms->nvdimms_state);
> @@ -2274,9 +2270,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>  
>      hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
>                           dev, &error_abort);
> -
> -out:
> -    error_propagate(errp, local_err);
>  }
>  
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e87be5d29a01..38b1be78e707 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1265,24 +1265,18 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
>                             DeviceState *dev, Error **errp)
>  {
> -    Error *local_err = NULL;
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>      X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
>      MachineState *ms = MACHINE(hotplug_dev);
>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>  
> -    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms));
>  
>      if (is_nvdimm) {
>          nvdimm_plug(ms->nvdimms_state);
>      }
>  
>      hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
> -out:
> -    error_propagate(errp, local_err);
>  }
>  
>  static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index c30351070bb8..2ffc986734df 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -64,7 +64,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
>                             errp);
>  }
>  
> -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
> +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
>  {
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ee716a12af73..4edd31b86915 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3438,10 +3438,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>      size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
>  
> -    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(dimm, MACHINE(ms));
>  
>      if (!is_nvdimm) {
>          addr = object_property_get_uint(OBJECT(dimm),
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index aec9527fdd96..3d3db82641f8 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -72,6 +72,6 @@ struct PCDIMMDeviceClass {
>  
>  void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
>                        const uint64_t *legacy_align, Error **errp);
> -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp);
> +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
>  void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
>  #endif
> 
> 
> 


