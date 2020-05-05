Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C29C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940C320675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJyvI3/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940C320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVula-00065R-Md
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVukK-0004YB-PX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:24:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVukI-0002vq-PA
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588674253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yUu2AgEYpC2lzDCQ8LMb7oZvPqSWZ/fLkeTxUFGypI=;
 b=GJyvI3/E+5Gp2+jyZhiODpL6dfwvGY3HuL4rqCRbGeQLNASUOZtuFc15QBV1TbH3EPgZs6
 nJtJ9WUpfnpJ2jIUt5FsCfvOuwv4NQVITfxrkPpVZaVvIPOanlV1YAf2PRL3rHPsPilT0U
 Jiv5MuP6y+cRVY6dux0wENP+0tqhM5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-5Kku06bROk-slWMxzj4fZQ-1; Tue, 05 May 2020 06:24:11 -0400
X-MC-Unique: 5Kku06bROk-slWMxzj4fZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B757C107ACCA;
 Tue,  5 May 2020 10:24:09 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D82D32DE9D;
 Tue,  5 May 2020 10:23:59 +0000 (UTC)
Date: Tue, 5 May 2020 12:23:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 02/10] hw/arm/virt: Introduce a RAS machine option
Message-ID: <20200505122358.1aaaccf4@redhat.com>
In-Reply-To: <20200410114639.32844-3-gengdongjiu@huawei.com>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-3-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, linuxarm@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 19:46:31 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> RAS Virtualization feature is not supported now, so
> add a RAS machine option and disable it by default.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c         | 23 +++++++++++++++++++++++
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7dc96ab..20409b9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1960,6 +1960,20 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
>      visit_type_OnOffAuto(v, name, &vms->acpi, errp);
>  }
>  
> +static bool virt_get_ras(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return vms->ras;
> +}
> +
> +static void virt_set_ras(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    vms->ras = value;
> +}
> +
>  static char *virt_get_gic_version(Object *obj, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -2284,6 +2298,15 @@ static void virt_instance_init(Object *obj)
>                                      "Valid values are none and smmuv3",
>                                      NULL);
>  
> +    /* Default disallows RAS instantiation */
> +    vms->ras = false;
> +    object_property_add_bool(obj, "ras", virt_get_ras,
> +                             virt_set_ras, NULL);
> +    object_property_set_description(obj, "ras",
> +                                    "Set on/off to enable/disable reporting host memory errors "
> +                                    "to a KVM guest using ACPI and guest external abort exceptions",
> +                                    NULL);
> +
>      vms->irqmap = a15irqmap;
>  
>      virt_flash_create(vms);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 60b2f52..6401662 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -131,6 +131,7 @@ typedef struct {
>      bool highmem_ecam;
>      bool its;
>      bool virt;
> +    bool ras;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;


