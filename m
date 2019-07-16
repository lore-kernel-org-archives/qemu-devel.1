Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F24C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F12C2173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1D+MsrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F12C2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLQx-0005Zl-Cf
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnLQj-00055D-Ut
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnLQi-0000L1-KK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:15:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnLQi-0000KU-DU; Tue, 16 Jul 2019 07:15:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay6so9945234plb.9;
 Tue, 16 Jul 2019 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=ei71zWO0pidwn+m9jKxK1nlgtuxyuyRxzmNG4G7BjBA=;
 b=S1D+MsrEwCr/ieu3ZRndnSnEu7SfZXXHTyBAHJTnd1mQyRg7MqU/O9sd6AaYcg6mXK
 4oZahVSn6BtQzgjYLBbgyqso10jF1QPt34IWnjFhiUWbgad9pztRyaKuA5FmRDDZsYVl
 uGjXMIQscIn0QkqA5NZTPSno2RrmeCI/Etpa6jvuSDRkpQrlDKYjcLAB/Cn5ILeMvpc4
 3ZNf+Eifq5zzMLBf3wCQtqXxGSQVN7X78zroI8SVG4tpEaCP452BqNS43mKvPPqSuVRl
 zyV8tE6zSLcuSt4WCM6y5tqHTdioJ9CIVzmxqWmbOhY50zdf4+BtiZWypXXC0Xk15z4+
 ds/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=ei71zWO0pidwn+m9jKxK1nlgtuxyuyRxzmNG4G7BjBA=;
 b=Wjcz9w5JSdgr5Asyb1/k5CtoX4sEOIwYFMIhm+bJ/s2gqiAmOJVbMW14QodLpaR6C0
 Bi/amUe32s+Bx3s5AKMv5Z0ywMdJDqynrTGy9lmyyUomzxn0gpw+Gv4CGxvDlUnvgG5b
 oWYdl75Hc72EGf7A2QhQBoXW0DmG1M479GBonoa9iUgbF2yGsUxu0uWFmqFaJ3RZ5C1u
 lDY59zGH2eFlD2ts/l3gBEhCeDVAyCxLKJZuZDYX1j+6vdclmIxY7p/MYm+OOQ+CxQ6X
 L9cCcXz+S1niAkOF+5/fpuKsC7NVMzdAJS0xuc05+G+xqSwE5FPCL4jA6KqNc2DcQH6l
 F1Aw==
X-Gm-Message-State: APjAAAWp0FY3vjNzlvDZ1snsSBUVr6RzqvfmuEoBC7U+8/3Mw3M2WpUs
 UBsSCmHlRhF67ISSvrxyfCQ=
X-Google-Smtp-Source: APXvYqyUyyD2vPZ65j1fjhOz7b6ZzgP94sZS4BYoiONlRE29I4ETJLF3ekeojA5AQlDGbzVm9V6Knw==
X-Received: by 2002:a17:902:e582:: with SMTP id
 cl2mr34741143plb.60.1563275730584; 
 Tue, 16 Jul 2019 04:15:30 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id r9sm28465842pjq.3.2019.07.16.04.15.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 04:15:29 -0700 (PDT)
Date: Tue, 16 Jul 2019 21:15:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-6-npiggin@gmail.com>
 <20190716083047.GG7525@umbus.fritz.box>
In-Reply-To: <20190716083047.GG7525@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563272743.gip4xrq099.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v4 5/5] spapr: Implement ibm,suspend-me
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson's on July 16, 2019 6:30 pm:
> On Tue, Jul 16, 2019 at 12:47:26PM +1000, Nicholas Piggin wrote:
>> This has been useful to modify and test the Linux pseries suspend
>> code but it requires modification to the guest to call it (due to
>> being gated by other unimplemented features). It is not otherwise
>> used by Linux yet, but work is slowly progressing there.
>>=20
>> This allows a (lightly modified) guest kernel to suspend with
>> `echo mem > /sys/power/state` and be resumed with system_wakeup
>> monitor command.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr.c         | 26 ++++++++++++++++++++++++++
>>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |  7 ++++++-
>>  3 files changed, 64 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 5c54e1cb9a..b85d41bb1e 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1710,6 +1710,11 @@ static void spapr_machine_reset(MachineState *mac=
hine)
>>      void *fdt;
>>      int rc;
>> =20
>> +    if (spapr->suspend_reset) {
>> +        spapr->suspend_reset =3D false;
>=20
> Do we need to migrate this value?

I suppose we do if we can migrate a suspended machine?

>=20
>> +        return;
>> +    }
>> +
>>      spapr_caps_apply(spapr);
>> =20
>>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>> @@ -2721,6 +2726,23 @@ static PCIHostState *spapr_create_default_phb(voi=
d)
>>      return PCI_HOST_BRIDGE(dev);
>>  }
>> =20
>> +static Notifier wakeup;
>=20
> I think this should be in sPAPRMachineState rather than global.

Sure.

>=20
>> +static void spapr_notify_wakeup(Notifier *notifier, void *data)
>> +{
>> +    WakeupReason *reason =3D data;
>> +
>> +    switch (*reason) {
>> +    case QEMU_WAKEUP_REASON_RTC:
>> +        break;
>> +    case QEMU_WAKEUP_REASON_PMTIMER:
>> +        break;
>> +    case QEMU_WAKEUP_REASON_OTHER:
>> +        break;
>> +    default:
>> +        break;
>> +    }
>=20
> So.. you have a bunch of switch cases, all of which ignore the input..

Yeah I kind of just copy and pasted I think. This part of the patch
may not have been quite as cooked as I remembered :\

>> +}
>> +
>>  /* pSeries LPAR / sPAPR hardware init */
>>  static void spapr_machine_init(MachineState *machine)
>>  {
>> @@ -3078,6 +3100,10 @@ static void spapr_machine_init(MachineState *mach=
ine)
>> =20
>>      qemu_register_boot_set(spapr_boot_set, spapr);
>> =20
>> +    wakeup.notify =3D spapr_notify_wakeup;
>> +    qemu_register_wakeup_notifier(&wakeup);
>> +    qemu_register_wakeup_support();
>> +
>>      if (kvm_enabled()) {
>>          /* to stop and start vmclock */
>>          qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index a618a2ac0f..60a007ec38 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -216,6 +216,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>>      qemu_cpu_kick(cs);
>>  }
>> =20
>> +static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
>> +                           uint32_t token, uint32_t nargs,
>> +                           target_ulong args,
>> +                           uint32_t nret, target_ulong rets)
>> +{
>> +    CPUState *cs;
>> +
>> +    if (nargs !=3D 0 || nret !=3D 1) {
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +        return;
>> +    }
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *c =3D POWERPC_CPU(cs);
>> +        CPUPPCState *e =3D &c->env;
>> +        if (c =3D=3D cpu)
>> +            continue;
>> +
>> +	/* See h_join */
>> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
>> +            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
>> +            return;
>> +        }
>> +    }
>> +
>> +    spapr->suspend_reset =3D true;
>> +    qemu_system_suspend_request();
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>>  static inline int sysparm_st(target_ulong addr, target_ulong len,
>>                               const void *val, uint16_t vallen)
>>  {
>> @@ -483,6 +513,8 @@ static void core_rtas_register_types(void)
>>                          rtas_query_cpu_stopped_state);
>>      spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
>>      spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
>> +    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
>> +                        rtas_ibm_suspend_me);
>>      spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
>>                          "ibm,get-system-parameter",
>>                          rtas_ibm_get_system_parameter);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 5d36eec9d0..df0b0c15da 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -171,6 +171,10 @@ struct SpaprMachineState {
>>      bool use_hotplug_event_source;
>>      SpaprEventSource *event_sources;
>> =20
>> +    /* Machine has been suspended, so the next machine_reset should not
>> +     * reset state, but just return and allow execution to resume. */
>> +    bool suspend_reset;
>=20
> Hrm, this seems odd, but maybe it's part of the existing suspend
> design.  Why would system_reset resume a suspend, rather than having a
> specific operation for that.

It is where `system_wakeup` cmd pops out, via qemu_system_reset,
main_loop_should_exit. I'm not sure if we have any existing state
we can use. runstate_is_running() doesn't seem to work because of
CAS I guess (maybe CAS is what makes spapr so much different from
x86 in terms of resetting the world here?)

Thanks,
Nick
=

