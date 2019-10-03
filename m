Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE60DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74DE21A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74DE21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFz7I-0003SL-HB
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFz5b-0002KR-SJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFz5Z-0006K8-VX
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFz5W-0006GQ-Uy
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:05 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23FBB7FDEC
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:15:59 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so963852wro.10
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 04:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=AqaNdRnO3HCEY8OfZ2w2vAbC8te7N0bIXi2FKABvAvo=;
 b=cqjpQ8LX/iNb4N2dxch5SY9pYUeODh9Q2klUyJ8tO2Uyff3wTvDkGm+J/iRT3ALH+X
 t7Xo3UR8NV54jOTr4vdLmQv63KOxbN+m8ZA6nPh87En07RyWH9AqWVuZV5+tUhA8XTlI
 IH6JnD5cbn2l0CFFAzUfzAGVPCbooocxtG7UxzDjiJ9ldvK1TnFx9RRK74jEJSxxC2i5
 ENgy9i1HxDTpTQwjY8hEfYHSwIW6PEvbgl4pGR+fj/7NxlCjNOszWydRDD2KWnxpmuT2
 X/b/IxVw+/VIv47yvca27Dbpjg+auFHk/DaLbbA1Gtlr19bXZnw4hToJy4IBtAmvM5wE
 9NBA==
X-Gm-Message-State: APjAAAUXWrnYLOMH0n/4CkWPtUC83QDpWKCGbpyliaWu8TvE49DIgiZM
 HOFqKiMP6Pyl61USMSKxgaM4P49cXPH2uauWLCWz62XFhrdBCeUne+YIPdDEzZ5pyKq274UVkMk
 NTtv1lcIXF8dzLHo=
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr6973948wmc.113.1570101357745; 
 Thu, 03 Oct 2019 04:15:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhOHBR9zhcumnIHN0EdhYiWqB3tBcycN2fNeCQukvecP8LJmCcF1R7q1fGcVtIzvUFl+8ryQ==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr6973917wmc.113.1570101357451; 
 Thu, 03 Oct 2019 04:15:57 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id g3sm5006579wro.14.2019.10.03.04.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 04:15:56 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-5-slp@redhat.com>
 <11c49099-7911-2f3b-3c8c-b3d1659fad6e@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 04/10] hw/i386: split PCMachineState deriving
 X86MachineState from it
In-reply-to: <11c49099-7911-2f3b-3c8c-b3d1659fad6e@redhat.com>
Date: Thu, 03 Oct 2019 13:15:54 +0200
Message-ID: <87imp6hyfp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
 mst@redhat.com, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com,
 Anthony Perard <anthony.perard@citrix.com>, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Sergio,
>
> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>> Split up PCMachineState and PCMachineClass and derive X86MachineState
>> and X86MachineClass from them. This allows sharing code with non-PC
>> x86 machine types.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/acpi/cpu_hotplug.c |  10 +--
>>   hw/i386/acpi-build.c  |  29 ++++---
>>   hw/i386/amd_iommu.c   |   3 +-
>>   hw/i386/intel_iommu.c |   3 +-
>>   hw/i386/pc.c          | 178 ++++++++++++++----------------------------
>>   hw/i386/pc_piix.c     |  43 +++++-----
>>   hw/i386/pc_q35.c      |  35 +++++----
>>   hw/i386/x86.c         | 139 +++++++++++++++++++++++++++++----
>>   hw/intc/ioapic.c      |   2 +-
>>   include/hw/i386/pc.h  |  27 +------
>>   include/hw/i386/x86.h |  56 ++++++++++++-
>>   11 files changed, 308 insertions(+), 217 deletions(-)
>>
> [...]
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index bc1b594a93..5de2f91845 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -17,7 +17,61 @@
>>   #ifndef HW_I386_X86_H
>>   #define HW_I386_X86_H
>>   +#include "qemu-common.h"
>> +#include "exec/hwaddr.h"
>> +#include "qemu/notify.h"
>> +
>>   #include "hw/boards.h"
>> +#include "hw/nmi.h"
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    MachineClass parent;
>> +
>> +    /*< public >*/
>> +
>> +    /* Enables contiguous-apic-ID mode */
>> +    bool compat_apic_id_mode;
>> +} X86MachineClass;
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    MachineState parent;
>> +
>> +    /*< public >*/
>> +
>> +    /* Pointers to devices and objects: */
>> +    ISADevice *rtc;
>> +    FWCfgState *fw_cfg;
>> +    qemu_irq *gsi;
>> +    GMappedFile *initrd_mapped_file;
>> +
>> +    /* Configuration options: */
>> +    uint64_t max_ram_below_4g;
>> +
>> +    /* RAM information (sizes, addresses, configuration): */
>> +    ram_addr_t below_4g_mem_size, above_4g_mem_size;
>> +
>> +    /* CPU and apic information: */
>> +    bool apic_xrupt_override;
>> +    unsigned apic_id_limit;
>> +    uint16_t boot_cpus;
>> +    unsigned smp_dies;
>> +
>> +    /* Address space used by IOAPIC device. All IOAPIC interrupts
>> +     * will be translated to MSI messages in the address space. */
>> +    AddressSpace *ioapic_as;
>> +} X86MachineState;
>> +
>> +#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>> +
>> +#define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
>> +#define X86_MACHINE(obj) \
>> +    OBJECT_CHECK(X86MachineState, (obj), TYPE_X86_MACHINE)
>> +#define X86_MACHINE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(X86MachineClass, obj, TYPE_X86_MACHINE)
>> +#define X86_MACHINE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
>>     uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>>                                       unsigned int cpu_index);
>> @@ -30,6 +84,6 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machine=
State *ms);
>>     void x86_system_rom_init(MemoryRegion *rom_memory, bool
>> isapc_ram_fw);
>>   -void x86_load_linux(PCMachineState *x86ms, FWCfgState *fw_cfg);
>> +void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
>>     #endif
>>
>
> You forgot to update Xen:
>
> hw/i386/xen/xen-hvm.c: In function =E2=80=98xen_ram_init=E2=80=99:
> hw/i386/xen/xen-hvm.c:203:53: error: =E2=80=98PC_MACHINE_MAX_RAM_BELOW_4G=
=E2=80=99
> undeclared (first use in this function); did you mean
> =E2=80=98X86_MACHINE_MAX_RAM_BELOW_4G=E2=80=99?
>
> PC_MACHINE_MAX_RAM_BELOW_4G,
>
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> X86_MACHINE_MAX_RAM_BELOW_4G
> hw/i386/xen/xen-hvm.c:203:53: note: each undeclared identifier is
> reported only once for each function it appears in
> hw/i386/xen/xen-hvm.c:217:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>          pcms->above_4g_mem_size =3D ram_size - user_lowmem;
>              ^~
> hw/i386/xen/xen-hvm.c:218:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=
=E2=80=99
>          pcms->below_4g_mem_size =3D user_lowmem;
>              ^~
> hw/i386/xen/xen-hvm.c:220:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>          pcms->above_4g_mem_size =3D 0;
>              ^~
> hw/i386/xen/xen-hvm.c:221:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=
=E2=80=99
>          pcms->below_4g_mem_size =3D ram_size;
>              ^~
> hw/i386/xen/xen-hvm.c:223:14: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>      if (!pcms->above_4g_mem_size) {
>               ^~
> hw/i386/xen/xen-hvm.c:230:40: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>          block_len =3D (1ULL << 32) + pcms->above_4g_mem_size;
>                                         ^~
> hw/i386/xen/xen-hvm.c:247:34: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98below_4g_mem_size=
=E2=80=99
>                               pcms->below_4g_mem_size - 0xc0000);
>                                   ^~
> hw/i386/xen/xen-hvm.c:249:13: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>      if (pcms->above_4g_mem_size > 0) {
>              ^~
> hw/i386/xen/xen-hvm.c:252:38: error: =E2=80=98PCMachineState=E2=80=99 {ak=
a =E2=80=98struct
> PCMachineState=E2=80=99} has no member named =E2=80=98above_4g_mem_size=
=E2=80=99
>                                   pcms->above_4g_mem_size);
>                                       ^~
> make[1]: *** [rules.mak:69: hw/i386/xen/xen-hvm.o] Error 1

Ouch, turns out I forgot to install xen-devel when I renewed the VM that
I'm using for this project.

I'll fix it right now.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2V2GoACgkQ9GknjS8M
AjWyVg/8ClNduztg4prAeFm0sDNr4v0b+nElDsh8Djj5120H5WP9lCWAP6cEJbEz
Jjw6Z+40lmFcViGCyHlQ5WyL/KoSTbF5BcbDbSDwBHa3g9kAVGoK/uvHhlDDInjV
tzWzgPcvP0uM5UwJVUzHsyKzXnKxIbHs66qmFekW9Iv/oK61YQtKJCtlYssyPf9j
QnaYD6FQvTe4k7MH8Vt22o8CWdaplIi99tzTzidrydaCt7xPwhLkDZzo+otH6rZh
yPmHtYMA51S3UIh33EOe0/8vE471XZzTygiCMkK08Ep9D+dOTKQkYAseEsM0cf9C
c5/kND2ylqDpCkm9MPaO5qj+gB59w40nlr2wU8k6mEMFT/ZNnk4BoigSi0FAmOrD
gWGcSn6b84UsUk2Fq6HuVTJ2QSEACmNRbgxt7we/3jqih45LwMumRHbPN8D0qVbu
zU6C6LtvaKvIEwVyxPV4IANIZn8zEdvJKLQ0oWorzhOC03nR/6v/eVB7WHa5rqGR
aYZTuZQ5J0F9X4J0gMSXiueo43Sh2l5KpoRDUb63Z95c9ERzKIgjDH17pPK/Gc+7
wKZ2kTOUlxcEi4Q2TkN9l2sOpikJG1M+vvq2d9fRucVLYRo7dIjOvuXl0a+ORhhv
QaXtufondsDY06UtuDSn6gTaB4gRbJ/wi2WE/zvZ8q9szwK8E0g=
=hOQr
-----END PGP SIGNATURE-----
--=-=-=--

