Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EBC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874F520645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874F520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQcs-0005ZK-Pu
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hfQTU-0007gc-JK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hfQTS-0002kX-FO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hfQTJ-0002LP-PF; Mon, 24 Jun 2019 11:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E640F30BBE9D;
 Mon, 24 Jun 2019 15:01:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDB915D9D5;
 Mon, 24 Jun 2019 15:01:02 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0d19df15-040b-b9e4-936c-d14210fe2c87@redhat.com>
Date: Mon, 24 Jun 2019 17:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620122132.10075-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 24 Jun 2019 15:01:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 3/3] hw/arm/virt: Use
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/20/19 14:21, Philippe Mathieu-Daud=C3=A9 wrote:
> Enable the EDK2 Crypto Policy features on the Virt machine.
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/virt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 431e2900fd..15727b3d59 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "kvm_arm.h"
>  #include "hw/firmware/smbios.h"
> +#include "hw/firmware/uefi_edk2.h"
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> @@ -1355,6 +1356,11 @@ static void virt_build_smbios(VirtMachineState *=
vms)
>      }
>  }
> =20
> +static void virt_uefi_setup(VirtMachineState *vms)
> +{
> +    edk2_add_host_crypto_policy(vms->fw_cfg);
> +}
> +
>  static
>  void virt_machine_done(Notifier *notifier, void *data)
>  {
> @@ -1383,6 +1389,7 @@ void virt_machine_done(Notifier *notifier, void *=
data)
> =20
>      virt_acpi_setup(vms);
>      virt_build_smbios(vms);
> +    virt_uefi_setup(vms);
>  }
> =20
>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

