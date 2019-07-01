Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E3C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA58720665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA58720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3Rp-0002GN-JO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:02:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hhykf-0002IJ-E5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 12:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hhykd-0008NV-RO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 12:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hhykb-0008Hg-Nx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 12:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F218FC0568FC;
 Mon,  1 Jul 2019 16:01:41 +0000 (UTC)
Received: from ptitpuce (ovpn-116-93.ams2.redhat.com [10.36.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5305C1F8;
 Mon,  1 Jul 2019 16:01:27 +0000 (UTC)
References: <20190701133536.28946-1-philmd@redhat.com>
 <20190701133536.28946-9-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <m1d0ithhhv.fsf@redhat.com>
In-reply-to: <20190701133536.28946-9-philmd@redhat.com>
Date: Mon, 01 Jul 2019 18:01:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 01 Jul 2019 16:01:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 08/15] hw/i386/pc: Let fw_cfg_init() use
 the generic MachineState
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 writes:

> We removed the PCMachineState access, we can now let the fw_cfg_init()
> function to take a generic MachineState object.

to take -> take

>
> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 1e856704e1..60ee71924a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -929,7 +929,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      }
>  }
>
> -static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
> +static FWCfgState *fw_cfg_arch_create(MachineState *ms,

I don't see where ms is used in the function. Maybe in a later patch,
I did not receive patches 09-15 yet.

>                                        const CPUArchIdList *cpus,
>                                        uint16_t boot_cpus,
>                                        uint16_t apic_id_limit)
> @@ -1667,6 +1667,7 @@ void pc_memory_init(PCMachineState *pcms,
>      MemoryRegion *ram_below_4g, *ram_above_4g;
>      FWCfgState *fw_cfg;
>      MachineState *machine =3D MACHINE(pcms);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>
>      assert(machine->ram_size =3D=3D pcms->below_4g_mem_size +
> @@ -1763,7 +1764,7 @@ void pc_memory_init(PCMachineState *pcms,
>                                          option_rom_mr,
>                                          1);
>
> -    fw_cfg =3D fw_cfg_arch_create(pcms, mc->possible_cpu_arch_ids(machin=
e),
> +    fw_cfg =3D fw_cfg_arch_create(machine, mc->possible_cpu_arch_ids(mac=
hine),
>                                  pcms->boot_cpus, pcms->apic_id_limit);
>
>      rom_set_fw(fw_cfg);


--
Cheers,
Christophe de Dinechin (IRC c3d)

