Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0FC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 01:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044A120737
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 01:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up4P0szH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044A120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKY5u-0002FI-6n
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 21:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jKY5J-0001eU-HD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 21:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jKY5I-000240-5h
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 21:58:57 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jKY5E-00022F-PK; Fri, 03 Apr 2020 21:58:52 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kx8so3843925pjb.5;
 Fri, 03 Apr 2020 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=nFwsdp5bfnRad92fgp2iuX/n0SGcq6Dvu2Vbv3r4tyU=;
 b=up4P0szHGyjaMIGR3mnbCT4bblGHtlLTaXC1MXfsjG6f8xb3pBDHLA8PMo2D54M1Qe
 xFehYH44BBSgov69iYhl4Hr7Y8yQLC/h2pbj+uG9MU4xpFUUvpUqUUmVLgBRFp6ZNna/
 lBQFwolTyD6MRVZbP+4eFDHXaWSKhhFkeyDso9fEtqm26rOrdr0JVeCqMdssr4vl8E3y
 Oz1itXrBtOCAUFAVMy812m0R+vE8CFDsHJtFViTdIuCg/xh0EmYA94FE1TVfZIldjdeJ
 2M97miH0Oim0i4bbeMCKDSS/X34RFXrHmS6RdWHL9lhqxOteUnO5JkCh2FBstQhb0QY8
 FStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=nFwsdp5bfnRad92fgp2iuX/n0SGcq6Dvu2Vbv3r4tyU=;
 b=DMdWXCu/8b4jfLMZcQsnmifhhHSZbwV7QWK1wKlKzX0zoXI78TwXnwJ/8//DDiplKw
 LDmnuBR48XCZzjx76M13V0z+k2CJoCnx3doC3vEEIaTyZRDjMMLNrRWtFmgJkDBvL6Ih
 PD5qUuoya2AvgLjekclCIKVyhXmdb2I6Icks9hxCaMEYue+UjlhK9dAm5AoEHXUU1JFt
 w0RzOkNuikEIb5RqJA6cvMmN3kGol95EskXj4u3ZKq3Bz/eLRs3pi88V8sIjQ3fvATvB
 qZmneBIONYGqEDI9V0FKvjJyGLxMFufBfFtIAjXfKzxQs2hsI1z7ZhVraky1AKHZBSOq
 p4LA==
X-Gm-Message-State: AGi0PuYPq0aKZSdyo896um1ixVNi9PDv588sEfcDuc7AAUjF6zPH9Thz
 7cUOGFbGHlQ1xfATUZWsZWk=
X-Google-Smtp-Source: APiQypLUSEYiZhpQdA7H5dt+vQ5Yo0LFWDs0i+wHIAWxe67DfdalA2sXiDxXTszlPcVYj+S+tvCBxA==
X-Received: by 2002:a17:902:aa88:: with SMTP id
 d8mr10403583plr.201.1585965531309; 
 Fri, 03 Apr 2020 18:58:51 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id v25sm6186329pgl.55.2020.04.03.18.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 18:58:50 -0700 (PDT)
Date: Sat, 04 Apr 2020 11:58:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
 <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
 <1585899319.9tofsl4fd9.astroid@bobo.none>
 <1585915002.kqdz9mya1i.astroid@bobo.none>
 <500c5162-ef10-1913-0ef0-de5fb1b8b28d@kaod.org>
In-Reply-To: <500c5162-ef10-1913-0ef0-de5fb1b8b28d@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585964288.dzemne94wb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

C=C3=A9dric Le Goater's on April 4, 2020 1:47 am:
> On 4/3/20 3:12 PM, Nicholas Piggin wrote:
>> Nicholas Piggin's on April 3, 2020 5:57 pm:
>>> C=C3=A9dric Le Goater's on March 26, 2020 2:38 am:
>>>> [ Please use clg@kaod.org ! ]
>>>>
>>>> On 3/25/20 3:41 PM, Nicholas Piggin wrote:
>>>>> This implements the NMI interface for the PNV machine, similarly to
>>>>> commit 3431648272d ("spapr: Add support for new NMI interface") for
>>>>> SPAPR.
>>>>>
>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>> one minor comment,
>>>>
>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>
>>>>> ---
>>>>>  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
>>>>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>>>> index b75ad06390..671535ebe6 100644
>>>>> --- a/hw/ppc/pnv.c
>>>>> +++ b/hw/ppc/pnv.c
>>>>> @@ -27,6 +27,7 @@
>>>>>  #include "sysemu/runstate.h"
>>>>>  #include "sysemu/cpus.h"
>>>>>  #include "sysemu/device_tree.h"
>>>>> +#include "sysemu/hw_accel.h"
>>>>>  #include "target/ppc/cpu.h"
>>>>>  #include "qemu/log.h"
>>>>>  #include "hw/ppc/fdt.h"
>>>>> @@ -34,6 +35,7 @@
>>>>>  #include "hw/ppc/pnv.h"
>>>>>  #include "hw/ppc/pnv_core.h"
>>>>>  #include "hw/loader.h"
>>>>> +#include "hw/nmi.h"
>>>>>  #include "exec/address-spaces.h"
>>>>>  #include "qapi/visitor.h"
>>>>>  #include "monitor/monitor.h"
>>>>> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, b=
ool value, Error **errp)
>>>>>      }
>>>>>  }
>>>>>
>>>>> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>>>>> +{
>>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>>>> +    CPUPPCState *env =3D &cpu->env;
>>>>> +
>>>>> +    cpu_synchronize_state(cs);
>>>>> +    ppc_cpu_do_system_reset(cs);
>>>>> +    /*
>>>>> +     * SRR1[42:45] is set to 0100 which the ISA defines as implement=
ation
>>>>
>>>> I see 'System Reset' in ISA 3.0
>>>>> +     * dependent. POWER processors use this for xscom triggered inte=
rrupts,
>>>>> +     * which come from the BMC or NMI IPIs.
>>>>> +     */
>>>>> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>>>>
>>>> So we could have used the skiboot SPR_SRR1_PM_WAKE_SRESET define ?=20
>>>
>>> Ah, that's only for power-saving wakeup. But you got me to dig further
>>> and I think I've got a few things wrong here.
>>>
>>> The architectural power save wakeup due to sreset bit 43 needs to be
>>> set, probably in excp_helper.c if (msr_pow) test.
>>>
>>>     case POWERPC_EXCP_RESET:     /* System reset exception             =
      */
>>>         /* A power-saving exception sets ME, otherwise it is unchanged =
*/
>>>         if (msr_pow) {
>>>             /* indicate that we resumed from power save mode */
>>>             msr |=3D 0x10000;
>>>             new_msr |=3D ((target_ulong)1 << MSR_ME);
>>>         }
>>=20
>> Sorry I'm wrong, that's the old MSR_POW thing I guess G5 had it.
>>=20
>> 'stop' state wakeup is powerpc_reset_wakeup of course, which seems to
>> do the right thing with SRR1.
>>=20
>> Something like this patch should fix this issue in the ppc-5.1 branch.
>> This appears to do the right thing with SRR1 in testing with Linux.
>>=20
>> ---
>>  hw/ppc/pnv.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index ac83b8698b..596ccfd99e 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1964,12 +1964,21 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, =
run_on_cpu_data arg)
>> =20
>>      cpu_synchronize_state(cs);
>>      ppc_cpu_do_system_reset(cs);
>> -    /*
>> -     * SRR1[42:45] is set to 0100 which the ISA defines as implementati=
on
>> -     * dependent. POWER processors use this for xscom triggered interru=
pts,
>> -     * which come from the BMC or NMI IPIs.
>> -     */
>> -    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>> +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
>> +        /* system reset caused wake from power saving state */
>> +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
>> +            warn_report("ppc_cpu_do_system_reset does not set system re=
set wakeup reason");
>> +            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>> +        }
>> +    } else {
>> +        /*
>> +	 * For non-powersave wakeup system resets, SRR1[42:45] are defined to
>> +	 * be implementation dependent. Set to 0b0010, which POWER9 UM defines
>> +	 * to be interrupt caused by SCOM, which can come from the BMC or NMI
>> +	 * IPIs.
>> +         */
>> +        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
>> +    }
>>  }
>=20
> That looks correct according to the UM.
>=20
> Do we care about the other non-powersave wakeup system resets ?=20
>=20
>   0011 Interrupt caused by hypervisor door bell.
>   0101 Interrupt caused by privileged door bell.

I think that's a typo in the UM, and those are powersave ones.

>=20
> The reason is that I sometime see CPU lockups under load, or with a KVM g=
uest,=20
> and I haven't found why yet.

I can't tell what's going on there, does it keep taking e80 interrupts
and never clear the doorbell message? Linux wakeup replay code has
always been solid.

Thanks,
Nick
=

