Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E2FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53D22173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5R7MoPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k2y-0003Gc-2j
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8k25-00026u-Jf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8k23-0001Xf-W5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8k23-0001XO-S6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583151527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndq0s0LH5UTL/DOzi6Pi7RusPHrHXRSqQxipPR2epEY=;
 b=K5R7MoPYAy2X81hUaILYl142h6WgdGGsm7UJd2iOcSzfEGblrjnV1RNCO0InZPf+pIrVLp
 skMAz2PQovu5HWF6E8U9VtseamCILjuRMg8GOO0e0710GZRwceD2AoOcMKa+Nuw01+f6p9
 tyhCowSwHVfxZtU76xSmB9SDsnKHEQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-0GvsD5yhMm2ztRKn7U_bvg-1; Mon, 02 Mar 2020 07:18:43 -0500
X-MC-Unique: 0GvsD5yhMm2ztRKn7U_bvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E921B2C986;
 Mon,  2 Mar 2020 12:18:42 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 536035DA2C;
 Mon,  2 Mar 2020 12:18:40 +0000 (UTC)
Subject: Re: [PATCH v3 2/6] hw/arm/virt: Introduce VirtGICType enum type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-3-eric.auger@redhat.com>
 <ff498491-820a-498a-2951-6e46951dd23e@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9b27e2d4-8076-7c1f-b62e-6692ea9b3090@redhat.com>
Date: Mon, 2 Mar 2020 13:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ff498491-820a-498a-2951-6e46951dd23e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Hi Philippe,

On 3/2/20 12:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/2/20 11:55 AM, Eric Auger wrote:
>> We plan to introduce yet another value for the gic version (nosel).
>> As we already use exotic values such as 0 and -1, let's introduce
>> a dedicated enum type and let vms->gic_version take this
>> type.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - replaced defines by enum VirtGICType
>> - use that new type for vms->gic_version
>> ---
>> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3=
0 +++++++++++++++---------------
>> =C2=A0 include/hw/arm/virt.h | 11 +++++++++--
>=20
> Please have a look at scripts/git.orderfile, it helps making review
> easier/quicker.
OK I added it to my .git/config. Thanks for pointer
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

Eric
>=20
>> =C2=A0 2 files changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index c093f0ab85..b449a445de 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -298,7 +298,7 @@ static void fdt_add_timer_nodes(const
>> VirtMachineState *vms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irqflags =3D GIC_=
FDT_IRQ_FLAGS_EDGE_LO_HI;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D 2) {
>> +=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irqflags =3D depo=
sit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIC_FDT_IRQ_PPI_CPU_WIDTH,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << vms->smp_cpus) - 1);
>> @@ -439,7 +439,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop_cell(vms->fdt, nodename,=
 "#address-cells", 0x2);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop_cell(vms->fdt, nodename,=
 "#size-cells", 0x2);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop(vms->fdt, nodename, "ran=
ges", NULL, 0);
>> -=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D 3) {
>> +=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nb_redist_reg=
ions =3D virt_gicv3_redist_region_count(vms);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fdt_s=
etprop_string(vms->fdt, nodename, "compatible",
>> @@ -518,7 +518,7 @@ static void fdt_add_pmu_nodes(const
>> VirtMachineState *vms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D 2) {
>> +=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irqflags =3D depo=
sit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIC_FDT_IRQ_PPI_CPU_WIDTH,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << vms->smp_cpus) - 1);
>> @@ -1469,7 +1469,7 @@ static uint64_t
>> virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * purposes =
are to make TCG consistent (with 64-bit KVM hosts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and to im=
prove SGI efficiency.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D =
3) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D =
VIRT_GIC_VERSION_3) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 clustersz =3D GICV3_TARGETLIST_BITS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 clustersz =3D GIC_TARGETLIST_BITS;
>> @@ -1560,15 +1560,15 @@ static void machvirt_init(MachineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We can probe only here because during =
property set
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * KVM is not available yet
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (vms->gic_version <=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* "host" or "max" */
>> +=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D=3D VIRT=
_GIC_VERSION_MAX) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_enabled(=
)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
vms->gic_version =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("gic-version=3Dhost requires KV=
M");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* "max": currently means 3 for TCG */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D 3;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GIC_VERSION_3;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vms->gic_version =3D kvm_arm_vgic_probe();
>> @@ -1627,7 +1627,7 @@ static void machvirt_init(MachineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The maximum number of CPUs depends on =
the GIC version, or on how
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * many redistributors we can fit in=
to the memory map.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D 3) {
>> +=C2=A0=C2=A0=C2=A0 if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virt_max_cpus =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virt_max_cpus +=
=3D
>> @@ -1855,7 +1855,7 @@ static void virt_set_its(Object *obj, bool
>> value, Error **errp)
>> =C2=A0 static char *virt_get_gic_version(Object *obj, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtMachineState *vms =3D VIRT_MACHINE(ob=
j);
>> -=C2=A0=C2=A0=C2=A0 const char *val =3D vms->gic_version =3D=3D 3 ? "3" =
: "2";
>> +=C2=A0=C2=A0=C2=A0 const char *val =3D vms->gic_version =3D=3D VIRT_GIC=
_VERSION_3 ? "3" :
>> "2";
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return g_strdup(val);
>> =C2=A0 }
>> @@ -1865,13 +1865,13 @@ static void virt_set_gic_version(Object *obj,
>> const char *value, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtMachineState *vms =3D VIRT_MACHINE(ob=
j);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(value, "3")) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D 3;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GI=
C_VERSION_3;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(value, "2")) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D 2;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GI=
C_VERSION_2;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(value, "host")) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D 0; /* W=
ill probe later */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GI=
C_VERSION_HOST; /* Will probe later */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(value, "max")) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D -1; /* =
Will probe later */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GI=
C_VERSION_MAX; /* Will probe later */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, =
"Invalid gic-version value");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_append_hint=
(errp, "Valid values are 3, 2, host, max.\n");
>> @@ -2139,7 +2139,7 @@ static void virt_instance_init(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "physical address space above 32
>> bits",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Default GIC type is v2 */
>> -=C2=A0=C2=A0=C2=A0 vms->gic_version =3D 2;
>> +=C2=A0=C2=A0=C2=A0 vms->gic_version =3D VIRT_GIC_VERSION_2;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_str(obj, "gic-version=
", virt_get_gic_version,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 virt_set_gic_version, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_description(obj, "gic=
-version",
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 02f500cb8e..c0827cacdf 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -95,6 +95,13 @@ typedef enum VirtIOMMUType {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VIRT_IOMMU_VIRTIO,
>> =C2=A0 } VirtIOMMUType;
>> =C2=A0 +typedef enum VirtGICType {
>> +=C2=A0=C2=A0=C2=A0 VIRT_GIC_VERSION_MAX,
>> +=C2=A0=C2=A0=C2=A0 VIRT_GIC_VERSION_HOST,
>> +=C2=A0=C2=A0=C2=A0 VIRT_GIC_VERSION_2,
>> +=C2=A0=C2=A0=C2=A0 VIRT_GIC_VERSION_3,
>> +} VirtGICType;
>> +
>> =C2=A0 typedef struct MemMapEntry {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr base;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr size;
>> @@ -123,7 +130,7 @@ typedef struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool highmem_ecam;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool its;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool virt;
>> -=C2=A0=C2=A0=C2=A0 int32_t gic_version;
>> +=C2=A0=C2=A0=C2=A0 VirtGICType gic_version;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOMMUType iommu;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t virtio_iommu_bdf;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct arm_boot_info bootinfo;
>> @@ -162,7 +169,7 @@ static inline int
>> virt_gicv3_redist_region_count(VirtMachineState *vms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t redist0_capacity =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vms->memmap[VIRT_GIC_REDIST].size / GICV3_RE=
DIST_SIZE;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 assert(vms->gic_version =3D=3D 3);
>> +=C2=A0=C2=A0=C2=A0 assert(vms->gic_version =3D=3D VIRT_GIC_VERSION_3);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vms->smp_cpus > redist0_cap=
acity ? 2 : 1;
>> =C2=A0 }
>>
>=20
>=20


