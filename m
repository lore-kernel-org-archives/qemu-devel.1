Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E5C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9335420645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9335420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQcp-0005No-BE
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hfQTP-0007Zj-M7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hfQTN-0002eN-Gu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hfQTJ-0002Iu-N8; Mon, 24 Jun 2019 11:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A8366E777;
 Mon, 24 Jun 2019 15:01:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0DDB60C6C;
 Mon, 24 Jun 2019 15:00:55 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <afb007ea-ec73-2065-2d57-63ecb3e5c968@redhat.com>
Date: Mon, 24 Jun 2019 17:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620122132.10075-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 15:01:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/3] hw/i386: Use
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/20/19 14:21, Philippe Mathieu-Daud=C3=A9 wrote:
> Enable the EDK2 Crypto Policy features on the PC machine.
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2c5446b095..fe99ebfe3d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -39,6 +39,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/timer/hpet.h"
>  #include "hw/firmware/smbios.h"
> +#include "hw/firmware/uefi_edk2.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "multiboot.h"
> @@ -1049,6 +1050,11 @@ static FWCfgState *bochs_bios_init(AddressSpace =
*as, PCMachineState *pcms)
>      return fw_cfg;
>  }
> =20
> +static void pc_uefi_setup(PCMachineState *pcms)
> +{
> +    edk2_add_host_crypto_policy(pcms->fw_cfg);
> +}
> +
>  static long get_file_size(FILE *f)
>  {
>      long where, size;
> @@ -1653,6 +1659,7 @@ void pc_machine_done(Notifier *notifier, void *da=
ta)
>      if (pcms->fw_cfg) {
>          pc_build_smbios(pcms);
>          pc_build_feature_control_file(pcms);
> +        pc_uefi_setup(pcms);
>          /* update FW_CFG_NB_CPUS to account for -device added CPUs */
>          fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpu=
s);
>      }
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

