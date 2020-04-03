Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8847EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DA820721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DA820721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOYV-0001CL-Be
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jKOXd-0000en-9C
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jKOXZ-0005qj-N5
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:47:33 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:43750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jKOXZ-0005nK-Cd
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:47:29 -0400
Received: from player715.ha.ovh.net (unknown [10.108.54.97])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id F02361BA37E
 for <qemu-devel@nongnu.org>; Fri,  3 Apr 2020 17:47:26 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id A9E5910E9EBF5;
 Fri,  3 Apr 2020 15:47:18 +0000 (UTC)
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
 <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
 <1585899319.9tofsl4fd9.astroid@bobo.none>
 <1585915002.kqdz9mya1i.astroid@bobo.none>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <500c5162-ef10-1913-0ef0-de5fb1b8b28d@kaod.org>
Date: Fri, 3 Apr 2020 17:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585915002.kqdz9mya1i.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6525152910583106368
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeigdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.97.206
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 3:12 PM, Nicholas Piggin wrote:
> Nicholas Piggin's on April 3, 2020 5:57 pm:
>> C=C3=A9dric Le Goater's on March 26, 2020 2:38 am:
>>> [ Please use clg@kaod.org ! ]
>>>
>>> On 3/25/20 3:41 PM, Nicholas Piggin wrote:
>>>> This implements the NMI interface for the PNV machine, similarly to
>>>> commit 3431648272d ("spapr: Add support for new NMI interface") for
>>>> SPAPR.
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> one minor comment,
>>>
>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>
>>>> ---
>>>>  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
>>>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>>> index b75ad06390..671535ebe6 100644
>>>> --- a/hw/ppc/pnv.c
>>>> +++ b/hw/ppc/pnv.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include "sysemu/runstate.h"
>>>>  #include "sysemu/cpus.h"
>>>>  #include "sysemu/device_tree.h"
>>>> +#include "sysemu/hw_accel.h"
>>>>  #include "target/ppc/cpu.h"
>>>>  #include "qemu/log.h"
>>>>  #include "hw/ppc/fdt.h"
>>>> @@ -34,6 +35,7 @@
>>>>  #include "hw/ppc/pnv.h"
>>>>  #include "hw/ppc/pnv_core.h"
>>>>  #include "hw/loader.h"
>>>> +#include "hw/nmi.h"
>>>>  #include "exec/address-spaces.h"
>>>>  #include "qapi/visitor.h"
>>>>  #include "monitor/monitor.h"
>>>> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, =
bool value, Error **errp)
>>>>      }
>>>>  }
>>>>
>>>> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg=
)
>>>> +{
>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>>> +    CPUPPCState *env =3D &cpu->env;
>>>> +
>>>> +    cpu_synchronize_state(cs);
>>>> +    ppc_cpu_do_system_reset(cs);
>>>> +    /*
>>>> +     * SRR1[42:45] is set to 0100 which the ISA defines as implemen=
tation
>>>
>>> I see 'System Reset' in ISA 3.0
>>>> +     * dependent. POWER processors use this for xscom triggered int=
errupts,
>>>> +     * which come from the BMC or NMI IPIs.
>>>> +     */
>>>> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>>>
>>> So we could have used the skiboot SPR_SRR1_PM_WAKE_SRESET define ?=20
>>
>> Ah, that's only for power-saving wakeup. But you got me to dig further
>> and I think I've got a few things wrong here.
>>
>> The architectural power save wakeup due to sreset bit 43 needs to be
>> set, probably in excp_helper.c if (msr_pow) test.
>>
>>     case POWERPC_EXCP_RESET:     /* System reset exception            =
       */
>>         /* A power-saving exception sets ME, otherwise it is unchanged=
 */
>>         if (msr_pow) {
>>             /* indicate that we resumed from power save mode */
>>             msr |=3D 0x10000;
>>             new_msr |=3D ((target_ulong)1 << MSR_ME);
>>         }
>=20
> Sorry I'm wrong, that's the old MSR_POW thing I guess G5 had it.
>=20
> 'stop' state wakeup is powerpc_reset_wakeup of course, which seems to
> do the right thing with SRR1.
>=20
> Something like this patch should fix this issue in the ppc-5.1 branch.
> This appears to do the right thing with SRR1 in testing with Linux.
>=20
> ---
>  hw/ppc/pnv.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ac83b8698b..596ccfd99e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1964,12 +1964,21 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs,=
 run_on_cpu_data arg)
> =20
>      cpu_synchronize_state(cs);
>      ppc_cpu_do_system_reset(cs);
> -    /*
> -     * SRR1[42:45] is set to 0100 which the ISA defines as implementat=
ion
> -     * dependent. POWER processors use this for xscom triggered interr=
upts,
> -     * which come from the BMC or NMI IPIs.
> -     */
> -    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> +        /* system reset caused wake from power saving state */
> +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> +            warn_report("ppc_cpu_do_system_reset does not set system r=
eset wakeup reason");
> +            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +        }
> +    } else {
> +        /*
> +	 * For non-powersave wakeup system resets, SRR1[42:45] are defined to
> +	 * be implementation dependent. Set to 0b0010, which POWER9 UM define=
s
> +	 * to be interrupt caused by SCOM, which can come from the BMC or NMI
> +	 * IPIs.
> +         */
> +        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
> +    }
>  }

That looks correct according to the UM.

Do we care about the other non-powersave wakeup system resets ?=20

  0011 Interrupt caused by hypervisor door bell.
  0101 Interrupt caused by privileged door bell.

The reason is that I sometime see CPU lockups under load, or with a KVM g=
uest,=20
and I haven't found why yet.

Thanks,


C.=20


[  259.069436] virbr0: port 2(tap0) entered forwarding state
[  259.069523] virbr0: topology change detected, propagating
[  384.427337] watchdog: CPU 1 detected hard LOCKUP on other CPUs 0
[  384.428566] watchdog: CPU 1 TB:255514422948, last SMP heartbeat TB:246=
648941120 (17315ms ago)
[  384.528958] watchdog: CPU 0 Hard LOCKUP
[  384.529380] watchdog: CPU 0 TB:255566522003, last heartbeat TB:2466489=
41120 (17417ms ago)
[  384.529879] Modules linked in: vhost_net vhost xt_CHECKSUM xt_MASQUERA=
DE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6ta=
ble_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 lib=
crc32c nf_defrag_ipv4 nf_tables nfnetlink ip6table_filter ip6_tables ipta=
ble_filter bpfilter bridge stp llc vmx_crypto crct10dif_vpmsum crc32c_vpm=
sum uio_pdrv_genirq uio kvm_hv kvm sch_fq_codel ip_tables x_tables autofs=
4 ipr e1000e ahci libahci
[  384.530400] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5+ #31
[  384.530473] NIP:  c00000000000a93c LR: c00000000001b944 CTR: 00007094c=
b3d9680
[  384.530522] REGS: c000000001a47a40 TRAP: 0e81   Not tainted  (5.6.0-rc=
5+)
[  384.530532] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 4800=
0242  XER: 00000000
[  384.530649] CFAR: 00000ac5e544b424 IRQMASK: 0=20
               GPR00: c000000000c03620 c000000001a47cd0 c000000001a48f00 =
0000000028000000=20
               GPR04: 00000000682a0000 0000003b80f29024 0000003ea9382e20 =
c000000001cf0000=20
               GPR08: 0000000200000000 00000ac5e55200a0 0000000000000000 =
00000ac61eb65648=20
               GPR12: 0000000044022444 00007094cb5ddcc0=20
[  384.531164] NIP [c00000000000a93c] replay_interrupt_return+0x0/0x4
[  384.531203] LR [c00000000001b944] arch_local_irq_restore.part.0+0x54/0=
x70
[  384.531305] Call Trace:
[  384.531360] [c000000001a47cd0] [c000000001a47d50] init_stack+0x3d50/0x=
4000 (unreliable)
[  384.531450] [c000000001a47cf0] [c000000000c03620] cpuidle_enter_state+=
0xf0/0x590
[  384.531471] [c000000001a47d70] [c000000000c03b5c] cpuidle_enter+0x4c/0=
x70
[  384.531503] [c000000001a47db0] [c00000000018c7cc] call_cpuidle+0x4c/0x=
90
[  384.531514] [c000000001a47dd0] [c00000000018cde8] do_idle+0x308/0x420
[  384.531523] [c000000001a47e70] [c00000000018d148] cpu_startup_entry+0x=
38/0x40
[  384.531531] [c000000001a47ea0] [c000000000010800] rest_init+0xe0/0xf8
[  384.531543] [c000000001a47ed0] [c00000000130445c] start_kernel+0x7c4/0=
x810
[  384.531553] [c000000001a47f90] [c00000000000accc] start_here_common+0x=
1c/0x3e8
[  384.531610] Instruction dump:
[  384.531782] 7d200026 618c8000 2c030900 4182e778 2c030500 4182f3b0 2c03=
0f00 4182f4c8=20
[  384.531821] 2c030a00 4182ffbc 2c030e60 4182f158 <4e800020> 7c781b78 48=
000329 48000341=20
[  388.127242] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  388.128093] rcu: 	0-...!: (0 ticks this GP) idle=3Dde0/0/0x0 softirq=3D=
40880/40880 fqs=3D0=20
[  388.128760] 	(detected by 1, t=3D5252 jiffies, g=3D61401, q=3D9509)
[  388.128967] Sending NMI from CPU 1 to CPUs 0:
[  388.124766] NMI backtrace for cpu 0
[  388.124789] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5+ #31
[  388.124799] NIP:  c00000000000a93c LR: c00000000001b944 CTR: 00007094c=
b3d9680
[  388.124807] REGS: c000000001a47a40 TRAP: 0e81   Not tainted  (5.6.0-rc=
5+)
[  388.124811] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 4800=
0242  XER: 00000000
[  388.124839] CFAR: 00000ac5e544b424 IRQMASK: 0=20
               GPR00: c000000000c03620 c000000001a47cd0 c000000001a48f00 =
0000000028000000=20
               GPR04: 00000000682a0000 0000003beeaf96c3 0000003ea9382e20 =
c000000001cf0000=20
               GPR08: 0000000200000000 00000ac5e55200a0 0000000000000000 =
00000ac61eb65648=20
               GPR12: 0000000044022444 00007094cb5ddcc0=20
[  388.124894] NIP [c00000000000a93c] replay_interrupt_return+0x0/0x4
[  388.124904] LR [c00000000001b944] arch_local_irq_restore.part.0+0x54/0=
x70
[  388.124909] Call Trace:
[  388.124920] [c000000001a47cd0] [c000000001a47d50] init_stack+0x3d50/0x=
4000 (unreliable)
[  388.124935] [c000000001a47cf0] [c000000000c03620] cpuidle_enter_state+=
0xf0/0x590
[  388.124946] [c000000001a47d70] [c000000000c03b5c] cpuidle_enter+0x4c/0=
x70
[  388.124959] [c000000001a47db0] [c00000000018c7cc] call_cpuidle+0x4c/0x=
90
[  388.124970] [c000000001a47dd0] [c00000000018cde8] do_idle+0x308/0x420
[  388.124981] [c000000001a47e70] [c00000000018d148] cpu_startup_entry+0x=
38/0x40
[  388.124991] [c000000001a47ea0] [c000000000010800] rest_init+0xe0/0xf8
[  388.125002] [c000000001a47ed0] [c00000000130445c] start_kernel+0x7c4/0=
x810
[  388.125013] [c000000001a47f90] [c00000000000accc] start_here_common+0x=
1c/0x3e8
[  388.125020] Instruction dump:
[  388.125031] 7d200026 618c8000 2c030900 4182e778 2c030500 4182f3b0 2c03=
0f00 4182f4c8=20
[  388.125057] 2c030a00 4182ffbc 2c030e60 4182f158 <4e800020> 7c781b78 48=
000329 48000341=20
[  388.129812] rcu: rcu_sched kthread starved for 5252 jiffies! g61401 f0=
x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[  388.130357] rcu: RCU grace-period kthread stack dump:
[  388.130752] rcu_sched       I    0    10      2 0x00000808
[  388.130829] Call Trace:
[  388.131100] [c000000068487890] [c000000068487940] 0xc000000068487940 (=
unreliable)
[  388.131135] [c000000068487a70] [c000000000021c6c] __switch_to+0x2dc/0x=
450
[  388.131151] [c000000068487ae0] [c000000000e98a14] __schedule+0x2d4/0x9=
20
[  388.131162] [c000000068487bb0] [c000000000e990d4] schedule+0x74/0x140
[  388.131173] [c000000068487be0] [c000000000e9ed24] schedule_timeout+0x1=
a4/0x3e0
[  388.131186] [c000000068487cc0] [c0000000001eac88] rcu_gp_kthread+0x788=
/0xd00
[  388.131197] [c000000068487db0] [c000000000170744] kthread+0x1a4/0x1b0
[  388.131210] [c000000068487e20] [c00000000000b648] ret_from_kernel_thre=
ad+0x5c/0x74
[  451.146090] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  451.147979] rcu: 	0-...!: (0 ticks this GP) idle=3De30/0/0x0 softirq=3D=
40880/40880 fqs=3D1=20
[  451.150009] 	(detected by 1, t=3D21007 jiffies, g=3D61401, q=3D9531)
[  451.150097] Sending NMI from CPU 1 to CPUs 0:
[  451.145933] NMI backtrace for cpu 0
[  451.146028] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5+ #31
[  451.146095] NIP:  c00000000000a93c LR: c00000000001b944 CTR: c00000000=
00b9780
[  451.146126] REGS: c000000001a47a40 TRAP: 0e81   Not tainted  (5.6.0-rc=
5+)
[  451.146139] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 4800=
0242  XER: 00000000
[  451.146233] CFAR: c0000000000b89a0 IRQMASK: 0=20
               GPR00: c000000000c03620 c000000001a47cd0 c000000001a48f00 =
0000000028000000=20
               GPR04: 00000000682a0000 0000004371f05548 0000004659916004 =
c000000001cf0000=20
               GPR08: 0000000200000000 c00a001080060031 0000000000000000 =
c000000001cb8f00=20
               GPR12: 0000000000008000 c000000001cf0000=20
[  451.146433] NIP [c00000000000a93c] replay_interrupt_return+0x0/0x4
[  451.146471] LR [c00000000001b944] arch_local_irq_restore.part.0+0x54/0=
x70
[  451.146492] Call Trace:
[  451.146540] [c000000001a47cd0] [c000000001a47d50] init_stack+0x3d50/0x=
4000 (unreliable)
[  451.146603] [c000000001a47cf0] [c000000000c03620] cpuidle_enter_state+=
0xf0/0x590
[  451.146636] [c000000001a47d70] [c000000000c03b5c] cpuidle_enter+0x4c/0=
x70
[  451.146686] [c000000001a47db0] [c00000000018c7cc] call_cpuidle+0x4c/0x=
90
[  451.146722] [c000000001a47dd0] [c00000000018cde8] do_idle+0x308/0x420
[  451.146757] [c000000001a47e70] [c00000000018d14c] cpu_startup_entry+0x=
3c/0x40
[  451.146786] [c000000001a47ea0] [c000000000010800] rest_init+0xe0/0xf8
[  451.146834] [c000000001a47ed0] [c00000000130445c] start_kernel+0x7c4/0=
x810
[  451.146871] [c000000001a47f90] [c00000000000accc] start_here_common+0x=
1c/0x3e8
[  451.146894] Instruction dump:
[  451.146933] 7d200026 618c8000 2c030900 4182e778 2c030500 4182f3b0 2c03=
0f00 4182f4c8=20
[  451.146998] 2c030a00 4182ffbc 2c030e60 4182f158 <4e800020> 7c781b78 48=
000329 48000341=20
[  451.151652] rcu: rcu_sched kthread starved for 15754 jiffies! g61401 f=
0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[  451.154297] rcu: RCU grace-period kthread stack dump:
[  451.155712] rcu_sched       I    0    10      2 0x00000808
[  451.155782] Call Trace:
[  451.155861] [c000000068487890] [c000000068487940] 0xc000000068487940 (=
unreliable)
[  451.155950] [c000000068487a70] [c000000000021c6c] __switch_to+0x2dc/0x=
450
[  451.155999] [c000000068487ae0] [c000000000e98a14] __schedule+0x2d4/0x9=
20
[  451.156029] [c000000068487bb0] [c000000000e990d4] schedule+0x74/0x140
[  451.156061] [c000000068487be0] [c000000000e9ed24] schedule_timeout+0x1=
a4/0x3e0
[  451.156103] [c000000068487cc0] [c0000000001eac88] rcu_gp_kthread+0x788=
/0xd00
[  451.156135] [c000000068487db0] [c000000000170744] kthread+0x1a4/0x1b0
[  451.156177] [c000000068487e20] [c00000000000b648] ret_from_kernel_thre=
ad+0x5c/0x74
[  496.617376] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  496.617727] rcu: 	0-...!: (0 ticks this GP) idle=3De80/0/0x0 softirq=3D=
40880/40880 fqs=3D0=20
[  496.618063] 	(detected by 1, t=3D5252 jiffies, g=3D61437, q=3D7149)
[  496.618085] Sending NMI from CPU 1 to CPUs 0:
[  496.613805] NMI backtrace for cpu 0
[  496.613833] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5+ #31
[  496.613844] NIP:  c00000000000a93c LR: c00000000001b944 CTR: c00000000=
05028c0
[  496.613852] REGS: c000000001a47a40 TRAP: 0e81   Not tainted  (5.6.0-rc=
5+)
[  496.613856] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 4800=
0242  XER: 00000000
[  496.613884] CFAR: c000000000ea0310 IRQMASK: 0=20
               GPR00: c000000000c03620 c000000001a47cd0 c000000001a48f00 =
0000000028000000=20
               GPR04: 00000000682a0000 00000048dd82a1dd 0000004a31bd97db =
c000000001cf0000=20
               GPR08: 0000000200000000 0000000000000000 00007fffef5c14a0 =
0800000042546c02=20
               GPR12: 0000000000002000 c000000001cf0000=20
[  496.613941] NIP [c00000000000a93c] replay_interrupt_return+0x0/0x4
[  496.613951] LR [c00000000001b944] arch_local_irq_restore.part.0+0x54/0=
x70
[  496.613956] Call Trace:
[  496.613970] [c000000001a47cd0] [c000000001a47d50] init_stack+0x3d50/0x=
4000 (unreliable)
[  496.613988] [c000000001a47cf0] [c000000000c03620] cpuidle_enter_state+=
0xf0/0x590
[  496.613998] [c000000001a47d70] [c000000000c03b5c] cpuidle_enter+0x4c/0=
x70
[  496.614011] [c000000001a47db0] [c00000000018c7cc] call_cpuidle+0x4c/0x=
90
[  496.614021] [c000000001a47dd0] [c00000000018cde8] do_idle+0x308/0x420
[  496.614030] [c000000001a47e70] [c00000000018d148] cpu_startup_entry+0x=
38/0x40
[  496.614038] [c000000001a47ea0] [c000000000010800] rest_init+0xe0/0xf8
[  496.614060] [c000000001a47ed0] [c00000000130445c] start_kernel+0x7c4/0=
x810
[  496.614071] [c000000001a47f90] [c00000000000accc] start_here_common+0x=
1c/0x3e8
[  496.614078] Instruction dump:
[  496.614091] 7d200026 618c8000 2c030900 4182e778 2c030500 4182f3b0 2c03=
0f00 4182f4c8=20
[  496.614109] 2c030a00 4182ffbc 2c030e60 4182f158 <4e800020> 7c781b78 48=
000329 48000341=20
[  496.618540] rcu: rcu_sched kthread starved for 5252 jiffies! g61437 f0=
x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[  496.618949] rcu: RCU grace-period kthread stack dump:
[  496.619169] rcu_sched       I    0    10      2 0x00000808
[  496.619184] Call Trace:
[  496.619207] [c000000068487890] [c0000000684878c0] 0xc0000000684878c0 (=
unreliable)
[  496.619231] [c000000068487a70] [c000000000021c6c] __switch_to+0x2dc/0x=
450
[  496.619244] [c000000068487ae0] [c000000000e98a14] __schedule+0x2d4/0x9=
20
[  496.619252] [c000000068487bb0] [c000000000e990d4] schedule+0x74/0x140
[  496.619260] [c000000068487be0] [c000000000e9ed24] schedule_timeout+0x1=
a4/0x3e0
[  496.619271] [c000000068487cc0] [c0000000001eac88] rcu_gp_kthread+0x788=
/0xd00
[  496.619280] [c000000068487db0] [c000000000170744] kthread+0x1a4/0x1b0
[  496.619291] [c000000068487e20] [c00000000000b648] ret_from_kernel_thre=
ad+0x5c/0x74


(qemu) info registers=20
NIP c00000000003c95c   LR c0000000000c40c4 CTR c000000000c083f0 XER 00000=
00000000000 CPU#0
MSR 9000000002803033 HID0 0880000000000000  HF 9000000002802031 iidx 5 di=
dx 5
TB 00000079 342952940705 DECR 466647440485
GPR00 c0000000000c4560 c000000001a47b80 c000000001a48f00 0000000000300331
GPR04 c0000000000c40c4 0000000088000242 0000000000000008 c0000000019c8c00
GPR08 c000000001a88f00 0000000000300331 0000000000000000 ffffffffffffffff
GPR12 c000000000c083f0 c000000001cf0000 0000000000000001 c000000000000000
GPR16 0000000000000001 c000000001af03b0 c000000001a81ff8 0000000000000000
GPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24 0000000000000000 0000000000000000 0000000000000000 4000000000000000
GPR28 ffffffffffffffff 0000000000000000 0000000080000000 0000000000000000
CR 88000242  [ L  L  -  -  -  E  G  E  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 736f6d6570736575
FPR12 6727fe175ed234df 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 00007094cb412eac  SRR1 900000000280f033    PVR 00000000004e1200 VRS=
AVE ffffffffffffffff
SPRG0 0000000000000000 SPRG1 c000000001cf0000  SPRG2 c000000001cf0000  SP=
RG3 0000000000000000
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
HSRR0 c0000000007f2efc HSRR1 9000000000009033
 CFAR c0000000000c40c0
 LPCR 0040400001d2f012
 PTCR 00000000f7fe0004   DAR 00000ac61eb32280  DSISR 000000000a000000

(qemu) cpu 1
(qemu) info registers=20
NIP c00000000003c95c   LR c0000000000c40c4 CTR c000000000c083f0 XER 00000=
00000000000 CPU#1
MSR 9000000000001033 HID0 0880000000000000  HF 9000000000000031 iidx 5 di=
dx 5
TB 00000081 348632348722 DECR 18446744073709522216
GPR00 c0000000000c4560 c0000000684bbbe0 c000000001a48f00 0000000000300331
GPR04 c0000000000c40c4 0000000088004222 0000000000000808 c000000068479000
GPR08 c000000001a88f00 0000000000300331 0000000000000000 ffffffffffffffff
GPR12 c000000000c083f0 c0000000fffff300 0000000000000001 c000000000000000
GPR16 0000000000000001 c000000001af03b0 c000000001a81ff8 0000000000000000
GPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24 0000000000000000 0000000000000000 0000000000000000 4000000000000000
GPR28 ffffffffffffffff 0000000000000000 0000000080000000 0000000000000000
CR 88004222  [ L  L  -  -  G  E  E  E  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 c00000000000a93c  SRR1 9000000000009033    PVR 00000000004e1200 VRS=
AVE 0000000000000000
SPRG0 0000000000000000 SPRG1 c000000001cf0000  SPRG2 c000000001cf0000  SP=
RG3 0000000000000001
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
HSRR0 c0000000000c1168 HSRR1 9000000000001033
 CFAR c0000000000c40c0
 LPCR 0040400001d2f012
 PTCR 00000000f7fe0004   DAR 00007be52be83320  DSISR 000000000a000000


