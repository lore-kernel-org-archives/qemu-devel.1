Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC80AC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4F206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHuIR-0005uz-N5
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHuH2-0005OU-CT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHuGy-0007OT-EH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:31:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHuGv-0007M9-Ge
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 395063090FC1;
 Tue,  8 Oct 2019 18:31:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5C9F10027A3;
 Tue,  8 Oct 2019 18:31:23 +0000 (UTC)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <6f3792fe-9cf6-725a-3fbc-475fda5c22e3@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9e48f2c3-cd70-ca96-6007-63391f37cdc3@redhat.com>
Date: Tue, 8 Oct 2019 20:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f3792fe-9cf6-725a-3fbc-475fda5c22e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 08 Oct 2019 18:31:42 +0000 (UTC)
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/19 15:29, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 10/8/19 12:52 PM, Laszlo Ersek wrote:
>> FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest
>> firmware,
>> due to historical reasons. That value is not useful to edk2, however. =
For
>> supporting VCPU hotplug, edk2 needs:
>>
>> - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
>>
>> - and the maximum foreseen CPU count (tracked in
>> =C2=A0=C2=A0 "MachineState.smp.max_cpus", but not currently exposed).
>>
>> Add a new fw-cfg file to expose "max_cpus".
>>
>> While at it, expose the rest of the topology too (die / core / thread
>> counts), because I expect that the VCPU hotplug feature for OVMF will
>> ultimately need those too, and the data size is not large. This is
>> slightly complicated by the fact that the die count is specific to
>> PCMachineState, but fw_cfg_arch_create() intends to be PC-independent
>> (see
>> commit 149c50cabcc4).
>=20
> The X86 topology is generic to the architecture (not machine specific)
> so it is well placed in fw_cfg_arch_create().

Certainly -- I didn't mean to "complain" in the commit message, just to
point out why I added a new parameter to fw_cfg_arch_create().

Because, my first instinct was to change fw_cfg_arch_create() to simply
take a (PCMachineState*), and then fw_cfg_arch_create() could fetch
whatever it needed, internally.

But, upon finding your commit 149c50cabcc4, I realized that adding a new
parameter was the correct approach (just "slightly complicated" relative
to passing (PCMachineState*) whole-sale.)

To wit, I didn't write "*tries* to be PC-independent", but "*intends* to
be PC-independent". I agree with the intent :)

>=20
>>
>> For now, the feature is temporarily disabled.
>=20
> I see you enable it in the PC machine in the next patch.
> Do you plan to remove the 'expose_topology' argument and expose the key
> later, or is this comment simply related to this patch?
>=20
> Ah, now I see you disable it previous to pc-4.2, OK.

Right, the sentence only refers to the "false" argument in this patch,
for the "expose_topology" parameter.

It took me some time to come up with this solution. I certainly wanted
to separate the feature from the versioned machine type changes. One
approach could have been to introduce the fw_cfg_expose_topology()
function in itself, in a separate patch -- but then bisection would
break at that commit, because gcc doesn't like static functions
(functions with internal linkage) that are never called. So I wanted to
call the new function at once, but short-circuit it too.

(I tend to build patch series at every stage, before posting them.)

>=20
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>> =C2=A0 hw/i386/fw_cfg.h | 30 +++++++++++++++++++++++++++++-
>> =C2=A0 hw/i386/fw_cfg.c | 26 ++++++++++++++++++++++++--
>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 3 files changed, 55 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
>> index e0856a376996..d742435b9793 100644
>> --- a/hw/i386/fw_cfg.h
>> +++ b/hw/i386/fw_cfg.h
>> @@ -18,9 +18,37 @@
>> =C2=A0 #define FW_CFG_E820_TABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
FW_CFG_ARCH_LOCAL + 3)
>> =C2=A0 #define FW_CFG_HPET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FW_CFG_ARCH_LOCAL + 4)
>> =C2=A0 +/**
>> + * FWCfgX86Topology: expose the X86 CPU topology to guest firmware
>> over fw-cfg.
>> + *
>> + * All fields have little-endian encoding.
>> + *
>> + * @dies:=C2=A0=C2=A0=C2=A0=C2=A0 Number of dies per package (aka soc=
ket). Set it to 1
>> unless the
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
concrete MachineState subclass defines it differently.
>> + * @cores:=C2=A0=C2=A0=C2=A0 Corresponds to @CpuTopology.@cores.
>> + * @threads:=C2=A0 Corresponds to @CpuTopology.@threads.
>> + * @max_cpus: Corresponds to @CpuTopology.@max_cpus.
>> + *
>> + * Firmware can derive the package (aka socket) count with the follow=
ing
>> + * formula:
>> + *
>> + *=C2=A0=C2=A0 DIV_ROUND_UP(@max_cpus, @dies * @cores * @threads)
>> + *
>> + * Firmware can derive APIC ID field widths and offsets per the stand=
ard
>> + * calculations in "include/hw/i386/topology.h".
>> + */
>> +typedef struct FWCfgX86Topology {
>> +=C2=A0 uint32_t dies;
>> +=C2=A0 uint32_t cores;
>> +=C2=A0 uint32_t threads;
>> +=C2=A0 uint32_t max_cpus;
>> +} QEMU_PACKED FWCfgX86Topology;
>> +
>> =C2=A0 FWCfgState *fw_cfg_arch_create(MachineState *ms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t boot_cpus,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t apic_id_limit);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t apic_id_limit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned smp_dies,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool expose_topology);
>> =C2=A0 void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
>> =C2=A0 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState
>> *fw_cfg);
>> =C2=A0 diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
>> index 39b6bc60520c..33d09875014f 100644
>> --- a/hw/i386/fw_cfg.c
>> +++ b/hw/i386/fw_cfg.c
>> @@ -85,9 +85,26 @@ void fw_cfg_build_smbios(MachineState *ms,
>> FWCfgState *fw_cfg)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 +static void fw_cfg_expose_topology(FWCfgState *fw_cfg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned die=
s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned cor=
es,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned thr=
eads,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned max=
_cpus)
>> +{
>> +=C2=A0=C2=A0=C2=A0 FWCfgX86Topology *topo =3D g_new(FWCfgX86Topology,=
 1);
>> +
>> +=C2=A0=C2=A0=C2=A0 topo->dies=C2=A0=C2=A0=C2=A0=C2=A0 =3D cpu_to_le32=
(dies);
>> +=C2=A0=C2=A0=C2=A0 topo->cores=C2=A0=C2=A0=C2=A0 =3D cpu_to_le32(core=
s);
>> +=C2=A0=C2=A0=C2=A0 topo->threads=C2=A0 =3D cpu_to_le32(threads);
>> +=C2=A0=C2=A0=C2=A0 topo->max_cpus =3D cpu_to_le32(max_cpus);
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "etc/x86-smp-topology", to=
po, sizeof *topo);
>> +}
>> +
>> =C2=A0 FWCfgState *fw_cfg_arch_create(MachineState *ms,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint16_t boot_cpus,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint16_t apic_id_limit)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t boot_cpus,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t apic_id_limit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned smp_dies,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool expose_topology)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWCfgState *fw_cfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *numa_fw_cfg;
>> @@ -143,6 +160,11 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 + apic_id=
_limit + nb_numa_nodes) *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*numa=
_fw_cfg));
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (expose_topology) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_expose_topology(fw_=
cfg, smp_dies, ms->smp.cores,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->smp.threads, ms->smp.max_cpus);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fw_cfg;
>> =C2=A0 }
>> =C2=A0 diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bcda50efcc23..bb72b12edad2 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1738,8 +1738,8 @@ void pc_memory_init(PCMachineState *pcms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 option_rom_mr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 fw_cfg =3D fw_cfg_arch_create(machine,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->boot_cpus, pcms->apic_id=
_limit);
>> +=C2=A0=C2=A0=C2=A0 fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_=
cpus,
>> pcms->apic_id_limit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->smp_dies, false);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rom_set_fw(fw_cfg);
>> =C2=A0=20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thank you!
Laszlo

