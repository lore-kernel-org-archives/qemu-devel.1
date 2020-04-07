Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB0C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBE2206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE2206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjZW-0007FD-6B
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jLjYn-0006en-77
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jLjYl-0007Tt-Ih
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:26:16 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:48564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jLjYl-0007QU-D6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:26:15 -0400
Received: from player159.ha.ovh.net (unknown [10.110.103.133])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 81BF199FDD
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 10:26:06 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 4929E112A3FE8;
 Tue,  7 Apr 2020 08:25:56 +0000 (UTC)
Subject: Re: [PATCH] aspeed: Add boot stub for smp booting
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200407072517.671521-1-joel@jms.id.au>
 <CACPK8XfHnE_kEPw++CdLRG9r=xJmLZkuV4WXP7NKTo8mW+dJvA@mail.gmail.com>
 <16f057db-a4d7-889f-344c-930587fc8bf1@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <141d2355-5f9d-c8f9-4021-01754f8bc2ae@kaod.org>
Date: Tue, 7 Apr 2020 10:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <16f057db-a4d7-889f-344c-930587fc8bf1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4115727110219402048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.61
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 10:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>=20
> On 4/7/20 9:38 AM, Joel Stanley wrote:
>> On Tue, 7 Apr 2020 at 07:25, Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> This is a boot stub that is similar to the code u-boot runs, allowing
>>> the kernel to boot the secondary CPU.
>>>
>>> u-boot works as follows:
>>>
>>> =C2=A0 1. Initialises the SMP mailbox area in the SCU at 0x1e6e2180 w=
ith default values
>>>
>>> =C2=A0 2. Copies a stub named 'mailbox_insn' from flash to the SCU, j=
ust above the
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mailbox area
>>>
>>> =C2=A0 3. Sets AST_SMP_MBOX_FIELD_READY to a magic value to indicate =
the
>>> =C2=A0=C2=A0=C2=A0=C2=A0 secondary can begin execution from the stub
>>>
>>> =C2=A0 4. The stub waits until the AST_SMP_MBOX_FIELD_GOSIGN register=
 is set to
>>> =C2=A0=C2=A0=C2=A0=C2=A0 a magic value
>>>
>>> =C2=A0 5. Jumps to the address in AST_SMP_MBOX_FIELD_ENTRY, starting =
Linux
>>>
>>> Linux indicates it is ready by writing the address of its entrypoint
>>> function to AST_SMP_MBOX_FIELD_ENTRY and the 'go' magic number to
>>> AST_SMP_MBOX_FIELD_GOSIGN. The secondary CPU sees this at step 4 and
>>> breaks out of it's loop.
>>>
>>> To be compatible, a fixed qemu stub is loaded into the mailbox area. =
As
>>> qemu can ensure the stub is loaded before execution starts, we do not
>>> need to emulate the AST_SMP_MBOX_FIELD_READY behaviour of u-boot. The
>>> secondary CPU's program counter points to the beginning of the stub,
>>> allowing qemu to start secondaries at step four.
>>>
>>> Reboot behaviour is preserved by resetting AST_SMP_MBOX_FIELD_GOSIGN
>>> when the secondaries are reset.
>>>
>>> This is only configured when the system is booted with -kernel and qe=
mu
>>> does not execute u-boot first.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> =C2=A0 hw/arm/aspeed.c | 65 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>>> =C2=A0 1 file changed, 65 insertions(+)
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index a6a2102a93cb..bc4386cc6174 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -116,6 +116,58 @@ static const MemoryRegionOps max_ram_ops =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>>> =C2=A0 };
>>>
>>> +#define AST_SMP_MAILBOX_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x1e6e2180
>>> +#define AST_SMP_MBOX_FIELD_ENTRY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (AST_SMP_MAILBOX_BASE + 0x0)
>>> +#define AST_SMP_MBOX_FIELD_GOSIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (AST_SMP_MAILBOX_BASE + 0x4)
>>> +#define AST_SMP_MBOX_FIELD_READY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (AST_SMP_MAILBOX_BASE + 0x8)
>>> +#define AST_SMP_MBOX_FIELD_POLLINSN=C2=A0=C2=A0=C2=A0=C2=A0 (AST_SMP=
_MAILBOX_BASE + 0xc)
>>> +#define AST_SMP_MBOX_CODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (AST_SMP_MAILBOX_BASE + 0x10)
>>> +#define AST_SMP_MBOX_GOSIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xabbaab00
>>> +
>>> +static void aspeed_write_smpboot(ARMCPU *cpu,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct arm_boot_in=
fo *info)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 static const uint32_t poll_mailbox_ready[] =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * r2 =3D per-cpu go=
 sign value
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * r1 =3D AST_SMP_MB=
OX_FIELD_ENTRY
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * r0 =3D AST_SMP_MB=
OX_FIELD_GOSIGN
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xee100fb0,=C2=A0 /* mrc=C2=
=A0=C2=A0=C2=A0=C2=A0 p15, 0, r0, c0, c0, 5 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe21000ff,=C2=A0 /* ands=
=C2=A0=C2=A0=C2=A0 r0, r0, #255=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe59f201c,=C2=A0 /* ldr=C2=
=A0=C2=A0=C2=A0=C2=A0 r2, [pc, #28]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe1822000,=C2=A0 /* orr=C2=
=A0=C2=A0=C2=A0=C2=A0 r2, r2, r0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe59f1018,=C2=A0 /* ldr=C2=
=A0=C2=A0=C2=A0=C2=A0 r1, [pc, #24]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe59f0018,=C2=A0 /* ldr=C2=
=A0=C2=A0=C2=A0=C2=A0 r0, [pc, #24]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe320f002,=C2=A0 /* wfe=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe5904000,=C2=A0 /* ldr=C2=
=A0=C2=A0=C2=A0=C2=A0 r4, [r0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe1520004,=C2=A0 /* cmp=C2=
=A0=C2=A0=C2=A0=C2=A0 r2, r4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1afffffb,=C2=A0 /* bne=C2=
=A0=C2=A0=C2=A0=C2=A0 <wfe>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xe591f000,=C2=A0 /* ldr=C2=
=A0=C2=A0=C2=A0=C2=A0 pc, [r1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AST_SMP_MBOX_GOSIGN,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AST_SMP_MBOX_FIELD_ENTRY,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AST_SMP_MBOX_FIELD_GOSIGN=
,
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 rom_add_blob_fixed("aspeed.smpboot", poll_mailbox=
_ready,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(po=
ll_mailbox_ready),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->smp=
_loader_start);
>>> +}
>>> +
>>> +static void aspeed_reset_secondary(ARMCPU *cpu,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct=
 arm_boot_info *info)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AddressSpace *as =3D arm_boot_address_space(cpu, =
info);
>>> +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* info->smp_bootreg_addr */
>>> +=C2=A0=C2=A0=C2=A0 address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD=
_GOSIGN, 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEMTXATTRS_UNSPECIFIED, NULL);
>>> +=C2=A0=C2=A0=C2=A0 cpu_set_pc(cs, info->smp_loader_start);
>>> +}
>>> +
>>> =C2=A0 #define FIRMWARE_ADDR 0x0
>>>
>>> =C2=A0 static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size=
_t rom_size,
>>> @@ -270,6 +322,19 @@ static void aspeed_machine_init(MachineState *ma=
chine)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (machine->kernel_filename) {
>>
>> I just realised this shouldn't be executed on non-ast2600 platforms.
>> We could test for the number of CPUs like this:
>>
>> if (machine->kernel_filename && aspeed_board_binfo.nb_cpus > 1) {
>=20
> =C2=A0 if (!strcmp(amc->soc_name, "ast2600")) { ?

or a 'bool' under AspeedMachineClass ?=20

A part from that,=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.=20


>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* With no u-boot we must=
 set up a boot stub for the secondary CPU */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *smpboot =3D=
 g_new(MemoryRegion, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_ram(sm=
pboot, OBJECT(bmc), "aspeed.smpboot",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80, &error_abort);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_add_subregi=
on(get_system_memory(),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AST_SM=
P_MAILBOX_BASE, smpboot);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.write_=
secondary_boot =3D aspeed_write_smpboot;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.second=
ary_cpu_reset_hook =3D aspeed_reset_secondary;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.smp_lo=
ader_start =3D AST_SMP_MBOX_CODE;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.ram_size =3D ram_si=
ze;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.loader_start =3D sc=
->memmap[ASPEED_SDRAM];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.nb_cpus =3D bmc->so=
c.num_cpus;
>>> --=20
>>> 2.25.1
>>>
>>
>=20


