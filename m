Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB137C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAC62173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAC62173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlHH-0001x3-Es
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hnlH7-0001T7-Ax
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hnlH6-0005MK-6v
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hnlH3-0005KL-Qq; Wed, 17 Jul 2019 10:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68D8859440;
 Wed, 17 Jul 2019 14:51:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83AC219C4F;
 Wed, 17 Jul 2019 14:51:09 +0000 (UTC)
Date: Wed, 17 Jul 2019 16:51:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190717165108.237c1926@redhat.com>
In-Reply-To: <20190716153816.17676-6-shameerali.kolothum.thodi@huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 17 Jul 2019 14:51:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 05/10] hw/arm/virt: Add 4.2
 machine type
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, shannon.zhaosl@gmail.com,
 ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 16:38:11 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This is in preparation to create ACPI GED device as we
> need to disable it for <4.2 for migration to work.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c       | 9 ++++++++-
>  hw/core/machine.c   | 3 +++
>  include/hw/boards.h | 3 +++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 907fb64bb9..bbe156dc35 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2095,10 +2095,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_4_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
> +
>  static void virt_machine_4_1_options(MachineClass *mc)
>  {
> +    virt_machine_4_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
> +DEFINE_VIRT_MACHINE(4, 1)
>  
>  static void virt_machine_4_0_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c58a8e594e..a79d4ad740 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -27,6 +27,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> +GlobalProperty hw_compat_4_1[] = {};
> +const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
> +
>  GlobalProperty hw_compat_4_0[] = {
>      { "VGA",            "edid", "false" },
>      { "secondary-vga",  "edid", "false" },
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a71d1a53a5..d9ec37d807 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -317,6 +317,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_4_1[];
> +extern const size_t hw_compat_4_1_len;
> +
>  extern GlobalProperty hw_compat_4_0[];
>  extern const size_t hw_compat_4_0_len;
>  


