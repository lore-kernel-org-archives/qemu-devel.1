Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E4EC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803582075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803582075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82Ov-0006iP-IT
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i82Mn-0004NN-HK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i82Mm-0000mX-DA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i82Mk-0000kO-0Z; Wed, 11 Sep 2019 09:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 187502A09B0;
 Wed, 11 Sep 2019 13:08:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D58860852;
 Wed, 11 Sep 2019 13:08:52 +0000 (UTC)
Date: Wed, 11 Sep 2019 15:08:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190911150851.7635b9de@redhat.com>
In-Reply-To: <20190904085629.13872-8-shameerali.kolothum.thodi@huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 11 Sep 2019 13:08:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 07/11] hw/arm: Factor out
 powerdown notifier from GPIO
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

On Wed, 4 Sep 2019 09:56:25 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This is in preparation of using GED device for
> system_powerdown event. Make the powerdown notifier
> registration independent of create_gpio() fn.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c         | 12 ++++--------
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 95accc28f1..89ee37d7de 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -791,10 +791,6 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>  }
>  
> -static Notifier virt_system_powerdown_notifier = {
> -    .notify = virt_powerdown_req
> -};
> -
>  static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
>  {
>      char *nodename;
> @@ -835,10 +831,6 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
>                            KEY_POWER);
>      qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
>                             "gpios", phandle, 3, 0);
> -
> -    /* connect powerdown request */
> -    qemu_register_powerdown_notifier(&virt_system_powerdown_notifier);
> -
>      g_free(nodename);
>  }
>  
> @@ -1730,6 +1722,10 @@ static void machvirt_init(MachineState *machine)
>          vms->acpi_dev = create_acpi_ged(vms, pic);
>      }
>  
> +     /* connect powerdown request */
> +     vms->powerdown_notifier.notify = virt_powerdown_req;
> +     qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> +
>      /* Create mmio transports, so the user can create virtio backends
>       * (which will be automatically plugged in to the transports). If
>       * no backend is created the transport will just sit harmlessly idle.
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 577ee49b4b..0b41083e9d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -137,6 +137,7 @@ typedef struct {
>      int psci_conduit;
>      hwaddr highest_gpa;
>      DeviceState *acpi_dev;
> +    Notifier powerdown_notifier;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


