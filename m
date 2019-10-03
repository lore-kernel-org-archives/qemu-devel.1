Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA0C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14230218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14230218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyJ9-0001fy-3r
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFyI7-00017o-FH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFyI5-0001gf-Ry
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFyI5-0001gB-GY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:24:57 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA3B7C049D7C
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:24:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 32so907556wrk.15
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7bHv14b2mRKZle8ci5oxB3hp8T1rZYI5YInGSdK1RVY=;
 b=RV/bU2MZj4Lkr2U3NMQiAeRtjHAXx2lxndJGOdnY8yM6UiEW78AEHHWnXKwJscpq5g
 wMiD47WadMKARxQFLj/w4HpLYzJq2DOM0UGfZVQUSiaeA1oVyH5+yGcqy3JVnrAIpDT2
 GrJ4H4Axk2dvTOY70hX14Lqlc/6gYpDBw/Rf/d+s8rJhm2xmE9pI8Ss4etcdFZdG5N75
 Ac2ey1vttCpU9pPNQbdKSaVK0RBO9GPb6ssw7Mn7XBEnDWb0NhHUoK3U4W7c6nfB/JEt
 +yfNBnNJgtyA/TR7U9HBR/pNkwr+NJV96CqTTyRr34N+LtrArFdQIE2ov0AF1T7FVbaK
 EAtg==
X-Gm-Message-State: APjAAAVpn9XLs9fSkv2RXjanvo4s/4TYqTaW9vG99vmFbPtYorw8PQ2J
 DsVYTM2M1kFAH0gLOUnoScLxtCmZE94bQ1ETwvXgzcPHyZwD54k5zyu8fNYiVnqZiLvCBD2QLbG
 d6gI5CK5sgr+Oagw=
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr6610601wmk.84.1570098294469; 
 Thu, 03 Oct 2019 03:24:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaGtgN1fIfFXrskicSvyXaxT6WuU7NCwPK7gRKFA+R7FGz5EelBuS6YYqzn+iOX+ShENTZyg==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr6610589wmk.84.1570098294211; 
 Thu, 03 Oct 2019 03:24:54 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f9sm1180156wre.74.2019.10.03.03.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:24:53 -0700 (PDT)
Subject: Re: [PATCH v5 04/10] hw/i386: split PCMachineState deriving
 X86MachineState from it
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-5-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11c49099-7911-2f3b-3c8c-b3d1659fad6e@redhat.com>
Date: Thu, 3 Oct 2019 12:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002113103.45023-5-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, ehabkost@redhat.com,
 mst@redhat.com, Paul Durrant <paul@xen.org>, kraxel@redhat.com,
 pbonzini@redhat.com, Anthony Perard <anthony.perard@citrix.com>,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/2/19 1:30 PM, Sergio Lopez wrote:
> Split up PCMachineState and PCMachineClass and derive X86MachineState
> and X86MachineClass from them. This allows sharing code with non-PC
> x86 machine types.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/acpi/cpu_hotplug.c |  10 +--
>   hw/i386/acpi-build.c  |  29 ++++---
>   hw/i386/amd_iommu.c   |   3 +-
>   hw/i386/intel_iommu.c |   3 +-
>   hw/i386/pc.c          | 178 ++++++++++++++---------------------------=
-
>   hw/i386/pc_piix.c     |  43 +++++-----
>   hw/i386/pc_q35.c      |  35 +++++----
>   hw/i386/x86.c         | 139 +++++++++++++++++++++++++++++----
>   hw/intc/ioapic.c      |   2 +-
>   include/hw/i386/pc.h  |  27 +------
>   include/hw/i386/x86.h |  56 ++++++++++++-
>   11 files changed, 308 insertions(+), 217 deletions(-)
>=20
[...]
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index bc1b594a93..5de2f91845 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -17,7 +17,61 @@
>   #ifndef HW_I386_X86_H
>   #define HW_I386_X86_H
>  =20
> +#include "qemu-common.h"
> +#include "exec/hwaddr.h"
> +#include "qemu/notify.h"
> +
>   #include "hw/boards.h"
> +#include "hw/nmi.h"
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineClass parent;
> +
> +    /*< public >*/
> +
> +    /* Enables contiguous-apic-ID mode */
> +    bool compat_apic_id_mode;
> +} X86MachineClass;
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +
> +    /* Pointers to devices and objects: */
> +    ISADevice *rtc;
> +    FWCfgState *fw_cfg;
> +    qemu_irq *gsi;
> +    GMappedFile *initrd_mapped_file;
> +
> +    /* Configuration options: */
> +    uint64_t max_ram_below_4g;
> +
> +    /* RAM information (sizes, addresses, configuration): */
> +    ram_addr_t below_4g_mem_size, above_4g_mem_size;
> +
> +    /* CPU and apic information: */
> +    bool apic_xrupt_override;
> +    unsigned apic_id_limit;
> +    uint16_t boot_cpus;
> +    unsigned smp_dies;
> +
> +    /* Address space used by IOAPIC device. All IOAPIC interrupts
> +     * will be translated to MSI messages in the address space. */
> +    AddressSpace *ioapic_as;
> +} X86MachineState;
> +
> +#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> +
> +#define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
> +#define X86_MACHINE(obj) \
> +    OBJECT_CHECK(X86MachineState, (obj), TYPE_X86_MACHINE)
> +#define X86_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(X86MachineClass, obj, TYPE_X86_MACHINE)
> +#define X86_MACHINE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
>  =20
>   uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>                                       unsigned int cpu_index);
> @@ -30,6 +84,6 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machin=
eState *ms);
>  =20
>   void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)=
;
>  =20
> -void x86_load_linux(PCMachineState *x86ms, FWCfgState *fw_cfg);
> +void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
>  =20
>   #endif
>=20

You forgot to update Xen:

hw/i386/xen/xen-hvm.c: In function =E2=80=98xen_ram_init=E2=80=99:
hw/i386/xen/xen-hvm.c:203:53: error: =E2=80=98PC_MACHINE_MAX_RAM_BELOW_4G=
=E2=80=99=20
undeclared (first use in this function); did you mean=20
=E2=80=98X86_MACHINE_MAX_RAM_BELOW_4G=E2=80=99?
=20
PC_MACHINE_MAX_RAM_BELOW_4G,
=20
^~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
X86_MACHINE_MAX_RAM_BELOW_4G
hw/i386/xen/xen-hvm.c:203:53: note: each undeclared identifier is=20
reported only once for each function it appears in
hw/i386/xen/xen-hvm.c:217:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
          pcms->above_4g_mem_size =3D ram_size - user_lowmem;
              ^~
hw/i386/xen/xen-hvm.c:218:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=E2=
=80=99
          pcms->below_4g_mem_size =3D user_lowmem;
              ^~
hw/i386/xen/xen-hvm.c:220:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
          pcms->above_4g_mem_size =3D 0;
              ^~
hw/i386/xen/xen-hvm.c:221:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=E2=
=80=99
          pcms->below_4g_mem_size =3D ram_size;
              ^~
hw/i386/xen/xen-hvm.c:223:14: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
      if (!pcms->above_4g_mem_size) {
               ^~
hw/i386/xen/xen-hvm.c:230:40: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
          block_len =3D (1ULL << 32) + pcms->above_4g_mem_size;
                                         ^~
hw/i386/xen/xen-hvm.c:247:34: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=E2=
=80=99
                               pcms->below_4g_mem_size - 0xc0000);
                                   ^~
hw/i386/xen/xen-hvm.c:249:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
      if (pcms->above_4g_mem_size > 0) {
              ^~
hw/i386/xen/xen-hvm.c:252:38: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct=20
PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=E2=
=80=99
                                   pcms->above_4g_mem_size);
                                       ^~
make[1]: *** [rules.mak:69: hw/i386/xen/xen-hvm.o] Error 1

