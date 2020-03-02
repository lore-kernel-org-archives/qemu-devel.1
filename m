Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6167C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7F920842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hdu1kTYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7F920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8j7G-0001aZ-Qs
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8j6E-0000YA-Ge
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8j6D-0004ig-4a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:19:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8j6D-0004iY-1K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583147940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyYbusHqkV7O2CQidgGkMeNh+438YXMlYqcU1o8X5oU=;
 b=Hdu1kTYHynKz3RaoDjf7PmeTk55Frc11wnraFhBr1RERrqjfuCD+IP6aIs42BWmlfvgbU0
 qEKrrKExP4E9rC8PommA1PRAKNoRMfLd15oyJo98OvtTxNYqXPyL1YlNgw+73xEeyBdK7H
 g00vOqLQYCbgOMleNnsVz4tjzuPpEMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-WTuqZhvMO6SKe2t0S8OFCg-1; Mon, 02 Mar 2020 06:18:57 -0500
X-MC-Unique: WTuqZhvMO6SKe2t0S8OFCg-1
Received: by mail-wr1-f72.google.com with SMTP id j14so3241279wru.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YQA6g/jSFAX204Wo4d/KbsPMP3CGdZr6T6ta2cKO92o=;
 b=Y1MpplkaDM518JTYyBi2VWac+2Zrf/MyvK91Qj51lmUw2a4DCcWlU2YRJPeVZNYUd0
 TQ1p3gLZaZsjJEFG7KmlR+59OdD9BUGiAGUqbB5CFtFsr8HifF2soRycom1ibIJ2ShmM
 KdIMmx13mxbl1SvZ7z0J4nib5W/n82iG5MaSWCnfR93n+DmKHyi/n1yGbrjyO6IYFa0B
 G9GrPkYE7cplkw4zCbe9kJfhVstxbRWdiIQsoQHUWDFCdYQ+8Iv6G5kP4yPoR07u2p/3
 p7bBwjRA9H+hXi3eWQ5ar/0vtTu+CqYzLI0aZVQgnsHF74mYDJ+mVWV89CG2NvC8dULq
 /D8Q==
X-Gm-Message-State: APjAAAX+KrullVBgo2pH7q/0/B2OA259LWs/5KwaWV3+6SLd13mxDcBN
 LQDJANYkqWCZSBsOjhCe6a1KsG7+Q4vnxcaWLHimYaZkPRjfUbVByOJ5FDj87HgwOxqIzJy1Kd/
 NaO2qEogZWW+PxVY=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr23544914wrq.153.1583147935733; 
 Mon, 02 Mar 2020 03:18:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9X9uhbY5jh297bfFjWdhTfQYzQgnLM/XgkL6jndHiGTjQ/0KsuE3Jq6JO0SlEB1gr38FSAQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr23544886wrq.153.1583147935459; 
 Mon, 02 Mar 2020 03:18:55 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id j5sm27807803wrx.56.2020.03.02.03.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 03:18:54 -0800 (PST)
Subject: Re: [PATCH v3 2/6] hw/arm/virt: Introduce VirtGICType enum type
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff498491-820a-498a-2951-6e46951dd23e@redhat.com>
Date: Mon, 2 Mar 2020 12:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302105516.5972-3-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 11:55 AM, Eric Auger wrote:
> We plan to introduce yet another value for the gic version (nosel).
> As we already use exotic values such as 0 and -1, let's introduce
> a dedicated enum type and let vms->gic_version take this
> type.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v2 -> v3:
> - replaced defines by enum VirtGICType
> - use that new type for vms->gic_version
> ---
>   hw/arm/virt.c         | 30 +++++++++++++++---------------
>   include/hw/arm/virt.h | 11 +++++++++--

Please have a look at scripts/git.orderfile, it helps making review=20
easier/quicker.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   2 files changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c093f0ab85..b449a445de 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -298,7 +298,7 @@ static void fdt_add_timer_nodes(const VirtMachineStat=
e *vms)
>           irqflags =3D GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
>       }
>  =20
> -    if (vms->gic_version =3D=3D 2) {
> +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>           irqflags =3D deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>                                GIC_FDT_IRQ_PPI_CPU_WIDTH,
>                                (1 << vms->smp_cpus) - 1);
> @@ -439,7 +439,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>       qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
>       qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
>       qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
> -    if (vms->gic_version =3D=3D 3) {
> +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
>           int nb_redist_regions =3D virt_gicv3_redist_region_count(vms);
>  =20
>           qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
> @@ -518,7 +518,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState =
*vms)
>           }
>       }
>  =20
> -    if (vms->gic_version =3D=3D 2) {
> +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>           irqflags =3D deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>                                GIC_FDT_IRQ_PPI_CPU_WIDTH,
>                                (1 << vms->smp_cpus) - 1);
> @@ -1469,7 +1469,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineSta=
te *vms, int idx)
>            * purposes are to make TCG consistent (with 64-bit KVM hosts)
>            * and to improve SGI efficiency.
>            */
> -        if (vms->gic_version =3D=3D 3) {
> +        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
>               clustersz =3D GICV3_TARGETLIST_BITS;
>           } else {
>               clustersz =3D GIC_TARGETLIST_BITS;
> @@ -1560,15 +1560,15 @@ static void machvirt_init(MachineState *machine)
>       /* We can probe only here because during property set
>        * KVM is not available yet
>        */
> -    if (vms->gic_version <=3D 0) {
> -        /* "host" or "max" */
> +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
> +        vms->gic_version =3D=3D VIRT_GIC_VERSION_MAX) {
>           if (!kvm_enabled()) {
> -            if (vms->gic_version =3D=3D 0) {
> +            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
>                   error_report("gic-version=3Dhost requires KVM");
>                   exit(1);
>               } else {
>                   /* "max": currently means 3 for TCG */
> -                vms->gic_version =3D 3;
> +                vms->gic_version =3D VIRT_GIC_VERSION_3;
>               }
>           } else {
>               vms->gic_version =3D kvm_arm_vgic_probe();
> @@ -1627,7 +1627,7 @@ static void machvirt_init(MachineState *machine)
>       /* The maximum number of CPUs depends on the GIC version, or on how
>        * many redistributors we can fit into the memory map.
>        */
> -    if (vms->gic_version =3D=3D 3) {
> +    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
>           virt_max_cpus =3D
>               vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>           virt_max_cpus +=3D
> @@ -1855,7 +1855,7 @@ static void virt_set_its(Object *obj, bool value, E=
rror **errp)
>   static char *virt_get_gic_version(Object *obj, Error **errp)
>   {
>       VirtMachineState *vms =3D VIRT_MACHINE(obj);
> -    const char *val =3D vms->gic_version =3D=3D 3 ? "3" : "2";
> +    const char *val =3D vms->gic_version =3D=3D VIRT_GIC_VERSION_3 ? "3"=
 : "2";
>  =20
>       return g_strdup(val);
>   }
> @@ -1865,13 +1865,13 @@ static void virt_set_gic_version(Object *obj, con=
st char *value, Error **errp)
>       VirtMachineState *vms =3D VIRT_MACHINE(obj);
>  =20
>       if (!strcmp(value, "3")) {
> -        vms->gic_version =3D 3;
> +        vms->gic_version =3D VIRT_GIC_VERSION_3;
>       } else if (!strcmp(value, "2")) {
> -        vms->gic_version =3D 2;
> +        vms->gic_version =3D VIRT_GIC_VERSION_2;
>       } else if (!strcmp(value, "host")) {
> -        vms->gic_version =3D 0; /* Will probe later */
> +        vms->gic_version =3D VIRT_GIC_VERSION_HOST; /* Will probe later =
*/
>       } else if (!strcmp(value, "max")) {
> -        vms->gic_version =3D -1; /* Will probe later */
> +        vms->gic_version =3D VIRT_GIC_VERSION_MAX; /* Will probe later *=
/
>       } else {
>           error_setg(errp, "Invalid gic-version value");
>           error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
> @@ -2139,7 +2139,7 @@ static void virt_instance_init(Object *obj)
>                                       "physical address space above 32 bi=
ts",
>                                       NULL);
>       /* Default GIC type is v2 */
> -    vms->gic_version =3D 2;
> +    vms->gic_version =3D VIRT_GIC_VERSION_2;
>       object_property_add_str(obj, "gic-version", virt_get_gic_version,
>                           virt_set_gic_version, NULL);
>       object_property_set_description(obj, "gic-version",
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 02f500cb8e..c0827cacdf 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -95,6 +95,13 @@ typedef enum VirtIOMMUType {
>       VIRT_IOMMU_VIRTIO,
>   } VirtIOMMUType;
>  =20
> +typedef enum VirtGICType {
> +    VIRT_GIC_VERSION_MAX,
> +    VIRT_GIC_VERSION_HOST,
> +    VIRT_GIC_VERSION_2,
> +    VIRT_GIC_VERSION_3,
> +} VirtGICType;
> +
>   typedef struct MemMapEntry {
>       hwaddr base;
>       hwaddr size;
> @@ -123,7 +130,7 @@ typedef struct {
>       bool highmem_ecam;
>       bool its;
>       bool virt;
> -    int32_t gic_version;
> +    VirtGICType gic_version;
>       VirtIOMMUType iommu;
>       uint16_t virtio_iommu_bdf;
>       struct arm_boot_info bootinfo;
> @@ -162,7 +169,7 @@ static inline int virt_gicv3_redist_region_count(Virt=
MachineState *vms)
>       uint32_t redist0_capacity =3D
>                   vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>  =20
> -    assert(vms->gic_version =3D=3D 3);
> +    assert(vms->gic_version =3D=3D VIRT_GIC_VERSION_3);
>  =20
>       return vms->smp_cpus > redist0_capacity ? 2 : 1;
>   }
>=20


