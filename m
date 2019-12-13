Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F66C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BAE20663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDyT3IVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmI3-000056-QF
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifmHB-0007qX-Kg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifmH8-0002c1-Vx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:50:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifmH8-0002a9-RS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576248637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sApt7enW3aW+jG00n+vFhjjeWhfocAMLoCFOarEiefE=;
 b=FDyT3IVsYPxOL2HjTZq5JBIgnurUgx8L3Uc716VLk0Xg4nVAypYuJ5+hwRuJwtCbbp68ig
 NgY/sL3XMr/hIVpj/SkihNzAPn7hSgHlV78Nq6SjacMOfyQV/MXwg6OXgTu2rRvLqrs3TE
 AoDOeO1t+D6CYIhnfQFDbdN9Xnpa9iI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Evq9yW1sNdugWLanTSJ15A-1; Fri, 13 Dec 2019 09:50:35 -0500
Received: by mail-wm1-f71.google.com with SMTP id 7so1860359wmf.9
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=696vUHk2gjuAFuo6lA2qGIaPicKf1rGoGd2HTerXWI4=;
 b=m6JycPMuu5ZzDBiOYXLhCEgww7JnYN8xcGrQCHfOMULbWA7Dq8zOFr1TPjnyIg2WGe
 XiawfWYrYmQN0l3bJoBh8ro514Q0wPm/M1ROXHompbPpPa21elae0rnp/6FqRz4N8Rrc
 rkLNms8El9DpQqQaqJEZo2SJeSgTB4eu9C3nQpLULAUnNNyTA9tcnGj5a5SvcsJAd10W
 pU20VxyU989dAEjLeQ+1ZMYFLU8f+ugMpCJAJq5jVhF6AJ4Hy9rIWTZbabQd9KnwMMEy
 pMbH798W1vQR3elGB+DWd9OZMvvWKTKmSMF53f+b89NRJK+Bo4/+cDxMY6DbOiYB4/aK
 G10A==
X-Gm-Message-State: APjAAAWyKRLjn3bhTNUjGLPEo30+rjfN6lkuG8fgaYLdN1fgz9ZhljxL
 DWaXo7DciffePtwQ2IxdGU1uWjpRIO20ltThMhJdVoppHCsxox2cYQG9Pm664DykqZJPokeTgLF
 EDR+/na2dL4krXhk=
X-Received: by 2002:adf:cd92:: with SMTP id q18mr13018979wrj.261.1576248634658; 
 Fri, 13 Dec 2019 06:50:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOY4843iCKTtljWWDjal18fpyFkRLfWJl/YBZLZzWF8acCxaqd0euJcsAG26gP2gTYb1PGyw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr13018960wrj.261.1576248634340; 
 Fri, 13 Dec 2019 06:50:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f1sm10121206wru.6.2019.12.13.06.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:50:33 -0800 (PST)
Subject: Re: [PATCH v2 5/8] x86: move SMM property to X86MachineState
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-6-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1b3649c-9622-1077-65e2-0dc6e73dadb8@redhat.com>
Date: Fri, 13 Dec 2019 15:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576171754-45138-6-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: Evq9yW1sNdugWLanTSJ15A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 6:29 PM, Paolo Bonzini wrote:
> Add it to microvm as well, it is a generic property of the x86
> architecture.
>=20
> Suggested-by: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/i386/pc.c          | 49 --------------------------------------------=
-----
>   hw/i386/pc_piix.c     |  6 +++---
>   hw/i386/pc_q35.c      |  2 +-
>   hw/i386/x86.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>   include/hw/i386/pc.h  |  3 ---
>   include/hw/i386/x86.h |  5 +++++
>   target/i386/kvm.c     |  3 +--
>   7 files changed, 59 insertions(+), 59 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fdbd2bf..6a3212e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2028,48 +2028,6 @@ static void pc_machine_set_vmport(Object *obj, Vis=
itor *v, const char *name,
>       visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
>   }
>  =20
> -bool pc_machine_is_smm_enabled(PCMachineState *pcms)
> -{
> -    bool smm_available =3D false;
> -
> -    if (pcms->smm =3D=3D ON_OFF_AUTO_OFF) {
> -        return false;
> -    }
> -
> -    if (tcg_enabled() || qtest_enabled()) {
> -        smm_available =3D true;
> -    } else if (kvm_enabled()) {
> -        smm_available =3D kvm_has_smm();
> -    }
> -
> -    if (smm_available) {
> -        return true;
> -    }
> -
> -    if (pcms->smm =3D=3D ON_OFF_AUTO_ON) {
> -        error_report("System Management Mode not supported by this hyper=
visor.");
> -        exit(1);
> -    }
> -    return false;
> -}
> -
> -static void pc_machine_get_smm(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> -    OnOffAuto smm =3D pcms->smm;
> -
> -    visit_type_OnOffAuto(v, name, &smm, errp);
> -}
> -
> -static void pc_machine_set_smm(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> -
> -    visit_type_OnOffAuto(v, name, &pcms->smm, errp);
> -}
> -
>   static bool pc_machine_get_smbus(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms =3D PC_MACHINE(obj);
> @@ -2116,7 +2074,6 @@ static void pc_machine_initfn(Object *obj)
>   {
>       PCMachineState *pcms =3D PC_MACHINE(obj);
>  =20
> -    pcms->smm =3D ON_OFF_AUTO_AUTO;
>   #ifdef CONFIG_VMPORT
>       pcms->vmport =3D ON_OFF_AUTO_AUTO;
>   #else
> @@ -2223,12 +2180,6 @@ static void pc_machine_class_init(ObjectClass *oc,=
 void *data)
>           pc_machine_get_device_memory_region_size, NULL,
>           NULL, NULL, &error_abort);
>  =20
> -    object_class_property_add(oc, PC_MACHINE_SMM, "OnOffAuto",
> -        pc_machine_get_smm, pc_machine_set_smm,
> -        NULL, NULL, &error_abort);
> -    object_class_property_set_description(oc, PC_MACHINE_SMM,
> -        "Enable SMM (pc & q35)", &error_abort);
> -
>       object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
>           pc_machine_get_vmport, pc_machine_set_vmport,
>           NULL, NULL, &error_abort);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 1bd70d1..dd0f00e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -281,7 +281,7 @@ else {
>           /* TODO: Populate SPD eeprom data.  */
>           pcms->smbus =3D piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
>                                       x86ms->gsi[9], smi_irq,
> -                                    pc_machine_is_smm_enabled(pcms),
> +                                    x86_machine_is_smm_enabled(x86ms),
>                                       &piix4_pm);
>           smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>  =20
> @@ -309,9 +309,9 @@ else {
>  =20
>   static void pc_compat_2_3_fn(MachineState *machine)
>   {
> -    PCMachineState *pcms =3D PC_MACHINE(machine);
> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
>       if (kvm_enabled()) {
> -        pcms->smm =3D ON_OFF_AUTO_OFF;
> +        x86ms->smm =3D ON_OFF_AUTO_OFF;
>       }
>   }
>  =20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 385e5cf..bccaaee 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -276,7 +276,7 @@ static void pc_q35_init(MachineState *machine)
>                            0xff0104);
>  =20
>       /* connect pm stuff to lpc */
> -    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
> +    ich9_lpc_pm_init(lpc, x86_machine_is_smm_enabled(x86ms));
>  =20
>       if (pcms->sata_enabled) {
>           /* ahci and SATA device, for q35 1 ahci controller is built-in =
*/
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 3e4aee5..6fb01e4 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -746,10 +746,53 @@ static void x86_machine_set_max_ram_below_4g(Object=
 *obj, Visitor *v,
>       x86ms->max_ram_below_4g =3D value;
>   }
>  =20
> +bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
> +{
> +    bool smm_available =3D false;
> +
> +    if (x86ms->smm =3D=3D ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +
> +    if (tcg_enabled() || qtest_enabled()) {
> +        smm_available =3D true;
> +    } else if (kvm_enabled()) {
> +        smm_available =3D kvm_has_smm();
> +    }
> +
> +    if (smm_available) {
> +        return true;
> +    }
> +
> +    if (x86ms->smm =3D=3D ON_OFF_AUTO_ON) {
> +        error_report("System Management Mode not supported by this hyper=
visor.");
> +        exit(1);
> +    }
> +    return false;
> +}
> +
> +static void x86_machine_get_smm(Object *obj, Visitor *v, const char *nam=
e,
> +                               void *opaque, Error **errp)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(obj);
> +    OnOffAuto smm =3D x86ms->smm;
> +
> +    visit_type_OnOffAuto(v, name, &smm, errp);
> +}
> +
> +static void x86_machine_set_smm(Object *obj, Visitor *v, const char *nam=
e,
> +                               void *opaque, Error **errp)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
> +}
> +
>   static void x86_machine_initfn(Object *obj)
>   {
>       X86MachineState *x86ms =3D X86_MACHINE(obj);
>  =20
> +    x86ms->smm =3D ON_OFF_AUTO_AUTO;
>       x86ms->max_ram_below_4g =3D 0; /* use default */
>       x86ms->smp_dies =3D 1;
>   }
> @@ -770,9 +813,14 @@ static void x86_machine_class_init(ObjectClass *oc, =
void *data)
>       object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
>           x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below=
_4g,
>           NULL, NULL, &error_abort);
> -
>       object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW=
_4G,
>           "Maximum ram below the 4G boundary (32bit boundary)", &error_ab=
ort);
> +
> +    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
> +        x86_machine_get_smm, x86_machine_set_smm,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, X86_MACHINE_SMM,
> +        "Enable SMM", &error_abort);
>   }
>  =20
>   static const TypeInfo x86_machine_info =3D {
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 82447f8..ca641e8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -43,7 +43,6 @@ struct PCMachineState {
>  =20
>       /* Configuration options: */
>       OnOffAuto vmport;
> -    OnOffAuto smm;
>  =20
>       bool acpi_build_enabled;
>       bool smbus_enabled;
> @@ -61,7 +60,6 @@ struct PCMachineState {
>   #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
>   #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
>   #define PC_MACHINE_VMPORT           "vmport"
> -#define PC_MACHINE_SMM              "smm"
>   #define PC_MACHINE_SMBUS            "smbus"
>   #define PC_MACHINE_SATA             "sata"
>   #define PC_MACHINE_PIT              "pit"
> @@ -165,7 +163,6 @@ void vmmouse_set_data(const uint32_t *data);
>   /* pc.c */
>   extern int fd_bootchk;
>  =20
> -bool pc_machine_is_smm_enabled(PCMachineState *pcms);
>   void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  =20
>   void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 4b84917..97d1575 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -60,6 +60,8 @@ typedef struct {
>       uint16_t boot_cpus;
>       unsigned smp_dies;
>  =20
> +    OnOffAuto smm;
> +
>       /*
>        * Address space used by IOAPIC device. All IOAPIC interrupts
>        * will be translated to MSI messages in the address space.
> @@ -68,6 +70,7 @@ typedef struct {
>   } X86MachineState;
>  =20
>   #define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> +#define X86_MACHINE_SMM              "smm"
>  =20
>   #define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
>   #define X86_MACHINE(obj) \
> @@ -95,4 +98,6 @@ void x86_load_linux(X86MachineState *x86ms,
>                       bool pvh_enabled,
>                       bool linuxboot_dma_enabled);
>  =20
> +bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
> +
>   #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ef63f3a..c7ff67a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2173,8 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       }
>  =20
>       if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> -        object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
> -        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
> +        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>           smram_machine_done.notify =3D register_smram_listener;
>           qemu_add_machine_init_done_notifier(&smram_machine_done);
>       }
>=20


