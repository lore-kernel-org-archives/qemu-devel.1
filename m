Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F4420645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F4420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtQH-0003jA-M5
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hgsAw-0000dT-75
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hgsAp-0003vp-0U
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1hgsAl-0003qY-HW; Fri, 28 Jun 2019 10:48:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4207B30811C7;
 Fri, 28 Jun 2019 14:48:13 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95090194A8;
 Fri, 28 Jun 2019 14:48:05 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190312085502.8203-1-david@gibson.dropbear.id.au>
 <20190312085502.8203-13-david@gibson.dropbear.id.au>
 <b693da29-0d2a-e739-17fb-9fd78894fd9e@redhat.com>
 <8416add1-453a-b8f7-5b43-fc31bf8e8fca@redhat.com>
 <95942a3b-0202-9a9f-cc71-ec6dfeceff8d@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <27915778-7789-5e3d-f952-7e2317a88634@redhat.com>
Date: Fri, 28 Jun 2019 16:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <95942a3b-0202-9a9f-cc71-ec6dfeceff8d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 14:48:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 12/62] target/ppc/spapr: Enable mitigations
 by default for pseries-4.0 machine type
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/2019 16:28, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/28/19 4:14 PM, Laurent Vivier wrote:
>> On 28/06/2019 13:27, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi,
>>>
>>> On 3/12/19 9:54 AM, David Gibson wrote:
>>>> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>>>
>>>> There are currently 3 mitigations the availability of which is contr=
olled
>>>> by the spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable=
 these
>>>> mitigations by default for the pseries-4.0 machine type.
>>>>
>>>> By now machine firmware should have been upgraded to allow these
>>>> settings.
>>>>
>>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>>> Message-Id: <20190301044609.9626-3-sjitindarsingh@gmail.com>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>> ---
>>>>  hw/ppc/spapr.c | 9 ++++++---
>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 37fd7a1411..946bbcf9ee 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -4307,9 +4307,9 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
>>>>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>>>>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>>>>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
>>>> -    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>>>> -    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>>>> -    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_WORKAROUND=
;
>>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_WORKAROUND=
;
>>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
>>>>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64=
kiB */
>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_O=
FF;
>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_ON;
>>>> @@ -4389,6 +4389,9 @@ static void spapr_machine_3_1_class_options(Ma=
chineClass *mc)
>>>>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>>      smc->update_dt_enabled =3D false;
>>>>      smc->dr_phb_enabled =3D false;
>>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_OFF;
>>>>  }
>>>
>>> While trying auto-bisection for LP#1834613 [*] I found this commit br=
eak
>>> clean bisection.
>>>
>>> ./configure --enable-debug
>>>
>>> $ qemu-system-ppc64 \
>>>  -kernel vmlinuz-vanilla \
>>>  -nographic -serial null
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-cfpc=3Dworkaround
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-sbbc=3Dworkaround
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-ibs=3Dworkaround
>>> Opcode 13 10 10 00 (4c400420) leaked temporaries
>>>
>>> More verbose log:
>>>
>>> $ qemu-system-ppc64 \
>>>  -kernel vmlinuz-vanilla \
>>>  -nographic -append "console=3Dhvc0" \
>>>  -d guest_errors,in_asm
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-cfpc=3Dworkaround
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-sbbc=3Dworkaround
>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>> cap-ibs=3Dworkaround
>>>
>>>
>>> SLOF ****************************************************************=
******
>>> QEMU Starting
>>>  Build Date =3D Jan 14 2019 18:00:39
>>>  FW Version =3D git-a5b428e1c1eae703
>>>  Press "s" to enter Open Firmware.
>>> [...]
>>> --------------
>>> IN: __switch_to
>>> 0xc00000000001aac0:  60000000  nop
>>> 0xc00000000001aac4:  7f44d378  mr       r4, r26
>>> 0xc00000000001aac8:  7f23cb78  mr       r3, r25
>>> 0xc00000000001aacc:  4bff3235  bl       0xdd00
>>
>> The kernel logs are:
>>
>> [    0.044473] Oops: Exception in kernel mode, sig: 4 [#1]
>> [    0.044899] BE PAGE_SIZE=3D64K MMU=3DRadix MMU=3DHash SMP NR_CPUS=3D=
2048 NUMA pSeries
>> [    0.045191] Modules linked in:
>> [    0.045504] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc4-000=
58-g582549e3fbe1-dirty #11
>> [    0.045646] NIP:  c00000000000be00 LR: c00000000000e168 CTR: 000000=
0000007fff
>> [    0.045747] REGS: c0000000011bb770 TRAP: 0700   Not tainted  (5.1.0=
-rc4-00058-g582549e3fbe1-dirty)
>> [    0.045808] MSR:  8000000002089032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 240=
28822  XER: 00000000
>> [    0.045971] CFAR: c00000000000bde4 IRQMASK: 1=20
>> [    0.045971] GPR00: c00000000001f390 c0000000011bba00 c0000000011bf8=
00 c0000000010db830=20
>> [    0.045971] GPR04: c00000001e4041b0 0000000000000000 00000000000000=
00 00000000028a5d7a=20
>> [    0.045971] GPR08: 0000000000000000 0000000000007fff 00000000000000=
00 fffffffffffffffd=20
>> [    0.045971] GPR12: 0000000024028828 c0000000013b0000 000000001dc5ff=
00 00000000011d8e18=20
>> [    0.045971] GPR16: 00000000011d89e0 fffffffffffffffd 000000001dc5ff=
00 0000000000000014=20
>> [    0.045971] GPR20: 000000001daf0000 c0000000010da4e0 000000001eef00=
00 0000000024028822=20
>> [    0.045971] GPR24: c0000000010db830 c00000001e4041b0 000000001eef00=
00 c000000000ff5598=20
>> [    0.045971] GPR28: c0000000010db830 c0000000010d9d00 c00000001e4026=
80 c0000000010d9d00=20
>> [    0.046505] NIP [c00000000000be00] flush_count_cache+0x120/0x2420
>> [    0.046561] LR [c00000000000e168] ._switch+0x68/0x180
>> [    0.046696] Call Trace:
>> [    0.046865] [c0000000011bba00] [c0000000011bba90] init_stack+0x3a90=
/0x4000 (unreliable)
>> [    0.046970] [c0000000011bbbe0] [c00000000001f390] .__switch_to+0x28=
0/0x490
>> [    0.047031] [c0000000011bbc90] [c000000000b62b5c] .__schedule+0x2bc=
/0xae0
>> [    0.047075] [c0000000011bbd80] [c000000000b633c8] .schedule+0x48/0x=
b0
>> [    0.047140] [c0000000011bbdf0] [c000000000b63918] .schedule_preempt=
_disabled+0x18/0x30
>> [    0.047187] [c0000000011bbe60] [c00000000001065c] .rest_init+0xcc/0=
xf0
>> [    0.047233] [c0000000011bbee0] [c000000000f04584] .start_kernel+0x6=
04/0x648
>> [    0.047276] [c0000000011bbf90] [c00000000000b260] start_here_common=
+0x1c/0x53c
>> [    0.047409] Instruction dump:
>> [    0.047647] 48000005 48000005 48000005 48000005 48000005 4800001c 6=
0000000 60000000=20
>> [    0.047744] 60000000 60000000 60000000 60000000 <7d2803a6> 39207fff=
 7d2903a6 4c400420=20
>> [    0.048410] ---[ end trace 523b05d3a02887f6 ]---
>> [    0.048523]=20
>=20
> How do you got the klogs?

To have the klogs on the serial output you have to disable vga:

 ... -vga none -nographic ...

or to set the default console:

 ... -serial stdout -prom-env "output-device=3D/vdevice/vty@71000000" ...

Thanks,
Laurent


