Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C4C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F245A2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4gvy-0005Vb-24
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 03:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i4guL-0004V9-Ss
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i4guK-00046j-M6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i4guH-00044z-3i; Mon, 02 Sep 2019 03:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F8FA882F5;
 Mon,  2 Sep 2019 07:37:43 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 648FA19C5B;
 Mon,  2 Sep 2019 07:37:39 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
 <20190813210539.31164-9-shameerali.kolothum.thodi@huawei.com>
Message-ID: <90b6bb3e-d8d9-b7ac-ab2d-786d08ebd678@redhat.com>
Date: Mon, 2 Sep 2019 09:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190813210539.31164-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 02 Sep 2019 07:37:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v9 08/12] hw/arm: Factor out
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 8/13/19 11:05 PM, Shameer Kolothum wrote:
> This is in preparation of using GED device for
> system_powerdown event. Make the powerdown notifier
> registration independent of create_gpio() fn.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/virt.c         | 12 ++++--------
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 56d64fc0a9..0e75213b44 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -787,10 +787,6 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
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
> @@ -831,10 +827,6 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
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
> @@ -1726,6 +1718,10 @@ static void machvirt_init(MachineState *machine)
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
> 

